Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB4C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC792077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrOX00z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfLDRay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:30:54 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33013 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 12:30:54 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so17834oie.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dli8YFVD4R0qizvJt4i+fvgv29DbOyQa4OJpj91uwLA=;
        b=jrOX00z/Gzn2UIxNkUaDktQIA+v+IwdpO6FEJZrvvpNwJxy3DKPcdEQLYtSirPHYCD
         B5+NRtZmD/7HxUajyjALHU/pLsnSm4GoQ28/7twno65+s/xiqZNCPoFbaf6XF6xPk2GQ
         s1r2kCEvm26MTZxnSYxNQsbAYPAnWpf+Al6TIoP6dxGZFvQLXd7g9V/I0Tz2pfe49bsu
         5JcmtGU7vmnouBnoLDNAPbuvVoPG+e88YRSgxbv0/Hvl98tvA79IFPvWLoCGFfu69kiR
         3DyJbIWclZMVQUaWhexPqhgUxRSyKy7ld3p+SBK7NiY+LsWpm4aKpPEUhZ+vBZs6o3fM
         1Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dli8YFVD4R0qizvJt4i+fvgv29DbOyQa4OJpj91uwLA=;
        b=RNyqm/gFJ3HTELTzWkDifYjDSYYxhFsKJK/RRxTJsfkjddU1dKuwrZafgS4nIE65AY
         04lUWE2WwoPydeUaBKJDv2Z5J3BeViyP5Pl3mbQLldLCFGyu8UGjLCRaB8t45IeLfsao
         QEQar5Ggvfe8E/uj3P+ruz5pvUE/xJag8L24wlanAPeZBrARO6dE30Q+6FULQChH0222
         hMuG9sGD1dGKExpoYhO89QjopQyKxKQPJMpfpg8fYaOA+8STAFnUH3GPZFPTHqlpF4pS
         YD9BtDdz5/IrrgDn/0VcdrAQKsqc3Z/lgjQl3MePPD5KFYjMmzQREhaqeFZhU5JuUbL0
         s0rg==
X-Gm-Message-State: APjAAAX+sM2tsZK6Fbp0t1S90zyPa9MxjJazB3qIsK1R47HdUsIRbzeL
        uk3aUg81uTFL46QDPcd1JLZPjUv34Bm2wS6z+ZKviJyo
X-Google-Smtp-Source: APXvYqy7H19ozB9jBqp8hFQhLI9Z2T+q6gRQhOawdG80yQNVM20pbtPVPJlOl8xi3+TBI1X8eX6rUDTLLzSp8yqZCrE=
X-Received: by 2002:aca:f083:: with SMTP id o125mr3448331oih.122.1575480652363;
 Wed, 04 Dec 2019 09:30:52 -0800 (PST)
MIME-Version: 1.0
References: <87fti15agv.fsf@kyleam.com>
In-Reply-To: <87fti15agv.fsf@kyleam.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Dec 2019 09:30:41 -0800
Message-ID: <CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com>
Subject: Re: [BUG?] ls-files -o now traverses nested repo when given multiple pathspecs
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

Thanks for the clear report and pointing out relevant commit(s) and
discussion.  Apologies in advance if I come off a bit ranty; it's
directed to dir.c and its API and not you.  It seems to be quite the
mess...

On Tue, Dec 3, 2019 at 2:08 PM Kyle Meyer <kyle@kyleam.com> wrote:
>
> 89a1f4aaf7 (dir: if our pathspec might match files under a dir, recurse
> into it, 2019-09-17) introduced a change in behavior in terms of
> traversing untracked nested repositories.  Say we have a repository that
> contains a single untracked repository with untracked content:
>
>     $ git init && git init a && touch a/x
>
> Calling ls-files with the nested repository as the sole pathspec does
> not recurse into that repository:
>
>     $ git ls-files --other a
>     a/
>
> However, as of 89a1f4aaf7, adding an additional pathspec results in the
> nested repository being traversed:
>
>     $ git ls-files --other a foo
>     a/
>     a/x
>
> Reading 89a1f4aaf7 and skimming the patch series and related thread [*],
> I haven't found anything that makes me think this change in behavior was
> intentional.

