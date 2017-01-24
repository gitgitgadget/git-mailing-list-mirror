Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7048C1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 22:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbdAXWTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 17:19:52 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36092 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdAXWTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 17:19:51 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so52955079pfu.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 14:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1XDXzc+AjRloCyUlpW8EUIh1la73MZsx+Mkf7xpx3g=;
        b=NfqlbOq2YXJMEHo21uOFhl5D/KW6wS9ajs3Mzkxyi2tdlQ139lN/CeOxVcC7TFPWQZ
         Of88rzis7+CLg+/QRXUY1xkhGsqeVc96i2wkQWfMGc3mF69IoWJmHKTWxAX+LlfS6xKH
         I2RR6inQ/i1z/NqehtWReJUd+dp4lqbjArSQO2P6iVQE9jsQHHXKNDh5QKzoD+xv5wlh
         CAHQCfaPoCDnPTu01u4McOj9YLDztyXhyXcMCw8AIQXe6Z+jssP69Rlbwh3yBKlInnNb
         vmLV8xUNNiLCaEiG89wClLRO3FRvfeZkYWbVZqM3ko/UbO+13IfutUBD7dl9Nkt1sojR
         fNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1XDXzc+AjRloCyUlpW8EUIh1la73MZsx+Mkf7xpx3g=;
        b=dZRIePg1CnibPqV37cdBkNechrKC8KNIo1xQ0rCOcjtATgZfijbLR0sHNlHDBYCZ1j
         xaFdJjOOT3jxYwIQg+GZ17JnAbvYm5vbaASaYXUzi5Llz1wfb43GnA713TP1KVH1ZKoP
         hnwz4fd6SAp57r0IepERtfcls0/eccv/sA0uvsG4mftbbJzKhnVnbAZoFodgycLTp8A9
         Ds4vI1au1yVyxzkO5iILzWIaCHgyRKb5PbDdQCnn/LGaBxuSAVGNAY7Fol2b3O9HKiw/
         0Evnw7pLigSk4TG5TOkwNk/ncP2osPRLqdAD6A28MQJky4KHV0uXiMO9QXe3phz5CHA2
         UJLA==
X-Gm-Message-State: AIkVDXKwQZb8YokCn3jOw4KIq0W/gjI69wACqjfgs7tj1iq1PN00ulZOoL/G29FrEteK0Oo/
X-Received: by 10.98.150.70 with SMTP id c67mr19638519pfe.84.1485296390339;
        Tue, 24 Jan 2017 14:19:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:85e5:5d8f:4777:ba11])
        by smtp.gmail.com with ESMTPSA id f3sm47093128pfd.10.2017.01.24.14.19.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 14:19:49 -0800 (PST)
Date:   Tue, 24 Jan 2017 14:19:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
Message-ID: <20170124221948.GB58021@google.com>
References: <20170124210346.12060-1-sbeller@google.com>
 <20170124215851.GA58021@google.com>
 <CAGZ79kYKkx441bbU5Oy9Ernb1FmbcTybYbL_M_+yWG_ycfPwrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYKkx441bbU5Oy9Ernb1FmbcTybYbL_M_+yWG_ycfPwrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/24, Stefan Beller wrote:
