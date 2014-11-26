From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: avoid unnecessary sha1 lookup in find_unique_abbrev
Date: Wed, 26 Nov 2014 10:50:16 -0800
Message-ID: <xmqq7fyhre3b.fsf@gitster.dls.corp.google.com>
References: <1416996767-12672-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XthfW-0000br-VU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaKZSuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 13:50:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751183AbaKZSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:50:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE0462136C;
	Wed, 26 Nov 2014 13:50:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tmpwnRe64HitW1MsvyeTpL/NsBQ=; b=viT76/
	NlGhFHkhm3H8bt7BbOzs82MNTjLTwO2IrUUoR4r9yZGIiyrDE27GGBdj0j+CqZTt
	CMchltdd79kL2y4hcjcvgFM6Epz/ZqYjpdAiapJdGBgCDcKpgm9cr6RAZYLNH+Fs
	hmyG85SuGCEAXMwrCa7onNWPNtqzJ6JQHv0qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DejrkLq9UWs3OVfltIbObm4AIXJ6T2Q7
	Ac9kHwgmkxKqTQpLYtTw9EfvdLO4iUZW+N9G90vaBDtOLynI0anv4vWZ+9OJzAwi
	FPZWQl2G24+EPaA1szPJPpyfvYTPqMgjwXXbCyBsLcOJ575cNA5hAvuXFM9RJG/R
	Tpx2WMXMaYU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E48BD2136B;
	Wed, 26 Nov 2014 13:50:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 685CD2136A;
	Wed, 26 Nov 2014 13:50:18 -0500 (EST)
In-Reply-To: <1416996767-12672-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Wed, 26 Nov 2014 19:12:47 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 110D50B6-759D-11E4-9F45-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260292>

Mike Hommey <mh@glandium.org> writes:

> An example where this happens is when doing an ls-tree on a tree that
> contains a commit link. In that case, find_unique_abbrev is called
> to get a non-abbreviated hex sha1, but still, a lookup is done as
> to whether the sha1 is in the repository (which ends up looking for
> a loose object in .git/objects), while the result of that lookup is
> not used when returning a non-abbreviated hex sha1.

Makes sense.  If we are not abbreviating, because the function is
prepared to give answer for both missing and existing objects, there
is no point checking the existence.

Thanks.
