Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48BC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD0613D8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCGKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 02:10:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4EAC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 23:08:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t28so4079988pfg.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IHkknYJd+bZHWbiedkIwz4jIw5smo3n9sjDIXQq1CIw=;
        b=Y0hzcveU3z7QHJbYA6XwBtc0r2mmFZYeQC83DRtuVjkf9y0umpBl8kVNJUEXqoPbJB
         07tB/wgdidt2dllUmokJVTmw6/Ett8istuLSpebXUChM1NAz4DRNf1YxakyFyFXUJ3Ye
         ZP73JW31C3/uxFXylcuE/2lCkBqkPIwxlGYZBjXCH1dBpgfcDqJTCJN+U0PgHuqk8tBz
         SfU6QREXVWs6KASpP7T+hoLTW1tBFH9RvjRn89mZXopBunt4ZvLk+qrXw6WSgH9L6mWZ
         rQDSHXZhmJquIJJSANaYpLemAYw/Gl+vJpPklpvnXlq6/wFutNxOu3SBkpZDWWtMNekZ
         YsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IHkknYJd+bZHWbiedkIwz4jIw5smo3n9sjDIXQq1CIw=;
        b=CbqEMiDalaYSFRnd+IE/gXc31FS2/MeXIFnLqrpqY7YFnikpNFCGpYxfNDpU9fxPbe
         3pVHS7Uu8+/6Lv2b/GowVbQdP7rxvT54/G0M4wTQuBsA8kSPSNhlAoRWuxJ93V2r+2qM
         B3ELo7cbLI1sOFzW2M/7vvKovY1rvU4sC6LLSX78qAanzRiRvMTKJwrMOzFRHvWx+whF
         H3eQoFKmcbG5vER7OLJl+O6K3IAJ+D1UReXxA6x+wGIfr/UYA9o+So/KRwY1PG9hlS3o
         IohFeKm2Lo3sFZlA3E8CwBXv+EmbRuU1isUhtwdXn69Ir5bJkalRfnEsS0ZpyYefTAsw
         rJ6Q==
X-Gm-Message-State: AOAM531NoExXkonB/O9uM86FvzuP0uBo6eR/3da3mJuDkz/IHTARRmC9
        4CaUd8kHrNN73xpmD5dbvRj3avtBDhY=
X-Google-Smtp-Source: ABdhPJyevmnxswf0ySyzDoNNc2omBOaWb+/3gb2wynbn9r6bP7r8NakWR6M2F/sK0H5JAbgRpKPhCA==
X-Received: by 2002:a05:6a00:216a:b029:2df:3461:4ac3 with SMTP id r10-20020a056a00216ab02902df34614ac3mr30364109pff.80.1622700528799;
        Wed, 02 Jun 2021 23:08:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:55f7:bb5a:649e:8fe8])
        by smtp.gmail.com with ESMTPSA id 60sm1073301pjz.42.2021.06.02.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 23:08:48 -0700 (PDT)
Date:   Wed, 2 Jun 2021 23:08:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLhx7nIptHUwXfBD@google.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Bagas Sanjaya wrote:

> We wonder whether git send-email can support Gmail OAuth2 so that we can
> seamlessly send patches without having to choose either action. But however,
> we have to create a GCP project [1] first in order to enable Gmail API. This
> can be overkill for some folks, but unfortunately that's the only way.

Yes, that's how I have mutt and other tools working with my Gmail
account set up.  See [1] for details.

> If we want to enable support for Gmail OAuth2, should we hands-off API
> configuration to git send-email users, or should we configure it on behalf
> of them? Note that when we go the former approach, some Gmail users simply
> can't afford GCP pricing for whatever reason

I didn't have to pay for GCP in order to set this up; I only had to
follow the instructions at
https://developers.google.com/identity/protocols/oauth2 to create a
client ID and client secret for oauth access.

Alas, I don't think Git can provide its own client secret to do this
out of the box.  I could imagine Git providing a way to supply an API
key at build time, but distros would need to go through a procedure
similar to [2] to make use of it for their own builds.  If someone
wants to set that up, I think that would make sense as its _own_
separate package --- e.g. a "sendgmail" command that "git send-email"
could use via the --sendmail-cmd option.  That way, it would be useful
for a variety of calling programs and not just Git.

Thanks and hope that helps,
Jonathan

[1] https://bugs.debian.org/905551;msg=5
[2] https://www.chromium.org/developers/how-tos/api-keys
