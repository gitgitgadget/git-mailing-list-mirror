From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Fri, 26 Sep 2014 13:40:35 -0700
Message-ID: <xmqq8ul6869o.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXdty-0007IA-NG
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 00:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076AbaIZWWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 18:22:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54370 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071AbaIZWWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 18:22:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 832E13DE21;
	Fri, 26 Sep 2014 18:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yj5uMlAGVcgOOf9Aj60Qm4it9CE=; b=FPM0jR
	hp+EiZGyru5z3DEhxbQyXEmm5qUj/nYtAl05iGNLXKScUqANSHfrD9A5CVnKfdW+
	imCnopWalLPkDvbsjN/VkZK3gmH/A08aeX/mS2ZmBe0lzeKcH1hisB9gP0MT7eFP
	oxabj3xr5NF+lv8rQh+dlj6NqUZFURwJVawiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UuKQSW9GPO4rtYrVgj6QGjZCBHXikfiA
	cloVnoicy+3A4QVIlqUfssbq6ivYG+gBdkblEsIQSOKi+ljR3r/88rjfoiiNnW52
	yVQ5Jfs/VKCXdfSd2gUXB/41SzW5YmS518AN7qjaAi++hWmPeRyI1Kbq9S2otGll
	OOGBUUGS9aM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74D223DE20;
	Fri, 26 Sep 2014 18:22:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CE253C18B;
	Fri, 26 Sep 2014 16:40:37 -0400 (EDT)
In-Reply-To: <1411726119-31598-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 26 Sep 2014 12:08:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EFC113C-45BD-11E4-AFF7-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257553>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +If you need to close the file descriptor you obtained from a
> +`hold_lock_file_*` function yourself, do so by calling
> +`close_lock_file`. You should never call `close(2)` yourself!

This is sometimes untenable, isn't it?  A caller may want to
freopen(3) a stream on the fd to write into it and then fclose(3);
which would not know to call close_lock_file() but calls close(2).
