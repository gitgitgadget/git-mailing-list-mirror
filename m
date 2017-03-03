Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B3F2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 01:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdCCBcd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 20:32:33 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:36094 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751829AbdCCBcc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2017 20:32:32 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1cjbSm-0004S0-Ra; Fri, 03 Mar 2017 01:52:52 +0100
To:     GIT Mailing-list <git@vger.kernel.org>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: log -S/-G (aka pickaxe) searches binary files by default
Message-ID: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
Date:   Fri, 3 Mar 2017 01:52:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1488504752;e18e2353;
X-HE-SMSGID: 1cjbSm-0004S0-Ra
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I happen to have quite large binary files in my repos.

Today I realized that a line like
git log -G a
searches also files found to be binary (or explicitly marked as binary).

Is that on purpose?
The documentation of "-G<regex>" states

"Look for differences whose patch text contains added/removed lines that
match <regex>."

which contradicts the current behaviour. At least for me text != binary.

To reproduce:
$ git init
$ echo -e "a\0b" > data.bin
$ git add data.bin
$ git commit -m "Add new data"
$ git log -p
[...]
diff --git a/data.bin b/data.bin
new file mode 100644
index 0000000..1a23e4b
Binary files /dev/null and b/data.bin differ
$ git log -G a
[...]

    Add new data

I've verified the behaviour with git version 2.12.0.windows.1 and git
version 2.12.0.189.g3bc5322 on debian.

If it is on purpose is there a config option to disable that?

Thanks for reading,
Thomas
