Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2596FC77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 22:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjDZW3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDZW3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 18:29:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2B269F
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 15:29:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f7db354092so4843773f8f.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682548154; x=1685140154;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIpRuoca9qvcmDFp40t//qO6Q6OSFkq/asXYUDf6ATY=;
        b=XolCG8sg6aHWDvOvefMopu3ElCrBmt+0fiED+QxosgnwDYs80XJ0fiu3DW0XUQz/3S
         gCqe4zuXF+98r5ThdFcR8KEAURW8Tv+LIAJEsRU2VBWzF7MdsrFbfGYCRWX2nBDZtEjx
         HjZSc5JV2D0rWKQPg8yoUCacn9hTu2VnrTm2/+EjIJ0mpAIrIqwlRpYuGbwfQxwke586
         U93k9c1s8SuI668a3i95EG0jmtXjRn5xlImwzLAhyRnad9kj0Gz/C1r6RHIZ1Qk4RDbb
         KHa6XExlGdLIWj0q9ggoG84elZyBT9bEvLMGIWQxVzrYz0IEbdshwSz+bJbq12w9HlDs
         xuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682548154; x=1685140154;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIpRuoca9qvcmDFp40t//qO6Q6OSFkq/asXYUDf6ATY=;
        b=FRDmZMAQIbt6wodPxcteyJe2ZLk4dVliTbkHYS8nW/Xayk2Ytl9jEXrwlXeKBq13jz
         Qcdjk/i1vyP8AkBwwd7mfh5Fv0RpIllrzCyYmeyfW+qukngImx9HuCI56d82d0JIYbmz
         +UrBkvnA5WOLjpR7S5aiJpoa5J3VXdxUb1RDOUvr7luEmrsrXlros0QE2ONUiSt4XKBd
         OoJKV2TSAm8hHq9pN67AdMtsZ9By+ta+vpZ6hEo+/wA2ogWhQSvpOhYLlgOysvEd9kwm
         IOkhsQeJP5dhDyyQL7avTvJAW0xKu7JB4jW9axqcNkj0IDwY/pbYWNy5eY8YGJyl9P6e
         1yHw==
X-Gm-Message-State: AAQBX9dcDfwM6yjmbnwxhVGaXlA/foAENMdditIcCJ3x8kzYcVbbRiGd
        pXR6aK88wWxLECGYj37WK8e7Caa4k2s=
X-Google-Smtp-Source: AKy350bsEf7A5z/Dz9X47hAukZ85U0yl/dEk6H/KbZH5WffCQ+hIG0LT0MTv62TtpdRqZj6lif8sjA==
X-Received: by 2002:adf:e843:0:b0:2fe:cafc:8b2c with SMTP id d3-20020adfe843000000b002fecafc8b2cmr16412255wrn.62.1682548154137;
        Wed, 26 Apr 2023 15:29:14 -0700 (PDT)
Received: from [192.168.2.52] (60.red-88-14-214.dynamicip.rima-tde.net. [88.14.214.60])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d58f1000000b002cea8e3bd54sm16751336wrd.53.2023.04.26.15.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 15:29:13 -0700 (PDT)
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
 <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com> <xmqq5y9lc9ep.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com>
Date:   Thu, 27 Apr 2023 00:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5y9lc9ep.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24-abr-2023 13:28:14, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > While working in a detached worktree, the user can create some commits
> > which won't be automatically connected to any ref.
> >
> > Eventually, that worktree can be removed and, if the user has not
> > created any ref connected to the HEAD in that worktree (e.g. branch,
> > tag), those commits will become unreachable.
> 
> The latter half of the first sentence feels a bit awkward, primarily
> it sounds as if it almost wants to hint that it is good if we
> connected these commits to some ref automatically, and it is far
> from obvious why it is a good idea.  Perhaps
> 
>     ... the user can create some commits on detached HEAD, that are
>     not connected to any ref.  If the user hasn't pointed at these
>     commits by refs before removing the worktree, those commits will
>     become unreachable.
> 
> That would be in line with the comment you moved in 1/3 that
> describes why orphaned_commit_warning() helper is there, i.e.
> 
>     /*
>      * We are about to leave commit that was at the tip of a detached
>      * HEAD.  If it is not reachable from any ref, this is the last chance
>      * for the user to do so without resorting to reflog.
>      */
> 

OK.  I'll reword the message with that.

> > Let's issue a warning to remind the user for safety, when deleting a
> > worktree whose HEAD is not connected to an existing ref.
> 
> Good idea.  "Let's issue" -> "Issue" (or "Give", "Show").

OK.

