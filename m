From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 07 Oct 2012 13:39:32 -0700
Message-ID: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 22:39:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKxdc-0003Nn-1o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 22:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab2JGUjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 16:39:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab2JGUjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 16:39:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF3E936E;
	Sun,  7 Oct 2012 16:39:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	8anqKg5UBcae69qYNxGMiVmJbA=; b=EtOPRSHgbNqRq99shHM5sIHMhfBJlSS0e
	CmFHSx34kNAkZu7jIANzrpb7+Vi6mR9fNZhiVMWZQF1T34bhngP1s1Oi1nOkELCB
	W9PSNnwTOOzYM9ztOi3JBcLj+9RuC0RJvt86ERwv50rifZ80gNALUR4vUrWpB7FR
	QO8hTcLG0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=i83
	cvpa/KNCras7E7ngmo5isOgdODHZ2O5ygPBpYbAL+c85J+wFQwxQzIOifzTzLRBv
	N9oyLDfr8VX2mp1hRsVbo/2tqqhxwKErlyljzNpTCEJQTZFn8U34JO1Gv5uqbqEy
	qlSxbSjcoz7Dw9SailaFbCdJ8yDd8TAK9zkjNdmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD415936D;
	Sun,  7 Oct 2012 16:39:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0897C936C; Sun,  7 Oct 2012
 16:39:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A4ABDAC-10BF-11E2-BB4C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207193>

By default, "make doc" generates the manpages and htmldocs in the
Documentation directory, but you may want to change this depending
on the target environment, e.g. to include 'pdf'.  Introduce a new
Makefile variable DEFAULT_DOC_TARGET to allow customizing this.

The primary motivation is to let us check documentation patches with

    $ DEFAULT_DOC_TARGET=git-push.1 make doc

but it is not so far-fetched to imagine that Windows users may want to
omit manpages with

    $ DEFAULT_DOC_TARGET=html make doc

or somesuch; this lets interested people to enhance the install-doc
target in a similar way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index 8413606..250b87a 100644
--- c/Makefile
+++ w/Makefile
@@ -299,6 +299,12 @@ all::
 #   DEFAULT_EDITOR='$GIT_FALLBACK_EDITOR',
 #   DEFAULT_EDITOR='"C:\Program Files\Vim\gvim.exe" --nofork'
 #
+# You can define DEFAULT_DOC_TARGET to something other than "all" to change it
+# from the built-in default of generating manpages and htmldocs.  e.g.
+#
+#   DEFAULT_DOC_TARGET='man html info pdf'
+#   DEFAULT_DOC_TARGET='html'
+#
 # Define COMPUTE_HEADER_DEPENDENCIES to "yes" if you want dependencies on
 # header files to be automatically computed, to avoid rebuilding objects when
 # an unrelated header file changes.  Define it to "no" to use the hard-coded
@@ -1496,6 +1502,8 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
+DEFAULT_DOC_TARGET ?= all
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -2468,10 +2476,10 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
 
-export DEFAULT_EDITOR DEFAULT_PAGER
+export DEFAULT_EDITOR DEFAULT_PAGER DEFAULT_DOC_TARGET
 
 doc:
-	$(MAKE) -C Documentation all
+	$(MAKE) -C Documentation $(DEFAULT_DOC_TARGET)
 
 man:
 	$(MAKE) -C Documentation man
