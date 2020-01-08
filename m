Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C52C33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 01:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A442080A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 01:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKZ5TgJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHBos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:44:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44154 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAHBos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 20:44:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so727416pgl.11
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 17:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iiyZFtazdsLrERaHd9h5/5w053h4XcUheS2prlOj5Fs=;
        b=NKZ5TgJR2M08BWTjzWff3rHjvn77rcHMp4NMox3fvPm7jifJnGv6Abg5DJr0BZP1lY
         SHd+iCt4Os8rxMWBZlaJcgyXFpuU02x29bxYgWCh8S2HH04D2jmypeXtQu5FVtUupnjR
         fATsrBWrko/oXt1JeWcmnwBWL1nMpJwpFPYsR/3oB3hMcTs3f32zzr4sMNTz5kwl2dYA
         LK3frCfAesoG1yNXqz8yw2UfVx2bSyxbVG1+LaIfLQdPZuGkhbQiRZEFmMPytVH0JwNk
         fpOu9rMPdSs7XX+MQNDDo4bLhRhhzvC4YOlC9EtSlnEnjLB0mlnfIDvo6utoUeLsilAm
         sQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiyZFtazdsLrERaHd9h5/5w053h4XcUheS2prlOj5Fs=;
        b=IGsUZZzryrTK2R1wnzC8nluty+fVCMikdIbqaTUO2c1K0K1JX4JHOoPTh+hfhk5+1O
         yC6zCzssGCGAayLXKcjuaWNiWw/epUXOk/6ukmYyFDQRieJU7hX6yuU/zW2dqE52zhc4
         yC+4EyDRtusWBSC0NH0dofX0jVtB0bSBjuHI6MaBN9BJSr31Z7MeLJmSVc+HzI8+s+9V
         xJGo2Px8w3akvS06io/JpgocR1KsrOyiSL+eH/psZt8KV0lY/WNNqJerY+L2A6bFs5mA
         PVWHD/CaWogDEBwRqgcG8sbnpXqtTBQccP0ddT72a0CYoTfM68xepKG4oTMOY3DDhstd
         i/qg==
X-Gm-Message-State: APjAAAXIkFkTayPg18LdZyJdgzBolwYOlXif4EdvUEew5kiSzPm91L03
        2+JG3QETHzKwWvg/eSYCf06ug0N3AQc=
X-Google-Smtp-Source: APXvYqxi39s4ZeSgbKXL7xfGySmJhU5IEG2SHahBxNPAWUfneBDo1sJtEL4XrWVGVxf4+HtkaZ/d0A==
X-Received: by 2002:a63:1344:: with SMTP id 4mr2801381pgt.0.1578447887044;
        Tue, 07 Jan 2020 17:44:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z22sm876654pfr.83.2020.01.07.17.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 17:44:46 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:44:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
Message-ID: <20200108014442.GC181522@google.com>
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
 <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <xmqqh8176xab.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8176xab.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 08:34:04AM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> [jc: skipped all the good suggestions I agree with]
> 
> >> +                                       }
> >> +                                       else {
> >> +                                               advise(_("The branch you are trying to delete is checked "
> >> +                                                       "out on another worktree, run the following command "
> >> +                                                       "to checkout a different branch then try again:\n"
> >> +                                                       "git -C %s switch <branch>"), wt->path);
> >
> > I like the use of -C here because it makes the command self-contained,
> > however, I also worry because wt->path is an absolute path, thus
> > likely to be quite lengthy, which means that the important part of the
> > example command (the "switch <branch>") can get pushed quite far away,
> > thus is more easily overlooked by the reader. I wonder if it would
> > make more sense to show the 'cd' command explicitly, although doing so
> > ties the example to a particular shell, which may be a downside.
> >
> >     cd %s
> >     git switch <different-branch>
> >     cd -
> >     git branch -%c <this-branch>
> 
> Note that wt->path may have special characters that would need to be
> protected from the user's shell (worse, the quoting convention may
> be different depending on which shell is in use).  That is one of
> the reasons why I would suggest to stay away from giving an advice
> that pretends to be cut-and-paste-able without being so.

Hm, I think you've sold me on the error of my ways trying to push for
copy-pasteable advices :)
But I wonder, how much is too much? I mean that suggesting a single Git
command which takes a branch name and a pathspec is safer than
suggesting some complicated -C=foo or cd bar thing, right?

> In this
> case, <different-branch> and <this-branch> must be filled by the
> user anyway, and the only thing worth cutting-and-pasting is the
> path to the other worktree, not the "git -C" or "cd" that users
> should be able to come up with.
> 
> 	"The branch is checked out on another worktree at\n"
> 	"path '%s'\n"
> 	"and cannot be deleted.  Go there, check out some other\n"
> 	"branch and try again."
> 
> or something like that, perhaps?  
> 
> > (It is rather verbose and ugly, though.)
> 
> I tend to agree.  It also feels to me that it is giving too much
> hand-holding, but after all advise() may turning out to be about
> giving that.

Well, if advise() isn't going to hold their hand, who is? ;)

What I mean is, I think that's indeed what advise() is about, and the
reason it can be disabled in config. To me, the harm of giving too much
hand-holding seems less than the harm of giving not enough; to deal with
the one requires skimming past things you already know, and to deal with
the other requires web searching, asking people, reading documentation,
perhaps gaining "tips" from questionable blogs which don't actually give
very useful advice. I think we were just discussing not long ago the
general quality of advice on StackOverflow, for example.

 - Emily
