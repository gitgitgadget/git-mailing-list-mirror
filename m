Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BF2420248
	for <e@80x24.org>; Sat, 23 Feb 2019 07:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfBWHJT (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 02:09:19 -0500
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:60843
        "EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfBWHJS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Feb 2019 02:09:18 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id xRQwgawhr6dqMxRQzgfERM; Sat, 23 Feb 2019 00:09:18 -0700
Date:   Sat, 23 Feb 2019 09:09:14 +0200
From:   Max Kirillov <max@max630.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [RFC PATCH] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190223070914.GC2354@jessie.local>
References: <20190130231359.23978-1-max@max630.net>
 <87lg2kj91a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg2kj91a.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfHgEjER6T0wIodnsbIP9axV5G4J71sJloIdWSMrH1tJaERDn9ZoMhcO0zSVTV6wT7L4O0J5I074YxuRKhtBPUdJ6EOnpMgLb8GlSAj1sSiRS294mwo9A
 eRT0d+xPrKb6A0k3YIKphVJotvUXD/37WyT288jeniqDQe7ngy5qQjJZ2oHhsRzwtR/JZCB30TlP2TbDbftygGS9PqsXZFHx3i/mykQ23jWJyubJXaqhn2wn
 /Xwoj5hDnyibnCNeSOU1Iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 11:08:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
> You have an extra two whitespaces after "&&" there.

Thanks, will check it.

>> +	git commit --allow-empty -m commit &&
> Looks like just "test_commit A" would do here.

About this I'm not sure. AFAIK test_commit does lots of stuff,
so can it be considered "just" compared to "commit
--allow-empty" or the opposite? I could replace it with
test_commit for uniformity reason though.

> We can fail in these sorts of loops. There's a few ways to deal with
> that. Doing it like this with "break" will still silently hide errors:

Thanks, this was pointed point

>> +	printf "$head_object refs/heads/b00\\n" >>.git/packed-refs &&
> 
> Looks like just "echo" here would be simpler since we only use printf to
> add a newline.

Could it happen so that "echo" adds '\r\n' at Windows? I
could use echo.

> Instead of "! git ..." use "test_must_fail git ...". See t/README. This
> will hide e.g. segfaults.

Thanks, this was pointed point

> Also, perhaps:
> 
>     test_must_fail git ... 2>stderr &&
>     grep "broken sorting in packed-refs" stderr
> 
> Would make this more obvious/self-documenting so we know we failed due
> to that issue in particular.

Thanks, will change it