Oh man, I guess I shouldn't be surprised by another area of the code
that depends on dir.c but lacks any meaningful tests of its behavior,
violated the existing contract[1], and depends on the side effects of
other bugs -- bugs which don't cover all cases and thus causes it to
get different behavior depending on things that otherwise shouldn't
matter.  Behold, *before* my changes to dir.c:

$ git --version
2.23.0
$ find . -type f | grep -v .git
./empty
./untracked_repo/empty
./untracked_dir/empty
./world
$ git ls-files
world
$ git ls-files -o
empty
untracked_dir/empty
untracked_repo/

So, as you say, it wouldn't traverse into untracked_repo/.  Now we
start adding pathspecs:

$ git ls-files -o untracked_repo
untracked_repo/

As you mentioned, it won't traverse into it even when specified...

$ git ls-files -o untracked_repo/
untracked_repo/empty

...except that it does traverse into this directory if the user tab
completes the name or otherwise manually adds a trailing slash.
Weird, let's try multiple pathspecs:

$ git ls-files -o untracked_dir untracked_repo
untracked_dir/empty
untracked_repo/

$ git ls-files -o untracked_dir untracked_repo/
untracked_dir/empty
untracked_repo/

So it will traverse into the untracked_repo when specified as
'untracked_repo/' but not if there are more than one pathspec given?!?
 And it traverses into an untracked directory regardless of the
trailing slash?  <sarcasm>What a paragon of consistency...</sarcasm>


At least my changes in git-2.24.0 made the behavior consistent; it'll
always traverse into a directory that matches a given pathspec.  As
for whether that's desirable or not when the pathspec is a submodule,
I'm not certain.  My fixes to dir.c stalled out for over a year and a
half despite a few reports that they had fixed issues people were
continuing to report in the wild because the whole traversal logic was
such a mess and there were so many dependencies on existing behavior
built up with that mess that it was really hard to determine what
"correct" behavior was and others seemed to be unwilling to wade
through the muck to figure out where sanity might lie so they could
help give me pointers or opinions on what "correct" was[2].

But here are some possibilities that at least sound sane:

A) ls-files -o should traverse into untracked submodules.  This case
is easy; the code already does that.

B) ls-files -o should NOT traverse into untracked submodules AND
should not even report them.  If so, fix looks like this:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f069a028ce..f144d44d8b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -301,6 +301,9 @@ static void show_files(struct repository *repo,
struct dir_struct *dir)
        int i;
        struct strbuf fullname = STRBUF_INIT;

+       if (!recurse_submodules)
+               dir->flags |= DIR_SKIP_NESTED_GIT;
+
        /* For cached/deleted files we don't need to even do the readdir */
        if (show_others || show_killed) {
                if (!show_others)

C) ls-files -o should NOT traverse into untracked submodules, but
should at least report their directory name.  If so, the fix is
probably to move the DIR_NO_GITLINKS if-block within
dir.c:treat_directory() to put it right next to the
DIR_SKIP_NESTED_GIT if-block (and maybe even partially combine the
two) so that it comes before some of the other code in that function.
Might have to be careful about checking for the presence of trailing
slashes.


It seems like it should be clear which one of these is "correct", but
I seem to be short a few brain cycles right now...either that, or
maybe my very rare use of submodules and nested repositories means I
just don't have enough context to answer.  Maybe it's obvious to
someone else...


Elijah

[1] https://lore.kernel.org/git/xmqqefjp6sko.fsf@gitster-ct.c.googlers.com/
[2] https://lore.kernel.org/git/20190905154735.29784-1-newren@gmail.com/
