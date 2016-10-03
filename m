Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B448207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 12:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbcJCMqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 08:46:38 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33635 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbcJCMqg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 08:46:36 -0400
Received: (qmail 11735 invoked from network); 3 Oct 2016 12:46:34 -0000
Received: (qmail 32226 invoked from network); 3 Oct 2016 12:46:34 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <jnareb@gmail.com>; 3 Oct 2016 12:46:28 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475498788.1776.20.camel@sapo.pt>
Subject: Re: [PATCH v2 04/11] i18n: add--interactive: mark plural strings
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 03 Oct 2016 12:46:28 +0000
In-Reply-To: <a46dc5cb-85d9-88f2-865c-734204832101@gmail.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
         <1474913721.1035.9.camel@sapo.pt>
         <a46dc5cb-85d9-88f2-865c-734204832101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sáb, 01-10-2016 às 18:49 +0200, Jakub Narębski escreveu:
> W dniu 26.09.2016 o 20:15, Vasco Almeida pisze:
> > 
> > A Qua, 31-08-2016 às 12:31 +0000, Vasco Almeida escreveu:
> > > 
> > > 
> > > Mark plural strings for translation.  Unfold each action case in
> > > one
> > > entire sentence.
> > > 
> > > Pass new keyword for xgettext to extract.
> > > 
> > > Update test to include new subrotine Q__() for plural strings
> > > handling.
> 
> Why use Q__() as the name of the subroutine? [looks further]. Oh, I
> see
> that you are following the example of C shortcut functions (_, Q_ and
> N_).
> 
> But this is Perl, not C.  The standard shortcut functions are those
> defined in Locale::TextDomain, even if we can't use this module
> directly.
> Those that deal with plural strings handling are __n and __nx / __xn.
> 
> The Perl equivalent of Q_ shorthand function in C, C++, etc. is __n.
> There is also a function __nx for combining handling plural strings
> together with variable interpolation.

I was trying to follow the same style of C. I will change the name Q__
to __x for the sake of conformance.


> > > diff --git a/git-add--interactive.perl b/git-add
> > > --interactive.perl
> > > index 4e1e857..08badfa 100755
> > > --- a/git-add--interactive.perl
> > > +++ b/git-add--interactive.perl
> > > @@ -666,12 +666,18 @@ sub status_cmd {
> > >  sub say_n_paths {
> > >  	my $did = shift @_;
> > >  	my $cnt = scalar @_;
> > > -	print "$did ";
> > > -	if (1 < $cnt) {
> > > -		print "$cnt paths\n";
> > > -	}
> > > -	else {
> > > -		print "one path\n";
> > > +	if ($did eq 'added') {
> > > +		printf(Q__("added one path\n", "added %d
> > > paths\n",
> > > +			   $cnt), $cnt);
> > > +	} elsif ($did eq 'updated') {
> > > +		printf(Q__("updated one path\n", "updated %d
> > > paths\n",
> > > +			   $cnt), $cnt);
> > > +	} elsif ($did eq 'reverted') {
> > > +		printf(Q__("reverted one path\n", "reverted %d
> > > paths\n",
> > > +			   $cnt), $cnt);
> > > +	} else {
> > > +		printf(Q__("touched one path\n", "touched %d
> > > paths\n",
> > > +			   $cnt), $cnt);
> > >  	}
> > >  }
> 
> One one hand side, it is recommended to avoid lego-like construction
> of sentences.
> 
>   Translatable strings should be entire sentences. It is often not
>   possible to translate single verbs or adjectives in a substitutable
>   way.
> 
> I think however that the action part ($did in original non-i18n code)
> is whole part in any language, so something like the following would
> be enough:
> 
>   	# this hash is as much for validation, as for translation
>    	my %actions = map { $_ => 1 } (N__"added", N__"updated",
> N__"reverted");
>    	if (exists $actions{$did}) {
>    		print __nx("{did} one path\n", "{did} {count}
> paths\n", $cnt,
>    			   did => __($did), count => $cnt);
>   	} else {
>    		print __nx("touched one path\n", "touched {count}
> paths\n", $cnt,
>    			   count => $cnt);
>    	}
> 
> Please correct me if I am wrong, and you know language where
> "added %d paths", "updated %d paths", "reverted %d paths" etc. must
> have
> different word order.

We may never know. :-) I prefer not to make assumptions about other
languages and I think there is not much to gain from using this
approach instead of marking entire sentence as the patch does. I mean
the code verbosity is almost the same but maybe it gets harder to
translate.
Other thing, we want to avoid marking for translation single words
(when that is avoidable) because those could appear on other sites that
need a different translation according to the context. For example:
'commit' could be a verb or a noun from the context.

> > When $cnt is 1 I get the following warning:
> > Redundant argument in printf at .../libexec/git-core/git-add
> > --interactive line 680.
> 
> I wonder what is the case of C code - is similar warning here, or is
> gettext smarter in that case...

I do not know but I know there is a few cases like this in C code.

> > The singular form does not have a %d to consume $cnt argument to
> > printf(). Either we find a way to suppress that warning or we
> > change
> > the singular form to contain %d.
> 
> Anyway, with __nx there should be no such problem.
> 
> > 
> > 
> > > 
> > > @@ -1508,8 +1514,10 @@ sub patch_update_file {
> > > ...
> > > -					print colored
> > > $header_color, "Split into ",
> > > -					scalar(@split), "
> > > hunks.\n";
> > > +					print colored
> > > $header_color, sprintf(
> > > +						Q__("Split into
> > > %d hunk.\n",
> > > +						    "Split into
> > > %d hunks.\n",
> > > +						    scalar(@spli
> > > t)), scalar(@split));
> > 
> > Like we do with this.
> 
> Note that it is a bit of change in behavior: previously Git would
> say "Split into 0 hunks.\n".
> 
> 
> Though this is probably more work that you wanted to do.  The __n
> would
> take place of Q__, while the __nx function might be defined like this
> (borrowing from Locale::TextDomain), which needs to be put into
> Git::I18N:
> 
> # Plural with interpolation.
> sub __nx ($$$@)
> {
>     my ($msgid, $msgid_plural, $count, %args) = @_;
>     
>     return __expand ((__n $msgid, $msgid_plural, $count),
> 		     %args);
> }

I thank you very much for your code suggestion and review but I am not
comfortable enough with perl to fiddle much more and add this to the
i18n work of the perl scripts, as I said before.

So if you find this a good think do add, please send patches as a
follow-up or to replace this patch.
