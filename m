From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] branch: allow -f with -m and -d
Date: Thu, 04 Dec 2014 11:13:31 -0800
Message-ID: <xmqqh9xbtehw.fsf@gitster.dls.corp.google.com>
References: <cover.1417699299.git.git@drmicha.warpmail.net>
	<7b1ae15228841d3eaed739e89295ec10a2be45fa.1417699299.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 20:13:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbqM-0006xO-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 20:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbaLDTNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 14:13:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932637AbaLDTNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 14:13:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 140E122D0A;
	Thu,  4 Dec 2014 14:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=majr5TNh0qtIcKwnj6HAU/GGW78=; b=KJeaLk
	yqgk1oHt7SATDkYcmOGUqYt7GfegqrWmDEy6JaGM5bgFerGKEfbA+8SX0+o18kyl
	ShHQYa8qI6wtZXp3DrAuRJRgI430P80p7bgOeaU2T4jZ0Maoqggh2u1PAb6BX4Rj
	Cdd0DE4rqMV0wB54SusYZNXiCzDpLbgcgdzn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kaBwB/+1xfeY8nNYXHFbUNU0QDq8a+vW
	nj9N1hojt9u1TKvjgLPitTRcnAJyG8WuXJnhRxOpTFhB+CvzmKuRLry7M0S2i+Cv
	M4uy69yHsvuguEGFSjJg1E8+uCObkaJds3sl1choAK8BZBPxKinD9tvhfpW7b+6o
	lcPArSpzA08=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0981222D08;
	Thu,  4 Dec 2014 14:13:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EAA522D07;
	Thu,  4 Dec 2014 14:13:32 -0500 (EST)
In-Reply-To: <7b1ae15228841d3eaed739e89295ec10a2be45fa.1417699299.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 4 Dec 2014 14:26:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A34CEBF6-7BE9-11E4-8005-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260783>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -f/--force is the standard way to force an action, and is used by branch
> for the recreation of existing branches, but not for deleting unmerged
> branches nor for renaming to an existing branch.
>
> Make "-m -f" equivalent to "-M" and "-d -f" equivalent to" -D", i.e.
> allow -f/--force to be used with -m/-d also.

I like that goal.  And I agree with your s/force_create/force/g
remark on the cover, too.



> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/branch.c  | 9 +++++++--
>  t/t3200-branch.sh | 5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 3b79c50..8ea04d7 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -848,7 +848,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
>  		OPT_BOOL(0, "edit-description", &edit_description,
>  			 N_("edit the description for the branch")),
> -		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
> +		OPT__FORCE(&force_create, N_("force creation, move/rename, deletion")),
>  		{
>  			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
>  			N_("commit"), N_("print only not merged branches"),
> @@ -891,7 +891,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	if (with_commit || merge_filter != NO_FILTER)
>  		list = 1;
>  
> -	if (!!delete + !!rename + !!force_create + !!new_upstream +
> +	if (!!delete + !!rename + !!new_upstream +

This puzzled me but earlier -f implied creation and no other mode
(hence it was an error to give it together with delete and other
modes), but now -f is merely a "do forcibly whatever mode of
operation other option determines" that does not conflict.

What should "-f -u" and "-f -l" do, then, though?

>  	    list + unset_upstream > 1)
>  		usage_with_options(builtin_branch_usage, options);
>  
> @@ -904,6 +904,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		colopts = 0;
>  	}
>  
> +	if (force_create) {
> +		delete *= 2;
> +		rename *= 2;
> +	}
> +
>  	if (delete) {
>  		if (!argc)
>  			die(_("branch name required"));
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 0b3b8f5..ddea498 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -106,6 +106,11 @@ test_expect_success 'git branch -M o/q o/p should work when o/p exists' '
>  	git branch -M o/q o/p
>  '
>  
> +test_expect_success 'git branch -m -f o/q o/p should work when o/p exists' '
> +	git branch o/q &&
> +	git branch -m -f o/q o/p
> +'
> +
>  test_expect_success 'git branch -m q r/q should fail when r exists' '
>  	git branch q &&
>  	git branch r &&
