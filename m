Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68998207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941579AbcIZSP2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:15:28 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53830 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941577AbcIZSP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:15:27 -0400
Received: (qmail 21100 invoked from network); 26 Sep 2016 18:15:24 -0000
Received: (qmail 11923 invoked from network); 26 Sep 2016 18:15:24 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 26 Sep 2016 18:15:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1474913721.1035.9.camel@sapo.pt>
Subject: Re: [PATCH v2 04/11] i18n: add--interactive: mark plural strings
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 26 Sep 2016 18:15:21 +0000
In-Reply-To: <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Qua, 31-08-2016 às 12:31 +0000, Vasco Almeida escreveu:
> Mark plural strings for translation.  Unfold each action case in one
> entire sentence.
> 
> Pass new keyword for xgettext to extract.
> 
> Update test to include new subrotine Q__() for plural strings handling.
> 
> > Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  Makefile                  |  3 ++-
>  git-add--interactive.perl | 24 ++++++++++++++++--------
>  perl/Git/I18N.pm          |  4 +++-
>  t/t0202/test.pl           | 11 ++++++++++-
>  4 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 4e1e857..08badfa 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -666,12 +666,18 @@ sub status_cmd {
>  sub say_n_paths {
> >  	my $did = shift @_;
> >  	my $cnt = scalar @_;
> > -	print "$did ";
> > -	if (1 < $cnt) {
> > -		print "$cnt paths\n";
> > -	}
> > -	else {
> > -		print "one path\n";
> > +	if ($did eq 'added') {
> > +		printf(Q__("added one path\n", "added %d paths\n",
> > +			   $cnt), $cnt);
> > +	} elsif ($did eq 'updated') {
> > +		printf(Q__("updated one path\n", "updated %d paths\n",
> > +			   $cnt), $cnt);
> > +	} elsif ($did eq 'reversed') {
> > +		printf(Q__("reversed one path\n", "reversed %d paths\n",

This should be 'reverted' not 'reversed'.

> > +			   $cnt), $cnt);
> > +	} else {
> > +		printf(Q__("touched one path\n", "touched %d paths\n",
> > +			   $cnt), $cnt);
> >  	}
>  }

When $cnt is 1 I get the following warning:
Redundant argument in printf at /home/vasco/dev/local/libexec/git-core/git-add--interactive line 680.

The singular form does not have a %d to consume $cnt argument to
printf(). Either we find a way to suppress that warning or we change
the singular form to contain %d.

> @@ -1508,8 +1514,10 @@ sub patch_update_file {
> ...
> > -					print colored $header_color, "Split into ",
> > -					scalar(@split), " hunks.\n";
> > +					print colored $header_color, sprintf(
> > +						Q__("Split into %d hunk.\n",
> > +						    "Split into %d hunks.\n",
> > +						    scalar(@split)), scalar(@split));
Like we do with this.
> > 
> > 
