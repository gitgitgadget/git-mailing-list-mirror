Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115911F453
	for <e@80x24.org>; Sun, 17 Feb 2019 13:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfBQN7e (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 08:59:34 -0500
Received: from placid1.grammatech.com ([98.159.213.246]:44836 "EHLO
        placid.grammatech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbfBQN7e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 08:59:34 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 08:59:33 EST
Received: from placid.grammatech.com (placid1 [192.168.219.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by placid.grammatech.com (Postfix) with ESMTPS id 4DC1F1446AE
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 08:49:39 -0500 (EST)
Received: from jranieri-l1.local (barracuda.grammatech.com [192.168.219.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by placid.grammatech.com (Postfix) with ESMTPSA id 2D0451446AD
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 08:49:39 -0500 (EST)
From:   Joe Ranieri <jranieri@grammatech.com>
Subject: [BUG] ls-files showing deleted files (unchecked lstat return value)
To:     git@vger.kernel.org
Message-ID: <1ff48830-f3de-11f4-9014-c20eb3890c21@grammatech.com>
Date:   Sun, 17 Feb 2019 08:49:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git ls-files -m" can show deleted files, despite -d not having been 
specified. This is due to ls-files.c's show_files function calling lstat 
but not checking the return value before calling ie_modified with the 
uninitialized stat structure.

This problem was found using the static analysis tool GrammaTech CodeSonar.

-- 
Thanks and Regards,
Joe Ranieri
Software Engineer
GrammaTech, Inc.
