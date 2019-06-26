Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08DCA1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZWlt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:41:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42479 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfFZWls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:41:48 -0400
Received: by mail-yw1-f67.google.com with SMTP id s5so238254ywd.9
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2cJjRAvqLeWwoK+IhSLEO/sDHMHEI3oAcYuNlEf9RPU=;
        b=HITGZXiuih48H05JVriqttmO32rg8JiKjgXCVXtfsRq21JKisaIlR89RUGkVLBv55d
         vI3chDgDj75+tswPvb7FqQ86ZiUtcv6WizkeE7JYordTaKZZ2wgo+qyObs+2c5srYc8J
         rqu7wCksP823yomgmimrv0qFD3681C+zkrAx5Q9gVNCds5RsBU6ApZJdVgC3LjT6tO6I
         KMFne5xMzsVb+SqIDMbKVitazKZgBTm9aUdx+GOElPTASPCv2nCzHl8zINH0MIaU+FG5
         GEfHD7Nv4a2HUhxP/g62TJADtH0iVBUbIKbaZyyGHVAPYbgKXGdiDn/oDrw6WAqhqMLT
         s2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2cJjRAvqLeWwoK+IhSLEO/sDHMHEI3oAcYuNlEf9RPU=;
        b=no7OUffRCap0Lyn38duj7TRrca9iGjWDIPTmpvG1V2M8DVPaJyvYyohZSD6P12B3Mi
         jfzC3ILXnm5r2p5NFFnW9JgauC+xRasy2L71W8th/8dvQ39hQjgYXrJDsS+bCiR97Wlm
         3UoLnMJQOvlH69US+hKCgeZ+IeuD7P0JD/2/BQxgB9j6a52qX0nfaVXYARcYgI7jKmDZ
         gwA/BQDzxmgFEMKs0JCQTFZ23W3hZQYn5BDmGtzjhF4KDdVKeca0xGyUkJd7Q1/0BuAc
         wfXAQvUevQUFINaq8ngTMWZtNG09/it6WhTdegli6vEMVJr4J4PRua4I5i7LS98unVJA
         U6dw==
X-Gm-Message-State: APjAAAUA4jm3H7zHVVgM+R1+OBnJLCwLyd/xLerj8CxMN1aFq8cI7+Ya
        GWNYWnNCHo2r63I4uM+G0cxqcmf53GpN7g==
X-Google-Smtp-Source: APXvYqxwjWf5pu31q+DNIV79yz6vuKn36hGNB22goOPms0tZ5qWFghL6dJs5Hp3oSEd89M+gPq7Eow==
X-Received: by 2002:a81:6dd6:: with SMTP id i205mr303241ywc.180.1561588907545;
        Wed, 26 Jun 2019 15:41:47 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:a495:edeb:abca:f993])
        by smtp.gmail.com with ESMTPSA id p17sm76404ywp.96.2019.06.26.15.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 15:41:46 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:41:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/1] ref-filter.c: faster multi-pattern ref filtering
Message-ID: <cover.1561588479.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Peff and I have been experimenting with using the references from a
repository's alternate to speed up the connectivity check following a
'git clone --reference'.

We have noticed that the connectivity check becomes much faster when
advertising both the heads and tags of an alternate, as opposed to just
the heads. But, in our initial experiments, we noticed that it took
*far* longer to compute the answer to:

  $ git for-each-ref refs/heads refs/tags

then simply

  $ git for-each-ref refs/heads

We found that this dates back to cfe004a5a9 (ref-filter: limit
traversal to prefix, 2017-05-22), which drops the user-provided patterns
entirely when more than one pattern is passed to the ref filter.

To remedy this, we implemented an algorithm which computes the longest
pattern prefixes over the disjoint subsets of patterns provided to the
ref filter. This produces the most-specific queries (i.e., the ones that
we hope to return the fewest extra results) without covering the same
ref more than once.

The details of the algorithm are written up in detail in the patch. This
doesn't have quite the impressive results on repositories the size of
the kernel, but yields a drastic improvement on our fork network
repositories. Some synthetic results are included in the patch as well.

Thanks in advance for your review.

Taylor Blau (1):
  ref-filter.c: find disjoint pattern prefixes

 ref-filter.c            | 89 +++++++++++++++++++++++++++++------------
 t/t6300-for-each-ref.sh | 26 ++++++++++++
 2 files changed, 89 insertions(+), 26 deletions(-)

--
2.21.0.203.g358da99528
