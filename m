Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09AC33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE802176D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLgrjwW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAPIG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:06:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36244 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPIG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 03:06:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so9514229pgc.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 00:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbxrEbRSvAupZjoO1jni4Fqnvo/H7VfoW4juW0KTXZE=;
        b=jLgrjwW2Gdhw6WIRX6XI0zpyNjsfZPcyTVh53SQdqvQcK44XiJfEycOTj14uGUwxcr
         xstMfJREYTQArD8T9NzzSC8u+7sTaSpjpi5WJ/xU3GCSq/2DmMZmI4SD9qou0JBUdKnJ
         i9ufocXghs+l1BEteyZxZgkk5hCceJ6yGLrZ67WHijoZXKwwJUxW9SduGYcsMuMAHVTo
         KO7SU7whvP+wrRSg0m/DBmZe4MsLmQ0eJulM/3Xik5s27Zfej2xD1ZYxKD3wUbvVZn8P
         kLT3x9enkZtLqEnS+64DU5Cp6Fmt3v/WHNM45EzCQbVbIZGVv1pBDYl8VT2TJOHGEbn2
         oV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbxrEbRSvAupZjoO1jni4Fqnvo/H7VfoW4juW0KTXZE=;
        b=VTFuhHGuYjCTwH94n5cYN2Kh12wCkDRq0rJOPYhW1qsrdFY5Vl1cQ4rsDiOji/PTQe
         YqFgQSCSnXU6V+GkEEUeX1OghtvREKaCFZ5Hq4ivrsZccz5KnWOJ+8K0N4WtQNhgIz1A
         Sk6GOGIWZbkrKFSs475gns+5iXT6CvcaaMiY7KfKdyBjTEyU+2/xTVcRlYYScHsXr8BC
         gz3thS82flSWYktLng4oKkIdcH8ktl4PoiM1r8zUGCjWzoJ5ewOx1VOV0iH8wXSOrl+n
         Q7LnfNSnudn9qpAhV5IRMuY/EVJwdAyqyBj4BbXPAS1labo7+9wD/KGEh0X0nEr+vK3r
         fE3g==
X-Gm-Message-State: APjAAAUaHdmq6i9BTf6SSIAuOzbZaJMWrndBByCh+V6m5oKoH1Z7oTLX
        MKhQTJoGP+ZEDoU4MYmvrdo=
X-Google-Smtp-Source: APXvYqw1zbt02GjB1peLB7lBVtpiQk6veANZeDTO1WL4ELzQi+G15sW2W5lKfLpsDtV+l/IkaRAW6w==
X-Received: by 2002:a63:26c4:: with SMTP id m187mr38379897pgm.410.1579161986648;
        Thu, 16 Jan 2020 00:06:26 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id j17sm24118194pfa.28.2020.01.16.00.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:06:26 -0800 (PST)
Date:   Thu, 16 Jan 2020 08:06:24 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200116080624.GA253496@google.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
 <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116075810.GB242359@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> 	#!/bin/bash
> 	# Sync gh-pages branch with master
> 	#########################################
> 	git checkout gh-pages
> 	git rm -rf -q .
> 	git checkout master -- .
> 	git add .
> 	git commit -am "Syncing gh-pages with master"
> 	git checkout master

Correction: I misread this one.  It was guarded with

	if [ `git rev-parse --abbrev-ref HEAD` == "master" ]; then
		...
	fi

which makes all the difference.  Another example is to compute ctags:

	#!/bin/sh

	~/bin/hook_ctags.sh >/dev/null 2>&1 &

Here's a fun one that updates a timesheet:
https://github.com/GokhanArik/git-hooks-timesheet

Sorry for the noise,
Jonathan
