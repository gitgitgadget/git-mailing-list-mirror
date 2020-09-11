Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A892C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A7521D40
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 12:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enQ46mJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgIKMQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:16:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgIKMQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 08:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599826575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X99g0q3bD7Wp2VLPKmcBz9je5sABShgxPObL6i633lI=;
        b=enQ46mJV0ING1sdscHQFnv3ho2eGNuP/GxKg9MEKA2ApUI+eV6qnfTPR94cdLDfS36qEqN
        wACfW9cI+CbEBBUBP+KQVn55wlgRfDRIYOYBp+/an8JcmJTUtI5WXTwR4Qzt29IhsLTkOq
        XMUAIDWU2FhDSQnuFNlzDpM2DDgjAe8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-boCybrp2N76b-nrunfpyPA-1; Fri, 11 Sep 2020 08:16:11 -0400
X-MC-Unique: boCybrp2N76b-nrunfpyPA-1
Received: by mail-ej1-f69.google.com with SMTP id qn7so4478825ejb.15
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=X99g0q3bD7Wp2VLPKmcBz9je5sABShgxPObL6i633lI=;
        b=LRsp/sl9KYGwfSbT5c75L447tRu6JHOzCCieM5XFSBvPUALwNdyg5+R3pqdEMB6MO6
         5070nVSoc2wodRHp8N7KcmzDDYIl8xgopzSKf+MMsZu1KU8scDrTqA1ZfCzv+7uKOTHr
         jgd9qfKDeS8irYu9yT0YXtV9pzAX+xeSyZYv7uEm1C3gMIRU++BWdzwenjSPTVFRiFcJ
         5bynBhfItatVzFmCMN8JTUkrLmPee6K4KltyaIxY7hEHgPS5lrt+DE26o/DBdI6nJWZp
         k2GDfG55Y9sJbL0rAxGYY8dwdClQu3FT04afNg1Av4AIvaqqeOQNlIpz4cnhE2rZrIwS
         Apuw==
X-Gm-Message-State: AOAM532mkAXaFUXvguiPwXsSBwRbX5WG2Hy1X5t63lRSY9Zd5LlK3aqN
        HX1IkR6t1NM1roZ0XTVq7cLYzmmtEXSY0Ne829JUZttmWi+KbiXeuklco68ekKhfCCbO2af3mgc
        uxFElunDzkPv4Lw1rHvEVsEv4XJvO
X-Received: by 2002:a50:f081:: with SMTP id v1mr1707244edl.161.1599826570235;
        Fri, 11 Sep 2020 05:16:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymTWmQ8v63mlUE8MtiiH6/0xmq7VYWBxdUSqr/jZO4viBVU6npoWaPVJHPGW8ATknUuHbvQc5HI9eYfiehoBk=
X-Received: by 2002:a50:f081:: with SMTP id v1mr1707222edl.161.1599826570031;
 Fri, 11 Sep 2020 05:16:10 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Fri, 11 Sep 2020 14:15:59 +0200
Message-ID: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
Subject: Git doesn't honor NO_PROXY environment variable while cloning
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

we've got a bug[0] reported in Red Hat Bugzilla. It seems like Git
doesn't honor NO_PROXY environment variable while cloning repositories

Reporter has provided these steps to reproduce using Git version 2.18.4:

1. Start a ubi8 container with podman:
```
$ podman run --rm -it registry.access.redhat.com/ubi8/ubi /bin/bash
```
2. Install git in the container - `# yum install -y git`
3. Add "bad" _PROXY environment variables:
```
# export HTTP_PROXY=3Dhttp://user:pass@bad.proxy
# export HTTPS_PROXY=3Dhttps://user:pass@bad.proxy
```
4. Add Github as an ignorable proxy domain:
```
# export NO_PROXY=3Dgithub.com
```
5. Clone a github repo:
```
# mkdir -p /tmp/clone-test
# cd /tmp/clone-test
# git clone https://github.com/sclorg/nodejs-ex.git
# echo $?
```

Actual results:
```
# git clone https://github.com/sclorg/nodejs-ex.git
Cloning into 'nodejs-ex'...
# echo $?
128
```

Expected results:

Git clone succeeds, bypassing the proxy.



However I've found out that this possible issue is present even in
newer versions e.g. 2.28.0.

There is a workaround. You can rewrite proxy to be blank in .gitconfig
for specific websites.
```
[http "https://github.com/"]
        proxy =3D ""
```

Is this an issue or expected behaviour? And if it is expected
behaviour, then why?

Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD


[0]https://bugzilla.redhat.com/show_bug.cgi?id=3D1875639

