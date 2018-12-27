Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF40211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 20:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeL0UWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 15:22:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51049 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbeL0UWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:22:04 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wBRKM0ji2533604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 27 Dec 2018 12:22:02 -0800
To:     git@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: RFE: merge driver without overwrite
Message-ID: <c3ad1c9b-86a6-2c51-8147-991ecbac1885@zytor.com>
Date:   Thu, 27 Dec 2018 12:21:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current definition for merge drivers require the output file %A to be
overwritten. When using a pipeline of Unix commands, this often results in %A
being truncated too early, requiring the user to add a temporary file managed
explicitly.

It would be far preferable if git could manage this; perhaps an %N marker for
a temporary filename, which, if given, is treated as the output; notionally:

	if [ $? -eq 0 -a -f %N ]; then mv -f %N %A; else rm -f %N; fi

	-hpa