> 
> > Let's also add an option to modify the message we show in
> > orphaned_commit_warning(): "Previous HEAD position was..."; allowing to
> > omit the word "Previous" as it may cause confusion, erroneously
> > suggesting that there is a "Current HEAD" while the worktree has been
> > removed.
> 
> Yes, it is absolutely necessary to adjust the message if you are to
> reuse the orphaned_commit_warning() helper so that it matches the
> situation as the end-user experiences.
> 
> >  	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
> > -		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
> > +		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit, 1);
> 
> The magic number "1" looks iffy.
> 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index a61bc32189..df269bccc8 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -1138,6 +1138,14 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
> >  
> >  		ret |= delete_git_work_tree(wt);
> >  	}
> > +
> > +	if (!wt->head_ref && !is_null_oid(&wt->head_oid)) {
> > +		struct commit* wt_commit = lookup_commit_reference_gently(the_repository,
> 
> Asterisk sticks to the variable, not to type, in C.  If you write
> 
> 	struct commit *pointer, structure;
> 
> it is clear only one is the pointer.  It misleads people if you wrote
> 
> 	struct commit* one, two;
> 
> instead.

OK, sorry.

> 
> > +									  &wt->head_oid, 1);
> 
> Also, lines around here look overly long.  Would it help to fold the
> line after the initialization assignment, i.e.
> 
> 		struct commit *wt_commit =
> 			lookup_commit_reference_gently(the_repository, ...);

OK.

> 
> 
> > +		if (wt_commit)
> > +			orphaned_commit_warning(wt_commit, NULL, 0);
> 
> Again, the magic number "0" looks iffy.
> 
> > diff --git a/checkout.c b/checkout.c
> > index 18e7362043..5f7b0b3c49 100644
> > --- a/checkout.c
> > +++ b/checkout.c
> > @@ -171,7 +171,8 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
> >   * HEAD.  If it is not reachable from any ref, this is the last chance
> >   * for the user to do so without resorting to reflog.
> >   */
> > -void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
> > +void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
> > +			     int show_previous_position)
> >  {
> >  	struct rev_info revs;
> >  	struct object *object = &old_commit->object;
> > @@ -192,8 +193,10 @@ void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commi
> >  		die(_("internal error in revision walk"));
> >  	if (!(old_commit->object.flags & UNINTERESTING))
> >  		suggest_reattach(old_commit, &revs);
> > -	else
> > +	else if (show_previous_position)
> >  		describe_detached_head(_("Previous HEAD position was"), old_commit);
> > +	else
> > +		describe_detached_head(_("HEAD position was"), old_commit);
> 
> Can we think of a single way to phrase this batter?  It's not like

OK.

This is the current situation:

   $ git checkout --detach 
   HEAD is now at 2efe05c commit-a

   $ git checkout HEAD~1
   Previous HEAD position was 2efe05c commit-a
   HEAD is now at 7906992 commit-b

   $ git worktree add test --detach && git worktree remove test
   Preparing worktree (detached HEAD 7906992)
   HEAD is now at 7906992 commit-b

Maybe "HEAD position was" fits for both usages.  This is how it would
look like:

   $ git checkout -
   HEAD position was 7906992 commit-b
   HEAD is now at 2efe05c commit-a

   $ git worktree add test --detach && git worktree remove test
   Preparing worktree (detached HEAD 2efe05c)
   HEAD is now at 2efe05c commit-a
   HEAD position was 2efe05c commit-a

Or just "HEAD was at":

   $ git checkout -
   HEAD was at 2efe05c commit-a
   HEAD is now at 7906992 commit-b

   $ git worktree add test --detach && git worktree remove test
   Preparing worktree (detached HEAD 7906992)
   HEAD is now at 7906992 commit-b
   HEAD was at 7906992 commit-b

I think, if there are no objections or better suggestions, I'll re-roll
with "HEAD was at". 

> 
> > diff --git a/checkout.h b/checkout.h
> > index c7dc056544..ee400376d5 100644
> > --- a/checkout.h
> > +++ b/checkout.h
> > @@ -18,7 +18,8 @@ const char *unique_tracking_name(const char *name,
> >   * HEAD.  If it is not reachable from any ref, this is the last chance
> >   * for the user to do so without resorting to reflog.
> >   */
> > -void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit);
> > +void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
> > +			     int show_previous_position);
> >  
> >  void describe_detached_head(const char *msg, struct commit *commit);
> >  #endif /* CHECKOUT_H */
> > diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> > index 230a55e99a..f2756f7137 100755
> > --- a/t/t2403-worktree-move.sh
> > +++ b/t/t2403-worktree-move.sh
> > @@ -247,4 +247,14 @@ test_expect_success 'not remove a repo with initialized submodule' '
> >  	)
> >  '
> >  
> > +test_expect_success 'warn when removing a worktree with orphan commits' '
> > +	git worktree add --detach foo &&
> > +	git -C foo commit -m one --allow-empty &&
> > +	git -C foo commit -m two --allow-empty &&
> > +	git worktree remove foo 2>err &&
> > +	test_i18ngrep "you are leaving 2 commits behind" err &&
> > +	test_i18ngrep ! "Previous HEAD position was" err
> > +	test_i18ngrep "HEAD position was" err
> > +'
> > +
> >  test_done

Thanks.
