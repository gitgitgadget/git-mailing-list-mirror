Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7340720A36
	for <e@80x24.org>; Tue,  7 Nov 2017 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757674AbdKGXZK (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 18:25:10 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:54030 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbdKGXZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 18:25:06 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id CDEtejrJ2bjdZCDEue03KG; Tue, 07 Nov 2017 23:25:04 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=WsYSNgmE4I-lTSgAepIA:9
 a=wPNLvfGTeEIA:10
Message-ID: <83D263E58ABD46188756D41FE311E469@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>,
        "Ann T Ropea" <bedhanger@gmx.de>
References: <20171105162730.31405-1-bedhanger@gmx.de> <20171107025321.31028-1-bedhanger@gmx.de>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
Date:   Tue, 7 Nov 2017 23:25:02 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171107-0, 07/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfJbHpQ13gN6leUOLRWV0Lm3ANZP/84iOxqU6JxkYPPnnU98/I7kD7rrJTQL4h3NUMrimh/C8l0VXVoUcgdAZBzQwkY9wjYpSN9N1bHFTBAij1j9GDxoT
 KZE7Agw/kr8HIikCVvPhTZ3NTH06FnXVu5elIG2h9xrixedWXflxYiT56Y4QryM5xoTrJxGbFYK8RdmKC4rF/YwDKjTNMitcONARLUIVX1CopNe4c3SOthdy
 KAEYKuDCpOnXieqp6J7RoP1i/no+eCFstbGjNShO/8D5YdyTkfn8KTlZ66+/d6w2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ann T Ropea" <bedhanger@gmx.de>
> Thanks for all the feedback provided!
>
> I'd like to summarise what consensus we have reached so far and
> then propose a way forward:
>
>   * we'll use the term "ellipsis (pl. ellipses)" for what's
>     been referred to as "3dots", "n-dots", "many dots" and so
>     forth

Using a consistent  term for the *display* of shortened oid's is good.

>
>   * we would like to use ellipses when attached to SHA-1
>     values only for the purpose of specifying a symmetric
>     difference (as per gitrevisions(7))

The symetric difference (three-dots) is a specific Git *cli* notation that 
is distinct from the use of ellipsis for displaying oid's

>
>   * the usage of ellipses as a "here we truncated something
>     longer" is a relic which should be phased out.

I think that is true.

>
> To get there, preventing describe_detached_head from appending
> an ellipsis to the SHA-1 values it prints is one important step.
>
> This change does not cause any test to fall over.

But...
>
> The other important step is dealing with the "git diff --raw"
> output which features ellipses in the relic-fashion no longer
> desired.
>
> It would appear that simplifying diff.c's diff_aligned_abbrev
> routine to something like:
>
> /* Do we want all 40 hex characters?
> */
> if (len == GIT_SHA1_HEXSZ)
> return oid_to_hex(oid);
>
> /* An abbreviated value is fine.
> */
> return diff_abbrev_oid(oid, len);
>
> does do the trick.
>
> This change causes quite a few tests to fall over; however, they
> all have truncated-something-longer-ellipses in their
> raw-diff-output expected sections, and removing the ellipses
> from there makes the tests pass again, :-)

The number of failures you report in the test suit suggests that someone 
somewhere will be expecting that notation, and that we may need a 
deprecation period, perhaps with an 'ellipsis' config variable whose default 
value can later be flipped, though that leaves a config value needing 
support forever!

Junio should be able to better advise on his preferred approach.

>
> If we can agree that this is a way forward, i'll create & send
> v2 of the patch series to the mailing list (it'll include the
> fixed tests) and we'll see where we go from there.

--
Philip 

