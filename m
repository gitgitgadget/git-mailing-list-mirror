Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A471F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbeATPfd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Jan 2018 10:35:33 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47984 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeATPfc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:35:32 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0KFZTU9030638
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 20 Jan 2018 10:35:30 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        <git@vger.kernel.org>
References: <20180119173406.13324-1-randall.s.becker@rogers.com> <20180119173406.13324-4-randall.s.becker@rogers.com> <1153e1c0-c7d5-3e0d-ce41-ffb1230164f7@web.de> <019601d391f4$dd367de0$97a379a0$@nexbridge.com> <9b7bf754-90bd-c25c-f5ae-124dcd97d281@web.de>
In-Reply-To: <9b7bf754-90bd-c25c-f5ae-124dcd97d281@web.de>
Subject: RE: [PATCH v2 2/6] Add tar extract install options override in installation processing.
Date:   Sat, 20 Jan 2018 10:35:26 -0500
Message-ID: <019901d39204$4ed19980$ec74cc80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH5ceUaUBDLnBuBgyHh9+OiHAZcgwJI/tV9AkeXrP0DG2hYFwHm6YW2ouSNUnA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 20, 2018 9:25 AM, René Scharfe wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
> Subject: Re: [PATCH v2 2/6] Add tar extract install options override in
> installation processing.
> 
> Am 20.01.2018 um 14:44 schrieb Randall S. Becker:
> > On January 20, 2018 7:31 AM, René Scharfe wrote:
> >> Am 19.01.2018 um 18:34 schrieb randall.s.becker@rogers.com:
> >>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >>>
> >>> * Makefile: Add TAR_EXTRACT_OPTIONS to allow platform options to be
> >>> specified if needed. The default is xof.
> >>>
> >>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com> ---
> >>> Makefile | 6 +++++- 1 file changed, 5 insertions(+), 1
> >>> deletion(-)
> >>>
> >>> diff --git a/Makefile b/Makefile index 1a9b23b67..040e9eacd
> >>> 100644 --- a/Makefile +++ b/Makefile @@ -429,6 +429,9 @@ all:: #
> >>> running the test scripts (e.g., bash has better support for "set -x"
> >>> # tracing). # +# Define TAR_EXTRACT_OPTIONS if you want to change
> >>> the default +behaviour # from xvf to something else during
> >>> installation.
> >>
> >> "xof" instead of "xvf"?
> >
> > When I look at the parent commit, it says xof, so I wanted to preserve
> > existing behaviour by default. Our install process wants to see the
> > actual set of files, so we wanted to use xvof but that hardly seemed
> > of general interest. I was hoping an option to control it would be
> > agreeable.
> 
> Preserving the default is good. I meant that the default is "xof", but the
> added line implies it was "xvf" instead.
> 
> Seeing your actual use case confirms that my suggestion below would work
> for you.
> 
> >
> >>> +# # When cross-compiling, define HOST_CPU as the canonical name
> >>> of the
> >> CPU on
> >>> # which the built Git will run (for instance "x86_64").
> >>>
> >>> @@ -452,6 +455,7 @@ LDFLAGS = ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> >>> ALL_LDFLAGS = $(LDFLAGS) STRIP ?= strip +TAR_EXTRACT_OPTIONS = xof
> >>>
> >>> # Create as necessary, replace existing, make ranlib unneeded.
> >>> ARFLAGS = rcs @@ -2569,7 +2573,7 @@ install: all ifndef NO_GETTEXT
> >>> $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
> >>> (cd po/build/locale && $(TAR) cf - .) | \ -	(cd
> >>> '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -) + (cd
> >>> '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR)
> >>> +$(TAR_EXTRACT_OPTIONS) -)
> >>
> >> Hmm.  TAR_EXTRACT_OPTIONS always needs to have f (or -f, or --file)
> >> at the end to go together with the following dash, meaning to extract
> >> from stdin. And x (or -x, or --extract) is probably needed in all
> >> cases as well.  So wouldn't it make more sense to only put the o (or
> >> -o, or --no-same-owner) into TAR_EXTRACT_OPTIONS and enforce x and
> f?
> >
> > This is a good suggestion, and I'd love to do that, if I could
> > guarantee a modern tar, which I can't. The platform comes with a
> > really old-school tar from some old (seemingly BSD4.3) epoch that only
> > takes one option set. There is a more modern tar that can be
> > optionally installed if the sysadmin decides to that takes a slightly
> > more modern set, which could support your request, and my team also
> > has a gnu port that is very modern. I can't control what customers are
> > choosing to have installed, unfortunately. Your point is well made and
> > I am completely on board with it, but it introduces a configuration
> > requirement.
> 
> Long options would be nice to nice to have, but are not my main point; I
> included them mainly to spare readers from firing up "man tar" to look up
> the meaning of the short ones.
> 
> I just meant to say that something like this here would make more sense
> because you always need x and f- anyway:
> 
> 	TAR_EXTRACT_OPTIONS = o
> 
> 	... ${TAR} x${TAR_EXTRACT_OPTIONS}f -
> 
> > As with the broadening setbuf (patch 2/6) change, I would like to
> > consider this for the future, having a slightly different more complex
> > idea. I could introduce something like this:
> >
> > 1. HAS_ANCIENT_TAR=UnfortunatelyYes in config.mak.uname that disables
> > this capability all together 2. HAS_ANCIENT_TAR=AreYouKiddingMe
> > (joke) then set up TAR_EXTRACT_ADDITIONAL_OPTIONS above and beyond
> the
> > default, so --file, --no-same-owner would always be in effect for that
> > operation.
> >
> > The micro-project would also, logically, need to apply to other tar
> > occurrences throughout the code and potentially need a test case
> > written for it (not entirely sure what that would test, yet).
> > Is that a reasonable approach?
> 
> As long as old-school dash-less flags suffice for our purposes (including
> yours) we can just keep using that style everywhere and avoid adding more
> settings.  It would be a different matter if we needed features that have no
> short flag, or are only offered by certain tar implementations.

Points taken. I will reissue this particular patch shortly.

