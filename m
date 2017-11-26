Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4206A20954
	for <e@80x24.org>; Sun, 26 Nov 2017 00:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbdKZAuZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 19:50:25 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:49027
        "EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751377AbdKZAuZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 19:50:25 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Nov 2017 19:50:25 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Il2CeTz4K9uxTIl2EegA9N; Sat, 25 Nov 2017 17:43:07 -0700
Date:   Sun, 26 Nov 2017 02:43:00 +0200
From:   Max Kirillov <max@max630.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by
 rfc3875
Message-ID: <20171126004300.GB26158@jessie.local>
References: <20160401235532.GA27941@sigill.intra.peff.net>
 <20171123234511.574-1-max@max630.net>
 <CAPig+cQEaqaOTcC=5pZZmZNs_QQQ0vBRbzczyM3ZXXi+ZHW4XA@mail.gmail.com>
 <20171125214721.GA26158@jessie.local>
 <CAPig+cRRHepuNNva_cq2YPEDSBCO25y1mihuC52RntpJ+a+YMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRRHepuNNva_cq2YPEDSBCO25y1mihuC52RntpJ+a+YMg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfK3gVWoBExnMvEpTX2mjg9m2zfnIjNbCmijb9mwNZzsWA9TD62Dha2rMjaaFv4sQtth/TuC6PtrdbPtTrmi+g0HUsmKGt6crs0aQBr6sA8++GynCcSTQ
 PHX9793njcdGbDPiwbcAjAZgr22z9x+EEOXEX1N6CKtV4ao6CEIaAsT9fsHPBkBsMM7qfrdwkIaTLDBqhGojOqvpALPAxpbLIuotqu96heEoGthq6HikaOSP
 Pg7+wXT4lgTWPMiJRMih+BRJ2Rkex9u23nIKqwJKt1QuxrUdfXxTNtXzpryq6aRmWrCjFB50rTwYSfXazULk7dPmBnQkgyHbmEKQUWTJdDWIOxYWiEFl0fIz
 Wks4HL24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 07:38:33PM -0500, Eric Sunshine wrote:
> On Sat, Nov 25, 2017 at 4:47 PM, Max Kirillov <max@max630.net> wrote:
>> On Thu, Nov 23, 2017 at 08:30:39PM -0500, Eric Sunshine wrote:
>>>> +static ssize_t read_request_fix_len(int fd, size_t req_len, unsigned char **out)
>>>
>>> Wrong data type: s/size_t req_len/ssize_t req_len/
>>
>> Passing negative value to the function makes no sense. I
>> could add explicit type cast to make it clear. It should be
>> safe as site_t's range is bigger, and overflown
>> CONTENT_LENGTH results in die() at parsing (I have a test
>> which verifies it)
> 
> A concern with requesting size_t bytes is that, if it does read all
> bytes, that value can't necessarily be represented by the ssize_t
> returned from the function. Where would the cast be placed that you
> suggest? How do other git functions deal with this sort of situation?

Right... ok, let it be ssize_t
