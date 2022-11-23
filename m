Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AADC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 02:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiKWCnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKWCnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 21:43:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0192786FB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:43:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so27441058wrt.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 18:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEJq/E5JloeLqLdYv1RwjMEJsUOoVussJ5qBX9QN40E=;
        b=R91SsTNy6VmuSyTmlRaB0JVBufr61JzHLvWJCEFs9P3ItrjtqtRc4w0VubnGwci2aV
         o1gj8FkkcV9ltd9Ylu5KK+UmrWVx16uXqR/+z2h/pFCr7L084NCpdaRMT/3V0PFEMboB
         PUGHOBGaD5GUSvf68117oAIVmAKc3Rwn0upRq3DxOWxsfENJkJEOwneh3x5eXLQiEzER
         GTYf2z7B7FCpP5nNBIllQbLGk171VJwSQGZadHpb4i53T93coGDf7JJe6N+VEINrj5Ki
         YJCgJ0+kViSv3FxOL99Cphj2cIGgWClTr43fFd5krixJJUxMks9qA5PFSoKCa3HG3MCN
         jY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEJq/E5JloeLqLdYv1RwjMEJsUOoVussJ5qBX9QN40E=;
        b=V7QrQTBW21/lKWM0HJ4gzLe6haMK1Mrf7dubsxZpAl+/pfxNb04oIIGZsRtPe0FE6y
         liPk2xV4KtFfp7tc0yehLZCk4pdFfKTdnoAdzBeYjmHOA+S/xmJmUNRDSq2HbxcsTlSa
         SN9V8K4vitW+p5xCEXI1yRp46o5W7od7X05Q22B/GS+uCoN6i6kTZqulk29RlEzUZMSi
         loJa02BF9VgBYrtLkSY5LB3Xe2s153iVeqTqtdCg27VG9mnh8Vfaxj2wCF+o2xhJ5U/E
         LQd98CpLY9BKuOxQLdGFlTXJlXsWuPgJCo8oVn9FF+rcsM9zKNXgHgVYAMoNdpxo2mbL
         dq4g==
X-Gm-Message-State: ANoB5pkY1BdK8y1KfTopQEikTt8pZ1BHyrbx6HgSJcQjZv9ZGRnkX4Bo
        UEwGgCGoJ8qeUXNBSsPab60=
X-Google-Smtp-Source: AA0mqf5RueNboWsjb46Ws459LFTg63riE5d88Idp0Oi929VWtf6NFZGQZfMd1o55Gs8ccPVMBfXdMA==
X-Received: by 2002:adf:dd10:0:b0:22e:4f2e:e57 with SMTP id a16-20020adfdd10000000b0022e4f2e0e57mr16008256wrm.698.1669171393361;
        Tue, 22 Nov 2022 18:43:13 -0800 (PST)
Received: from [192.168.2.52] (14.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.14])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003cfa81e2eb4sm550710wms.38.2022.11.22.18.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 18:43:12 -0800 (PST)
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new
 worktrees
To:     Jacob Abel <jacobabel@nullpo.dev>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com>
 <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
 <20221119034728.m4kxh4tdpof7us7j@phi>
 <221119.86a64nf9k5.gmgdl@evledraar.gmail.com>
 <CAPig+cTGATAYCpFcW2F6byf827-_TOyN1FNLfFCm0NdiReYVpg@mail.gmail.com>
 <20221122232647.2jdsp5kioq7muymb@phi>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <e027dc5b-dbb9-c511-038e-5440d59d976c@gmail.com>
Date:   Wed, 23 Nov 2022 03:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20221122232647.2jdsp5kioq7muymb@phi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-nov-2022 23:26:57, Jacob Abel wrote:
> On 22/11/22 12:16AM, Eric Sunshine wrote:
> > On Sat, Nov 19, 2022 at 6:49 AM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> > > On Sat, Nov 19 2022, Jacob Abel wrote:
> > > > I'd support adding an `advise()` for at least the basic case where you try to
> > > > create a worktree and no branches currently exist in the repository.
> > > > i.e. something like this:
> > > >
> > > >     % git -C foo.git worktree add foobar/
> > > >     hint: If you meant to create a new initial branch for this repository,
> > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > >     hint:
> > > >     hint:   git worktree add --orphan main main/
> > > >     hint:
> > > >     fatal: invalid reference: 'foobar'
> > > > and
> > > >     % git -C foo.git worktree add -b foobar foobardir/
> > > >     hint: If you meant to create a new initial branch for this repository,
> > > >     hint: e.g. 'main', you can do so using the --orphan option:
> > > >     hint:
> > > >     hint:   git worktree add --orphan main main/
> > > >     hint:
> > > >     fatal: invalid reference: 'foobar'
> > >
> > > I think those would make sense, yes.
> >
> > Yes, this sort of advice could go a long way toward addressing my
> > discoverability concerns. (I think, too, we should be able to
> > dynamically customize the advice to mention "foobar" rather than
> > "main" in order to more directly help the user.) Along with that,
> > explaining this use-case in the git-worktree documentation would also
> > be valuable for improving discoverability.
> 
> Perfect. I think I've got this working already on my end using more or less
> the following:
> 
>     diff --git a/builtin/worktree.c b/builtin/worktree.c
>     index 71786b72f6..f65b63d9d2 100644
>     --- a/builtin/worktree.c
>     +++ b/builtin/worktree.c
>     @@ -736,7 +736,21 @@ static int add(int ac, const char **av, const char *prefix)
>         if (!opts.quiet)
>             print_preparing_worktree_line(opts.detach, branch, new_branch, !!new_branch_force);
> 
>     -	if (new_branch && !opts.orphan_branch) {
>     +	if (opts.orphan_branch) {
>     +		branch = new_branch;
>     +	} else if (!lookup_commit_reference_by_name("head")) {

I haven't read the full thread and sorry to enter this way in the
conversation, but this line got my attention.  This needs to be "HEAD",
in capital letters.

Thank you for working on this, this is a thing that has hit me several
times.

The first impression got me thinking.. Why do we need this advise?
Why not make the orphan branch right away? And why the argument for the
--orphan option?

I like what this new flag allows: make a new orphan branch when we
are in any branch.  But if we are already in an orphan branch (like the
initial) what's the user's expectation?

Maybe we can use the new flag to indicate that the user unconditionally
wants an orphan branch, and use the rest of the arguments as they are,
'-b' included.

This needs more work, but something like this:

--- >8 ---

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d774ff192a..1ea8d05c2f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -406,7 +406,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-	    ref_exists(symref.buf)) {
+	    (opts->orphan_branch || ref_exists(symref.buf))) {
 		is_branch = 1;
 		if (!opts->force)
 			die_if_checked_out(symref.buf, 0);
@@ -738,18 +738,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	if (opts.orphan_branch) {
 		branch = new_branch;
-	} else if (!lookup_commit_reference_by_name("head")) {
-		/*
-		 * if head does not reference a valid commit, only worktrees
-		 * based on orphan branches can be created.
-		 */
-		advise("if you meant to create a new orphan branch for this repository,\n"
-			 "e.g. '%s', you can do so using the --orphan option:\n"
-			 "\n"
-			 "	git worktree add --orphan %s %s\n"
-			 "\n",
-			 new_branch, new_branch, path);
-		die(_("invalid reference: %s"), new_branch);
+	} else if (new_branch && !lookup_commit_reference_by_name("HEAD")) {
+		branch = opts.orphan_branch = new_branch;
 	} else if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
