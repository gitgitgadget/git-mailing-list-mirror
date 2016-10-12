Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8F92098A
	for <e@80x24.org>; Wed, 12 Oct 2016 13:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755273AbcJLNsj (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:48:39 -0400
Received: from mout.web.de ([212.227.17.11]:63662 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754922AbcJLNsP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:48:15 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MgOL4-1bWiSJ3oNK-00Ng1k; Wed, 12 Oct 2016 15:47:26
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 0/2] Stream and fast search
Date:   Wed, 12 Oct 2016 15:47:24 +0200
Message-Id: <20161012134724.28287-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161009095649.1886-1-tboegi@web.de>
References: <20161009095649.1886-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BkwCXqrv69wj8uRkAUWVeW8cE7GMbdFqISf/kX/5dDKqF7YKbqy
 D47QHrNrBx4w4CPRErKJzbMSx51vFfqseab/GFNTGdaEUzC+HWnE8T2S8jp/AjXP5Zr0TrU
 ptbSEH3QLpkViKEPcHolIIrcN7psCoc19vNOJ4krxCq+IgWL0l75e8uSN93wIcxT9tppkdv
 hogORSrGViAYSY3DGhokQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rtg5N93DBVs=:0kLTTk0FLFhYzDoY+XE5QK
 +n6LxVojnUdBPWpZkNxOSaobFhOwPHtjMsbHW7kF1WY0O2GkPS8PF6HpwJpeVIG6p+vpaC5L3
 q712tOLyzOEka/gOE0GTjQtIVwNaYgun0ICa+jikiMGt13ei4gPirpSDX7wQM4ZByGTJQ7oTf
 LwiZiCJAxoOgFqCCvAaAeGw/S+3yHVBzJOtdYWFEOuXw+nyATRLZnCX1VunLn8IQKqnr/5Q56
 Fz1818JiK2sXU0k89XtEIPag5TOETmvXWPCsH30HrmA92nmykAjE6+8tAJoy6ZB/3ri8yYKzN
 bHCbHLfUDQ20KR5Z6L2/uZ9ESXp/xdCm1YQdzDWDSAc/kb/oMuPMLOPZAL+J4rR7qsu0TqiUC
 h0PUv+DRRdpfoSsaYIXbsPBjV4RXevfYg6tX4vDbVhlLYhoH9T/mDQ28Z1k96b5BGtC1WTd63
 Jy/aWCXFKG9Ok8YqZdj6hsvxaEcElC76GtPpN0QvayFRmDk5+iGuhmZlrO9A+b3odAWQmadxK
 t+pOtwDAbLgjiQnAJXC88SRibF05T1KN4X0i+dezo4TRUzyrMel0MQZUrkMxy2qqORDmSmBA8
 e0L/puetVKj+/3KiLz5lR2DCdLOhTNolP4dKohO6OodZLnl7oeeOzc8sjqfh9JBeLwDDkYpJ+
 2T9WBg7+cgt53ObvsCaNPIdLAVL+6xFcWB+VRN6PCV8oNkEHvKF2JDQl+fLo/ResNhkGq6/TJ
 xGipaOKTKlQtXeW9Ko8tgaJoqyv70i/x7t0k4jZ57r/hQcBneeOEudogFRRjEHzZtb/HrAE/F
 R5pSBqo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Changes since v1:
- Rename earlyout into search_only
- Increase buffer from 2KiB to 16KiB
- s/mask/eol_bits/
- Reduce the "noise"
- Document "split gather_stats() into gather_all_stats()/gather_stats_partly()

Torsten Bögershausen (2):
  read-cache: factor out get_sha1_from_index() helper
  convert.c: stream and fast search for binary

 cache.h      |   3 +
 convert.c    | 191 ++++++++++++++++++++++++++++++++++++++++-------------------
 read-cache.c |  29 +++++----
 3 files changed, 150 insertions(+), 73 deletions(-)

-- 
2.10.0

