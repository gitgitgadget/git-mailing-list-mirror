Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E8B20248
	for <e@80x24.org>; Wed, 27 Feb 2019 19:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfB0TgM (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 14:36:12 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:4671 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfB0TgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 14:36:12 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 448mBc3Qv0z5tlF;
        Wed, 27 Feb 2019 20:36:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4B5D71DEB;
        Wed, 27 Feb 2019 20:36:07 +0100 (CET)
Subject: Re: Need multibyte advice - Shift-JIS
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?B?J01pY2hhbCBTdWNow6FuZWsn?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com>
 <20190227150836.495f1692@kitsune.suse.cz>
 <000001d4ceb4$b930df50$2b929df0$@nexbridge.com>
 <20190227171103.4cbc735a@kitsune.suse.cz>
 <000a01d4ceb8$3cd19720$b674c560$@nexbridge.com>
 <20190227172841.3a74fa60@kitsune.suse.cz>
 <000b01d4ceba$39cfddf0$ad6f99d0$@nexbridge.com>
 <20190227175135.4392e9d7@kitsune.suse.cz>
 <001101d4cebe$7119a080$534ce180$@nexbridge.com>
 <20190227181458.4f019d91@kitsune.suse.cz>
 <001b01d4cec3$364149e0$a2c3dda0$@nexbridge.com>
 <20190227185044.120c0ba7@kitsune.suse.cz>
 <002501d4cec6$2a5e5a20$7f1b0e60$@nexbridge.com>
 <20190227191814.054c2f3c@kitsune.suse.cz>
 <003301d4cecd$4bced250$e36c76f0$@nexbridge.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d3b76f4f-29b7-663e-ca3b-c15b1345a133@kdbg.org>
Date:   Wed, 27 Feb 2019 20:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <003301d4cecd$4bced250$e36c76f0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.19 um 19:50 schrieb Randall S. Becker:
> On February 27, 2019 13:18, Michal Suchánek wrote:
>> What are your requirements, exactly?
> Source code and comments contain SJIS content. The requirement is to
> be able to move seamlessly in and out of git, and have git show/diff/log
> display SJIS as well as ASCII content. How that happens is open. The
> UTF-16 is a red-herring, only as an attempt at getting at SJIS content
> differently than the limitation imposed by less.

When your file content contains ShiftJIS, you should set an attribute in
.gitattributes:

*.sourcecode	encoding=ShiftJIS

When your git commits messages contain ShiftJIS, you should configure

 git config i18n.commitEncoding ShiftJIS

More precisely, this assumes that your editor that composes to commits
messages writes the .git/COMMIT_MSG in ShiftJIS.

When your terminal or pager is configured that it interprets the byte
stream that it receives from applications for display as ShiftJIS, then
you should configure

 git config i18n.logOutputEncoding ShiftJIS

You can set this independently from the other settings. In particular,
when it is not set, UTF-8 is assumed. That is, if your terminal or pager
supports UTF-8, you should *NOT* set this configuration (or set it to
UTF-8).

And, of course, you must have built Git with iconv, which must have
support for ShiftJIS.

-- Hannes
