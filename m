From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Avoid TAGS/tags warning from GNU Make
Date: Sat, 04 Sep 2010 09:14:38 -0700
Message-ID: <7v8w3hxz81.fsf@alter.siamese.dyndns.org>
References: <20100904090331.GA10903@burratino>
 <vpqeid97sn6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Fredrik Kuivinen <frekui@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Sep 04 18:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvOO-0000AU-Ri
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab0IDQO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:14:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab0IDQOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:14:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F7BD3468;
	Sat,  4 Sep 2010 12:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOcXWRuiRUPC6p/MtsnTJfuEL1A=; b=IRXd5g
	y53XHV0uit7pHyACCpUY3xfTMqMPsJqY+KZ9vaaPuOq5QO5EKNp8hJ+5M59RYiDD
	c17Zn4/1egadwTC3Chllhwfz90xE/QxuQCfn/sOIDiFczkBing1ovvDCY4UjzxrZ
	1BGVnYMedHChBite0xkNCCG/4TsKfD2AfXtb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kvF2xIStD7iMnBLua2tMR6llxoqYUHK2
	yomk0VTwwcJmgyHF8VznWNBw5m38ilsMkuv2uox9iQ0dBiiBHK7n1lrBFBrAJB6T
	2cr8qxHZL2dv7RE3B0xTsOTSng6+WY+DvveOxNQC250xWiidbdMBVfwFnzRjXAkd
	temPNWeCphg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF59D3467;
	Sat,  4 Sep 2010 12:14:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E724ED3466; Sat,  4 Sep
 2010 12:14:39 -0400 (EDT)
In-Reply-To: <vpqeid97sn6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 04 Sep 2010 11\:41\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8901A9C0-B83F-11DF-BD4D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155337>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date: Thu, 22 Oct 2009 19:04:17 +0200
>>
>> MinGW make considers the TAGS and tags targets to refer to
>> the same file:
>>
>>  Makefile: warning: overriding commands for target `TAGS'
>>  Makefile: warning: ignoring old commands for target `TAGS'
>>
>> Suppress both targets on that platform.
>
> Wouldn't it be more sensible to rename them (like ETAGS/CTAGS) on
> mingw instead, in case someone wants to use these files on windows?

I think that makes much more sense.  How about doing it that way, perhaps
something like this?

By the way, doesn't case insensitive HFS+ have the same issue?

-- >8 --
[Subject] MinGW: avoid collisions between "tags" and "TAGS"

On case insensitive filesystems, "tags" and "TAGS" target will try to
overwrite the same file.  Allow MinGW to use "ETAGS" instead.

These two targets do produce real files; do not put them on .PHONY target
list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Makefile |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8b7c243..d87efdd 100644
--- a/Makefile
+++ b/Makefile
@@ -390,6 +390,8 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
+ETAGS_TARGET = TAGS
+
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -1120,6 +1122,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	ETAGS_TARGET = ETAGS
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1954,9 +1957,9 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
 
-TAGS:
-	$(RM) TAGS
-	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
+$(ETAGS_TARGET):
+	$(RM) $(ETAGS_TARGET)
+	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
 
 tags:
 	$(RM) tags
@@ -2228,7 +2231,7 @@ clean:
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
 	$(RM) -r $(dep_dirs)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
@@ -2252,7 +2255,7 @@ endif
 
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE TAGS tags cscope
+.PHONY: FORCE cscope
 
 ### Check documentation
 #
