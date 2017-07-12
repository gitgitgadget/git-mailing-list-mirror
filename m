Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69444202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 13:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdGLNqw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 09:46:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34931 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdGLNqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 09:46:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id y28so1399705wrd.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=46wUR0MlhdXnoaXpvTjrb/1UYWK3tJV0kuhrUImcY2A=;
        b=U2OPSeOA5F+Z2fC3fJLfntutvFHM0Bc7bJ+P75cnm6NlWq0P+d3SZubDscl4mlA7Zm
         sBLCWrXnABYrT0U+jdt7fsfIUMaRKyfIO900ezXlvhtgZAAhL87yLOh1vAqsp4rE6Nd+
         SEP75Ady39Liu0B0CJ+Qw68FBgF56AMma+zcGbHgB9mmP0poB4ZtDTah0iZF4jktZK8J
         NakcrC/PvXsB/tbKA9Hp2vnSJ4iGZ7Q7hkH1O6Tfba3KM9BJ07X0AKfDrk15RTSW7u5Q
         gThYVHl/Y7RFxxEXg/KZMXUYfgHWJxRTaFW4fz8fSFeUecP9z3l6DMpjJo9FHOFSYaUS
         uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=46wUR0MlhdXnoaXpvTjrb/1UYWK3tJV0kuhrUImcY2A=;
        b=mbfKWbyVWhEGQLo4b3zpu6HVw+6aN92Eczm5NQyR4RO7yUN8WuovQX+yT/dDsT+7DP
         1d8AyfK6Wr2LXOR9Xn7OicIincGK2Tq9yig4xcjThwOdeSRmsmSw/yIZBlYRcyStdaUz
         0wuMHPp9nZ/6qxymC/Rq8LcQHdQal9OnjkHwgapxmr0M9+JiNBNExKJQ3U/2ojuJ+/s8
         5e8LzmuA3fMQg1lc15Rj68RYqZfyp8Su+GxcdwQHkRH0Do0rvG9PzlVAqtU3ud6LMGWa
         vrEOVJv2p3ty5oizih0bXOZnPLARVa+YrsoDKI8fk3CVJE7Sco/rxl/HM6A74giXStWm
         kMJw==
X-Gm-Message-State: AIVw1136LO6hmVBl3KZ+sJ+qUdUxUrzjeRwpcoa7fbTjms8KJAs4ZoWy
        QgDv5320DCVFDTa2CZI=
X-Received: by 10.223.161.204 with SMTP id v12mr2909649wrv.125.1499867210226;
        Wed, 12 Jul 2017 06:46:50 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.gmail.com with ESMTPSA id 55sm3437950wrt.36.2017.07.12.06.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2017 06:46:47 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] interpret-trailers: add --where, --if-exists, --if-missing
Date:   Wed, 12 Jul 2017 15:46:43 +0200
Message-Id: <20170712134646.17179-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

These options are useful to experiment with "git interpret-trailers"
without having to tinker with .gitconfig.  It can also be useful in the
oddball case where you want a different placement for the trailer.

The case that stimulated the creation of the patches was configuring

     trailer.signed-off-by.where = end

and then wanting "--where before" when a patch author forgets his
Signed-off-by and provides it in a separate email.

Paolo

Paolo Bonzini (3):
  trailers: create struct trailer_opts
  trailers: export action enums and corresponding lookup functions
  interpret-trailers: add options for actions

 Documentation/git-interpret-trailers.txt | 16 ++++++
 builtin/interpret-trailers.c             | 53 +++++++++++++++---
 t/t7513-interpret-trailers.sh            | 51 ++++++++++++++++++
 trailer.c                                | 93 ++++++++++++++++++++------------
 trailer.h                                | 35 +++++++++++-
 5 files changed, 205 insertions(+), 43 deletions(-)

-- 
2.13.0

