Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D890C1F42D
	for <e@80x24.org>; Tue, 22 May 2018 10:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEVKdb (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 06:33:31 -0400
Received: from n2.nabble.com ([162.253.133.85]:61000 "EHLO n2.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeEVKd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 06:33:29 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2018 06:33:29 EDT
Received: from n2.nabble.com (localhost [127.0.0.1])
        by n2.nabble.com (Postfix) with ESMTP id BF3104548E3A
        for <git@vger.kernel.org>; Tue, 22 May 2018 03:26:39 -0700 (MST)
Date:   Tue, 22 May 2018 03:26:39 -0700 (MST)
From:   curlUser <suga18@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1526984799739-0.post@n2.nabble.com>
In-Reply-To: <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
References: <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net> <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net> <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr> <20131125143213.GA22642@sigill.intra.peff.net> <20131125144321.GA23779@sigill.intra.peff.net> <alpine.DEB.2.00.1311272237400.17037@tvnag.unkk.fr>
Subject: Re: [curl PATCH 2/2] ignore SIGPIPE during curl_multi_cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Again SIGPIPE is seen with curl version 7.45.0 with multi interface.
Backtrace shows :

#7  0x00007f141bea40cd in Curl_ossl_close (conn=0x7f14193f9848, sockindex=0)
at vtls/openssl.c:881
#8  0x00007f141bea8f54 in Curl_ssl_close (conn=0x7f14193f9848, sockindex=0)
at vtls/vtls.c:527
#9  0x00007f141be63969 in Curl_disconnect (conn=0x7f14193f9848,
dead_connection=true) at url.c:2791
#10 0x00007f141be63f4b in disconnect_if_dead (conn=0x7f14193f9848,
data=0xb6a598) at url.c:3050
#11 0x00007f141be63f84 in call_disconnect_if_dead (conn=0x7f14193f9848,
param=0xb6a598) at url.c:3066
#12 0x00007f141bea01c2 in Curl_conncache_foreach (connc=0xae0f48,
param=0xb6a598, func=0x7f141be63f59 <call_disconnect_if_dead>)
    at conncache.c:295
#13 0x00007f141be6400f in prune_dead_connections (data=0xb6a598) at
url.c:3081

Looks like SIGPIPE_IGNORE to be added in prune_dead connections or in
disconnect_if_dead?
Can anyone comment on this. 



--
Sent from: http://git.661346.n2.nabble.com/
