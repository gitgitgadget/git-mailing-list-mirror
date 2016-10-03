Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E0C207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 12:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbcJCMl7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 08:41:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:56272 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751171AbcJCMl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 08:41:57 -0400
Received: (qmail 23545 invoked from network); 3 Oct 2016 12:41:54 -0000
Received: (qmail 12176 invoked from network); 3 Oct 2016 12:41:52 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <jnareb@gmail.com>; 3 Oct 2016 12:41:47 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475498507.1776.15.camel@sapo.pt>
Subject: Re: [PATCH v2 03/11] i18n: add--interactive: mark strings with
 interpolation for translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 03 Oct 2016 12:41:47 +0000
In-Reply-To: <b8c25ae3-143c-3e9b-0c7b-115a9b4756ae@gmail.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-4-git-send-email-vascomalmeida@sapo.pt>
         <b8c25ae3-143c-3e9b-0c7b-115a9b4756ae@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> W dniu 31.08.2016 o 14:31, Vasco Almeida pisze:
> > Use of sprintf following die or error_msg is necessary for
> > placeholder
> > substitution take place.
> 
> No, it is not.  Though I don't think that we have in out Git::I18N
> the support for Perl i18n placeholder substitution.

I will try to change the commit message to better reflect the reality.

> From gettext manual:
> https://www.gnu.org/software/gettext/manual/gettext.html#perl_002dfor
> mat
> 
>   15.3.16 Perl Format Strings
> 
>   There are two kinds format strings in Perl: those acceptable to the
> Perl
>   built-in function printf, labelled as ‘perl-format’, and those
> acceptable
>   to the libintl-perl function __x, labelled as ‘perl-brace-format’.
> 
>   Perl printf format strings are described in the sprintf section of
>   ‘man perlfunc’.
> 
>   Perl brace format strings are described in the
> Locale::TextDomain(3pm)
>   manual page of the CPAN package libintl-perl. In brief, Perl format
> uses
>   placeholders put between braces (‘{’ and ‘}’). The placeholder must
> have
>   the syntax of simple identifiers.
>  
> Git doesn't use Locale::TextDomain, from what I understand, to
> provide
> fallback in no-gettext case.  Also, Locale::TextDomain is not in
> core.

Yes that can be a reason not to use Locale::TextDomain. When Ævar
Arnfjörð Bjarmason added gettext support and i18n stuff, he chose no to
use TextDomain because it did more than he wanted it to do, and that
could introduce bugs and unnecessary work.

5e9637c ("i18n: add infrastructure for translating Git with gettext",
2011-11-18)

https://public-inbox.org/git/AANLkTilYD_NyIZMyj9dHtVk-ylVBfvyxpCC7982LW
nVd@mail.gmail.com/


> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index e11a33d..4e1e857 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -612,12 +612,12 @@ sub list_and_choose {
> >                       else {
> >                               $bottom = $top = find_unique($choice, @stuff);
> >                               if (!defined $bottom) {
> > -                                     error_msg "Huh ($choice)?\n";
> > +                                     error_msg sprintf(__("Huh (%s)?\n"), $choice);
> 
> So this would be, self explained without need of comment
> for translators:
> 
>   +                                     error_msg __x ("Huh ({choice})?\n"), choice => $choice);
> 
> 
> >                                       next TOPLOOP;
> >                               }
> 
> Though this is probably more work that you wanted to do.
> The __x might be defined like this (borrowing from Locale::TextDomain),
> which needs to be put into perl/Git/I18N.pm
> 
>   sub __ ($);
>   sub __expand ($%);
> 
>   # With interpolation.
>   sub __x ($@)
>   {
>         my ($msgid, %vars) = @_;
> 
>         return __expand (__($msgid), %vars);
>   }
>   
>   sub __expand ($%)
>   {
>         my ($translation, %args) = @_;
>     
>         my $re = join '|', map { quotemeta $_ } keys %args;
>         $translation =~ s/\{($re)\}/defined $args{$1} ? $args{$1} : "{$1}"/ge;
> 
>         return $translation;
>   }

I wonder if it is worth the trouble to add and use these functions,
when there is already a way that works and for me looks simpler. One
reason, if valid, would be that translators already translate strings
with %d and %s from C source which is where the majority of the English
text comes from. Thus it would make little difference for them.
If we use in perl string like in C there is a chance that there will be
a match of some string and would lead to just one msgid instead of two
in the git.pot template for translation. Actually this happens for the
string with "Huh (%s)?" in clean.c.

Unfortunately, I do not know if I would add these changes because I
know little about perl and hence I am not comfortable to do so.

Maybe if you see it is indeed worth adding these to Git I18N.pm, you
could send a follow-up patch or a replacement for this one.
