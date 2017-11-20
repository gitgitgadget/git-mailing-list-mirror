Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5539202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbdKTVVj (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:21:39 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33627 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbdKTVVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:21:38 -0500
Received: by mail-io0-f195.google.com with SMTP id i184so9800491ioa.0
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O5SzfI2TI6lM7xh58xg219DWgbbKPIGUyNc2m8xmbnk=;
        b=BwGCTG2Evz0Vrs7CtkVXbM0JfCczveG7Zrli9CpmVvvd2n1mMJ4VcwZ+xDm/o6xjv6
         7oKc8XZ+rbn/elMU0JD4GjTrL+bcg+dEKxYFWGXhN6JpqwHyfc4GCd8MwW2hcQ6ykoxZ
         kw2JxVVBW0GI1jj3tjXUe9yX/2Ja8MVyWj+cesIGfzyDP1fiYHPQGJHtV0iSQg46rKDz
         wpHvJ+8ebMrIT3DpiOeB1SrYRvnR1CcU11GlHa+3CzPLAfR9nDKPatOrmq5PR+9JUUFr
         gKDiIaabFMYfQrZaFqrQW29gtJV21ERrrpOhXz3AXR0vDkZ/eGRh8LAlXfca8gwNkLr/
         kxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O5SzfI2TI6lM7xh58xg219DWgbbKPIGUyNc2m8xmbnk=;
        b=W12yo1vZ6oHp+Wi8zh4HMzSRAtUiptXCHEnb2ebkS+OrNuvgW6cyRxb9IIif3XcaTB
         e8NPO8KiUdUUvDOpmCwsG8obLAjorv9WymUm7HBk0rGxKG/cPEHqK8bMBh2NkRMpV567
         Yrwu1HQ2nLFv1K9dBIKvvDxLXB0crZ1NPHAq+rxdUMQCermowKJArmHrkjVddJkRTlSE
         riEuu8c8bKE4cyKMxB4BHiC0C6vHIxHC2HxQ4U07GVE0LH+oASV48zjII8EALRCdOEj+
         Aby44VRnEoGkz9PkDHOLFyDTq4aA7WHKlISZAWfmLoK0bZoxYcIweXKH8zDHExvlcwSu
         HoWw==
X-Gm-Message-State: AJaThX6jAg3zrcjaGMdgY8/UkkHJfElfCRi7eJB40gPpfI2JyfW6YMbG
        PLinkMLZvttlE6z0yyGHk2O6w9n8
X-Google-Smtp-Source: AGs4zMbl1PldZBnoyu4Op4zHM8FZ52N+E3FH+UgHRDGKJoqwjCbnTsauchAunk4IBNkrEWApCN8XdQ==
X-Received: by 10.107.20.68 with SMTP id 65mr15345381iou.244.1511212897608;
        Mon, 20 Nov 2017 13:21:37 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b77sm1215278ioj.42.2017.11.20.13.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:21:36 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:21:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH v3 0/8] Coping with unrecognized ssh wrapper scripts in
 GIT_SSH
Message-ID: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously: [1].

This version should be essentially identical to v2.  Changes:
- patch 1 is new and should fix the test failure on Windows
- patch 2 is new, discussed at [2]
- patch 5 split off from patch 6 as suggested at [3]
- patch 6 commit message got two new notes to address the worries
  from [3]

Thanks for the helpful reviews, and sorry to take so long to get this
out.  Thoughts of all kinds welcome, as always.

Sincerely,
Jonathan Nieder (8):
  ssh test: make copy_ssh_wrapper_as clean up after itself
  connect: move no_fork fallback to git_tcp_connect
  connect: split git:// setup into a separate function
  connect: split ssh command line options into separate function
  connect: split ssh option computation to its own function
  ssh: 'auto' variant to select between 'ssh' and 'simple'
  ssh: 'simple' variant does not support -4/-6
  ssh: 'simple' variant does not support --port

 Documentation/config.txt |  24 ++--
 connect.c                | 322 +++++++++++++++++++++++++++++------------------
 t/t5601-clone.sh         |  69 ++++++----
 t/t5603-clone-dirname.sh |   2 +
 4 files changed, 265 insertions(+), 152 deletions(-)

[1] https://public-inbox.org/git/20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com/
[2] https://public-inbox.org/git/20171115202516.hduhzsgeoff5a22b@aiede.mtv.corp.google.com/
[3] https://public-inbox.org/git/xmqq60b59toe.fsf@gitster.mtv.corp.google.com/
