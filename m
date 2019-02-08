Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E821F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBHKsk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 05:48:40 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38532 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBHKsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:48:40 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18AmXPu056524
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:48:34 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Date:   Fri, 8 Feb 2019 05:48:27 -0500
Message-ID: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdS/m9I5LMkrDCGOS9SxOi9MRSn8xA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

We have a few new breakages on the NonStop port in 2.21.0-rc0. The first is in t5403, as below:

/home/git/git/t/trash directory.t5403-post-checkout-hook/clone3/.git/hooks/post-checkout: line 2: $GIT_DIR/post-checkout.args: ambiguous redirect
not ok 8 - post-checkout hook is triggered by clone
#
#               mkdir -p templates/hooks &&
#               write_script templates/hooks/post-checkout <<-\EOF &&
#               echo "$@" >$GIT_DIR/post-checkout.args
#               EOF
#               git clone --template=templates . clone3 &&
#               test -f clone3/.git/post-checkout.args
#

The post-checkout hook is:
#!/usr/local/bin/bash
echo "$@" >$GIT_DIR/post-checkout.args

This looks like it is a "bash thing" and $GIT_DIR might have to be in quotes, and is not be specific to the platform. If I replace 

echo "$@" >$GIT_DIR/post-checkout.args

with

echo "$@" >"$GIT_DIR/post-checkout.args"

The test passes. I wonder I should provide this patch or whether the author would like to do so.

Thanks,
Randall

