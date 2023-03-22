Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37342C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 22:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVWZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCVWZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 18:25:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FE23847
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:25:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w4so12533139plg.9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679523946;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39kBECxFmq+ljMYO6kYLZx4MceoKMb/5IkA43jxYKgA=;
        b=Ro85G3ERTwmUGg6ZtDVC1zj+4+k6+zW4P9OCM5rtbWLIyeX8EuPpZrEF64Gkel+urA
         8SrKzz2NQsxfPQFr53KIPFPbiY7biAFXChBgAJxwX6fO2xVPVsHCFLplHiHOlBqP7c2Z
         zD8+kzI2EIWIDuQwcQ2FVbeAgFWEhzGekqlIUlEwX+auC5IZlFHbgQjNFCjSVsxHnwje
         spqSM/pik36TDwiLvyRFFqL5QYH5MASdlAw72FuIujBHc54mnWTI/VU1WlC2Yc1oPUG1
         /kL2RSz1HxfJbAj8cYC2UKWLdHCmfgLVKe5HqnPU9bjq3RLkkaRT8jkkkmlWGFLyMM49
         yfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679523946;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39kBECxFmq+ljMYO6kYLZx4MceoKMb/5IkA43jxYKgA=;
        b=uDUVO3tn3ZipIMv3mm2oxg6jX1IanysXFTzt7md5l5iK9If4m3lBlOxDPMRUnAA5Zr
         vnPVU+khmC7VlO6s7THZuie6Y9ACvLsWgwhZEtc0/+xF8zika7ila2d4xrztwS8I3DIN
         5nQQQBHb51ActEATofMZZ/BHgEYXKD1C0Co/ejDusBmy82wcPz2IukC5PZTogBr6DMxz
         tb0Eb3TveBIVQCPFPWLgyWQy4U2LYcpvwtJP/JVHyYq+Ubwwt8fTNfbisqa62c4V8t2x
         ageAsdVya/FIbRpwH3HiHidEFlgx4tIyvC1g0BWzpjh8BfEeRF43YQTOJwP3XoW9hPU+
         NnoQ==
X-Gm-Message-State: AO0yUKWUkzP98H1XOdI5oh20qTXTMtDhVJ2rugzYpndyZ+VTKyGTxsA9
        Yvdz/onv2GcxpvXU6Sh0OKI=
X-Google-Smtp-Source: AK7set/ADLNpY1RA4/JEcz9uOLmjk22CrBqis4k4m9X1td9A30kcjFxsaMmHsOeHjBUEGf4PZp69nQ==
X-Received: by 2002:a05:6a20:4c8f:b0:d4:fcb2:7966 with SMTP id fq15-20020a056a204c8f00b000d4fcb27966mr808549pzb.11.1679523946406;
        Wed, 22 Mar 2023 15:25:46 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h24-20020a63df58000000b0050f85ef50d1sm5598475pgj.26.2023.03.22.15.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 15:25:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ClementMabileau <mabileau.clement@gmail.com>
Subject: Re: [PATCH v2] branch: improve error log on branch not found by
 checking remotes refs
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
        <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 15:25:45 -0700
In-Reply-To: <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
        (ClementMabileau via GitGitGadget's message of "Wed, 22 Mar 2023
        20:03:22 +0000")
Message-ID: <xmqq355wctjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ClementMabileau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ctmbl <mabileau.clement@gmail.com>

This "name <address>" should match what is on "Signed-off-by:".  I
offhand do not know where GitGitGadget gets the information, but I
suspect the original commit object you created records ctmbl as the
author name, not "Clement Mabileau"?  I can fix it for this single
time, but if you plan to contribute to the project in an ongoing
basis, you may want to fix your .git/config (or $HOME/.gitconfig)
with a "[user] name = ..." entry.


> when failing to delete a branch with `git branch -d <branch>` because
> of branch not found, try to find a remote refs matching `<branch>`
> and if so add an hint:
> `Did you forget --remote?` to the error message



>  builtin/branch.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f63fd45edb9..697636e2874 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -216,10 +216,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *item;
>  	int branch_name_pos;
> +	char* FMT_REMOTES = "refs/remotes/%s";
> +	char* FMT_BRANCHES = "refs/heads/%s";

In our codebase, the asterisk sticks to the variable, not to the
type.  cf. Documentation/CodingGuidelines

 - When declaring pointers, the star sides with the variable
   name, i.e. "char *string", not "char* string" or
   "char * string".  This makes it easier to understand code
   like "char *string, c;".

> @@ -263,9 +265,26 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  					| RESOLVE_REF_ALLOW_BAD_NAME,
>  					&oid, &flags);
>  		if (!target) {
> -			error(remote_branch
> -			      ? _("remote-tracking branch '%s' not found.")
> -			      : _("branch '%s' not found."), bname.buf);
> +			char* MISSING_REMOTE_REF_ERROR_MSG = "remote-tracking branch '%s' not found.";
> +			char* MISSING_BRANCH_ERROR_MSG = "branch '%s' not found.";
> +			char* MISSING_BRANCH_HINT_MSG = "branch '%s' not found.\n"
> +											"Did you forget --remote?";

You'd need to enclose these text literals inside N_() to tell the
tools that they are to be translated.  e.g.

	char *remote_ref_error = N_("remote-tracking branch '%s' not found.");

Otherwise, using the variables inside _() would not let the
machinery to find translated strings.

Having said that, I do not see the point of introducing three
variables that are hard to read, misleadingly named with all capital
letters as if they were macros, and each of which is only used once.
It does not make the code that computes which message gets used any
easier to follow (by hiding long text literal), and it does not help
reusing the same message elsewhere.  For that matter, the two new
variables we saw above (again in all caps) are also of dubious merit.



> +
> +			if (remote_branch) {
> +				error(_(MISSING_REMOTE_REF_ERROR_MSG), bname.buf);
> +			} else {
> +				char* virtual_name = mkpathdup(FMT_REMOTES, bname.buf);

Hmph.  bname.buf at this point has what?  

If the user said "git branch -d frotz", we would have 'frotz'
there, right?  Then we apply FMT_REMOTES (Yuck, now I have to go
scroll up, see that it is set to "refs/remotes/%s", and hope or
verify that its value hasn't been changed in the meantime---in
short, don't introduce that variable.  A macro might be OK, but I do
not see much point here) and we get "refs/remotes/frotz" back.

So, we check "refs/remotes/frotz" here ...

> +				char* virtual_target = resolve_refdup(virtual_name,
> +							RESOLVE_REF_READING
> +							| RESOLVE_REF_NO_RECURSE
> +							| RESOLVE_REF_ALLOW_BAD_NAME,
> +							&oid, &flags);
> +				FREE_AND_NULL(virtual_name);

... but why should we?  If your workflow interacts with the original
repository you cloned from, you would have remote-tracking branches
like "refs/remotes/origin/frotz" and it may be plausible that you
meant to remove with "git branch -d frotz" the remote-tracking
branch "refs/remotes/origin/frotz".  But the new code makes no
effort to figure out the name of the remote (e.g. 'origin') here,
and I am not sure what value it adds to check and try to tell the
user about "refs/remotes/frotz".  Or are we assuming that the user
would say "git branch -d origin/frotz" in such a case?

> +				if (virtual_target)
> +					error(_(MISSING_BRANCH_HINT_MSG), bname.buf);
> +				else
> +					error(_(MISSING_BRANCH_ERROR_MSG), bname.buf);
> +			}

Are you leaking virtual_target here?

>  			ret = 1;
>  			continue;
>  		}
