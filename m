Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3761DC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12167208E4
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Rtgp95fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgEFRhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:37:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F13C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:37:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x2so1357258pfx.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5jNN2qYwhcrSMDI7zdPs7cGooK8KcT6WdI5CfE5fBXE=;
        b=Rtgp95fHulSmquLIQyiehSWPomNbJ+fTpBL0Bb0OFK9WAm+CMTpL5rNioDJD4/J8i2
         B55ccGs9MlYp9AlUHGFzQtn6+fgZeuNSnVU52KY/Tf62jsnIwkwYe2JhtEJ2yfRkQvtN
         5UrYYq91xHwt7QNEL0FKG8X5l5Guc633RwJZ2cYA3OBd4g75gLQ0fCnSBThkoKLkWG+V
         /lw96myLdhuirCdoLrlPFeu0eH6aYF1NRoCgqSngW9w3+JQG1HwWy2XgF3PShthM0l4R
         L0I7w1KrsmckRcJhSsL0+/naxShFLhaO0AG+kzWUaysi6zmZLRgmyOdOkbWW1uE1QNWU
         ryYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jNN2qYwhcrSMDI7zdPs7cGooK8KcT6WdI5CfE5fBXE=;
        b=I018gzdh42Drpsj9uYBWD7M7uln0vVOPQgyfLnWtFvhEtv4H0ir5r3fyq7l8H5oJkG
         tCq8wtyH4rUyurGXivALxZYwsew51tL4fW1jTKelEO5kJeXlU1CIWf9GLGbBGWvuZAte
         Plln6ikz2Z8d7spUdXoBdtkaCtQa4Yi3y79hPDKih4wRlhAQgfAknayZW+IWyO0OwIUB
         0rTFRQr/CzDkDZkQdRQMW0P6r/2uXqBngD3sK3AUd2RFYW0jvdkFJrqzOJ65O2HH+vmV
         V+iExdnSz85IxlM7vMhy4F+PPFsxQ/T9LsfdNNKLjb0vrSBnc9nL0986vYbtkziZgypI
         EEUA==
X-Gm-Message-State: AGi0PuZ4KEYHMMbiMJGJUFIBPAsY+VzGGZ4CVpDiBStgCxTaigQldlr5
        s3NXRZQfOY2a3PmnQR2hz2hbXIrFN7I=
X-Google-Smtp-Source: APiQypKI5ZfxGDKxRTK7+RVQEz/VLDkQBzg1Iy4waJCD4XqUg6pCa+Minw7c7OpBJIn72/3FKDkh5w==
X-Received: by 2002:a63:564e:: with SMTP id g14mr8314040pgm.63.1588786635156;
        Wed, 06 May 2020 10:37:15 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g6sm5206319pjx.48.2020.05.06.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:37:14 -0700 (PDT)
Date:   Wed, 6 May 2020 11:37:13 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Claus Schneider <claus.schneider@eficode.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] subtree: use say and exit 0 rather than die in case of no
 new revision found scenario
Message-ID: <20200506173713.GD6078@syl.local>
References: <CA+GP4boTMaShBbJUQUA0GThpXXPiCQHFGKFYUYLE3mbsjSdqTw@mail.gmail.com>
 <CA+GP4boXi4tW23Z6CDF2v_ch2_7_dqhB_POAhi1FfYrEBG4DWQ@mail.gmail.com>
 <CA+GP4brpeGhBy3LF0LomDO-AOEZS02tOi2phQ4e1XoTGgeAx2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+GP4brpeGhBy3LF0LomDO-AOEZS02tOi2phQ4e1XoTGgeAx2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Claus,

On Wed, May 06, 2020 at 03:11:49PM +0200, Claus Schneider wrote:
> Hi..
>
> Currently subtree dies if "No new revisions found" which is hard as it
> is a non-operation.
>
> I suggest using the "say" command rather than "die".
>
> It will then become easier just to call "git subtree split" and you do
> not need to handle this special case.
>
> Patches can be found here:
> https://github.com/git/git/commit/fe435a1ba128698f6acb69ee1891c45be32610fa

Thanks for your patch. The Git mailing list reviews patches over email,
so please re-submit this (and the other two patches) you sent to the
list here.

Detailed guidelines on how to do that are here:

  https://github.com/git/git/blob/master/Documentation/SubmittingPatches

and

  https://github.com/git/git/blob/master/Documentation/MyFirstContribution.txt

Alternatively, you may use GitGitGadget, which makes it convenient to
send patches to the mailing list from GitHub's UI. More information
about that may be found here: https://gitgitgadget.github.io/.

> Best regards
> Claus Schneider

Thanks,
Taylor
