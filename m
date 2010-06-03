From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 17:55:28 +0200
Message-ID: <201006031755.29814.jnareb@gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com> <20100603152030.GD20775@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:55:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKClt-0004r1-4C
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718Ab0FCPzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:55:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41815 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0FCPzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 11:55:40 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2206108fgb.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NG1nMhcZ0HKXLzEEyz4f5UML4MKtQzfV/S+pmQiSprg=;
        b=PBM8fNjGU6g2FgCE9/n5XlOp4Kzet09freJrnXB82ke7fhfgz2+dRRDBjv/lJpHYku
         33OPp+TAqDoFYvyUEh3lh4A6YB4DJALX/Hzn+w/BAOVfmJO6GPoo6kPSEC3CnJBVFd8C
         2K1xAuZdEfD6PZvqhEmhXSYeOR9Fd68XNRAW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tjZRreNz/gPQ8LP/XVPA2ug+FEf+SpEifW2gpBqNyQZRtFUnKuRbIsQkAU/r98T/Q7
         7cwNSiW7YZ/EialQe71ln5eY89px5IVuhIt2duyHRyJC8G91GKEG+0T4MG80GaXuOMnx
         MuwhYn8g+JphU6mQOkiGgNlc5xKAOx+m6NO3w=
Received: by 10.103.4.13 with SMTP id g13mr3476944mui.12.1275580538712;
        Thu, 03 Jun 2010 08:55:38 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id e9sm257664muf.40.2010.06.03.08.55.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 08:55:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100603152030.GD20775@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148339>

On Tue, 3 Jun 2010, Petr Baudis wrote:
>
>   I have couple of concerns; maybe they were addressed in the previous
> discussion which I admit I did not read completely, but in that case
> they ought to be addressed in the commit message as well.
> 
> On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote:
> > -our $t0;
> > -if (eval { require Time::HiRes; 1; }) {
> > -	$t0 = [Time::HiRes::gettimeofday()];
> 
> Why is this moved to Gitweb::Config? Shouldn't this be rather part of
> Gitweb::Request?

I also think that this should be either part of Gitweb::Request, oe
even be left in gitweb.perl.  I think having it in Gitweb::Request
would be a better idea, because it is about time (and number of git
commands) it took to process request.

> > +# __DIR__ is taken from Dir::Self __DIR__ fragment
> > +sub __DIR__ () {
> > +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
> >  }
> > -our $number_of_git_cmds = 0;
> > +use lib __DIR__ . "/lib";
> 
> Wouldn't it be more elegant to use FindBin? I'm just not sure how long
> is it part of core Perl.

Actually FindBin is in core since 5.4, and we require Perl 5.8+ for
gitweb anyway (for Encode and proper Unicode support).  

But from what I've heard FindBin is not recommended anymore, although
perhaps the disadvantages of FindBin doesn't matter in our situation.


>From FindBin(3pm) manpage:

  KNOWN ISSUES

  If there are two modules using `FindBin` from different directories under
  the same interpreter, this won't work. Since `FindBin` uses a `BEGIN` block,
  it'll be executed only once, and only the first caller will get it
  right.  **This is a problem under mod_perl** and other persistent Perl
  environments, where you shouldn't use this module.

>From what I remember there might also be problems with symlinks.


>From Dir::Self(3pm) manpage:

  DESCRIPTION

  Perl has two pseudo-constants describing the current location in your
  source code, __FILE__ and __LINE__.  This module adds __DIR__, which
  expands to the directory your source file is in, as an absolute pathname.

  This is useful if your code wants to access files in the same directory,
  like helper modules or configuration data.  This is a bit like `FindBin`
  except it's not limited to the main program, i.e. you can also use it in
  modules.  **And it actually works.**


Is there on git mailing list a Perl hacker that can tell us one way or
another?  (Not that this matter much, if it works).

> 
> > +
> > +use Gitweb::Config;
> >  
> >  BEGIN {
> >  	CGI->compile() if $ENV{'MOD_PERL'};
> >  }
> >  
> > -our $version = "++GIT_VERSION++";
> > +$version = "++GIT_VERSION++";

This change is not necessary.

  our $version = "++GIT_VERSION++";

would keep working even if '$version' is declared in other module and
exported by this module (is imported into current scope).

> >  
> >  our ($my_url, $my_uri, $base_url, $path_info, $home_link);
> >  sub evaluate_uri {
> > @@ -68,402 +71,58 @@ sub evaluate_uri {
> >  
> >  # core git executable to use
> >  # this can just be "git" if your webserver has a sensible PATH
> > -our $GIT = "++GIT_BINDIR++/git";
> > +$GIT = "++GIT_BINDIR++/git";
> 
> I dislike the new schema in one aspect - the list of configuration
> variables together with their description is not at a single place
> anymore: the build-time overridable variables have their descriptions
> still in gitweb.pl and only very brief mentions in Gitweb::Config, while
> the rest has moved fully to Gitweb::Config. I think it would be best to
> move all descriptions to Gitweb::Config and keep only the override
> assignments in gitweb.pl. So, Gitweb::Config would have
> 
> 	# core git executable to use
> 	# this can just be "git" if your webserver has a sensible PATH
> 	our $GIT;

Good idea.

Perhaps we should provide some sane default fallback values, like for
example

  	our $GIT = "git";

> 
> and gitweb.pl would have _just_
> 
> 	$GIT = "++GIT_BINDIR++/git";

I would say

  	our $GIT = "++GIT_BINDIR++/git";

> I think you ought to add a comment in front of this section explaining
> that not all configuration variables are listed here anymore. Something
> like
> 
> 	# Only configuration variables with build-time overridable
> 	# defaults are listed below. The complete set of variables
> 	# with their descriptions is listed in Gitweb::Config.

Right.  I wholehartily agree.

> >  # name of your site or organization to appear in page titles
> >  # replace this with something more descriptive for clearer bookmarks
> > -our $site_name = "++GITWEB_SITENAME++"
> > +$site_name = "++GITWEB_SITENAME++"
> >                   || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
> 
> This looks like some new feature; please do that in a separate patch.
> (BTW, I assume that there are no other changes like this in the rest of
> the moved code blocks!)

No, it isn't.  And without 'our $var = VALUE' -> '$var = VALUE' change,
which is not necessary and artifically inflates the size of patch, this
chunk wouldn't even be present.

-- 
Jakub Narebski
Poland
