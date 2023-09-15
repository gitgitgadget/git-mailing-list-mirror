Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84DEED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjIOS3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbjIOS3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:29:07 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03833273A
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:28:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c0a7d54bdso11392447b3.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694802523; x=1695407323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mA6tN7UTJvOy+5emRhdGdgV8iWsNnByw9QayfEPnFDE=;
        b=j1JHBMp9rsffiDllPOo5mGQLoWWi7PIETGVaP1SaoAraRQysbWJttg/NotgB9SmSkl
         7oWu3V34B0f7PnEZVwHKS/MfHspYm6G8v4lHervkN9sN5dPj49ldKuNXLBQll2JFhWzm
         hwDA+8UNWfTqtihq8AubMQZDKzZ2RakwCZawH7f+xDoY9GDGZvnDanxLxfPdyYSl3+ab
         NRhK5BLVoRoqiiboiui4bSSvWZSobN1m9qPDHCAuaJgvAxxZo1boXDESOMDPIgS0gOoY
         Dszqi28TlHyyJDUcbuGPtzrE1LkvmifTDGonlRnBMdfDqXRVqTjxhVb9CAZi4tte+YPk
         XYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802523; x=1695407323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA6tN7UTJvOy+5emRhdGdgV8iWsNnByw9QayfEPnFDE=;
        b=ieEX7ZIHdKHhIsRjV6W18Bl5amLpPif4ALBfmoAaU1ouCuRFLT7GD6HOymfoD2xuuQ
         PfYccQh4tLI1/g3Os6VnUZh2JOlZxbAe1IMdUOR7Ra4UHyE1Hq4qurcCBHA1L8naP8Lv
         GoLKzwyMdcs18wjrj9NeKWBjAJPftQLry9HINyyhxn4kFVLQRGafGnPSC6MMxYZp99Mr
         ToeTmGEl7v7QennbKn7W/+VXi3k2VJIAMlF9Lcs0TUrKQkV8XT7KyyMjrW+o6bPsmD23
         3dXbozeXcyEDRSbwOinefzjDIg2kALAzQ+pLus2zwvEdgrOvCJ2AkPC3uxl/CqhFf6Rv
         qPCw==
X-Gm-Message-State: AOJu0Yxnyl6eWhx7PD87fuVzSL38ti/FBQm+35CVGiEOD0z3MU2WX1Db
        pPG3/JtddxNYJuI2z6XcBn25MAZouIGpHYzmB27F8g==
X-Google-Smtp-Source: AGHT+IFoOpYj8A9LlQVghRmPZ+1Z+QvIoJEQve+1D1y2880Ja7ob5zyuDNVAsWw+oypJZ2xZMcbQtw==
X-Received: by 2002:a0d:ee83:0:b0:573:bb84:737c with SMTP id x125-20020a0dee83000000b00573bb84737cmr2615852ywe.26.1694802523111;
        Fri, 15 Sep 2023 11:28:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a0deb0b000000b0059ae483b89dsm995693ywe.50.2023.09.15.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:28:42 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:28:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] updating curl http/2 header matching (again)
Message-ID: <ZQSiWXm3y07afjCv@nand.local>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915113237.GA3531328@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 07:32:37AM -0400, Jeff King wrote:
> (If anyone wants to confirm the bug or test, the new version of curl
> just hit debian unstable).

These two patches look sensible, and I can confirm that they resolve the
issue with the newest version of curl. With the latest 'master' (which
is bda494f404 (The ninth batch, 2023-09-14), at the time of writing) and
an old version of curl, I get:

    $ ./t5559-http-fetch-smart-http2.sh -vdi
    [...]
    expecting success of 5559.17 'GIT_TRACE_CURL redacts auth details':
      rm -rf redact-auth trace &&
      set_askpass user@host pass@host &&
      GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
      expect_askpass both user@host &&

      # Ensure that there is no "Basic" followed by a base64 string, but that
      # the auth details are redacted
      ! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
      grep -i "Authorization: Basic <redacted>" trace

    Cloning into bare repository 'redact-auth'...
    remote: Enumerating objects: 6, done.
    remote: Counting objects: 100% (6/6), done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 6 (delta 0), reused 0 (delta 0), pack-reused 0
    Receiving objects: 100% (6/6), done.
    == Info: [HTTP/2] [3] [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
    == Info: [HTTP/2] [5] [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
    == Info: [HTTP/2] [7] [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
    not ok 17 - GIT_TRACE_CURL redacts auth details
    #
    #		rm -rf redact-auth trace &&
    #		set_askpass user@host pass@host &&
    #		GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
    #		expect_askpass both user@host &&
    #
    #		# Ensure that there is no "Basic" followed by a base64 string, but that
    #		# the auth details are redacted
    #		! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
    #		grep -i "Authorization: Basic <redacted>" trace
    #

and after applying these patches, those tests pass.

    $ ./t5559-http-fetch-smart-http2.sh -di
    [...]
    # passed all 54 test(s)
    1..54

Thanks,
Taylor
