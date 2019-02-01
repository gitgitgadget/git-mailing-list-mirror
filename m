Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F821F453
	for <e@80x24.org>; Fri,  1 Feb 2019 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBAJGc (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:06:32 -0500
Received: from mx-out2.startmail.com ([145.131.90.155]:44343 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBAJGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:06:31 -0500
Message-ID: <747726ae27ff52509f831c9615f2b102.startmail@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1549011989;
        bh=osnHiBAuA8dNaen9n4cypaC8v0rHnOeGkBr+U3bQl9k=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=HNrF8OK36BRNdCGjP7IYFNEYX3aWwVRllX2zfowBUeX1SblEycBQowAN1ERsSq/jb
         ivh2ZjXRRABOhOCY+ApKRGoOLzzIkR0sqMz58A+QlOtCRJQVIhPxQiM7XRKekGQFdg
         KXDwXSrPgkT0AusJs5Ij1/3RvKQA5HXmZoscUvAuSC1fW1SqqxMK0N9M/HN/Ewey6L
         yV37z27+Zx707/LYrBxImyw/b/nrIR3Mfikz+2MzcNlIBNMxvLrBgAVImJJgAEXxVk
         V8pE8DJ7ecHLknAfG+MdaXV/SaQLze8K1DUfoflFVZLhE4Yvn/hGSzOsSuc+a16OoX
         3iPUYTjBPk0qQ==
In-Reply-To: <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
    <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
    <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
    <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
    <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
    <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
    <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
    <nycvar.QRO.7.76.6.1902010835210.41@tvgsbejvaqbjf.bet>
Date:   Fri, 1 Feb 2019 10:06:29 +0100
Subject: Re: Broken interactive rebase text after some UTF-8 characters
From:   "Michal Nowak" <mnowak@startmail.com>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood@talktalk.net>,
        "Alban Gruin" <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        "Michal Nowak" <mnowak@startmail.com>, git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

On Friday, February 1, 2019 at 8:38 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Thu, 31 Jan 2019, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>> >> Are we misusing C formats?
>> >
>> > The C standard and POSIX both say that the * refers to the maximum
>> > number of bytes to print but it looks like it is being treated as the
>> > maximum number of characters on OpenIndiana.
>> >
>> > Johannes - Perhaps we should change it to use fwrite() unless
>> printf()
>> > gets fixed and we're sure no other operating systems are affected?
>>
>> Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
>> many other places in our codebase, if you can.
> 
> Yes, this would be painful in particular in cases like
> 
> 	master:advice.c:101:           fprintf(stderr, _("%shint: %.*s%s\n"),
> 
> where we want to write more than just a variable-length buffer.
> 
> I am curious: is libintl (gettext) used on OpenIndiana? I ask because
> AFAIR fprintf() is overridden in that case, and the bug might be a lot
> easier to fix if it is in libintl rather than in libc.

here you can see the full output of the OpenIndiana git build: https://hipster.openindiana.org/logs/oi-userland/latest/git.publish.log.

From what I see there, libintl was found.

If you believe this is illumos libc bug, it would be cool if someone created an simple testcase, which I can forward to the illumos developers.

Thanks,
Michal

> 
> Of course, it might *still* be a bug in libc by virtue of handing '%.*s'
> through to libc's implementation.
> 
> Alban, can you test this with NO_GETTEXT?
> 
> Thanks,
> Johannes
