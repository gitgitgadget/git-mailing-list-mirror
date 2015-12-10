From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Makefile: add missing phony target
Date: Thu, 10 Dec 2015 19:37:09 +0100
Message-ID: <vpqio46b162.fsf@anie.imag.fr>
References: <1449761094-37915-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a765h-0000tK-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbbLJShR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:37:17 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53804 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbbLJShP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:37:15 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tBAIb7ti023335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Dec 2015 19:37:07 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tBAIb9v8028914;
	Thu, 10 Dec 2015 19:37:09 +0100
In-Reply-To: <1449761094-37915-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Thu, 10 Dec 2015 15:24:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 Dec 2015 19:37:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tBAIb7ti023335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1450377430.8733@u3tNl092YjAChxxiHQPBBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282221>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Also put the .PHONY
> declaration immediately before the target declaration, where necessary,
> for a better readability and a uniform style.
[...]
> --- a/Makefile
> +++ b/Makefile
> @@ -522,11 +522,11 @@ SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
>  # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
>  # from subdirectories like contrib/*/
>  .PHONY: build-perl-script build-sh-script build-python-script
> +.PHONY: install-perl-script install-sh-script install-python-script
>  build-perl-script: $(SCRIPT_PERL_GEN)
>  build-sh-script: $(SCRIPT_SH_GEN)
>  build-python-script: $(SCRIPT_PYTHON_GEN)
>  
> -.PHONY: install-perl-script install-sh-script install-python-script
>  install-sh-script: $(SCRIPT_SH_INS)
>  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  install-perl-script: $(SCRIPT_PERL_INS)

Isn't this hunk doing exactly the opposite of what the commit message
says? install-sh-script's .PHONY used to be right before the target, and
it's now in the paragraph above.

> @@ -534,7 +534,7 @@ install-perl-script: $(SCRIPT_PERL_INS)
>  install-python-script: $(SCRIPT_PYTHON_INS)
>  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  
> -.PHONY: clean-perl-script clean-sh-script clean-python-script
> +.PHONY: clean-sh-script clean-perl-script  clean-python-script

double-space befroe clean-python-script.

> @@ -546,7 +546,6 @@ SCRIPTS = $(SCRIPT_SH_INS) \
>  	  $(SCRIPT_PERL_INS) \
>  	  $(SCRIPT_PYTHON_INS) \
>  	  git-instaweb
> -
>  ETAGS_TARGET = TAGS

Is this needed/good?

> @@ -1792,7 +1794,7 @@ GIT-PERL-DEFINES: FORCE
>  	    fi
>  
>  
> -.PHONY: gitweb
> +.PHONY: gitweb git-instaweb

No: git-instaweb is not a .PHONY target, it's a real file generated from
git-instaweb.sh.

This bug in your patch is hard to spot in its current form where you mix
code movement and subtle changes. The patch cannot be reviewed in good
condition as-is.

> +.PHONY: tags cscope FORCE
>  tags: FORCE
>  	$(RM) tags
>  	$(FIND_SOURCE_FILES) | xargs ctags -a

If tags depends on FORCE, it doesn't need to be .PHONY. I strongly
prefer the old style, since tags is actually a file, and I prefer using
.PHONY for targets that are not meant to generate files, and depend on
FORCE where the rule actually generate a file named after its target,
but needs to be re-ran every time it's called.

If you disagree with this, then you need to justify the change in the
commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
