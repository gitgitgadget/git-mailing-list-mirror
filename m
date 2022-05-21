Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62699C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 00:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiEUAi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiEUAi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 20:38:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21BC1AB7B4
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:38:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bs17so9098735qkb.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oWPWYS158YOZ8EmrsEwzn15jze6W0jRPyLYNcVnfdF8=;
        b=Lkxg6Gx74uheAYr6XSafQC8zZLAyOZxUMHMnzSfJvYfROnaqeKUP4exjsF3SgfkA1M
         kksmfsjQCHbrkH7T1apfBVRa/EATJutxC1MtN9NaeT9WG78/utST8ea6XRnQwmPHhk/H
         jwgfpHuuzcpPEASdsQhe2SmC/sreAeNZogI4km+cxkHCBEWYdk9EEldtwP3KCLZAkGaN
         R9tEGl6M5ZBUUzzNbbdX9w3kDWpwQeDb+NyTkZNDS+WZqZPgAUnuoIJGnNWum9nmstsh
         iAa99ZQlnEFwr8dfr0tVHLRufvAdULgVy6A7cPNEtY5KJCb0aiQ4QgJXJBcYI9ur5NLS
         kWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oWPWYS158YOZ8EmrsEwzn15jze6W0jRPyLYNcVnfdF8=;
        b=LoCVcWC9WS3eJ14ZQ7YNn3cEY0xDU6RjFMKpTip7VNqG8UlVxmCXgdfUJrRGiTmhFz
         TgVJNZBej4SgcXUg8td0E+9PRqqDasbm35H8T8lh5r6o3kRzTfFeyVnKt7i3GMYbVOjt
         nvmKUEnxm7MEIDec0bgTev1GFWqZXi0BY2+jPylESjgN8F6VbJfo55k9nHE7OPjKS04T
         lE5/nM/7JWttZuBCjYwc586qAuqyBsZaI+AB5PxuVA35dewYciUCZtvKzqESeUZoXrJU
         d2uQ/MU2UT8Eg+RfNeH77QjR3lbOlQj8dkwu2PaLI1XlVkEFEJUIYBOGaYodVAFqy+Vt
         n7HA==
X-Gm-Message-State: AOAM533oYoZPdGcQLpz/kCQBe15qTf+pbjB+TouLxm/Zyfly8giQIxH+
        Azw9K9Xck4bCqElmUo5rZ/A=
X-Google-Smtp-Source: ABdhPJzI6OyLaVnRuRk3uTmUSOCQmKrgsF56OfXZrC/8GrFRsSM48XluW94JkWs1DesNvwLIf3x6Nw==
X-Received: by 2002:a37:9e92:0:b0:6a3:4a0e:7296 with SMTP id h140-20020a379e92000000b006a34a0e7296mr4407704qke.504.1653093535860;
        Fri, 20 May 2022 17:38:55 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id s63-20020ae9de42000000b006a2f5ea4a29sm568370qkf.46.2022.05.20.17.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 17:38:55 -0700 (PDT)
To:     Git mailing list <git@vger.kernel.org>
Cc:     Carlo Arenas <carenas@gmail.com>, Ed Maste <emaste@FreeBSD.org>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Investigating Cirrus CI FreeBSD failures
Message-ID: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
Date:   Fri, 20 May 2022 20:38:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I spent a bit of time investigating the Git Cirrus-CI failures on FreeBSD.
It seems something goes wrong with the Perl installation, as most failures 
are in t9001-send-email.sh, and the error messages are:

ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"

The first instance is in t9001.6. (See for example [1]).

I know next to nothing about Perl or FreeBSD, but simply changing our image
to FreeBSD 13.0 makes all failures in t9001 disappear [2]:


diff --git a/.cirrus.yml b/.cirrus.yml
index 0d94d89f6c..d1ea14362f 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -9,7 +9,7 @@ freebsd_12_task:
     DEFAULT_TEST_TARGET: prove
     DEVELOPER: 1
   freebsd_instance:
-    image_family: freebsd-12-2
+    image_family: freebsd-13-0
     memory: 2G
   install_script:
     pkg install -y gettext gmake perl5 vim

Is this something that we should do ? Or should we stick to FreeBSD 12
and try to debug this installation problem ?

Cheers,
Philippe.

[1] https://cirrus-ci.com/task/5856927879004160
[2] https://cirrus-ci.com/task/4597971764379648
