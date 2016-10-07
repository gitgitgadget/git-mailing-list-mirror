Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E4420987
	for <e@80x24.org>; Fri,  7 Oct 2016 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756777AbcJGPHV (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 11:07:21 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:49918 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756698AbcJGPGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 11:06:55 -0400
Received: from [84.131.252.35] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsWja-00056S-Fn; Fri, 07 Oct 2016 17:06:50 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v2 0/3] Speedup finding of unpushed submodules
Date:   Fri,  7 Oct 2016 17:06:33 +0200
Message-Id: <cover.1475851621.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.637.g09b28c5
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can find the first iteration of this series as part of this thread:

http://public-inbox.org/git/%3C20160914173124.GA7613@sandbox%3E/

All mentioned issues should be fixed. I dropped the last patch which was
the cause of the broken tests.

This should optimize every part of this test to a nice speed if you are
pushing to a remote. The only case that is still broken/slow as hell is
when calling push with a direct url.

I am thinking whether we should maybe error out with a "not implemented"
message or something and mention that --recurse-submoules does not work
with direct urls? But we might want to have another look at performance
with this patch included. Maybe it is actually useable with the last
patch included which was not yet on pu.

Cheers Heiko

Heiko Voigt (3):
  serialize collection of changed submodules
  serialize collection of refs that contain submodule changes
  batch check whether submodule needs pushing into one call

 submodule.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 submodule.h |   5 +--
 transport.c |  29 ++++++++++-----
 3 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.10.1.637.g09b28c5

