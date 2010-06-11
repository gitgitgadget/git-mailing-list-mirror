From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Fri, 11 Jun 2010 09:15:48 -0700
Message-ID: <7vhbl9k0jv.fsf@alter.siamese.dyndns.org>
References: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch> <I5rdmhJblm27JnzIPi7xP5KmntXzA3-wGL-IGXejOPAurGsMke2J3g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:16:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON6tr-0000x9-15
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab0FKQQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 12:16:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0FKQP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:15:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2A0FBB164;
	Fri, 11 Jun 2010 12:15:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ES6IjbjY61q6crDGG2MTz829xXE=; b=YvyTto
	m8PyI1/G+jQAQCEwby7rjPGXyOZRd8xQXsydtIWwmtHphGgjJ+Y3xz6s+e8ybI/z
	dpfnnM/HXlxZEZlhSEfN6EgONp2anqoJ7/MN9PIwD6msrY/VOkNivvPR9rnmzGe+
	hcqCZ1fiaD02fK6xwWg6kgU/02STAbXNflf88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O80dsqJEPdFW2KJU6rTWZvuavQsEfAAl
	DET2xcyr/FKCqRoyqafn7Ee76bP1PtOTma6ypYDW4lZHkrfLnZ6eZpsj1gurQsxL
	985Q0Noz2iDqm2c5BCG1OB0pDu0MQ7H5CDc8WLB1pYo1lExATfWvUtJCmMuZYp7z
	GmldfDfrRro=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E9FBB163;
	Fri, 11 Jun 2010 12:15:54 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F8EDBB15D; Fri, 11 Jun
 2010 12:15:50 -0400 (EDT)
In-Reply-To: <I5rdmhJblm27JnzIPi7xP5KmntXzA3-wGL-IGXejOPAurGsMke2J3g@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\, 10 Jun 2010 12\:23\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C546CA0-7574-11DF-BB8A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148958>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> I think what should be done instead, is to move this section
> down below the line where GIT-BUILD-OPTIONS is sourced.  That
> way, the value of $DIFF can be gotten from that file.
>
> I guess GIT_TEST_CMP and GIT_TEST_CMP_USE_COPIED_CONTEXT
> should be written into GIT-BUILD-OPTIONS too.

I like that.  Something like this?

 Makefile      |    6 ++++++
 t/test-lib.sh |   20 ++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 0367e8a..6b3b59b 100644
--- a/Makefile
+++ b/Makefile
@@ -1944,6 +1944,12 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
+ifdef GIT_TEST_CMP
+	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@
+endif
+ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
+	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@
+endif
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a290011..eafe146 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -64,16 +64,6 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
-if test -z "$GIT_TEST_CMP"
-then
-	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
-	then
-		GIT_TEST_CMP="$DIFF -c"
-	else
-		GIT_TEST_CMP="$DIFF -u"
-	fi
-fi
-
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
@@ -691,6 +681,16 @@ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOB
 
 . ../GIT-BUILD-OPTIONS
 
+if test -z "$GIT_TEST_CMP"
+then
+	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
+	then
+		GIT_TEST_CMP="$DIFF -c"
+	else
+		GIT_TEST_CMP="$DIFF -u"
+	fi
+fi
+
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
 test -d ../templates/blt || {
