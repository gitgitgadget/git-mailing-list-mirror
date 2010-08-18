From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Splitting gitweb and build-time configuration variables
Date: Wed, 18 Aug 2010 10:05:48 +0200
Message-ID: <201008181005.49524.jnareb@gmail.com>
References: <201008172015.37353.jnareb@gmail.com> <20100818030321.GB21185@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	John Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 10:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OldfI-0001wB-1r
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 10:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938Ab0HRIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 04:06:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63798 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0HRIGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 04:06:02 -0400
Received: by bwz3 with SMTP id 3so318912bwz.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zNkLRx1MISaOcaYva2ghwpOIdG0C3x1vGdSVMQYWAjo=;
        b=xm1KXyvrDJOVQrJ7ybbpIXdJnDXWxNEn8KePoIYxH6OTxxe4OIMyinYm+9XQWK8S3w
         Rz9gAqEoFu+Wkjm1BzTFLqzoSi/CmVSo0T9H1tTry+1A2KZJqVoWRKrPQRBSBJ1TGFwU
         0U4DULHtHuMThBEe4Mzcm1lVkqnk32jFD0OCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HkeJmwhOMUphOuUV9edwFqsfy8L2tFSG/B25hO5EZ5T6yRXei5ZncBDXsYBcz06HeN
         c13mQ0zzHpRJt6LMBwVwwrRM0GN17z/QZOBKoTD4UXv7dHU/5ecfmGY4PpS05Rv1K6gi
         zRclufg7g3Rcx/HT9rvVwFP4UJoXKY6q0JY10=
Received: by 10.204.80.98 with SMTP id s34mr5295573bkk.211.1282118759842;
        Wed, 18 Aug 2010 01:05:59 -0700 (PDT)
Received: from [192.168.1.13] (abve74.neoplus.adsl.tpnet.pl [83.8.202.74])
        by mx.google.com with ESMTPS id x13sm5908896bki.0.2010.08.18.01.05.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 01:05:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100818030321.GB21185@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153814>

On Wed, 18 Aug 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > 1. Description of build-time configuration variable is in the module
> >    that defines it, and each block of variables coming from the same
> >    module would have notice where one can find description of those
> >    variables
> [...]
> > 2. Description of build-time configuration variables is in gitweb.perl,
> >    and in each module there is comment that full description of those
> >    variables can be found there, e.g. (proposal):
> > 
> >      # Values of those variables are set during build time in 
> >      # gitweb/gitweb.perl (main script).  You can find their description
> >      # there.
> [...]
> > 3. Duplicate description of those variables
> 
> With #2, a person reading the Makefile can grep for some particular
> substitution (++GITWEB_PROJECTROOT++) and quickly find the name and
> description of the variable it is used for.  If there were a 1:1
> correspondence between the variables in gitweb.perl and the Makefile,
> I would even suggest moving the description to the Makefile.

There is a bit of difference between Perl variables in gitweb.perl and
make build-time variables in gitweb/Makefile, namely:

  our $GIT = "++GIT_BINDIR++/git";

  our $site_name = "++GITWEB_SITENAME++"
                 || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";

  our @stylesheets = ("++GITWEB_CSS++");

  our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");

  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
  our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'}
                            || "++GITWEB_CONFIG_SYSTEM++";

Perl variables can be overriden in run-time configuration (testsuite
uses this to test _source_ version i.e. gitweb.perl rather than 
generated gitweb.cgi), so they have to be described anyway.

I think that adding description of make variables to gitweb/Makefile,
similar to what main Makefile does, would be a good idea, though I don't
like that it leads to some duplication.

> 
> In practice, I suspect the run-time configuration is more important to
> people.  That is already fairly well documented in gitweb/README.

Build-time configuration is also described in gitweb/README, in more
detail.

-- 
Jakub Narebski
Poland
