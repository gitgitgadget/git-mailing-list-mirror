Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F7420899
	for <e@80x24.org>; Tue,  1 Aug 2017 09:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdHAJDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 05:03:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34344 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdHAJDh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 05:03:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id o33so832881wrb.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ml9f1JuiIj2z2mgcvFpAMnlsVQc1+nIV6TF1zsQj/zQ=;
        b=Y6AqTMk086nTTsHcBpxmZUybW44dQQjjl2maWvsRg0mNZ+Vqiq3sfb1bTBn17hDSV8
         sl5wmj6nCbD84yOkRh4LbUUpvG0mAbirfG5e7BZ0aeTld71eAJSLeyXbum6nL1gkPSVP
         4nAssXS3UsgcRSS9igj+uDKq5ZnIH1YJYnjz6cQjgLTPdRdx0pzUjrRbKPe4yirUJn15
         jQ2q3eD5+PXttvmh4KiIQ6oLjAuYcA95QvaixHuSsh101r2/EC5fyFYX1UU/bJK2YxcX
         9AnKHALs4y86JpKTuUXmn74DvivB88XfOOIpkS+VnsKYHF1BrVpXOVN1hdP4QpnYXUeL
         DcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ml9f1JuiIj2z2mgcvFpAMnlsVQc1+nIV6TF1zsQj/zQ=;
        b=DDRQJBiZLAjQnMcQ8k+qQXwfWyhQiIX5AImR1NupcDn+qY2JAt+yp9gjxBJx5MOgaG
         hSlR7UxMTUrAL7gGl4GCRYDFi9AXt0Oh3LxqJgfe+Ncs3xFeuzr7wFuSoUgN0xZMqXyc
         T7XJw4JiHkNl8cD8UH/vKV6SC99MNkVu4y9U0TqF7FR/v6UwtbdlFUY5F1pL/7l8M1O6
         3/+aIW6ZkX6SsaI9vgSbnOPaTNdLnAoCfQqcVn/jf2hgYnl4OC44Ma3nwHbampzMjzMe
         2clBGcSauIq2cD6bBC3ruAkzGivEYauNZrPa2LEXoQATPY/d8ylCxkEbO0EJIw3nI6kx
         PHBw==
X-Gm-Message-State: AIVw112L10hSQL6Fr0tcHwESPdy1/wdkNJShniReHuymA9kSMNEfDqTy
        jv0opWbCZIKS6GgO8NM=
X-Received: by 10.223.150.200 with SMTP id u66mr17001268wrb.216.1501578216347;
        Tue, 01 Aug 2017 02:03:36 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.gmail.com with ESMTPSA id 91sm29947237wrg.83.2017.08.01.02.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Aug 2017 02:03:34 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/4] interpret-trailers: add --where, --if-exists, --if-missing
Date:   Tue,  1 Aug 2017 11:03:29 +0200
Message-Id: <20170801090333.32642-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

These options are useful to experiment with "git interpret-trailers"
without having to tinker with .gitconfig (Junio said git should ahve
done this first and only added configuration afterwards).  It can
be useful in the case where you want a different placement for the trailer,
or for scripts/aliases that don't want to rely on specific .gitconfig
settings.

Compared to v2, the main change is that option order on the command-line
is respected.  That is,

	--trailer 'acked-by: foo' --where end --trailer 'signed-off-by: me'

will only apply where=end to the second trailer.  Likewise,

	--where end --trailer 'signed-off-by: me' --no-where \
	--trailer 'acked-by: foo'

will only apply it to the first, reverting to trailer.*.where for the
"acked-by" trailer.

Paolo

v1->v2: support --no-* options, minor code fixes

v2->v3: largely rewritten to respect option order on the command-line;
	keep trailer.h namespace clean (Christian)

v3->v4: fix compilation warnings (Junio), added documentation fix

Paolo Bonzini (4):
  trailers: export action enums and corresponding lookup functions
  trailers: introduce struct new_trailer_item
  interpret-trailers: add options for actions
  interpret-trailers: fix documentation typo

 Documentation/git-interpret-trailers.txt |  27 ++++++-
 builtin/interpret-trailers.c             |  73 +++++++++++++++++--
 t/t7513-interpret-trailers.sh            |  66 +++++++++++++++++
 trailer.c                                | 118 +++++++++++++++++++------------
 trailer.h                                |  43 ++++++++++-
 5 files changed, 274 insertions(+), 53 deletions(-)

-- 
2.13.3

