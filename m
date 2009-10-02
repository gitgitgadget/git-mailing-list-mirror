From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: fix build warnings
Date: Fri, 02 Oct 2009 15:05:04 -0700
Message-ID: <7v7hvd4flb.fsf@alter.siamese.dyndns.org>
References: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 00:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtqFd-0000Ib-6W
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 00:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbZJBWFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 18:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbZJBWFJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 18:05:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbZJBWFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 18:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2576949540;
	Fri,  2 Oct 2009 18:05:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nL3iQXUnXJ/g+7dpczgsFRcfES0=; b=EbnCWN
	CibLvHoFbCl1jb46U9nP0dAePzfM6fxOkdlamXZ0FLritJ7wpXjdWUenAooE9J43
	MwEuoIBwvCFpst4BG1HDJe+Ds3ZsZ5FMBec2RL2HbG9VohDo62bLq/2HtW6LpUIU
	MperERC3AUy0IWo7WlOH/9Ykv+I/CPqO+rkTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rjHdSE/eLKI/9t2sFtJCEiP21+d7AQJ2
	ttpFlz/nhi5yrZtaY8tEZ2VgrD0ElDbbPtJ2tuh8mPw90iht/d4PQSxJseLlJPN5
	vF3kKVIPsyDX68NJP9RXYYc7ANhc+lBVbCDhmNC1z9ZBDjRsUROzt7CSfdb1YyNg
	17/+jL6u/jI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 080DE4953F;
	Fri,  2 Oct 2009 18:05:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 738AE4953E; Fri,  2 Oct
 2009 18:05:06 -0400 (EDT)
In-Reply-To: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com>
 (Michael Wookey's message of "Sat\, 3 Oct 2009 07\:40\:08 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A628EA26-AF9F-11DE-9C72-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129462>

Michael Wookey <michaelwookey@gmail.com> writes:

> diff --git a/builtin-branch.c b/builtin-branch.c
> index 9f57992..cf6a9ca 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -93,7 +93,7 @@ static const char *branch_get_color(enum color_branch ix)
>
>  static int delete_branches(int argc, const char **argv, int force, int kinds)
>  {
> -	struct commit *rev, *head_rev = head_rev;

I haven't tried, but the patch may break build with "gcc -Werror".

This is a common and unfortunate idiom to tell the readers of the code
that this initialization is unnecessary, gcc is not clever enough to
notice and gives warnings, and we are squelching it, knowing what we are
doing.
