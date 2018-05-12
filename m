Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9471F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeELIWA (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:22:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:41069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeELIV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:21:59 -0400
Received: from [192.168.123.75] ([95.223.128.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrePN-1eJ63n0DVt-013Ltq; Sat, 12
 May 2018 10:21:58 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] git send-email: incorrectly parses email address with comma
To:     git@vger.kernel.org
Message-ID: <9a35041b-8333-9533-4344-08d6ef99c9c9@gmx.de>
Date:   Sat, 12 May 2018 10:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZLzZM8uzpuO5+x6vpSlPANwgTRYnENBQT3JzKd3EEKA1K6lEHxq
 1ttMXnPNcZO/hdifGQFYgCnDUMtIsAtzDNcfGlv6Trj8f6RWT2ziwLVP3W3a6mJ7Ip4PEOZ
 HQs/oZXkJRFPz+CQGC1w3bLhkAxCrfZGY9uN5fyn7V+s7fdXw1xY2Z9L7l1ilx454H8rCST
 EbjffanToPaeolrkXmxAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pf/V4aSOsK8=:lbI2s8a/oePfP/JvAmlftc
 IVC8OxG42Hk7Ug9nMkOzYcJy/AArDFCpH6y4Lg789QiuUZ2kZJJL7ppgJewd0dFMeWO9FhCEY
 RyQX/yrwYlNyhlmfVO4jvf3jXdmO1OlH00DM64lag/wQTUFdUng9UJim7tt//tEXWeP8Uab/R
 BanX63S1bQYt8SBMWOvC59SgXlfQXr8Fn+8zVghyOQXbCrI0mmUH6avb9eaogDS0bIyhhI8/o
 M2dxR7Q/9LMvpY56ridHeszrbA8XAI5evU616DSvUbpbtaxlbExTwVq8YVCrS0Vmxy6bD9Dbo
 r0olG5yfImkv2P+liX5kj7bsqTSNcmGE59UQcola+Fp3SOCwOTriJtnv1CLxH6jFPkMEpd2CO
 aNdG8SdSTPKUumls2FP4sDqDAUz25vLJeTdxbrd1IAVzMaC/s5speaCbL6GoLDozwD/zJdtsK
 dbLro5gJVp432rxWLPBTHUb1mfMnqEcTSgZKAcwVSrP00OQfHNb5yHsm4YsP70dCXYyH5+gN+
 tTM/TNSwgb64RvgLTb2XP8yVqDDe9XryHUr7x+JkYkmBLRZCqwLbZfy5Ius8NiU2PG/GSMWLl
 cViUJ7UDYFc3N3aG+qHnBpRJL09NDpvNg0U+JhDf0tgnlQeOB7skm/YhS+3Zt8SRiMIayFcmr
 CDmbkwQTWx7ovOjWE9jOKd52z9bNUdPkPhe5njkURRXuRT0rArBNp/0p569gzUjIjOCPntFwl
 3arkJWicVFtIGFpkk86V8gRJBFXxriQw9K4VAjsmLHbclqLxUSTp3ptNuod4oZm2x28ngp+MX
 ucBgoHR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git send-email allows to combine multiple email addresses in one
parameter, e.g.

--to="a@example.com, b@example.com"

But email addresses may contain commas themselves:

--to="LASTNAME, firstname <firstname.lastname@example.com>"

This may lead to an error:
$ git send-email --to="Schuchardt, Heinrich <xypron.glpk@example.com>" \
0000*.patch0000-cover-letter.patch
(mbox) Adding cc: Heinrich Schuchardt <xypron.glpk@example.com> from
line 'From: Heinrich Schuchardt <xypron.glpk@example.com>'

From: Heinrich Schuchardt <xypron.glpk@example.com>
To: Schuchardt,
        Heinrich <xypron.glpk@example.com>
Subject: [PATCH 0/2] efi_loader: adjust definitions of variable services
Date: Sat, 12 May 2018 10:01:21 +0200
Message-Id: <20180512080121.26620-1-xypron.glpk@example.com>
X-Mailer: git-send-email 2.17.0

Send this email? ([y]es|[n]o|[q]uit|[a]ll): a
Password for 'smtp://xypron.glpk@example.com@mail.example.com:587':
Syntax error in parameters or arguments



Please, implement the following logic,

If the string preceding a comma is not a valid email address do not
split it off.

Best regards

Heinrich Schuchardt
