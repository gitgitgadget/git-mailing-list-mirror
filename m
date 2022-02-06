Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92545C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiBFWrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiBFWrq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:47:46 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F07C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:47:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c192so8650145wma.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ku53glgdwgC22ARRi588zxruTHU0Nsl1GOUfdeXiFWE=;
        b=TVDHJ0fm5P5KpXIGcV+0yz5G5cOgDObi3vRlhOP845PxlVhkPpSQHEa3DiweM0f43B
         //ITTAmaUxfkjiTLVOC8Fz0imxMKkodRZ1vfs4hPhfb4WSheuseEcKPi8kySqkG4pMOF
         /EbgN4KCpJlAV6rD6qPkbaNU9YzcgnT6kZwwONS+KeccjGVJrqGvDyGXopS94AY5O3lR
         84T9xuFTi0uT3EwqTLsWnv9TSL/rxUTbvONGr8a2G1yL0S6u4oTNFAiLbB9lkuI7tngL
         4vHFW6ubd9cEPtMFJdGshShw3fGzK9DxNOCeiIuo1/laZ38jAC53m+ljr9cDpFy9PsBK
         pf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ku53glgdwgC22ARRi588zxruTHU0Nsl1GOUfdeXiFWE=;
        b=kfiJ5RZU4GgfTRieqmhenBTg4nZqS7jVAroIAJQlQLmFbIqvHsExirdDXCigNh9EZr
         P4kLYauu4yE5sRytZq0mqsasIEfklj2HWgJbKM2kxwBL6giPn3sh3Sso4ETlbXV2O0k5
         M0tPmz0fQ7k/O2waWI1OuTIcxR5SAmNsjfSIS4eP3GMwpbtW/aM2h82SGsNSC3eHTHzT
         ZJgJSeUPnqzdWprMrcjy6yJCuItNj1vaWBekRdZJUCNqECMMN8/p79dkN83pkcWHTsda
         kNMedlwGoXsTo1K4Wt3g5d9NLv5F3e8vymhbGB1D5cXMoYSnAgOqPdY9XevhDsiEaP5c
         tAXQ==
X-Gm-Message-State: AOAM531KtbNOL6uWWQauLfvKrTmAz7Lu+o4QzkmdKvYc9zFI1l//V0Bl
        BkjjcVtsCoidjavDdmM2XMM=
X-Google-Smtp-Source: ABdhPJwWeTWa9YvtUJ1socQxwwZs/3lr5PEZci6EHKLoiqu6Cz7O705SWXVWFBXyqwmmJCQxxXOJLw==
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr8669512wmq.106.1644187663010;
        Sun, 06 Feb 2022 14:47:43 -0800 (PST)
Received: from szeder.dev (94-21-146-211.pool.digikabel.hu. [94.21.146.211])
        by smtp.gmail.com with ESMTPSA id az16sm7431842wmb.15.2022.02.06.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:47:42 -0800 (PST)
Date:   Sun, 6 Feb 2022 23:47:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Hongyi Zhao <hongyi.zhao@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Sm/Do28=?= Victor Bonfim 
        <JoaoVictorBonfim+Git-Mail-List@protonmail.com>
Subject: Re: [PATCH v2 2/2] completion: add a GIT_COMPLETION_SHOW_ALL_COMMANDS
Message-ID: <20220206224740.GD1936@szeder.dev>
References: <patch-1.1-5f18305ca08-20220125T124757Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20220202T111228Z-avarab@gmail.com>
 <patch-v2-2.2-2e2e3569e02-20220202T111228Z-avarab@gmail.com>
 <20220206133026.GB1936@szeder.dev>
 <xmqq8runiwow.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8runiwow.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 06, 2022 at 12:09:35PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > To complete only rarely used plumbing commands in a non-intrusive way,
> > in my experience, it's best to first attempt to complete only
> > porcelains and aliases, and fall back to complete all commands,
> > plumbing included, only when no porcelains match the current word to
> > be completed.  E.g.:
> >
> >   $ git d<TAB>
> >   describe   diff   difftool
> >   $ git diff-<TAB>
> >   diff-files   diff-index   diff-tree
> 
> So after getting
> 
>     $ git diff<TAB>
>     diff difftool
> 
> you _have_ to know, if you are not happy with these two, that the
> next letter in the name of the command you forgot is a dash,

Yeah, it can only save a couple of keystrokes, but it's not really
useful when you want to use it to jog your memory.  I naively assumed
that if you use plumbing, then you know what you are doing and which
command you want to execute :)

> to be
> able to say
> 
>     $ git diff-<TAB>
> 
> which is a bit unfortunate, but I agree that it is much nicer than
> getting all the plumbing when trying to complete "git d<TAB>".
> 
> I wonder if we can do better, and teach the completion logic an
> ability to say this: "I gave 'diff and difftool' after being asked
> for 'git diff<TAB>' and then the user is asking the same again
> without choosing either. Perhaps I should add less frequent one to
> the mix"?
> 
> I.e. the end-user session may look like
> 
>     $ git diff<TAB>
>     diff difftool
>     $ git diff<TAB>
>     diff difftool diff-files diff-index diff-tree
> 
> ?

Hrm, interesting, but dunno.  When completing commands in __git_main()
we could save the current word to be completed in a variable, and when
completing commands the next time we could check whether the current
word is still the same, and then include plumbing as well.  However,
when the current word can't be uniquely completed, then we have to
press TAB twice to get the list of possible completion, so we have to
preserve the last two current words, and only list plumbing when both
match.

  ---   >8   ---

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 377d6c5494..cda6b48c4e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3455,8 +3455,17 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				echo >>/tmp/COMPLOG "__git_main() cur: '$cur' last: '$__git_last_command_cur' last2: '$__git_last_command_cur2'"
+				if test "$cur" = "$__git_last_command_cur" &&
+				   test "$cur" = "$__git_last_command_cur2"
+				then
+					__gitcomp "$(__git --list-cmds=main,others,nohelpers,alias,list-complete)"
+				else
+					__gitcomp "$(__git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+				fi
 			fi
+			__git_last_command_cur2=$__git_last_command_cur
+			__git_last_command_cur=$cur
 			;;
 		esac
 		return

  ---   8<   ---

Superficial testing shows that it appears to work in common cases, but
we'll have to think it through when and how to clear these variables.
E.g.:

  $ git d<TAB><TAB>
  describe   diff   difftool
  # Oh, but I wanted to disable the pager
  $ git --no-p<TAB>
  # this completes the option uniquely
  $ git --no-pager d<TAB><TAB>
  daemon     diff         diff-index   diff-tree
  describe   diff-files   difftool

I think here it should list only porcelains, but because both those
last_cur variables still contain 'd', it lists plumbing as well.

And, of course, 'git <TAB><TAB>' in a newly started terminal should
list only porcelains, but it lists plumbing as well.

