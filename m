Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709141FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeCTPx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:53:28 -0400
Received: from esa2.arlut.utexas.edu ([66.162.93.36]:5745 "EHLO
        esa2.arlut.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCTPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:53:28 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2018 11:53:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=arlut.utexas.edu; i=@arlut.utexas.edu; q=dns/txt;
  s=default; t=1521561208; x=1553097208;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=ITo4ZIXqmF6kMIEQ0LVAwbtLjGn3lkt9qABA39WutdQ=;
  b=ORLd/R6c513+c1j9kS21Wm00gvtAuqoj6bRTHawQ3nhDRWavhH4QDtFf
   iqFwpTlshXTK01k4BS5OeaozcAOjrObmMrWDYDzOECod73qx3kZuq2abt
   kT8hN2UZQqGSjEfmZkadZAubtJF6yphquNNC/EqINi1auaILPxY7Ggbeq
   e78+FztkqvJyugpsJeKkXr2PveskhkSGhPG5YVe+olFXxov3VxNuQmFad
   ww7WU/JKe3+DZMjOl9YK88bSmgNkGLuisREidBZSFpSP6f0bNDah3eYSq
   1ck5LiGRilUaE0X0BJxVt9xh0Fqf0tTQK2LxqBJsrEDUqYp4ZyiX2w9MD
   g==;
X-IronPort-AV: E=McAfee;i="5900,7806,8837"; a="3803921"
X-IronPort-AV: E=Sophos;i="5.48,336,1517896800"; 
   d="scan'208";a="3803921"
Received: from intpfx2.arlut.utexas.edu ([10.14.8.123])
  by esa2.arlut.utexas.edu with ESMTP; 20 Mar 2018 10:43:52 -0500
Received: from intesa2.arlut.utexas.edu (intesa2.arlut.utexas.edu [10.14.8.33])
        by intpfx2.arlut.utexas.edu (Postfix) with ESMTP id 0C15DA645A
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 10:43:51 -0500 (CDT)
X-IronPort-AV: E=McAfee;i="5900,7806,8837"; a="1690346"
X-IronPort-AV: E=Sophos;i="5.48,336,1517896800"; 
   d="scan'208";a="1690346"
Received: from footstool.arlut.utexas.edu (HELO [10.14.136.104]) ([10.14.136.104])
  by mail.arlut.utexas.edu with ESMTP; 20 Mar 2018 10:43:52 -0500
To:     git@vger.kernel.org
From:   Luke Robison <robison@arlut.utexas.edu>
Subject: Understanding Binary Deltas within Packfile
Message-ID: <f301d093-af93-016b-79b9-3102475260cf@arlut.utexas.edu>
Date:   Tue, 20 Mar 2018 10:43:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any documentation of the contents of the binary delta datain a 
packfile, and how to interpret them?  I found 
https://github.com/git/git/blob/master/Documentation/technical/pack-format.txt 
documenting the packfile itself, but the "compressed delta data" seems 
largely undocumented.  The source code of 
https://github.com/git/git/blob/master/diff-delta.c is pretty dense.  
This is what I've got so for:

+-------------+
| Varint src_size
| Varint trg_size
| 1-byte inscnt
| N-bytes up to 16 bytes of trg_buf
|
| A series of Operations
|
+-------------


Any details on how to interpret the opcodes would be greatly appreciated.

Thanks,
Luke

