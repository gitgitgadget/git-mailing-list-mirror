Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABEECA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 12:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3F3206B7
	for <git@archiver.kernel.org>; Wed, 13 May 2020 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRv5xIoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgEMMoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 08:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgEMMoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 08:44:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A3C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 05:44:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id a4so7738996pgc.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7GbGcl7YFfCdMI+u5N1vhbtR3YaG65q74ZFzZ7T1ThE=;
        b=CRv5xIojoQKgu2cnnfqUdYL8e2k2pIhR7pjjfip5sjVPZzjk5a1mG8PK22Sb1la0Sv
         gkRZ6SdMa74cVE1iA12C3YqKn/99Qt4TQ0hK+OqlmCzBYUrfbz8VvGsPRbo+1vCyWOi3
         ZxKv5hDg0sg3C+DkroQQHI4dv3CBTqwhrKKGnG/c4bFKaCRqIxTwmmqA1tfxgV0Q4bX7
         WBiXS304BLcw7QHT031tHokA45S6/WhRrTAx3APwMGOrLZxBw36pPXMMI6hWTExwqIFD
         OPj9oQ1darRBrEs01jNrHLwNLyUuh9DMCTpmCnk4CenDb8UCK4vFCx2Mbb/oh4mX4ziC
         ZnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GbGcl7YFfCdMI+u5N1vhbtR3YaG65q74ZFzZ7T1ThE=;
        b=PS3UyZUmXxW5mEz9TfB8cdidUF8wOz7ccsqpp85SmoMykFJ4umAOIAZmofqKMlAZl3
         nl6OPg/vj8K+btZbin9bsLYPq0AFGXqL3WLWqvrVgQpTkKPQAWfpOhLGOSnil9CNb9Jm
         CcYpT4Q/kngYQOiirTqtciXlCKzZz8C2GoaVjrmlhX4Nwm8YpASSLEfjdf3smdoNId23
         wOppVRmNEVudwRWcaNfpXUdyD9NYnLhbOOeojusM1rN/U3CtbLXc7rIzaF2EYQZavYoP
         Keu7FXleV+E3vPKmddcIxClsvvYFRnVk8Hgg/eFZ7ZKgSobqtlu8YGNlVwQ+6aO7omi7
         cYvA==
X-Gm-Message-State: AGi0PuZWEFVYkPlRfNsum2jMnusMi+Q3IlQiujr/5W9gzqfYg1HE4T5c
        wN9dR16SUw3AdptthZMInVkc9rPH
X-Google-Smtp-Source: APiQypKAbRxXthGqN34gORTcrES7hF1JIf2DB/heDCCRF1s9MQXqwbPp+rI4Tv02s3+MiALWph626w==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr23879594pgj.151.1589373849787;
        Wed, 13 May 2020 05:44:09 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id x23sm12961533pgf.32.2020.05.13.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:44:09 -0700 (PDT)
Date:   Wed, 13 May 2020 19:44:06 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid pounding on the poor ci-artifacts container
Message-ID: <20200513124406.GB1982@danh.dev>
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-12 20:47:10+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> -      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
> +      run: |
> +        ## Add `json_pp` to the search path
> +        PATH=$PATH:/usr/bin/core_perl
> +
> +        ## Get artifact
> +        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
> +        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
> +          json_pp |
> +          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
> +        download_url="$(curl "$urlbase/$id/artifacts" |
> +          json_pp |
> +          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"

Hi Dscho,

I wonder if it's acceptable to introduce jq (already installed in
GitHub Actions and Travis) into our codebase (only in GitHub Actions).

If yes, I think this will be easier to follow than depending on static
number of space and sed branching.
---------------------8<-----------------
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index e2e1611aa2..482df46651 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -13,17 +13,12 @@ jobs:
     - name: download git-sdk-64-minimal
       shell: bash
       run: |
-        ## Add `json_pp` to the search path
-        PATH=$PATH:/usr/bin/core_perl
-
         ## Get artifact
         urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
         id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
-          json_pp |
-          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
+          jq -r ".value[] | .id")
         download_url="$(curl "$urlbase/$id/artifacts" |
-          json_pp |
-          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
+          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
         curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
           -o artifacts.zip "$download_url"
 
@@ -104,17 +99,12 @@ jobs:
     - name: download git-sdk-64-minimal
       shell: bash
       run: |
-        ## Add `json_pp` to the search path
-        PATH=$PATH:/usr/bin/core_perl
-
         ## Get artifact
         urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
         id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
-          json_pp |
-          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
+          jq -r ".value[] | .id")
         download_url="$(curl "$urlbase/$id/artifacts" |
-          json_pp |
-          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
+          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
         curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
           -o artifacts.zip "$download_url"
 
----------->8------------

-- 
Danh
