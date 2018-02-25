Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7703D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBYTFx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 25 Feb 2018 14:05:53 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19695 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeBYTFw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:05:52 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w1PJ5nRA035118
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Feb 2018 14:05:49 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Matthieu Moy'" <git@matthieu-moy.fr>,
        "'Petr Baudis'" <pasky@ucw.cz>,
        "'Benoit Bourbie'" <bbourbie@slb.com>,
        "'Jeff King'" <peff@peff.net>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jari Aalto'" <jari.aalto@cante.net>,
        "'Giuseppe Bilotta'" <giuseppe.bilotta@gmail.com>,
        "'Marcus Griep'" <marcus@griep.us>
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-4-avarab@gmail.com> <20180214225754.GC136185@aiede.svl.corp.google.com> <87sh9oew4d.fsf@evledraar.gmail.com>
In-Reply-To: <87sh9oew4d.fsf@evledraar.gmail.com>
Subject: RE: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Date:   Sun, 25 Feb 2018 14:05:44 -0500
Message-ID: <001201d3ae6b$a67ba0d0$f372e270$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE8zbkPVSCpOCnjAVBPxLmSpSGjUwGQhiMYAWpzOXYCpz8YmaS2KP0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 25, 2018 1:57 PM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Feb 14 2018, Jonathan Nieder jotted:
> 
> > Ævar Arnfjörð Bjarmason wrote:
> >
> >> Change the two wrappers to load from CPAN (local OS) or our own copy
> >> to do so via the same codepath.
> >
> > nit: I think with s/to load/that load/ this will be easier to read.
> >
> >> I added the Error.pm wrapper in 20d2a30f8f ("Makefile: replace
> >> perl/Makefile.PL with simple make rules", 2017-12-10), and shortly
> >> afterwards Matthieu Moy added a wrapper for Mail::Address in
> >> bd869f67b9 ("send-email: add and use a local copy of Mail::Address",
> >> 2018-01-05).
> >>
> >> His was simpler since Mail::Address doesn't have an "import" method,
> >> but didn't do the same sanity checking, e.g. a missing FromCPAN
> >> directory (which OS packages are likely not to have) wouldn't be
> >> explicitly warned about.
> >
> > I'm having trouble parsing this.  Mail::Address didn't do the same
> > sanity checking or his didn't?
> >
> > The comma before e.g. should be a period or semicolon, since it's
> > starting a new independent clause.
> >
> >> Now both use a modification of the previously Error.pm-specific
> >> codepath, which has been amended to take the module to load as
> >> parameter, as well as whether or not that module has an import method.
> >
> > Does "now" mean before this patch or after this patch?  Usually commit
> > messages describe the status quo without the patch in the present
> > tense and the change the patch will make in the imperative.
> > So this could say:
> >
> > 	Update both to use a common implementation based on the
> previous
> > 	Error.pm loader.
> 
> All good feeedback, thanks. Incorporated into v2 which I'm about to submit.
> 
> > [...]
> >> +++ b/perl/Git/LoadCPAN.pm
> >> @@ -0,0 +1,74 @@
> > [...]
> >> +The Perl code in Git depends on some modules from the CPAN, but we
> >> +don't want to make those a hard requirement for anyone building from
> >> +source.
> >
> > not about this patch: have we considered making it a hard requirement?
> > Both Mail::Address and Error.pm are pretty widely available, and I
> > wonder if we could make the instructions in the INSTALL file say that
> > they are required dependencies to simplify things.
> 
> I can't remember when, but at some point this was discussed on list, and the
> consensus was that us using perl should be kept as a non-invasive
> implementation detail that would be as small of a pain as possible for users.

That would include the platform I'm maintaining, where perl is currently pretty handcuffed and blindfolded (including completion code misinterprets). CPAN isn't currently an option, but might be soon.

> It's easy for distros to package these modules, but for users building from
> source who know nothing about perl it can be a pain.

Know perl I do. Use it not, can I. ;-)

> I also think it's very useful to avoid the side-discussion about not using some
> useful CPAN module in the future just because it's not widely used, but
> would be perfect for some use-case of ours.
> 
> > I admit part of my bias here is coming from the distro world, where we
> > have to do extra work to get rid of the FromCPAN embedded copies and
> > would be happier not to have to.
> 
> I think there's a very good argument to be made for inverting the
> NO_PERL_CPAN_FALLBACKS logic, but my soon to be submitted v2 keeps it
> off by default.

Cool, thanks.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



