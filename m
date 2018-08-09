Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCC61F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHJBRa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:17:30 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:39082 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJBRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:17:30 -0400
Received: by mail-it0-f46.google.com with SMTP id g141-v6so248431ita.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cYl1jPV+d7RQtOGcHIjdbzE90clVositMHbUFQiVg6k=;
        b=E1XigLLwQbynOtbMSCIH9dU09xgp9OyDLFLSjDKFF9ZgNFkZAK70mjJX8RMoiGGWJX
         mUGBJSVtfQRyq0VyPtvSgNbuaaP/JvcaBNTqsoKE7px7T5gKPd37wtZXLnWVYikUMspN
         SMkOXm0jVX21Gfnp5Qg5EkMgC7pAnWJ2l3Kh/6NwM0T/2jLW6W2RTn/Tc7SiN5Ty4V7X
         zACAhiGYKxslw2VKTGZdmMLRILoYjqMDJ6WfxdFdPmEejmUUFR/xoaRoeGcOtQ34duTE
         g8slvPcQjHAuUj/DPW7/HPyWceA9wX3BvmODYWo9cloftofYI7WiGyQtzNjqxieQBGwe
         Mi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cYl1jPV+d7RQtOGcHIjdbzE90clVositMHbUFQiVg6k=;
        b=oT8lT4SXld7+eL0BPytZypBmWce3OwShfc2rheOyyOJDrJIa6GRGvvWhSUZuIkz+VH
         sk8w/5Onro16HMnSq8Iazx+ZoSfBJwlhf+aFYdHGCvsIhahIVDAcQ8CJTHhR9dwpRzb+
         rHsgnJ5vNbC7wgq8Y8zJJhTAB7dIYXQ0xsd0xvDxiPaR2umtyfsZi3QbKORmMjIfnSJw
         P1BoRfL+ZYNHSju5fXVYgFzNk7QvgR2mmBwLXf+dWczIiEgX2r+WpqZ9UHF3GVCfxJBn
         3+UsfSmHKc406aK/aQz4e+GrzStQ1F32Ni2j0m8h6i4G/n8Bt7ImHDvL1Diqrnc5JVee
         QJMw==
X-Gm-Message-State: AOUpUlG/17ICvmltDC5640MMAGlsxLlRCnDeHq3g81G6pkCdNjXtyFce
        fnBbfUhxolQbRjyN+FS/7jkPpRXyLqpu61yUZhWT9yYB
X-Google-Smtp-Source: AA+uWPwnzZTdec3b5US4eRG1GEskd5TNOE4iNOnRj2Xj8CHZyEYtcPc4U13RaijlXyq0gthrZNVkj69nIM1/lXg55a4=
X-Received: by 2002:a02:9b54:: with SMTP id g20-v6mr3696130jal.33.1533855028899;
 Thu, 09 Aug 2018 15:50:28 -0700 (PDT)
MIME-Version: 1.0
From:   Jonathon Reinhart <jonathon.reinhart@gmail.com>
Date:   Thu, 9 Aug 2018 18:50:02 -0400
Message-ID: <CAPFHKzepqebXX7mrbeoc=+SHzWZ5N+6eOaLiC26tVGKogZoLGg@mail.gmail.com>
Subject: 'git submodule update' ignores [http] config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been trying to track down an issue with the GitLab CI Runner:
https://gitlab.com/gitlab-org/gitlab-runner/issues/3497

Note that I'm using "git version 2.7.2.windows.1".

I've narrowed it down to an observation that the [http] config seems
to be ignored by 'git submodule update'. Shouldn't those options be
respected by submodules?

Given a .git/config file like this:

------------------------------------------------------------------------
[fetch]
    recurseSubmodules = false
[http "https://gitlab.exmaple.com"]
    sslCAInfo =
C:\\Users\\gitlab-runner\\builds\\deadbeef\\0\\somegroup\\someproj.git\\CA_SERVER_TLS_CA_FILE
[core]
    ...
[remote "origin"]
    url = https://jreinhart:<private-access-token>@gitlab.example.com/somegroup/someproj.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[submodule "some-lib"]
    url = https://jreinhart:<private-access-token>@gitlab.example.com/somegroup/some-lib.git
------------------------------------------------------------------------

...I see the following results:

------------------------------------------------------------------------
C:\Users\jreinhart\testrepo>set GIT_CURL_VERBOSE=1
C:\Users\jreinhart\testrepo>git fetch
...
* Connected to gitlab.example.com (x.x.x.x) port 443 (#0)
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: C:\Users\gitlab-runner\builds\deadbeef\0\somegroup\someproj.git\CA_SERVER_TLS_CA_FILE
  CApath: none
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  <certificate details here>
*        SSL certificate verify ok.
...
C:\Users\jreinhart\testrepo>git checkout master
C:\Users\jreinhart\testrepo>git submodule update --init
...
* Connected to gitlab.example.com (x.x.x.x) port 443 (#0)
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
  CApath: none
* SSL certificate problem: unable to get local issuer certificate
...
------------------------------------------------------------------------

Note that the CAfile reverted to its default instead of using the same
one from the `git fetch`.


Thanks in advance,

Jonathon Reinhart
