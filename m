Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C89B2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbcKGSyo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 13:54:44 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:51560 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933531AbcKGSym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 13:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=to:cc:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=HJ5ZIs/ZCYpJjkWvXBz3810oL9e
        POfzN/wCZIkcUzzc=; b=jIFmnJ/pBY5AU66JGFkf1n1FiSiAVFeJlzCxFWl/t/e
        LQ6Z42fnIySCpgSsI0MChbnM6V0eH6RMqbyDZXYL5gdev5oRrxbpPblual3MWXV+
        +J0yuYOVFL4M+WhsO0+M1UrOSHEBhATVAGbPW/xKOSi0jPWhxvGRZKmYNRzLzR+Y
        =
Received: (qmail 10834 invoked from network); 7 Nov 2016 19:54:28 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 7 Nov 2016 19:54:28 +0100
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Subject: [PATCH 0/3] gitk: memory consumption improvements
Message-ID: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
Date:   Mon, 7 Nov 2016 19:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


List, Paul,

after searching for a while on why Gitk sometimes consumes exorbitant amounts of memory I found a pair of minor issues and also a big one: the text widget comes with an unlimited undo manager, which is turned on be default. Considering that each line is inserted seperately, this piles up a huuuge undo stack ... for a read-only text widget. Simply turning off this undo manager saves about 95% of memory when viewing large commits (with tens of thousands of diff lines).

3 patches are about to follow:

 - turn off the undo manager,

 - forget already closed file descriptors and

 - forget the 'commitinfo' array on a reload to enforce reloading it.

I hope this finds you appreciation.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
