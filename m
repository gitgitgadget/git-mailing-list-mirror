Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80D31F462
	for <e@80x24.org>; Tue, 21 May 2019 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEUVsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:48:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29139 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUVsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:48:04 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x4LLm1vh008435
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:48:02 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git Mailing List'" <git@vger.kernel.org>
Subject: [Breakage] 2.22.0-rc1 t5401-update-hooks.sh
Date:   Tue, 21 May 2019 17:47:54 -0400
Message-ID: <001501d5101e$db98dfb0$92ca9f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdUQEiztDlPa8Ur/QXaMmSmTTxdKJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another situation came up during regression testing on NonStop:

t5401 broke on the first run through (most tests), with the failures below. 

*** t5401-update-hooks.sh ***
not ok 1 - setup
#
#               echo This is a test. >a &&
#               git update-index --add a &&
#               tree0=$(git write-tree) &&
#               commit0=$(echo setup | git commit-tree $tree0) &&
#               echo We hope it works. >a &&
#               git update-index a &&
#               tree1=$(git write-tree) &&
#               commit1=$(echo modify | git commit-tree $tree1 -p $commit0)
&&
#               git update-ref refs/heads/master $commit0 &&
#               git update-ref refs/heads/tofail $commit1 &&
#               git clone --bare ./. victim.git &&
#               GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1
&&
#               git update-ref refs/heads/master $commit1 &&
#               git update-ref refs/heads/tofail $commit0
#
t5401-update-hooks.sh: line 26: victim.git/hooks/pre-receive: No such file
or di
rectory
chmod: cannot access 'victim.git/hooks/pre-receive': No such file or
directory
t5401-update-hooks.sh: line 35: victim.git/hooks/update: No such file or
directo
ry
chmod: cannot access 'victim.git/hooks/update': No such file or directory
t5401-update-hooks.sh: line 45: victim.git/hooks/post-receive: No such file
or d
irectory
chmod: cannot access 'victim.git/hooks/post-receive': No such file or
directory
t5401-update-hooks.sh: line 54: victim.git/hooks/post-update: No such file
or di
rectory
chmod: cannot access 'victim.git/hooks/post-update': No such file or
directory
ok 2 - push
etc.

When running the test in isolation, it passes without incident whether or
not --verbose is used. So far, this only occurs on the first run through. I
wanted to report it, based on the inconsistency of results. This is not the
first time tests have acted in this fashion, and I realize it is difficult
to do anything about it without being able to recreate the situation.

Such as it is,
Randall

