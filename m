From: Junio C Hamano <gitster@pobox.com>
Subject: Re: packaging vs default pager
Date: Wed, 28 Oct 2009 10:55:58 -0700
Message-ID: <7vskd3o11t.fsf@alter.siamese.dyndns.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:56:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Cks-0003F0-KN
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 18:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbZJ1R4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZJ1R4F
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 13:56:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbZJ1R4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 13:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3D53891CD;
	Wed, 28 Oct 2009 13:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EM1aAXx41gnrI5SscTStMyJxMFQ=; b=uPsx4r
	Ej1Fgw5IMdTX9QX7bItZB7jo6G1KvmH0xhAUlVxC5Tw41TU9SBl4Pqu4bq1j2n5/
	/jtBDBwqxnuWZlqBnRarfEfGEsb1zhPEO2uGsYyiOXoqllOyjib2PlJ3nmcui1t8
	3Yt7BxXKrV00bsiyYGUHF/v38XJhNJHQGGFoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0JKxXvORtf775FvOxw7d6kcmXIis87B
	U3GujD+eLP1VGE5hqC9qONfelz5lVJb15vbffzCcBKXGMer8Yf9fPDzzxN3NTtAd
	aPfj94bDE6HCFEZN5RwiKZUgwwMh7DpEA6BBbx1XTght/Whkr43gEE4JyfB5sDTq
	FriGXT9nPK0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7888891C7;
	Wed, 28 Oct 2009 13:56:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 88512891C6; Wed, 28 Oct 2009
 13:56:00 -0400 (EDT)
In-Reply-To: <1256742357-sup-3798@ntdws12.chass.utoronto.ca> (Ben Walton's
 message of "Wed\, 28 Oct 2009 11\:21\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28CF2D8C-C3EB-11DE-8EB8-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131483>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> On (old) solaris systems, /usr/bin/less (typically the first less
> found) doesn't understand the default arguments (FXRS), which forces
> users to alter their environment (PATH, GIT_PAGER, LESS, etc) or have
> a local or global gitconfig before paging works as expected.
>
> Would it be completely out of line to provide a knob so that the
> fallback $pager could be set to something more specific/appropriate
> during the build?

I think that is a sensible thing to do.  Something like this?

 Makefile |    6 ++++++
 pager.c  |    6 +++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 268aede..342d49a 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,9 @@ all::
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
+#
+# Define DEFAULT_PAGER to the path of a sensible pager (defaults to "less") if
+# you want to use something different.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1294,6 +1297,9 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
+ifdef DEFAULT_PAGER
+	BASIC_CFLAGS += -DDEFAULT_PAGER='"$(DEFAULT_PAGER)"'
+endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
diff --git a/pager.c b/pager.c
index 86facec..f4c992d 100644
--- a/pager.c
+++ b/pager.c
@@ -2,6 +2,10 @@
 #include "run-command.h"
 #include "sigchain.h"
 
+#ifndef DEFAULT_PAGER
+#define DEFAULT_PAGER "less"
+#endif
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -58,7 +62,7 @@ void setup_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = DEFAULT_PAGER;
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
