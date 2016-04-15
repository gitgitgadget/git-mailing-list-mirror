From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Fri, 15 Apr 2016 10:06:52 -0700
Message-ID: <xmqqa8kudcnn.fsf@gitster.mtv.corp.google.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
	<xmqqtwj2di3r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:07:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7Cw-0002Uo-2J
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbcDORG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 13:06:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752956AbcDORG4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 13:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD5C13E5B;
	Fri, 15 Apr 2016 13:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8Q57gJX3KScI
	Z9uzvnjkkRGqa44=; b=pzTJ1KrtvzRZxeZmWSVlogsT0AzRL1Sqa8SPQZ+YoEb7
	MK9SAR9k7xcyp7NHMuRmHJ4I/bR3t9vUSADu20cD4bdniOre57fUyV2ywTtixhQD
	DmNCS4OVrb6gHcL8UOq50fZnw9nNpLoQh24tzt0lHFSqbFnUVN5bynu5rlHC7bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZaKu78
	Jr/eYcLANlD8eu2nOU5ko+lRoBl88J8eYozVsUcGZfF2pevDvEZnz3Y+JIdB+lq/
	Jsm4W0Or7vjx7Xd+l/BdwcdL+f3pZrYhsc6d5IheelpwPM5pAdhRWf8bisPOy2uZ
	vDNVh2CYhAYR3Oo3ypYMWwt4gPQfyj51GcJz0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1CA913E5A;
	Fri, 15 Apr 2016 13:06:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E5DE13E58;
	Fri, 15 Apr 2016 13:06:54 -0400 (EDT)
In-Reply-To: <xmqqtwj2di3r.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Apr 2016 08:09:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7419B47E-032C-11E6-96D7-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291621>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This keeps top dir a bit less crowded. And because these programs ar=
e
>> for testing purposes, it makes sense that they stay somewhere in t/
>
> But leaves many *.o files after "make clean".  Even "distclean" does
> not clean them.

Perhaps something like this as a preparatory patch, to protect us
from future breakages similar to this change.

-- >8 --
Subject: Makefile: clean *.o files we create

The part that removes object files in the 'clean' target predates
various Makefile macros that list object files we create, and
instead removes the objects with shell glob, perpetually requiring
updates whenever a new location that builds object files is added.

Simplify the target by removing $(OBJECTS), which is supposed to
have all the objects we create during the build.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fe0bf7d..69d32bf 100644
--- a/Makefile
+++ b/Makefile
@@ -2456,8 +2456,8 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs))=
)
=20
 clean: profile-clean coverage-clean
-	$(RM) *.o *.res refs/*.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*=
=2Eo
-	$(RM) xdiff/*.o vcs-svn/*.o ewah/*.o builtin/*.o
+	$(RM) *.res
+	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
