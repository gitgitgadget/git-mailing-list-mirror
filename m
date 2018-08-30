Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C981F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeH3GnA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:43:00 -0400
Received: from avasout06.plus.net ([212.159.14.18]:38790 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeH3GnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 02:43:00 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id vCvKfYPekWLW2vCvLfcbsK; Thu, 30 Aug 2018 03:43:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=j6OFnsxIUQazhbATvgkA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: Missing Tagger Entry
To:     Stephen & Linda Smith <ischis2@cox.net>,
        Git Mailing List <git@vger.kernel.org>
References: <2548439.nLQp1kU402@thunderbird>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <827dde10-9a7b-a7f1-76de-8ea079167d5e@ramsayjones.plus.com>
Date:   Thu, 30 Aug 2018 03:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2548439.nLQp1kU402@thunderbird>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK0oJmqOl4rm144arI1DhzV2YApZsZf+0v9h530aOzztB0KnpPQRz0k4CZV0BC12r1j4GHwACA8a6l7AwPUGhVoqT0tfXoYdOZOljGcZ02Ov15k9sZUf
 yFysXNct+1cpyFOsWOibOhZQcKGmJPjXyORIsyUHubCi8jYZ6tgGjTJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/08/18 02:56, Stephen & Linda Smith wrote:
> I am getting the following warning when runing a git fsck command against tag 
> v0.99.

Yes, that is expected.

> 
> $ git --version
> git version 2.18.0
> 
> $ git fsck
> checking object directories: 100% (256/256), done.
> warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: 
> invalid format - expected 'tagger' line
> Checking objects: 100% (254339/254339), done.
> Checking connectivity: 254329, done.

This tag is so old that it dates to before a change in
the tag object format - in particular, before the 'tagger'
line was included. Viz:

  $ git cat-file tag v0.99
  object a3eb250f996bf5e12376ec88622c4ccaabf20ea8
  type commit
  tag v0.99
  
  Test-release for wider distribution.
  
  I'll make the first public RPM's etc, thus the tag.
  -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1.4.1 (GNU/Linux)
  
  iD8DBQBC0b9oF3YsRnbiHLsRAlUUAKCJEyvw8tewGFKd/A3aCd82Wi/zAgCgl7z4
  GYPjO+Xio0IvuEYsrhFc2KI=
  =TVVN
  -----END PGP SIGNATURE-----
  $ 

Note the lack of a 'tagger' line, unlike a more up-to-date tag:

  $ git cat-file tag v2.18.0
  object 53f9a3e157dbbc901a02ac2c73346d375e24978c
  type commit
  tag v2.18.0
  tagger Junio C Hamano <gitster@pobox.com> 1529600438 -0700
  
  Git 2.18
  -----BEGIN PGP SIGNATURE-----
  
  iQIzBAABCAAdFiEE4fA2sf7nIh/HeOzvsLXohpav5ssFAlsr2bYACgkQsLXohpav
  5suqEhAAgDu2A1n9G7ik+HdKoH2VNGwDqaRu/3k8znLPR6NmcOpHqopCgaxPYN4T
  gH69ff+8Le8NiOYcoWaOE2WdpGGY9Gu12N65MpxYbEhehEGo7ze4T8jDNlHz7q5B
  XC55FKHAwqy51NtdzvqNgsptc3bASy+ThxNM5XS0GSeqz00ublquHhiGTzhkBKm2
  KbexWhGWjzq0zP+wOrRIX4zU1lAOHXzjVV7G8vo3pTcg+GgK0BmiAz8zmOlef2au
  SYlU2LJCcQFm12j7pdDx42qCfZYM3QB0vJkHAcEdKYlcSEKRYUdOEnIQHxHwPPvB
  A/uogytfeExnpBd/aHA/YBKlr8FNBMZeDKGHiwxWsBK5yExxfelIFnOg27YBIxl2
  zzbMnHubBqHs5luo2Yv9JmFCbmuqV6ei6qgDKn2BXtJkuXVqYI1FYuKQyO26b3cz
  C6hF5n3OIixL0wv1S+44QqDEc/ss8kvqosT2Ypjd56dNeZripTe3jC+bqUouHblD
  NGaUn+V2YGBKc3rPw1UE3WnXgqOcbyvxn8AoZIKhJveaq7z89CbcvQYpqNjGhmrp
  OvqSVG3NUoOKGXiMAg4/a4wx6JWTyu5SLHY269tC3cPfxQkD3br6hMsBy+AXrCwq
  5yk6A3kQ2d6S9QfbWr6PGT7FI/AhG9CftFXPjpF0h9W9xbPJfkE=
  =ResM
  -----END PGP SIGNATURE-----
  $ 

You can suppress this warning by using an fsck 'skiplist':

  1) Add the following lines to your .git/config file:
	[fsck]
		skiplist = .git/skip

  2) Add the object-id of the v0.99 tag to the skiplist file:

	$ echo d6602ec5194c87b0fc87103ca4d67251c76f233a >.git/skip

Hope this helps.

ATB,
Ramsay Jones



