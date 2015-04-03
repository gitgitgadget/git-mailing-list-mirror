From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Freeing struct lock_file?
Date: Fri, 03 Apr 2015 15:01:46 -0700
Message-ID: <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
References: <1428097515.31333.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9f0-0007a0-9u
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbbDCWBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:01:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751817AbbDCWBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:01:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D2A0454CE;
	Fri,  3 Apr 2015 18:01:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KTopjC22t+XQVV5p7O2LsE7eM70=; b=phoszH
	3I3f6CgMs0nc7uSwc1ccwZQb/hBmKPNWyw7KQvzCj1QS7ZO7Mu3jiLO5OYXy1mig
	ZH1WGKZi/9pZu7yJBWY9KvkZQcHUgxLjsbTp8B2RUpBBKV6RpnOhRfx5TUi/+9oe
	Odd8vuWZ4K5BH1PTe6S75ATVeYW0u8OH0i7qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izZQBu1zK33oBP53Lat7/UNZbe6MzfAO
	/WS2YJjsmbGN5OG5m9XhGibaQzzzjsycBxDLCQKRYHiRBHGw9zLbRrfP+ku/XQBv
	LZgG/ksn8nkHmG3NQ98lq0ZiKTYCZbY/trC5Byr4eNrzjge+3HdFFhPD30SJTqia
	Zl4SBoIvT6o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94AB7454CD;
	Fri,  3 Apr 2015 18:01:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B63F454CC;
	Fri,  3 Apr 2015 18:01:48 -0400 (EDT)
In-Reply-To: <1428097515.31333.2.camel@ubuntu> (David Turner's message of
	"Fri, 03 Apr 2015 17:45:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 06509CA4-DA4D-11E4-B573-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266738>

David Turner <dturner@twopensource.com> writes:

> Why is it impossible to free struct lock_files?  I understand that they
> become part of a linked list, and that there's an atexit handler that
> goes over that list.  But couldn't we just remove them from the linked
> list and then free them? 

I suspect that the code is worried about getting a signal, while it
is manipulating the linked list, and then cause the atexit handler
to walk a list that is in a broken state.
