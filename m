Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A482035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966097AbcJYVll (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:41:41 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50537 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966295AbcJYVjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:39:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t3RPD0lNPz5tlP;
        Tue, 25 Oct 2016 23:39:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9D9D45311;
        Tue, 25 Oct 2016 23:39:11 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not
 inherited by child processes
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20161024180300.52359-1-larsxschneider@gmail.com>
 <20161024180300.52359-3-larsxschneider@gmail.com>
 <10135d1c-d9a7-d4ec-438a-bb0a8f6762fe@kdbg.org>
 <4C96209A-756F-45F1-B075-037FE32B3291@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, e@80x24.org,
        jnareb@gmail.com, gitster@pobox.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e8deda5f-11a6-1463-4fc5-25454084ccb1@kdbg.org>
Date:   Tue, 25 Oct 2016 23:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <4C96209A-756F-45F1-B075-037FE32B3291@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2016 um 21:53 schrieb Lars Schneider:
>
>> On 24 Oct 2016, at 21:22, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 24.10.2016 um 20:03 schrieb larsxschneider@gmail.com:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> This fixes "convert: add filter.<driver>.process option" (edcc8581) on
>>> Windows.
>>
>> Today's next falls flat on its face on Windows in t0021.15
>> "required process filter should filter data"; might it be the
>> failure meant here?(I haven't dug deeper, yet.)
>
> Yes, this is the failure meant here :-)

I trust your word and Dscho's that it fixes a failure on Windows. In my 
case, however, it was an outdated perl (5.8.8) which left a message 
along the lines of "lookup of member flush in IO::Handle failed" in one 
of the *.log files. I came up with the following workaround.

Fix-method: shot-in-the-dark
Perl-foo: not-present
Not-signed-off-by: Me

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ae4c50f..bb88c5f 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -22,6 +22,7 @@

  use strict;
  use warnings;
+use FileHandle;

  my $MAX_PACKET_CONTENT_SIZE = 65516;
  my @capabilities            = @ARGV;
-- 
2.10.0.343.g37bc62b

