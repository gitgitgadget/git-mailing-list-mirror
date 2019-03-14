Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1C920248
	for <e@80x24.org>; Thu, 14 Mar 2019 18:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCNS2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 14:28:25 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36530 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfCNS2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 14:28:24 -0400
Received: by mail-ed1-f41.google.com with SMTP id e4so5507404edi.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NRHNxiigx+14rtlUP9TZwKVDDEzAd+9xb9CUX+BZuBI=;
        b=T19q7mli9APzaKkvgHdGlz5dfrSnT8zaDkXrpCXxJ/rR+g0JJ7r+O0r0kL0+kOI23/
         b2cI7YeQttc+FC/R5/jYgKGxuSBACYTUB+6eE7KXBxLTPvr+d3mjZ5qmr+kIj7TkF+od
         GJNVGoVR4ljfFu5Y4vk+3m2G3+sBpU3gEJzgV8EuQLIQhn++CmXhpaIXqufwbCdeplpv
         QPu6vgeaAgHQYM4PCkv6lr9D8nEO4nXHl0OovftBVt0D2vo27xsa0dGm3jBUQjpELJ+K
         jtWfbYOOz1yWCVkL4Gt2oAoZ9vvLWM+ht9SpL4Vh6h3bwdgKuv5oodXkVlp+WaglR4K8
         VnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NRHNxiigx+14rtlUP9TZwKVDDEzAd+9xb9CUX+BZuBI=;
        b=AqfXtX0wSOukH64/SpzjarUaHRWZx4qF/pF2g/a0qpnqWhVq3ZoscCMLJVyxnsuuBZ
         W6hrWwxrup0R36kEkl+QSJ4xJ2NIYMTqCuJudJGsh7PhxQQY3RNj9+sduRflKXTqcgTe
         iflISBUiKwxDMHD7E1qR797UcCO+InYKteXA9c/ybt91y4jDlSv4fb5J0c5qItZWKGmI
         erZQymRjiqAbDGEOijoQR18zN+KLWv2q6ZD7rV6D7VItZXsjFusOeXhq69PemTSNM2yD
         PQl3/ALno4JvYdZCxNX+IEPOA7OE0IIe9BdGOZkjLYSa2QZcmP8xIZYNoZetMJtvA2DQ
         zc8Q==
X-Gm-Message-State: APjAAAXxhG4yCl0g2ENUYnZbrhlieZ0864eZNgdyMyJt/kVAhWAT/PXv
        +HeCbwyyfSvLgswKZ2AqjXEAk6nZ253LHwSqaGrdJg==
X-Google-Smtp-Source: APXvYqxduiR9kVjSphqXiHMDcWBbw0+JiYNWLnOGFRBy3VNOK1B4BCBDWQA68gS2AVirFoHu0z5R9wSXzUwKmEgnYNk=
X-Received: by 2002:a17:906:1dd0:: with SMTP id v16mr7320202ejh.204.1552588102891;
 Thu, 14 Mar 2019 11:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:91e3:0:0:0:0:0 with HTTP; Thu, 14 Mar 2019 11:28:22
 -0700 (PDT)
From:   Daniel Dromboski <dandromb@gmail.com>
Date:   Thu, 14 Mar 2019 14:28:22 -0400
Message-ID: <CAGGzCPF_0ZGWn1-GCLLb=1XKcW936U_4CxiNRHPCV1kw5ZeOBw@mail.gmail.com>
Subject: git apply --check should give some indication that a patch applies cleanly
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

The main purpose of `git apply --check` is to see if a patch can apply.

It's not intuitive to a user, just from the command name, that "no
output" means your patch can apply cleanly.

Furthermore, `git apply --check --verbose` only says that it is
checking the patch, ending with "..." which usually means "more info
to come"... But it doesn't print anything else. An example command and
output:

```
$ git apply --check --verbose [my-patch.patch]
Checking patch [path/to/file.ext]...
```

I'd like if there were some way for the command to confirm outright
that the patch applies, to save users the confusion.

Thanks.
