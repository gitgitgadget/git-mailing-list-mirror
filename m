Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD324C4BA13
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F6820838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgV8/Flw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgBZRXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:23:44 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36462 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgBZRXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 12:23:43 -0500
Received: by mail-wm1-f41.google.com with SMTP id p17so97092wma.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2MLWDjrjcl8afK6gO2C1+tT0WE7N21obAlMkG0Cim7U=;
        b=jgV8/FlwPqZCeicYx4529bvS21kNvaUoQo5T9oDSdSAKzJKEQnBmMSHd6a7NfdQhfI
         zHCw/MNNLm4MSynDPGTvKxQpeR1YQpPTTpI1Q1tI/vkxI2KCtym46xyT7h2l1w2Ogf4B
         zFvRxBZUuKJgVwND74Aht1wMHJhSHPfZzuDcUihtdaGmjjPMHPAU0UiIwjXaJu0+2KDi
         ranfgZHHKLcVL4x3p/oJ/5HGjmlXXO5RDOh7qfVIVnP5lxK+0kBteKWtJ2JAfwKVwML3
         u3MO5GtnAoFuHh4KwIFpp7t7cia700Lx9MEIgTaS3hAzVyZoyuRliXbcb4pqzYDmWp9Q
         J9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2MLWDjrjcl8afK6gO2C1+tT0WE7N21obAlMkG0Cim7U=;
        b=XGGR74gDahz1URjOOUTmhHE//YykbumHc0udbUuD4HUpQRWI3UuWvn50rDVlAXsuZE
         iiAKA4K8M7cgKSKCFeYYXyiuV5uA5xyuNvHZM2uy/yVkcwg3I5JBF4ZyKXHqpXuwYyhj
         jjkX5tiJQvNwWPy2J/LePvq0xpb/8RadPXwqDINjxo0SczD3vqYoga/Jmu3wHhQZomye
         kYic87CDYubNhhQlvSbXYvFMqaujUYhV0Ydgs7mmYd0qQjGp1Ui2jS0sODoaqbh5fCft
         fQblL9ozKjMsTohiYnRbGkBQFtp9863jjgVpuA3lZd3YmzA2ud8w/9jUrZ/cVaSSwFlo
         poXg==
X-Gm-Message-State: APjAAAUOhuNU80bUJCHvpbrmPgl1muzBwC+fUjofSHKeDCFPubzUXToF
        9mR/VZBipQja61PZj7NCSe4=
X-Google-Smtp-Source: APXvYqwWwVx7C0RrhhcP7FCuI9rI9DyVnRl4EDPqxwhThz6X/gMCJlSPjQGEyU5jALEudrrSPE6DVQ==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr6503185wmm.179.1582737821114;
        Wed, 26 Feb 2020 09:23:41 -0800 (PST)
Received: from mithrim ([147.210.21.27])
        by smtp.gmail.com with ESMTPSA id a13sm4078156wrp.93.2020.02.26.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:23:40 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:23:38 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Nested submodule status bug
Message-ID: <20200226172338.unembhjhog36sqj7@mithrim>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 26 Feb 2020 18:02:13 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developers,

still about nested submodules, I stumbled upon the following very strange
behaviour.

1) Make a baz submodule inside a bar submodule inside foo
  mkdir foo; cd foo; git init
  mkdir bar; cd bar; git init
  mkdir baz; cd baz; git init
  touch 1
  git add 1
  git commit -m 'first baz commit'
  cd ..
  git submodule add ./baz
  git commit -m "Add baz submodule"
  cd ..
  git submodule add ./bar
  git commit -m "Add bar submodule\n"
  git submodule absorbgitdirs
  cd bar
  touch 2

2) Now add the following alias:
  subs="! git -C baz status"

3) And run it
  git subs

To get:
~~~
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	../2

nothing added to commit but untracked files present (use "git add" to track)
~~~


While when not launched as an alias, `git -C baz status` give the correct
result:
On branch master
nothing to commit, working tree clean


Note: I get the same bug when I use
  subs="! sh -c 'cd baz; git status'"
The bug is only there if absorbgitdirs is used. Also I have to be in an
intermediate submodule.

Best regards,
Damien
