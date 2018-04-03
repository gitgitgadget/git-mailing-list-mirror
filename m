Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA0C1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbeDCN3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:29:50 -0400
Received: from mailhost.frm2.tum.de ([129.187.179.12]:15188 "EHLO
        mailhost.frm2.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeDCN3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:29:48 -0400
Received: from mailhost.frm2.tum.de (localhost [127.0.0.1])
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTP id w33DTBPx065955;
        Tue, 3 Apr 2018 15:29:45 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Virus-Scanned: at mailhost.frm2.tum.de
Received: from taco6.ictrl.frm2 (taco6.ictrl.frm2 [172.25.2.6])
        (authenticated bits=0)
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTPSA id w33DTDqT065971
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Apr 2018 15:29:13 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
Subject: Re: Test 5561 failed
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <66ac8aec-3e4c-43be-83d1-7bd823ec2b20@frm2.tum.de>
 <20180403131447.GB18824@sigill.intra.peff.net>
From:   =?UTF-8?Q?Jens_Kr=c3=bcger?= <Jens.Krueger@frm2.tum.de>
Message-ID: <7769193d-f10d-9e3e-6c9d-c21a4a72485f@frm2.tum.de>
Date:   Tue, 3 Apr 2018 15:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403131447.GB18824@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mailhost.frm2.tum.de [129.187.179.12]); Tue, 03 Apr 2018 15:29:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




Am 03.04.2018 um 15:14 schrieb Jeff King:
> On Tue, Apr 03, 2018 at 01:43:37PM +0200, Jens Krüger wrote:
>
>> expecting success: GET refs/heads/master "404 Not Found" not ok 2 - 
>> direct refs/heads/master not found 
> That GET function is:
>
>    GET() {
>          curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
>          tr '\015' Q <out |
>          sed '
>                  s/Q$//
>                  1q
>          ' >act &&
>          echo "HTTP/1.1 $2" >exp &&
>          test_cmp exp act
>    }
>
> The tarball you sent shows "out" as empty, and "act" is missing. So
> "curl" produced no output, and we did not make it as far as the tr/sed
> pipe. Just a guess, but are you missing the "curl" command-line tool on
> your system? If so, "apt install curl" should fix the failure.
Yes, the missing curl program was the reason, but I didn't find any hint 
about
the missed program in the log output. The output will be suppressed by 
the '2>/dev/null' in
lines: 9 and 22 of the t5561-http-backend.sh script.

Nevertheless many thanks for helping.

> As far as code changes in Git, perhaps (assuming my guess is right):
>
>    - drop the redirect of stderr here; the test suite already handles
>      hiding stderr from the user (without "-v"), and in "-v" mode you
>      probably would have gotten a useful error like "curl: not found"
>
>    - it's rare but possible to have libcurl installed (which is needed
>      for the server side, and what we key on for running the httpd tests)
>      but not the curl binary. This test probably should check for the
>      existence of the curl binary as a prerequisite.
>
> -Peff

