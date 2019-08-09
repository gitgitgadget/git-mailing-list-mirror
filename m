Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCE51F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407338AbfHIPeJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:34:09 -0400
Received: from rchemail.bankofamerica.com ([171.159.227.167]:48211 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406607AbfHIPeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:34:09 -0400
Received: from vadmzmailmx05.bankofamerica.com ([171.182.203.230])
        by lrcha0mzxepmx02.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x79FY7p4017596;
        Fri, 9 Aug 2019 15:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565364847;
        bh=4TzGIf6d1zEACM0fT5CD1zRKfQEskepStKDnMT40NRo=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=NlOs6J40a83Q/pV4HQmHaY6hXdk4pwNbycQyTDMNkbejMZ1hWyFUx/haiWNT4NrYk
         hVfZcwD+z1wY8t/GmoGDQ9E/5tiREMxfxHyh0Xu2JD/eXbQ9ytGzfqyzxLQNClwfIq
         CsPfKncrGkJM2aLTrzD3fbImy0FaongLPQkAUe3g=
Received: from lrcha0n5xepmx12.bankofamerica.com (lrcha0n5xepmx12.bankofamerica.com [171.205.12.15])
        by vadmzmailmx05.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x79FY0eG018957;
        Fri, 9 Aug 2019 15:34:07 GMT
Date:   Fri, 09 Aug 2019 15:34:05 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwA=
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com> <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After correcting spelling of renormalize, the end result of the script you gave is that line endings in working directory are CRLF, and in the repo are LF.
Is that expected?  Surprising?  Not sure what you were trying to test there.  I also fixed my script to use printf, new version is:
(using copy/paste this time, instead typing from memory like last time; learned my lesson).

mkdir empty
cd empty
git init
git config core.autocrlf false
printf '1\r\n2' > test.txt
git add .
git commit -m test
git config core.autocrlf input
cp test.txt t2.txt
printf 'a\r\nb' > test.txt
git add .

Thank you for ls-files, I've been resorting to deleting from working directory and then doing a checkout.
And also thank you for the gem of "od -c"!
The output of ls-files after running my script is:

i/lf    w/crlf  attr/                   t2.txt
i/crlf  w/crlf  attr/                   test.txt

So I'm still confused.  Why didn't test.txt lose its CRs while t2.txt did?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
