From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 7 Jul 2010 22:20:18 +0200
Message-ID: <201007072220.18824.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <7viq4rxnro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 22:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWb6f-0004tM-3Z
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab0GGUU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 16:20:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35621 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab0GGUU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:20:26 -0400
Received: by bwz1 with SMTP id 1so56565bwz.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IgYgVd+1iQIazShSnl9JClTnf1iQXmo94iw1H3VFpZs=;
        b=RJjThlCIkDNLmbVRMmBtx6JS89C2bBJm1wOK3ct7Sd57gfNbC1IvKViKOwuQy974i1
         +2tYKH9128JggXayVt8u2ZbCys1/LrSHL+EwayDoFRfSVOVF1cS4iTqjzXnM5L1mMSF6
         8TtKBDWLzMlwPK3BZRPG5/oDxyDpSlsgLQ5aA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=n8ETzx4f2HvrDZS1yrNKAQBluDlLKYvPDr9JwBzNdNQ8gaY57iDkz0uOcgx91xBeUQ
         KjrsOfI+jh1in7orB281ej3JWpZfOT3O7aFhMB2yIAU/AekSh4IFgTqTTESwyZQwWt+x
         Rqg0W8FoPX+zjHbrmc655+TZzdO11JNrkzYtw=
Received: by 10.204.126.161 with SMTP id c33mr5481261bks.108.1278534024613;
        Wed, 07 Jul 2010 13:20:24 -0700 (PDT)
Received: from [192.168.1.15] (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id g11sm29500845bkw.22.2010.07.07.13.20.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:20:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7viq4rxnro.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150498>

On Wed, 7 Jul 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index 2fb7c2d..84a1d71 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -145,12 +146,23 @@ gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
> >  
> >  ### Installation rules
> >  
> > -install: all
> > +install: all install-modules
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> >  	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
> >  	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
> >  
> > +install-modules:
> > +	install_dirs=$(sort $(dir $(GITWEB_MODULES))) && \
> > +	for dir in $$install_dirs; do \
> > +		test -d '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir' || \
> > +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$dir'; \
> > +	done
> > +	gitweb_modules=$(GITWEB_MODULES) && \
> > +	for mod in $$gitweb_modules; do \
> > +		$(INSTALL) -m 644 $$mod '$(DESTDIR_SQ)$(gitwebdir_SQ)/$$(dirname $$mod)'; \
> > +	done
> > +
> 
> Sorry, but you lost me here.  Where is GITWEB_MODULES defined (iow, what
> commit is this patch supposed to be applied)?

This is preparatory patch either for Pavan GSoC2010 work on splitting
gitweb and adding committool / admin write capabilities, or for mine
gitweb caching series split into modules (based on J.H. patch for 
git.kernel.org).

So currently $(GITWEB_MODULES) is not defined / empty.

> I also suspect that your assignment to "install_dirs" is completely bogus
> when the files listed in GITWEB_MODULES span multiple directories.

install_dirs contains _list_ of directories gitweb modules are to be
installed into.  `$(dir NAMES...)' extracts the directory-part of each
file name in NAMES ('./' if there is no '/' in a file name), and
`$(sort LIST)' is used to remove duplicate words in LIST.

It was actually tested that it works for modularized gitweb caching,
in the older form using `$(foreach ...)' rather than current shell
'for' loop.


For example with the following Makefile:

  GITWEB_MODULES += GitwebCache/SimpleFileCache.pm
  GITWEB_MODULES += GitwebCache/Capture.pm
  GITWEB_MODULES += GitwebCache/Capture/SelectFH.pm
  GITWEB_MODULES += Gitweb/Config.pm
  
  all:
  	@echo $(sort $(dir $(GITWEB_MODULES)))

running 'make' results in:

  Gitweb/ GitwebCache/ GitwebCache/Capture/
-- 
Jakub Narebski
Poland
