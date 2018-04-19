Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFFC1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDSMfD convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Apr 2018 08:35:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:46286 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDSMfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:35:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CA3441B2C32;
        Thu, 19 Apr 2018 08:35:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DMoxJ5zuJimy; Thu, 19 Apr 2018 08:35:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E1B851B2C21;
        Thu, 19 Apr 2018 08:35:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TKVbCqRWn-yB; Thu, 19 Apr 2018 08:35:00 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CF19F1B2C18;
        Thu, 19 Apr 2018 08:35:00 -0400 (EDT)
Date:   Thu, 19 Apr 2018 08:35:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Message-ID: <646938104.13100.1524141300699.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180419121024.GD5556@bombadil.infradead.org>
References: <20180418140503.GD27475@bombadil.infradead.org> <87tvs8e174.fsf@evledraar.gmail.com> <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com> <20180419121024.GD5556@bombadil.infradead.org>
Subject: Re: [PATCH] git-send-email: Cc more people
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: git-send-email: Cc more people
Thread-Index: Mtgjy9/6HIVJPy/zqhptA9vDcPr5EQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- On Apr 19, 2018, at 8:10 AM, Matthew Wilcox willy@infradead.org wrote:

> On Thu, Apr 19, 2018 at 06:21:42AM +0900, Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>> 
>> > But IMO this patch is really lacking a few things before being ready:
>> >
>> > 1. You have no tests for this. See t/t9001-send-email.sh for examples,
>> > ...
>> > 2. Just a few lines down from your quoted hunk we have this:
>> > ... code about $supress_cc{<token>} ...
>> >    Your change should at least describe why those aren't being updated,
>> >    but probably we should add some other command-line option for
>> >    ignoring these wildcards, e.g. --[no-]wildcard-by-cc=reviewed
>> >    --[no-]wildcard-by-cc=seen etc, and we can make --[no-]signed-off-by
>> >    a historical alias for --[no-]wildcard-by-cc=signed-off.
>> > 3. Ditto all the documentation in "man git-send-email" about
>> > ...
>> 
>> Thanks, I agree that 2. (the lack of suppression) is a showstopper.
> 
> I agree with that (and the lack of tests, obviously)
> 
>> I'd further say that these new CC-sources should be disabled by
>> default and made opt-in to avoid surprising existing users.
> 
> But I disagree with this.  The current behaviour is surprising to
> existing users, to the point where people are writing their own scripts
> to replace git send-email (which seems crazy to me).

We could perhaps go with a whitelist approach. The four
main match I would be tempted to add are: Acked-by, Reported-by,
Reviewed-by, and Tested-by.

My workflow is to initially CC a bunch of relevant maintainers
when sending out a patch, and as the Acked, Reviewed and Tested
by tags come it, I replace those CC with the relevant tag.
I never expected them to stop being CC'd when switching between
those categories.

Thanks,

Mathieu

> 
>> One thing we also need to be very careful about is that some of the
>> fields may not even have an e-mail address.  We can expect that
>> S-o-b and Cc would be of form "human readable name <email@addre.ss>"
>> by their nature, but it is perfectly fine to write only human
>> readable name without address on random lines like "suggeted-by" and
>> "helped-by".  There needs a way for the end-user to avoid using data
>> found on such lines as if they are valid e-mail addresses.
> 
> I also agree with this.  I'll add some test-cases and make sure we only
> add these if they're valid email addresses.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
