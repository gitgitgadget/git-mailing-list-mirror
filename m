Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7E820899
	for <e@80x24.org>; Fri, 11 Aug 2017 16:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbdHKQht (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 12:37:49 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:49921 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753357AbdHKQhs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Aug 2017 12:37:48 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 9F1593C000746;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from:to
        :cc:subject:date:message-id:in-reply-to:references; s=
        jupiterrise.com; bh=etqyzCwAsBTCKRkAQTUkLO36tcs=; b=bLI+r6qa3XdX
        eIB2cjo2AMtkQ+aLmHiDLBZixBksV6kl8DzZfxs+8fvALytBHidHn/BA4dYhc4XJ
        w/fpj77HJuw2WOBsBOJgAm64WTg66en39esIK9MhVFxclXC+0GBkJGREQoFu8mVD
        3c3AEWok1liFtUkmrpFiQ4Rx2G1HbjU=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 6840D3C000740;
        Fri, 11 Aug 2017 09:37:47 -0700 (PDT)
Received: from athena.tgcnet.jupiterrise.com (athena.tgcnet.jupiterrise.com [192.168.20.1])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTP id E415460608;
        Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
Received: by athena.tgcnet.jupiterrise.com (Postfix, from userid 500)
        id C43046E4AD; Fri, 11 Aug 2017 18:37:44 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
To:     git@vger.kernel.org
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: [PATCH 0/2] http: handle curl with vendor backports
Date:   Fri, 11 Aug 2017 18:37:32 +0200
Message-Id: <cover.1502462884.git.tgc@jupiterrise.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The curl packages provided by Red Hat for RHEL contain several
backports of features from later curl releases.
This causes problems with current version based checks in http.c.

Here is an overview of the features that have been backported:
7.10.6 (el3) Backports CURLPROTO_*
7.12.1 (el4) Backports CURLPROTO_*
7.15.5 (el5) Backports GSSAPI_DELEGATION_*
             Backports CURLPROTO_*
7.19.7 (el6) Backports GSSAPI_DELEGATION_*
             Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
7.29.0 (el7) Backports CURL_SSL_VERSION_TLSv1_{0,1,2}

This patch series will update the current version based checks for
protocol restriction and GSSAPI delegation control support to ones
based on features to properly deal with the above listed backports.
The fine grained TLS version support does not seem to be
distinguishable via a preprocessor macro so I've left that alone.

I have build tested these changes against upstream curl 7.12.0 (fails),
7.12.1 and 7.15.5. I have also built and run the testsuite against the
Red Hat provided curl versions listed above.

Tom G. Christensen (2):
  http: Fix handling of missing CURLPROTO_*
  http: use a feature check to enable GSSAPI delegation control

 http.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.14.1

