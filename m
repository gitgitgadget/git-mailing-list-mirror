Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28908C4D2EB
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBFC24787
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQhYxYVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfLMUP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:15:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35865 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMUP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 15:15:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so75448wma.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FsEURgA8pJzxQjkx5rlabC2ZCSjiKmDLNkf5jVDLJU=;
        b=LQhYxYVoDNUM6jGHGSSpv8a+UFUmOApMUDVS2y7vcTRzrgbo2o7wpGAB8HbllzsyD0
         DxCxjr4R66hRZGYERVjawFWW84RbpzJeFY7VDAuBqb6GLltiQOz1HFjU75tzVNDhQcBI
         oGc65FIHstDT24kDGJKTieNYkIXCJwojrRsVvmWO9Z0rlvrpttuS8erR/SJ49dRu3jqP
         lADv8oT8ca5avX++dmxkiFiZKx7CkEi74PUuDIvD+UwijG5S9RwKTmGwCLAbtfOuzNyv
         gpxMZN6qrxxZWEw+SOqmmQYGUb2qGzIFxJboj4sq7xGhd7+CthPKY2brWt4pFRb228C+
         e5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FsEURgA8pJzxQjkx5rlabC2ZCSjiKmDLNkf5jVDLJU=;
        b=NQN7Wp5tv8R/Zytnmty9qhhoeEiNTNaH1zKJwfBZzu5XozbUkXO2hOKn1CpZT0ztjk
         nKIzoyUYoWFI2MFc/g8x2G+JgD0dqgkf4a26wcUZFWnbi3SdePiJMoiuWgwiqrwfqHMs
         82aTWwewcxvl2NHlDLuk8xYmxszOLu3VqymH3pM7XgAGbZfIJkvti3zFqc6T9Ieieu6e
         H9y+xRqRx8qnbiCQxmk1wx8V4/sLPVsiU/grdh6eS4FAHq9+kfdOmJv+4arJpS+xePj3
         k2VFw6pcWqGGHKqdfBDQUAa5rv6ADC2S5CptNtUnEuUT2bu0aKqc4l8g9C9mMJmP2APS
         5vlQ==
X-Gm-Message-State: APjAAAVo3diJbn00OK6DtRV93o8TCRRIDhSLObqi0xzNcw5HUJDyY0b6
        RhceX9pO5RMROvEZNC1HrWqQWsdD
X-Google-Smtp-Source: APXvYqyFxvQPIbOfqzzfp6REEk1QdraRFmBMwzc7CrV7T27FjpSrAvC0erTW/DrvDvvevSLNK7oY9w==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr15021361wmb.174.1576268124608;
        Fri, 13 Dec 2019 12:15:24 -0800 (PST)
Received: from szeder.dev (x4db954a5.dyn.telefonica.de. [77.185.84.165])
        by smtp.gmail.com with ESMTPSA id p26sm11305108wmc.24.2019.12.13.12.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 12:15:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 21:15:22 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
Subject: Re: Parallel fetch and commit graph writing results in locking
 failure (even on linux)
Message-ID: <20191213201522.GM6527@szeder.dev>
References: <492636883.190386.1576264842701@ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <492636883.190386.1576264842701@ox.hosteurope.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 08:20:42PM +0100, Thomas Braun wrote:
> Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> 
> (Sorry for the german text, this is not easily reproducible.)

It's unrelated to your issue, and I'm not a native German or English
speaker... but that translation doesn't look quite right to me.

The original is:

  _("Computing commit graph generation numbers"),

where the word "generation" isn't used in the sense of "creation"
(erzeugen, generieren), but rather as in "generation gap" or "my
parents are one generation older than me".  So I don't think that
"Generierung..." is the right word to use here, but perhaps
"Generationsnummer".

But who am I to argue about German software ranslation?! :)

