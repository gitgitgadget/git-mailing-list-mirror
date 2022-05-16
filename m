Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E46C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 13:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiEPNIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243682AbiEPNIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 09:08:07 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2E13F7E
        for <git@vger.kernel.org>; Mon, 16 May 2022 06:07:56 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u35so11938372qtc.13
        for <git@vger.kernel.org>; Mon, 16 May 2022 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBD50XmwtZcNvmOUFWKZ6+CUwOfv9WH0RalMYtUosDg=;
        b=HEgzIMrwveYbEsms4SSjFVY6tovFMzDt45yACMmc3SmQEpWKL9Z5yL6+3khm0YRMob
         LncihEQvPFtok06HYOW2AAq211+zo8uvmT/0sgVY8LwZ0DCqLhk2Dk6Wince6IJPQycT
         /lpmKrwe+Bwh1WF9GpeDR0oi6mwJ8dUHMXSfWbIhGzMIJ3doABnLwOgY2OuHC87cOV5c
         XpgcVEqaWCsW6djAed7DRW1c6sPBZs5WqkNbqm6S7enKu7128PZlyyQhY1Xn5Pfz+tx/
         jDOmDHDCsEH7zLEq7USKV/Bl0dv5B9fiaC5t3QfFMiJ90qcaAMZwru56ufki5JzVFcr2
         DLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBD50XmwtZcNvmOUFWKZ6+CUwOfv9WH0RalMYtUosDg=;
        b=cJUJNa731do9xlBf+N1r+oRxBM7Ro9BO8QomsFKTLPzn6nb46BEtJUlMm0SDt1AuhO
         qRqG/7Px6fO50tKpS3AN87SEYaDD7mKKVv9aVde6ZGybjN4ZOTxQua/yJenEMP1Tnih2
         NEsJjZ7icWxFCL32e8XCZvP+ZPdf6Hy+Ui/50HxW91Nmp7oZyOUd1n2FeeKUk/WFqu11
         cWQUPsHpngz2zFjw7RxjHYs9MnbZnraDC3hyW6ikjk9HftXZgWzqeJ7cSBjoXUEKYtYV
         zTiH0khpvpaqa2+6jrBDE8Nv8cOBmutQA5XctrTfKhEUFWBg0SDHdEaJGchaXMa/9ANa
         fhpQ==
X-Gm-Message-State: AOAM533e3PCfIgy6x+5cAof3okYXj3fCAKJi21HjLb385QPGijDkGpVB
        RTCwKOAvpbwHyVYq8fU2ps4=
X-Google-Smtp-Source: ABdhPJwjUEp7OnYsTwRGd0EZhRxsxusFrMU+D+SGA2aUQ9+QlZ8IEcgxrrkE/IWq4lmNSDcEWaSXOw==
X-Received: by 2002:a05:622a:1cd:b0:2f3:e050:dcc1 with SMTP id t13-20020a05622a01cd00b002f3e050dcc1mr15219240qtw.101.1652706475969;
        Mon, 16 May 2022 06:07:55 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002f3e2435ee2sm6138910qtx.63.2022.05.16.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:07:55 -0700 (PDT)
Date:   Mon, 16 May 2022 06:07:53 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
Message-ID: <20220516130753.kgelgbfovs5kze7h@Carlos-MacBook-Pro-2.local>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
 <20220513010020.55361-4-carenas@gmail.com>
 <xmqqee0ycjos.fsf@gitster.g>
 <CAPUEspj1JTG2Ujuk4O6ogo6qEQEwe-2aHF8J95xjX+OpY4cenQ@mail.gmail.com>
 <xmqqr14u7n4l.fsf@gitster.g>
 <CAPUEsphNOf37WB_xUuRNdfcz1TRRsSocbUoCbrmA3OjS_BTpdw@mail.gmail.com>
 <xmqqo7zy59p3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo7zy59p3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2022 at 10:27:04PM -0700, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> 
> >> Hmph, it may not be needed, but it should still work, in which case
> >> it probably is still worth testing, even with the optional patch #4.
> >
> > Just because it works, it doesn't mean we have to test it.
> 
> Yes.  It all depends on the answer to this question

Not quite, after all this is part of the "git" testsuite and therefore will
only apply if it would be testing git's functionality, and in this case it
does not.

More details below.

> Is it
> reasonably expected that any half-way intelligent Git user would not
> be surprised to learn that "sudo sudo git status" would be a way to
> work on a repository that is owned by root as root?  Given that
> "sudo git status" is a good way to work on a repository that is
> owned by you as root, perhaps the answer is yes, but I am not
> a representative sample ;-)
> 
> If the answer is yes, then we would want to make sure it will
> continue to work by having a test to protect it from future
> breakage.  If not, and "sudo sudo git" (or worse "sudo sudo sudo
> git") is something that would be imagined by the most wicked mind
> and no sane person would imagine it would be a way to achieve
> something useful, no, it does not have to be protected from any
> future breakage.

The answer is "yes", but it is because of a misunderstanding (which has
nothing to do with intelligence, but just experience with sudo and the type
of environment where it runs).

* sudo does NOT respect SUDO_UID, indeed is one of those few *NIX tools
  that doesn't even respect EUID but insist on only trusting the real id.
* once you run something through sudo, it creates an environment for you
  that is based on its security policy and not even the invoking user can
  change some of the parametersr it uses to do that, only "root" can.
* that means that once you invoke the first sudo, then the second runs as
  root and ignores the SUDO_UID the first sudo creates, so by the time git
  gets to run, it will only see the SUDO_UID that the one that invoked it
  creates, and since that sudo was running as root it MUST be the same than
  a root owned file/directory would use, hence why it works for that root
  owned repository and would fail in one that is owned by the original user.

there is no new functionality or code path difference inside git between the
first and second invocation of sudo, the only relevant difference is that
the starting environment from the two last processes in that triple chain
have different values for the SUDO_UID environment variable.

Carlo
