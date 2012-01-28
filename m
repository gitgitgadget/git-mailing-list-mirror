From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"
Date: Sat, 28 Jan 2012 18:48:48 +0100
Message-ID: <201201281848.49483.jnareb@gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <201201271845.39576.jnareb@gmail.com> <7vty3gzxhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>,
	Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCOO-0000q6-4h
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2A1RsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 12:48:20 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47658 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2A1RsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 12:48:19 -0500
Received: by eekc14 with SMTP id c14so931534eek.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 09:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=dT4oSToMtSHDkQNiEkErLc5efKCWkUSkYtMoeuaZ/vw=;
        b=PlBWzdaXg++eGKV1/QWk+dHSglYDlh8X+It4Zsxzl/TbYLDob5Fx3TWn/GaO31ys6A
         2Gb5Bw+neHLXA4IxoMXLgTHxDvNxn2vEx7qNBBDXFyhhnzCd4d7qYLexUNZkEkCTLnx4
         4LWDHo57Qj1gZ0qQI3TYq8ZbXEvBF4mZ65N+E=
Received: by 10.14.40.79 with SMTP id e55mr3696144eeb.26.1327772897990;
        Sat, 28 Jan 2012 09:48:17 -0800 (PST)
Received: from [192.168.1.13] (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id n17sm46613481eei.3.2012.01.28.09.48.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 09:48:17 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vty3gzxhs.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189262>

On Fri, 27 Jan 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Though Time::HiRes is a core Perl module, it doesn't necessarily mean
> > that it is included in 'perl' package, and that it is installed if
> > Perl is installed.
> 
> I do not think we have seen the end of Redhat/Fedora Perl saga.  I am
> hoping that either one of the two things to happen:
> 
>  (1) Redhat/Fedora distrubution reconsiders the situation and fix their
>      packages so that by default when its users ask for "Perl" they get
>      what the upstream distributes as "Perl" in full, while still allowing
>      people who know what they are doing to install a minimum subset
>      "perl-base"; or
> 
>  (2) Many applications that use and rely on Perl like we do are hit by
>      this issue, and Redhat/Fedora users are trained to install the
>      perl-full (or whatever it is called) package when applications want
>      "Perl".
> 
> In other words, I am hoping that "it doesn't necessarily mean" will not
> stay true for a long time.  So please hold onto this patch until the dust
> settles, and resend it if (1) does not look to be happening in say 3
> months.
 
So for the time being (those "3 months") you would apply instead your
change to INSTALL (or equivalent to gitweb/INSTALL) mentioning Time::HiRes
issue, and perhaps also original patch by Hallvard skipping gitweb tests
if Time::HiRes is not available, isn't it?
 
> > For example RedHat has split it out to a separate RPM perl-Time-HiRes.

[...]
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index abb5a79..c86224a 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -17,10 +17,12 @@ use Encode;
> >  use Fcntl ':mode';
> >  use File::Find qw();
> >  use File::Basename qw(basename);
> > -use Time::HiRes qw(gettimeofday tv_interval);
> >  binmode STDOUT, ':utf8';
> >  
> > -our $t0 = [ gettimeofday() ];
> > +our $t0;
> > +if (eval { require Time::HiRes; 1; }) {
> > +	$t0 = [Time::HiRes::gettimeofday()];
> > +}
> >  our $number_of_git_cmds = 0;
> 
> Why should these even be initialized here?  Doesn't reset_timer gets
> called at the beginning of run_request()?

I think it predates adding reset_timer() to gitweb.  Anyway $t0 has
to be set to something defined anyway to denote that Time::HiRes is
available... though if Time::HiRes is required unconditionally it would
not be really needed, and we can always check $INC{'Time/HiRes.pm'}
if it was loaded or not.

> >  BEGIN {
> > @@ -1142,7 +1144,7 @@ sub dispatch {
> >  }
> >  
> >  sub reset_timer {
> > -	our $t0 = [ gettimeofday() ]
> > +	our $t0 = [Time::HiRes::gettimeofday()]
> >  		if defined $t0;
> >  	our $number_of_git_cmds = 0;
> 
> The statement modifier look ugly.
> 
> More importantly, if you are not profiling, i.e. if we didn't initialize
> $t0 at the beginning, do you need to reset $number_of_git_cmds at all?
> 
> I also think this should take gitweb_check_feature('timed') into
> account, perhaps like this:
> 
> 	sub reset_timer {
>         	return unless gitweb_check_feature('timed');
>                 our $t0 = ...
>                 our $number_of_git_cmds = 0;
> 	}
> 
> Then all the other
> 
> 	if (defined $t0 && gitweb_check_feature('timed'))
> 
> can become
> 
> 	if (defined $t0)

I think this is a good idea... though it would complicate applying revert
a bit ;-(

> If you go this route, even though tee-zero, the beginning of the time, is
> a good name for the variable, you may want to rename it to avoid confusing
> readers who might take it as a temporary variable #0.

Good idea.  $request_start_time perhaps?  Or $time_start?

-- 
Jakub Narebski
Poland
