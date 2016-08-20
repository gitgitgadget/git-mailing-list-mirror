Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8593A1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 18:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbcHTSjY convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Aug 2016 14:39:24 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:4730 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbcHTSjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 14:39:23 -0400
X-Greylist: delayed 9431 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Aug 2016 14:39:23 EDT
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 2E6C8B004D9;
        Sat, 20 Aug 2016 18:38:11 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
Date:   Sat, 20 Aug 2016 20:38:40 +0200
Message-ID: <4016813.pOBvC7ZxlR@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.23.0; x86_64; ; )
In-Reply-To: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com> <9262712.D6TC1VHfMN@cayenne> <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On samedi 20 août 2016 11:03:00 CEST Junio C Hamano wrote:
> Jean-Noël AVILA <jn.avila@free.fr> writes:
> > 1.  In config.c, the changes to the function die_bad_number tried to
> > flatten the translated strings (no message building logic). I think it
> > went too far, and the reason of the failure can be factorized so that we
> > don't have to retranslate each time. I might be wrong on this one, but I
> > have no example of language where we would need differentiated error
> > reasons.
> 
> I do not have a strong opinion on this one.  I think it is an
> attempt to avoid language-lego.

No problem with the changes for blob, files, command line. It's just about 
dividing by two the number of strings to translate by factorizing "out of 
range" and "invalid unit", which are invariable anyway.  		

> 
> > 2.  in sequencer.c, there is a mistake in the original string to translate
> > "Cannot revert during a another revert"
> 
> This should be corrected. Thanks for spotting.

I also spotted a missing capitals. Will propose a patch.

> 
> > 3. git-rebase--interactive, in this_nth_commit_message and
> > skip_nth_commit_message are not localizable,
> 
> As the "TRANSLATORS" comment alludes to, "This is the Nth thing" can
> be rephrased to "This is the thing N" or "This is the thing #N"
> easily, and if that form without ordinal is acceptable for many
> languages, we should say that it is also OK in C-locale without
> translation.  So I agree that the recent change was pointless (even
> though the result may be localizable).
> 
> In an ideal world, I would imagine that this would be done by using
> Q_("This is the first thing", "This is the thing #%d", nth) aka
> ngettext, but
> 
>     (1) I haven't seen ngettext used from shell scripts; and
> 

There's a use_ngettext macro

>     (2) I do not think po files are set up to express "for this
>         message, this language has 4 variants and here are the local
>         rules to decide which one to use depending on the number,
>         but the rules apply only to this message".  The Plural-Forms
>         rule [*1*] seems to be global to a .po file, unfortunately.
> 


> so I do not think we cannot do it with ngettext().
> 

Let's cut it like this : first ten are literally translated, the following ones 
fall back to a general rule. All languages are treated equally. With more than 
10 squashed commit, you no longer really care if the numbering is pedantically 
correct.

> [Reference]
> 
> *1*
> https://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/Plural-> forms.html


