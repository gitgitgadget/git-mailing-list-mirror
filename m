From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Un-static gitmkstemps
Date: Thu, 15 Sep 2011 09:05:33 -0700
Message-ID: <7vvcstpz8y.fsf@alter.siamese.dyndns.org>
References: <1316089260-76049-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 18:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4ERY-00054z-Sm
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 18:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934126Ab1IOQFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 12:05:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934067Ab1IOQFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 12:05:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 468EC5181;
	Thu, 15 Sep 2011 12:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bVCGL4UflVjPF1KA4ozomxhNBWc=; b=e+c8fG
	kvQq8ZXgUne5atG+e0Uier5NDX8//7SRgNp0tj525pdOswJD39doXpYjgvlUsZZE
	kuAaGTNgW5qkbtR2pEF9hZamzPDeEtD75FVf0oOzqTTJc8oApUQqYB8DCeIvx2s0
	XAUwJPojvc5I2RrY7MZcf/ym2zUx3pqyymH9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xeKD3XALSWu7rIV12DhnXzKdJwxxBVYM
	cRTo5ZtbbUnvYUOxr2Dr4QqlBQexJCpFw2qKhylzAYQgq8yhL4J8f/+yJ2G9O3Zu
	Bux/AyNViBBIOK29y7DDXvWcDYeFIsdPODZPRushYYH/bED787ClotMTVU4WX6Vz
	pOAuOvxCykk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CB775180;
	Thu, 15 Sep 2011 12:05:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA02F517F; Thu, 15 Sep 2011
 12:05:34 -0400 (EDT)
In-Reply-To: <1316089260-76049-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu, 15 Sep 2011 08:21:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B7BF118-DFB4-11E0-9295-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181477>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> It may not be used in most builds, but it's used via a #ifdef in
> git-compat-util.h  ...

Hmm, do you mean "#define", not "#ifdef", specifically, this:

    maint:git-compat-util.h:#define mkstemps gitmkstemps

> ... Also, making it static makes a -Wall compile fail
> since it's not used in the file without NO_MKSTEMPS.

Your alternative of not defining on builds without NO_MKSTEMPS is better,
and probably even better yet, it would make sense to move the definition
of git_mkstemps() out of wrapper.c and have it somewhere in compat/, just
like the way in which compat/qsort.c defines git_qsort() that is used as a
replacement for qsort() via #define on systems that lack it.
