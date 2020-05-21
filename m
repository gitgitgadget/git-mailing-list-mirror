Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B5DC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E57020759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfIfitoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEUTDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgEUTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:03:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F67C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:03:33 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so8266492qke.13
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oQFeI2cftX3LRrZCtddzTmsnecQRRZW9evDc0yaminA=;
        b=nfIfitoelDYCYGJFSm3HeScBk/rMd8VarNlvHxiTC+uubIdRa4VDay7wO0s2PWfkUF
         ByLUHWZ4yWMsuorYRqw55PQhGkvTtTQBLD+WcjPHEThYswbyMrWHqUFnPRCJ0YlVaQ0b
         VpsxxcD/MGVfFYiU5vAkkJaw7E/a1VcIztJpKubEUr7c1d3dRMaMSzhpee+gQXp4idXl
         8PnAn4tw2/81BilRzObszTTOy6JOYvptphQPVYDpD2gTZPRwfPYQF7ghiSsAGKs7yjU6
         hPBQuqWvJGjZT1lJFqGimCqNJC4BDIFxIImphquengSUMX+F7U/6kytxxT6U9DDnxIOp
         WlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQFeI2cftX3LRrZCtddzTmsnecQRRZW9evDc0yaminA=;
        b=tSa+ssGGE9035nh656xR9VCZbZ0hvhDipPCa1G4pYFTn/1Iw2hRtPTyKwXidN/QXjN
         pM3e2VrPJaZ49o8oki/pM9/TmiraJqipvCq8dJo7v3M2MTM/zuIVuzjvitibOaTMCsKh
         6+8qA1NbFc8gEG4HeTpp/nFfzLe2tI6Ioo5EUwjNqCdpR/e6Y5VdMKhmF7pJQhS0Azyd
         9Vnm368YM5ydXJpXGxdbKQe9qXmuMeFwx53l3G+Ysr/9dZNuxjJKohkllcO5395K7krj
         rGOZoOLTBi73tuBd/p3kFjO5vylaSrVLLEfzKuxaGmajf2d1aj+lDyi9GLMcF+cWtI6Q
         TvNg==
X-Gm-Message-State: AOAM533QgaP+fuibjN+nByYehlVTDb2Na7D9zoFowbyRx/nFnFj/S0qD
        Y72BbA+4GVZGVfIRggHwCsu7yRDb
X-Google-Smtp-Source: ABdhPJxbNl8wcEn32CFyOfjxQZHKMlgghK/DFYiEKbdTPZviGb6yiFVorLfUlB+SIWwE99g8MVUgCg==
X-Received: by 2002:a37:a42:: with SMTP id 63mr11767432qkk.399.1590087812952;
        Thu, 21 May 2020 12:03:32 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d74sm5553020qke.100.2020.05.21.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:03:31 -0700 (PDT)
Date:   Thu, 21 May 2020 15:03:29 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        congdanhqx@gmail.com, sunshine@sunshineco.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200521190329.GB615266@generichostname>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <xmqqk115ruux.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk115ruux.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 11:44:22AM -0700, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > Convert submodule subcommand 'set-branch' to a builtin and call it via
> > 'git-submodule.sh'.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Helped-by: Denton Liu <liu.denton@gmail.com>
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> > Thank you for the review Eric. I have changed the commit message,
> > and the error prompts. Also, I have added a brief comment about
> > the `quiet` option.
> 
> Sorry, I may have missed the previous rounds of discussion, but the
> comment adds more puzzles than it helps readers.  "is currently not
> used" can be seen from the code, but it is totally unclear why it is
> not used.  Is that a design decision to always keep quiet or always
> talkative (if so, "suppress output..." is not a good description)?
> Is that that this is a WIP patch that the behaviour the option aims
> to achieve hasn't been implemented?  Is it that no existing callers
> pass "-q" to the scripted version, so there is no need to support
> it (if so, why do we even accept it in the first place)?  Is it that
> all existing callers pass "-q" so we need to accept it, but there is
> nothing we need to make verbose so the variable is not passed around
> in the codepath?

As the original author of the shell code, I had it accept -q because,
with the other subcommmands, you can pass -q either before or after the
subcommand such as

	$ git submodule -q sync

or
	$ git submodule sync -q

and I wanted set-branch to retain that behaviour even though -q
ultimately doesn't affect set-branch at all since it's already a quiet
command.

Perhaps as a follow-up to this patch, we could stop accepting -q in
set-branch. I highly doubt that anyone is using it anyway.
