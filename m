Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B0C1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 17:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdHVRG2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 13:06:28 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:21685 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdHVRG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 13:06:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xcH5Y2tZZz5tlV;
        Tue, 22 Aug 2017 19:06:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D1052271;
        Tue, 22 Aug 2017 19:06:24 +0200 (CEST)
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: mk-dontmerge/size-t-on-next test failure
Message-ID: <fcddd218-e104-0f96-71e6-4522564555f1@kdbg.org>
Date:   Tue, 22 Aug 2017 19:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I observe the test failure below in t0040-parse-options.sh. It bisects
to 1a7909b25eb4ab3071ce4290115618e2582eadaa "Convert pack-objects to
size_t". It looks like git_parse_size_t() needs a fix. This is on
Windows, 32 bit. size_t, int and long are all 32 bits wide.

expecting success:
        check magnitude: 1073741824 -m 1g

ok 18 - OPT_MAGNITUDE() giga

expecting success:
        check magnitude: 3221225472 -m 3g

error: switch `m' expects a non-negative integer value with an optional
k/m/g suffix
usage: test-parse-options <options>

    --yes                 get a boolean
    -D, --no-doubt        begins with 'no-'
    -B, --no-fear         be brave
    -b, --boolean         increment by one
    -4, --or4             bitwise-or boolean with ...0100
    --neg-or4             same as --no-or4

    -i, --integer <n>     get a integer
    -j <n>                get a integer, too
    -m, --magnitude <n>   get a magnitude
    --set23               set integer to 23
    -t <time>             get timestamp of <time>
    -L, --length <str>    get length of <str>
    -F, --file <file>     set file to <file>

String options
    -s, --string <string>
                          get a string
    --string2 <str>       get another string
    --st <st>             get another string (pervert ordering)
    -o <str>              get another string
    --list <str>          add str to list

Magic arguments
    --quux                means --quux
    -NUM                  set integer to NUM
    +                     same as -b
    --ambiguous           positive ambiguity
    --no-ambiguous        negative ambiguity

Standard options
    --abbrev[=<n>]        use <n> digits to display SHA-1s
    -v, --verbose         be verbose
    -n, --dry-run         dry run
    -q, --quiet           be quiet
    --expect <string>     expected output in the variable dump

not ok 19 - OPT_MAGNITUDE() 3giga
#
#               check magnitude: 3221225472 -m 3g
#
