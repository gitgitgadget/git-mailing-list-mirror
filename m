Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6440C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 10:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjHXKTd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Aug 2023 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbjHXKTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 06:19:25 -0400
Received: from mailg210.ethz.ch (mailg210.ethz.ch [IPv6:2001:67c:10ec:5606::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F203198B
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 03:19:21 -0700 (PDT)
Received: from mailm216.d.ethz.ch (2001:67c:10ec:5603::30) by mailg210.ethz.ch
 (2001:67c:10ec:5606::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 12:19:09 +0200
Received: from mailm214.d.ethz.ch (2001:67c:10ec:5603::28) by
 mailm216.d.ethz.ch (2001:67c:10ec:5603::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 12:19:18 +0200
Received: from mailm214.d.ethz.ch ([fe80::18d4:d750:ea54:d4cb]) by
 mailm214.d.ethz.ch ([fe80::18d4:d750:ea54:d4cb%4]) with mapi id
 15.01.2507.027; Thu, 24 Aug 2023 12:19:18 +0200
From:   "Reverdell  Auriane" <auriane.reverdell@cscs.ch>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: diff alias which used to work in version 2.27, failing from version
 2.28 onwards
Thread-Topic: diff alias which used to work in version 2.27, failing from
 version 2.28 onwards
Thread-Index: AQHZ1nRHnN/T205IeU6lM8PoB3hrSQ==
Date:   Thu, 24 Aug 2023 10:19:18 +0000
Message-ID: <31866645d2ac4cb1be17e35fae742cb2@cscs.ch>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.164.175.245]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

To output the diff of a specific commit, I created the alias dici (see below), git dici 12345 or git dici to output the diff of the HEAD:

[alias]
    dici = !git diff ${1:-HEAD}^..${1:-HEAD}

a trace for this alias gives (same trace for both git 2.27 and 2.28!):

14:38:45.275964 git.c:439               trace: built-in: git diff a2028e7b^..a2028e7b a2028e7b 

The commit number is put again at the end of the command (the wanted alias is supposed to output only `git diff a2028e7b^..a2028e7b`), this was accepted by version 2.27 but not by the version 2.28. For now, my temporary fix is adding a bash comment at the end of the alias:

[alias]
    dici = "!git diff ${1:-HEAD}^..${1:-HEAD} #"

Note: the first alias still doesn't work with the latest git versions (tested with 2.40.0, 2.39.2, 2.37.5).

Is that expected behavior? if yes, how is the right/clean way to discard the command line argument of the alias?

Thanks in advance!

Auriane