> On Tue, Jan 24, 2017 at 1:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 01/24, Stefan Beller wrote:
> >> +     if (read_gitfile_gently(old_git_dir, &err_code) ||
> >> +         err_code == READ_GITFILE_ERR_NOT_A_REPO) {
> >> +             /*
> >> +              * If it is an actual gitfile, it doesn't need migration,
> >> +              * however in case of a recursively nested submodule, the
> >> +              * gitfile content may be stale, as its superproject
> >> +              * (which may be a submodule of another superproject)
> >> +              * may have been moved. So expect a bogus pointer to be read,
> >> +              * which materializes as error READ_GITFILE_ERR_NOT_A_REPO.
> >> +              */
> >> +             connect_work_tree_and_git_dir(path, real_new_git_dir);
> >
> > So connect_work_tree_and_git_dir() will update the .gitfile if it is
> > stale.
> >
> >> +             return;
> >> +     }
> >> +
> >> +     if (submodule_uses_worktrees(path))
> >> +             die(_("relocate_gitdir for submodule '%s' with "
> >> +                   "more than one worktree not supported"), path);
> >
> > No current support for worktrees (yet!).
> >
> >> +
> >>       if (!prefix)
> >>               prefix = get_super_prefix();
> >>
> >> @@ -1437,22 +1448,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
> >>                                     const char *path,
> >>                                     unsigned flags)
> >>  {
> >> -     const char *sub_git_dir, *v;
> >> -     char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
> >>       struct strbuf gitdir = STRBUF_INIT;
> >> -
> >>       strbuf_addf(&gitdir, "%s/.git", path);
> >> -     sub_git_dir = resolve_gitdir(gitdir.buf);
> >>
> >>       /* Not populated? */
> >> -     if (!sub_git_dir)
> >> +     if (!file_exists(gitdir.buf))
> >>               goto out;
> >
> > There should be a is_submodule_populated() function now, maybe
> > we should start using it when performing population checks?
> 
> Yes I am aware of that, but the problem is we cannot use it here.
> is_submodule_populated[1], just like the code here, uses
> resolve_gitdir, which is
> 
>     const char *resolve_gitdir(const char *suspect)
>     {
>         if (is_git_directory(suspect))
>            return suspect;
>         return read_gitfile(suspect);
>     }
> 
> And there you see the problem: read_gitfile will die on error.
> we'd have to have use read_gitfile_gently(old_git_dir, &err_code),
> and then allow READ_GITFILE_ERR_NOT_A_REPO to go through,
> just as above.

Hmm, then maybe is_submodule_populated should be rewritten to not die on
an error then?

> 
> And that is also the reason why we had to move submodule_uses_worktrees
> down, as it also uses no gentle function to look for a git directory
> (read: it would die as well). When you have bogus content in your
> .git file, there is really nothing you can do to determine if the submodule
> is part of a worktree setup, so it is fine to postpone the check until after we
> fixed up the link.
> 
> So here is the bug you spotted: If it is a worktree already, then
> read_gitfile_gently would work fine, no need to "fix" it.
> 
> I'll resend with logic as follows:
> 
>     char *retvalue = read_gitfile_gently(old_git_dir, &err_code);
>     if (retvalue)
>         // return early; a worktree is fine here, no need to check
>         // because we do nothing
> 
>     if (err_code == READ_GITFILE_ERR_NOT_A_REPO)
>         // connect; then check for worktree and return early;
> 
>     // do the actual relocation.
> 
> 
> [1] as found e.g. at
> https://public-inbox.org/git/1481915002-162130-2-git-send-email-bmwill@google.com/
> 
> >
> >>
> >> -     /* Is it already absorbed into the superprojects git dir? */
> >> -     real_sub_git_dir = real_pathdup(sub_git_dir);
> >> -     real_common_git_dir = real_pathdup(get_git_common_dir());
> >> -     if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
> >> -             relocate_single_git_dir_into_superproject(prefix, path);
> >> +     relocate_single_git_dir_into_superproject(prefix, path);
> >
> > So the check was just pushed into the relocation function.
> 
> The check was pushed down, so we can use the
> connect_work_tree_and_git_dir instead.
> 
> >
> >>
> >>       if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
> >>               struct child_process cp = CHILD_PROCESS_INIT;
> >> @@ -1481,6 +1484,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
> >>
> >>  out:
> >>       strbuf_release(&gitdir);
> >> -     free(real_sub_git_dir);
> >> -     free(real_common_git_dir);
> >>  }
> >> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> >> index 1c47780e2b..e2bbb449b6 100755
> >> --- a/t/t7412-submodule-absorbgitdirs.sh
> >> +++ b/t/t7412-submodule-absorbgitdirs.sh
> >> @@ -64,6 +64,33 @@ test_expect_success 'absorb the git dir in a nested submodule' '
> >>       test_cmp expect.2 actual.2
> >>  '
> >>
> >> +test_expect_success 're-setup nested submodule' '
> >> +     # un-absorb the direct submodule, to test if the nested submodule
> >> +     # is still correct (needs a rewrite of the gitfile only)
> >> +     rm -rf sub1/.git &&
> >> +     mv .git/modules/sub1 sub1/.git &&
> >> +     GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
> >> +     # fixup the nested submodule
> >> +     echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
> >> +     GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
> >> +             core.worktree "../../../nested" &&
> >> +     # make sure this re-setup is correct
> >> +     git status --ignore-submodules=none
> >> +'
> >> +
> >> +test_expect_success 'absorb the git dir in a nested submodule' '
> >> +     git status >expect.1 &&
> >> +     git -C sub1/nested rev-parse HEAD >expect.2 &&
> >> +     git submodule absorbgitdirs &&
> >> +     test -f sub1/.git &&
> >> +     test -f sub1/nested/.git &&
> >> +     test -d .git/modules/sub1/modules/nested &&
> >> +     git status >actual.1 &&
> >> +     git -C sub1/nested rev-parse HEAD >actual.2 &&
> >> +     test_cmp expect.1 actual.1 &&
> >> +     test_cmp expect.2 actual.2
> >> +'
> >> +
> >>  test_expect_success 'setup a gitlink with missing .gitmodules entry' '
> >>       git init sub2 &&
> >>       test_commit -C sub2 first &&
> >> --
> >> 2.11.0.486.g67830dbe1c
> >
> >
> > Aside from my one question the rest of this looks good to me.
> >
> > --
> > Brandon Williams

-- 
Brandon Williams
