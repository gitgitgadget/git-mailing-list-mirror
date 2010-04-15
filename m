From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 18:42:56 -0700
Message-ID: <7v1vehmqxr.fsf@alter.siamese.dyndns.org>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
 <201004140030.47222.jnareb@gmail.com>
 <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
 <201004150225.42101.jnareb@gmail.com>
 <7veiihmtjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 03:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2E6v-0007BA-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 03:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab0DOBnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 21:43:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab0DOBnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 21:43:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F4C8ABA40;
	Wed, 14 Apr 2010 21:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FhW6Nb9612YBTjuN3KPX9P+qGb8=; b=IRg33Z
	cEIIPRYHUUakd/6+BuPpi5omoIZUQXivFiOirgzS1KwQ5jovNq3QWii/ADrCRK9Z
	98J2M0SLmkZgP+2IXiuTOPvX/0GopM8D/tdmkUF3S8qYYKTNfblGb9PuOEqYKkC6
	7iGCLZOUL1EqWDMUBBmlkJVCjPuNynP65Ns/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/p9Z4HCxjAuhDgeJzGoWTP8SDBTiJ92
	N96/KJNGBuYwbJLQPd5fjE6rslf+CTkURZAQfMMSoTxyhpjo7l//BqRHZ8MWe8FY
	ThlUGMP43qfCoYctgSghA7ArtZjkU1AbPQd0/0MgbAQRfiqI7FBv6Xi2OSxRN0Sq
	PQS0fV1xuUk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17452ABA3E;
	Wed, 14 Apr 2010 21:43:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E47ECABA3C; Wed, 14 Apr
 2010 21:42:57 -0400 (EDT)
In-Reply-To: <7veiihmtjw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 14 Apr 2010 17\:46\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BA38718-4830-11DF-BDA5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144941>

Junio C Hamano <gitster@pobox.com> writes:

> Unless you are including gitweb.cgi (iow, the contents of the generated
> file depends on the _contents_ of gitweb.min.js (or gitweb.js), gitweb.cgi
> does _not_ depend on these files.  Of course if you generate gitweb.cgi
> out of gitweb.perl with one setting of GITWEB_JS and then change your
> mind, then you need to regenerate it, but that is not something you can do
> by comparing file timestamp of gitweb.cgi and the file timestamp of
> $(GITWEB_JS) anyway.  You would need to imitate something like how
> GIT-BUILD-OPTIONS is used by the primary Makefile.

Here is a minimally tested patch.

In addition to the points raised by the proposed log message for the
previous one, this tries to make sure that the scripts are regenerated
whenever the replacement variables are modified.  For a good measure, if
you used different JSMIN/CSSMIN since the last time you produced minified
version of these files, they are regenerated.

If this seems to work Ok, please send it back to me with a proper commit
log message (concat of the above and the previous) with Tested-by: or
Acked-by: as appropriate, so that we can fix it at the tip of 'master'
before we tag 1.7.1-rc2.

Thanks.

 gitweb/Makefile |   75 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index ffee4bd..f2e1d92 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -80,54 +80,55 @@ endif
 
 all:: gitweb.cgi
 
-FILES = gitweb.cgi
 ifdef JSMIN
-FILES += gitweb.min.js
 GITWEB_JS = gitweb.min.js
+all:: gitweb.min.js
+gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
+	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif
+
 ifdef CSSMIN
-FILES += gitweb.min.css
 GITWEB_CSS = gitweb.min.css
+all:: gitweb.min.css
+gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
+	$(QUIET_GEN)$(CSSMIN) <$ >$@
 endif
-gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
 
-gitweb.cgi:
+GITWEB_REPLACE = \
+	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
+	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
+	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
+	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
+	-e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
+	-e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	-e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
+	-e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	-e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
+	-e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
+	-e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
+	-e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
+	-e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
+	-e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
+	-e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	-e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
+	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
+	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g'
+
+GITWEB-BUILD-OPTIONS: FORCE
+	@rm -f $@+
+	@echo "x" '$(PERL_PATH_SQ)' $(GITWEB_REPLACE) "$(JSMIN)|$(CSSMIN)" >$@+
+	@cmp -s $@+ $@ && rm -f $@+ || mv -f $@+ $@
+
+gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
-	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
-	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-	    -e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
-	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
-	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
-	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
-	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
-	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
-	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
-	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
-	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
-	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
-	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
-	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
-	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
-	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
-	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $< >$@+ && \
+		$(GITWEB_REPLACE) $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-ifdef JSMIN
-gitweb.min.js: gitweb.js
-	$(QUIET_GEN)$(JSMIN) <$< >$@
-endif # JSMIN
-
-ifdef CSSMIN
-gitweb.min.css: gitweb.css
-	$(QUIET_GEN)$(CSSMIN) <$ >$@
-endif
-
 clean:
-	$(RM) $(FILES)
+	$(RM) gitweb.cgi gitweb.min.js gitweb.min.css GITWEB-BUILD-OPTIONS
+
+.PHONY: all clean .FORCE-GIT-VERSION-FILE FORCE
 
-.PHONY: all clean .FORCE-GIT-VERSION-FILE
