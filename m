From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Fri, 06 Mar 2015 10:30:05 -0800
Message-ID: <xmqqtwxyyo5u.fsf@gitster.dls.corp.google.com>
References: <1425618810-21192-1-git-send-email-akshayaurora@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Akshay Aurora <akshayaurora@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 19:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTx0p-0002eq-3J
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 19:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbbCFSaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 13:30:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752623AbbCFSaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 13:30:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF2423CC15;
	Fri,  6 Mar 2015 13:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YVfPZHmsHPAwyeYKK8+u4bmCTCE=; b=hnZa3B
	scJ/L6H6Odfjhq6jH1AHHEcPOiYO84toLhRnzDqPGU6KvW2tRPn4bbSggcIRbShc
	1NrS9MS9yGLGL+HY/nuP/wuf06CLvsM65Z4YymkdJ/6u5sJcdG6D7VkF//p9/ib9
	0ic/Cd2C15FzqJDba1/NMwrne7ZKF/cKJ2wy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eq7xuojOS8Qa8DdHMLxgJ+dMFoxlUes9
	CqbgDLnPzlbSLvmAf3Mx+FjgF4thhbCXw1/apb/cnGIK1VUxKeFDrD0Fs1MZ3lxj
	+XWuhuerM7vpDH/T+PW1rpxV1TLnyKmjiK5IskByv+W89tcdpHRz6aWo4hCi3wSn
	kZHhR/BhNtA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D79693CC13;
	Fri,  6 Mar 2015 13:30:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 695903CC0F;
	Fri,  6 Mar 2015 13:30:06 -0500 (EST)
In-Reply-To: <1425618810-21192-1-git-send-email-akshayaurora@yahoo.com>
	(Akshay Aurora's message of "Fri, 6 Mar 2015 00:13:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFF5181C-C42E-11E4-98D5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264948>

Akshay Aurora <akshayaurora@yahoo.com> writes:

> Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>
> ---
> This is my first patch for a GSoC Microproject, would be great to have your feedback.
>
>  revision.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index bd027bc..d578652 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2248,7 +2248,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	 */
>  	if (revs->reverse && revs->graph)
>  		die("cannot combine --reverse with --graph");
> -
> +	if (revs->no_walk && revs->graph)
> +		die("cannot combine --no-walk with --graph");
>  	if (revs->reflog_info && revs->graph)
>  		die("cannot combine --walk-reflogs with --graph");
>  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)

Needs a new test to make sure "log --no-walk --graph" is rejected,
and also you need to make sure all other existing tests that used to
pass before this change still pass.
