X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Problem compiling: that perl thing again
Date: Fri, 8 Dec 2006 13:26:30 -0800 (PST)
Message-ID: <760708.55141.qm@web31801.mail.mud.yahoo.com>
References: <7vvekmgljm.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 8 Dec 2006 21:26:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=KTfu+oDSV+j8AQiTFbLhAbKyY8LLjPROLvnvjxyhq7unt70IsXN3QcBu1JK+iD76KiIzD/Bxr+Js27tyY+wCfD3vk9bqWZHSgh2DynM2w6n00by7Q2OyAaQbPmZS1AAzBOfemOVG1M5s+QxfZEV/29vksQjmE3cb4M4e10Escfg=;
X-YMail-OSG: _bbeQHMVM1mzB7GSGoKeLBYS6.vXg8NCYnT1Snbv3HNC1hor8Xw8Lv2k6.6HkX8bQXFcn1rCsGMyBCgryvcAVGICPVzfjMNwJYIJhR5CtuHcNnU21O85zgR.qqw41OCSuUAfKNsovZ4-
In-Reply-To: <7vvekmgljm.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33746>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnEp-0007id-Bt for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947253AbWLHV0c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947257AbWLHV0c
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:26:32 -0500
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:29154 "HELO
 web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1947253AbWLHV0b (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 16:26:31 -0500
Received: (qmail 64768 invoked by uid 60001); 8 Dec 2006 21:26:30 -0000
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Fri,
 08 Dec 2006 13:26:30 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Over the last 2 months each time I pull, check out next and compile,
> > I'm seeing _some_ kind of problem with compiling the perl section
> > of git.  Sometimes git-reset --hard, or a fresh checkout, or git-clean
> > resolve the situation.  But not this time.
> > ...
> > So, where is "perl.mak"?
> 
> This particular breakage cannot be "last two months", but there
> was a recent breakage by commit f848718a last week on the 'master'
> branch.

Not this particular one, but others in that area (perl make).

> Now, I am CLUELESS about what MakeMaker does, but would this
> help?
> 
> --- 
> diff --git a/perl/Makefile b/perl/Makefile
> index bd483b0..099beda 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -29,7 +29,7 @@ $(makfile): ../GIT-CFLAGS Makefile
>  	echo '	echo $(instdir_SQ)' >> $@
>  else
>  $(makfile): Makefile.PL ../GIT-CFLAGS
> -	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
> +	'$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
>  endif
>  
>  # this is just added comfort for calling make directly in perl dir
> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index de73235..4168775 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -24,5 +24,6 @@ WriteMakefile(
>  	NAME            => 'Git',
>  	VERSION_FROM    => 'Git.pm',
>  	PM		=> \%pm,
> +	MAKEFILE	=> 'perl.mak',
>  	%extra
>  );

Yes, this helps.  Please commit.

Thanks,
    Luben
