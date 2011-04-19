From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 12/11] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
Date: Tue, 19 Apr 2011 19:18:25 +0200
Message-ID: <201104191918.26909.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com> <201104190836.16221.jnareb@gmail.com> <7vmxjm5gae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCEZW-0007mw-3L
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab1DSRSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 13:18:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54006 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1DSRSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 13:18:36 -0400
Received: by bwz15 with SMTP id 15so4715924bwz.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=kauEsGUBElenETBCDIhOpZWtZPiEgy1l2FjoQnB7QZM=;
        b=t29hP0iRfkiFIYThgkX9UWXGy/VmEFYHGBkGXB2yxp5C2SeUgGm54HndZK8wBHUgQo
         Ej2+51thpRIiSkBZJI04xlRzbC/4Xf8/l1vKBw/Zj6DCrD1gNdImk3R7MDQE8xBKo1hk
         jpOUDEOjfOla9JPUQFmqJ4S1x4EOGAKQLwQQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IJ/TAWosSYYN56gzT5qeZgm6qCUVlS9r3Ysg84nqu7mmiMphtk3NiixhOhzS+mcddd
         iue+YCKllpTiD9MGQmw4I0csI2e1oiD4/kjBAGikCWMMEO49ZAQgEX2xOnospysR0SOm
         n4bzwkzCbQ+/KvzhtH/xrcI80xhGDHP8Epmcc=
Received: by 10.204.22.204 with SMTP id o12mr19228bkb.76.1303233514866;
        Tue, 19 Apr 2011 10:18:34 -0700 (PDT)
Received: from [192.168.1.13] (abvx167.neoplus.adsl.tpnet.pl [83.8.221.167])
        by mx.google.com with ESMTPS id a23sm55357bkc.16.2011.04.19.10.18.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 10:18:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmxjm5gae.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171802>

On Tue, 19 Apr 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Perhaps something like that would be a good change, what do you think?
> 
> Should be a lot saner thing to do.
> 
> Do we even need to know about JSMIN, GITWEB_JS, etc., in our main
> Makefile?  Shouldn't we be delegating both the build and the install
> targets to "$(MAKE) -C gitweb $@"?
> 
> > diff --git i/Makefile w/Makefile
> > index cbc3fce..8960cee 100644
> > --- i/Makefile
> > +++ w/Makefile
> > @@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
> >  endif # CSSMIN
> >  
> >  
> > -git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
> > +git-instaweb: git-instaweb.sh gitweb
> >  	$(QUIET_GEN)$(RM) $@ $@+ && \
> >  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
> >  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \

How about that?

The patch below is to be after just sent "git-instaweb: Simplify build
dependency on gitweb", not necessary as last patch in series.

Note that I have left duplicated description of JSMIN and CSSMIN in main
Makefile; perhaps they also should be removed...

-- >8 --
Subject: [PATCH 12/11] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile

Now that there is gitweb/Makefile, let's leave only "gitweb" and
"install-gitweb" targets in main Makefile.  Those targets just
delegate to gitweb's Makefile.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Makefile |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 8960cee..d0c577b 100644
--- a/Makefile
+++ b/Makefile
@@ -1747,32 +1747,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
-ifdef JSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.js
-GITWEB_JS = gitweb/static/gitweb.min.js
-else
-GITWEB_JS = gitweb/static/gitweb.js
-endif
-ifdef CSSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.css
-GITWEB_CSS = gitweb/static/gitweb.min.css
-else
-GITWEB_CSS = gitweb/static/gitweb.css
-endif
-OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
-gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-
-ifdef JSMIN
-gitweb/static/gitweb.min.js: gitweb/static/gitweb.js
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # JSMIN
-ifdef CSSMIN
-gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # CSSMIN
-
-
 git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-- 
1.7.3
