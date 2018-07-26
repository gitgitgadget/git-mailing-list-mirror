Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DCBB1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 04:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeGZFzG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 01:55:06 -0400
Received: from p3plsmtpa12-01.prod.phx3.secureserver.net ([68.178.252.230]:56284
        "EHLO p3plsmtpa12-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbeGZFzF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Jul 2018 01:55:05 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id iY2AfL47uTtfhiY2DfwNG6; Wed, 25 Jul 2018 21:37:55 -0700
Date:   Thu, 26 Jul 2018 07:37:51 +0300
From:   Max Kirillov <max@max630.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180726043751.GB1959@jessie.local>
References: <20180610150521.9714-1-max@max630.net>
 <20180610150521.9714-4-max@max630.net>
 <20180725121435.20519-1-szeder.dev@gmail.com>
 <20180725145100.GA1959@jessie.local>
 <CAM0VKjkSMqPy=N3_0HUNxpCFwusrD_XE5j7kMsE4L-79g2t_VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkSMqPy=N3_0HUNxpCFwusrD_XE5j7kMsE4L-79g2t_VA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfAI1UUMqQSY4qZ+JX4c1KWhaHfrsjSHVbO7wbhz2Teqwi9E5cQkYoluoN3i/DC1Opa9HGBUPRpEQSgJL0z48JD9iQz0RXAzqh/zFz5FgL0tx2pZOT7ga
 2YJzakAy/5QnFPddma8CO2B+oHvxb8pWjqTY/iUO33uo8diACoeyZdCU8juCAmPP3KynmrVyZ2KlYOAr7nIUZjg1IF9W5n8xz4AJi4jO92C3Xafg1WUmhq70
 B6oMlbCE8GJXux16jwxehWykjAZjlcIrrHT3A3cEHK5D2q72e61jVrDsPq4la3aK2vz9mKITMxB96BUwgrpik8K3A5Bg1UBS27kQT1OJ8fQLEZIcOMYTkbJV
 4BJvcu2V/mLpuEZmi1rNRLFPs6o+Qp5tZtYUeShCx+KzIfEk9gTEcuPFJu3LT0iIXUL94QeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 08:41:31PM +0200, SZEDER Gábor wrote:
> On Wed, Jul 25, 2018 at 4:51 PM Max Kirillov <max@max630.net> wrote:
>>> I just happened to stumble upon a failure because of 'fatal: the
>>> remote end hung up unexpectedly' in the test 'push plain'.
>>
>> Did it happen once or repeated? It is rather strange, that
>> one shoud not fail. Which OS it was?
> 
> Only once, so far.  It was one of my OSX build jobs on Travis CI, but
> I don't know what OSX version is used.
> 
> 'act.err' contained this (which will get line-wrapped, I'm afraid):
> 
> ++handler_type=receive
> ++shift
> ++env CONTENT_TYPE=application/x-git-receive-pack-request
> QUERY_STRING=/repo.git/git-receive-pack
> 'PATH_TRANSLATED=/Users/travis/t/trash
> dir.t5562/.git/git-receive-pack' GIT_HTTP_EXPORT_ALL=TRUE
> REQUEST_METHOD=POST
> /Users/travis/build/szeder/git-cooking-topics-for-travis-ci/t/t5562/invoke-with-content-length.pl
> push_body git http-backend
> <...128 zero bytes...>fatal: the remote end hung up unexpectedly
> 
> I couldn't reproduce it on my Linux box.

The only reason for this I could imagine is some perl
utility failure to feed the body to git http-backend.
I could not reproduce it either, but if such things happen
often again maybe should concider C helper instead. Though
I'm afraid I easily can make more mistakes in it than perl
interpreter authors.

I'll make the other changes, and sofar just hope it would
not happen again.
