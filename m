Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE30208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdHOMxw (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:52 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36868 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbdHOMxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:49 -0400
Received: by mail-wm0-f53.google.com with SMTP id i66so9172331wmg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNuRK7IAabDfx9EjMSQjtpOylLaFWnNSuRPmq4uXhs8=;
        b=mPxxXsA3C/GwQh+SM3o9UOf32nZUrxgoYcyNKSHt6Fs6v5fkDr5BRAMUasB543WZvy
         zsKlvnH+8t3NZG02eJnYRnR290NfYrSWibFpRCRDCSUNE1DUow5gUG3dwP0aYcqKn9zk
         fztXCzZcUZaqZrB+qErS9iTCVOy00BfU3cZb91W0BcNz5shCOfbzyEe/KdMpyoBkRcee
         NRmb73zQrzvgbv7NQInpMoaY+jptjHmwppULAIqDtMWFA+nGX89uUeKYhmI+0D9sWtPS
         xpaYRjxgIdwjzKX7VKRcVrzrLUK8Iv5yqmQv8l9K3LQH+FKrlFimsKHqAG0T+QKBKyOF
         uoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNuRK7IAabDfx9EjMSQjtpOylLaFWnNSuRPmq4uXhs8=;
        b=sMZM5VxX392Af0tN7UxS37E10qXxNMtHU/xQJBxFEgWyKzK/0dLMvRYGA6AS/GTuHX
         pexg/Q3WhHBFPlndKQ15DjS/nzJjXPFBIAwllV1wsxtLXI3DK3+tDk7z0ewnomFDofBO
         AlT9UHaC1SE3+TSxZFjeeToHJnvMmvLCol33X/rfmsWs9oYeuYpm53aCUBN+qXQaSs0t
         WIJYO3wURUwgXIvI9mAr63O2BlmxCG46f8L5+zN5Qdfs8QVAQJzartQW2xaZXh0wY8V+
         sydSpWBSTc1hyMJL0O93D3MIbraEmsxTgJBF4iKDYUej8WiBmOEfdEHSIZQKO3oCiyJK
         i33g==
X-Gm-Message-State: AHYfb5h/vYaXB5ATsJzl2MlAtUGPn8BGHh6DmYAhK427QODteQj7XbTU
        61l+0zVOtIAxU3Q6
X-Received: by 10.28.19.68 with SMTP id 65mr1249920wmt.122.1502801627332;
        Tue, 15 Aug 2017 05:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: tsan: t3008: hashmap_add touches size from multiple threads
Date:   Tue, 15 Aug 2017 14:53:06 +0200
Message-Id: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using SANITIZE=thread made t3008-ls-files-lazy-init-name-hash.sh hit
the potential race below.

What seems to happen is, threaded_lazy_init_name_hash ends up using
hashmap_add on the_index.dir_hash from two threads in a way that tsan
considers racy. While the buckets each have their own mutex, the "size"
does not. So it might end up with the wrong (lower) value. The size is
used to determine when to resize, but that should be fine, since
resizing is turned off due to threading anyway.

If the size is ever used for something else, the consequences might
range from cosmetic error to devastating. I have a "feeling" the size is
not used at the time, although maybe it is, in some roundabout way which
I'm not seeing.

Martin

WARNING: ThreadSanitizer: data race (pid=10554)
  Read of size 4 at 0x00000082d488 by thread T2 (mutexes: write M16):
    #0 hashmap_add hashmap.c:209 (test-lazy-init-name-hash+0x000000438b7d)
    #1 hash_dir_entry_with_parent_and_prefix name-hash.c:302 (test-lazy-init-name-hash+0x00000043ea6c)
    #2 handle_range_dir name-hash.c:347 (test-lazy-init-name-hash+0x00000043ea6c)
    #3 handle_range_1 name-hash.c:415 (test-lazy-init-name-hash+0x00000043ea6c)
    #4 lazy_dir_thread_proc name-hash.c:471 (test-lazy-init-name-hash+0x00000043ea6c)
    #5 <null> <null> (libtsan.so.0+0x0000000230d9)

  Previous write of size 4 at 0x00000082d488 by thread T1 (mutexes: write M31):
    #0 hashmap_add hashmap.c:209 (test-lazy-init-name-hash+0x000000438b90)
    #1 hash_dir_entry_with_parent_and_prefix name-hash.c:302 (test-lazy-init-name-hash+0x00000043e0f2)
    #2 handle_range_dir name-hash.c:347 (test-lazy-init-name-hash+0x00000043e0f2)
    #3 handle_range_1 name-hash.c:415 (test-lazy-init-name-hash+0x00000043e0f2)
    #4 handle_range_dir name-hash.c:380 (test-lazy-init-name-hash+0x00000043e709)
    #5 handle_range_1 name-hash.c:415 (test-lazy-init-name-hash+0x00000043e709)
    #6 lazy_dir_thread_proc name-hash.c:471 (test-lazy-init-name-hash+0x00000043e709)
    #7 <null> <null> (libtsan.so.0+0x0000000230d9)

  Location is global 'the_index' of size 208 at 0x00000082d400 (test-lazy-init-name-hash+0x00000082d488)

  Mutex M16 (0x7d640001a5b8) created at:
    #0 pthread_mutex_init <null> (libtsan.so.0+0x0000000280b5)
    #1 init_recursive_mutex thread-utils.c:73 (test-lazy-init-name-hash+0x0000004d829b)
    #2 init_dir_mutex name-hash.c:241 (test-lazy-init-name-hash+0x00000043d714)
    #3 threaded_lazy_init_name_hash name-hash.c:526 (test-lazy-init-name-hash+0x00000043d714)
    #4 lazy_init_name_hash name-hash.c:588 (test-lazy-init-name-hash+0x00000043d714)
    #5 lazy_init_name_hash name-hash.c:581 (test-lazy-init-name-hash+0x00000043ec34)
    #6 test_lazy_init_name_hash name-hash.c:613 (test-lazy-init-name-hash+0x00000043ec34)
    #7 time_runs t/helper/test-lazy-init-name-hash.c:74 (test-lazy-init-name-hash+0x000000405ac2)
    #8 cmd_main t/helper/test-lazy-init-name-hash.c:261 (test-lazy-init-name-hash+0x0000004066c1)
    #9 main common-main.c:43 (test-lazy-init-name-hash+0x000000404f91)

  Mutex M31 (0x7d640001a810) created at:
    #0 pthread_mutex_init <null> (libtsan.so.0+0x0000000280b5)
    #1 init_recursive_mutex thread-utils.c:73 (test-lazy-init-name-hash+0x0000004d829b)
    #2 init_dir_mutex name-hash.c:241 (test-lazy-init-name-hash+0x00000043d714)
    #3 threaded_lazy_init_name_hash name-hash.c:526 (test-lazy-init-name-hash+0x00000043d714)
    #4 lazy_init_name_hash name-hash.c:588 (test-lazy-init-name-hash+0x00000043d714)
    #5 lazy_init_name_hash name-hash.c:581 (test-lazy-init-name-hash+0x00000043ec34)
    #6 test_lazy_init_name_hash name-hash.c:613 (test-lazy-init-name-hash+0x00000043ec34)
    #7 time_runs t/helper/test-lazy-init-name-hash.c:74 (test-lazy-init-name-hash+0x000000405ac2)
    #8 cmd_main t/helper/test-lazy-init-name-hash.c:261 (test-lazy-init-name-hash+0x0000004066c1)
    #9 main common-main.c:43 (test-lazy-init-name-hash+0x000000404f91)

  Thread T2 (tid=10557, running) created by main thread at:
    #0 pthread_create <null> (libtsan.so.0+0x000000027577)
    #1 threaded_lazy_init_name_hash name-hash.c:541 (test-lazy-init-name-hash+0x00000043d7ab)
    #2 lazy_init_name_hash name-hash.c:588 (test-lazy-init-name-hash+0x00000043d7ab)
    #3 lazy_init_name_hash name-hash.c:581 (test-lazy-init-name-hash+0x00000043ec34)
    #4 test_lazy_init_name_hash name-hash.c:613 (test-lazy-init-name-hash+0x00000043ec34)
    #5 time_runs t/helper/test-lazy-init-name-hash.c:74 (test-lazy-init-name-hash+0x000000405ac2)
    #6 cmd_main t/helper/test-lazy-init-name-hash.c:261 (test-lazy-init-name-hash+0x0000004066c1)
    #7 main common-main.c:43 (test-lazy-init-name-hash+0x000000404f91)

  Thread T1 (tid=10556, finished) created by main thread at:
    #0 pthread_create <null> (libtsan.so.0+0x000000027577)
    #1 threaded_lazy_init_name_hash name-hash.c:541 (test-lazy-init-name-hash+0x00000043d7ab)
    #2 lazy_init_name_hash name-hash.c:588 (test-lazy-init-name-hash+0x00000043d7ab)
    #3 lazy_init_name_hash name-hash.c:581 (test-lazy-init-name-hash+0x00000043ec34)
    #4 test_lazy_init_name_hash name-hash.c:613 (test-lazy-init-name-hash+0x00000043ec34)
    #5 time_runs t/helper/test-lazy-init-name-hash.c:74 (test-lazy-init-name-hash+0x000000405ac2)
    #6 cmd_main t/helper/test-lazy-init-name-hash.c:261 (test-lazy-init-name-hash+0x0000004066c1)
    #7 main common-main.c:43 (test-lazy-init-name-hash+0x000000404f91)

SUMMARY: ThreadSanitizer: data race hashmap.c:209 hashmap_add

