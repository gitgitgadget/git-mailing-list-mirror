Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851F2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeHFTMr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 6 Aug 2018 15:12:47 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54847 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFTMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:12:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w76H2hma053694
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Aug 2018 13:02:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Duy Nguyen'" <pclouds@gmail.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Stefan Beller'" <sbeller@google.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>,
        "'Han-Wen Nienhuys'" <hanwen@google.com>
References: <20180804020009.224582-1-sbeller@google.com>        <20180804020255.225573-1-sbeller@google.com>        <20180804060928.GB55869@aiede.svl.corp.google.com>        <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>        <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com> <87zhxzsb2p.fsf@evledraar.gmail.com>
In-Reply-To: <87zhxzsb2p.fsf@evledraar.gmail.com>
Subject: RE: [PATCH] Makefile: enable DEVELOPER by default
Date:   Mon, 6 Aug 2018 13:02:37 -0400
Message-ID: <001001d42da7$4a9e6570$dfdb3050$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHcHQgNlToVxohtCSKuj/FaLNrO4gKynkmJAzrMNb8BurMUxgJD1Su/Afe4naakQ/UMEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 6, 2018 12:40 PM, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Aug 04 2018, Junio C Hamano wrote:
> 
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> >> On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com>
> wrote:
> >>> My main concern is not about them but about other people building
> >>> from source in order to run (instead of to develop) Git, and by
> >>> extension, the people they go to for help when it doesn't work.  I
> >>> have lots of bitter experience of -Werror being a support headache
> >>> and leading to bad workarounds when someone upgrades their compiler
> >>> and the build starts failing due to a new warning it has introduced.
> >>
> >> Even old compilers can also throw some silly, false positive warnings
> >> (which now turn into errors) because they are not as smart as new
> >> ones.
> >
> > I agree with both of the above.  I do not think the pros-and-cons are
> > in favor of forcing the developer bit to everybody, even though I am
> > sympathetic to the desire to see people throw fewer bad changes that
> > waste review bandwidth by not compiling or passing its own tests at
> > us.
> 
> I agree.
> 
> Responding to the thread in general, perhaps people would like this more if
> we turned DEVELOPER=1 DEVOPTS=no-error on by default?
> 
> That's basically why I added it in 99f763baf5 ("Makefile: add a DEVOPTS to
> suppress -Werror under DEVELOPER", 2018-04-14), because I wanted the
> abilty to have verbose informative output without the build dying on some
> older systems / compilers.
> 
> It's fine and understandable if you're someone who's just building a package
> on some older system if you get a bunch of compiler warnings, but more
> annoying if you have to dig into how to disable a default -Werror.

Any idea when this is going to be in an official release, and exactly what the settings will be for "Not Developer". I assume DEVELOPER=0 and DEVOPTS=error, which is the current behaviour, correct? I am the platform maintainer for HPE NonStop and need to make sure I'm not packaging DEV builds to anyone, since I'm the only one doing this for the platform. It's another hoop, but hopefully not a bad one. The question is the best place to set this, assuming we are using Jenkins for our builds, and I'd rather keep the existing config.mak.uname the same, since at least it seems stable. We currently just run "make" for our build. So make arguments? And is making the change now non-destructive in preparation so that I don't forget when the time comes?

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



