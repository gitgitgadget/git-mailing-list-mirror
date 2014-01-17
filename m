From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Fri, 17 Jan 2014 11:57:27 -0800
Message-ID: <xmqqiotiwfdk.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:57:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FXr-0008VM-DB
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbaAQT5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:57:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbaAQT5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:57:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1038B62865;
	Fri, 17 Jan 2014 14:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPmdEQ2WNMqtUMNgAJQuoFsLouA=; b=RIufrp
	0aPHAagK+eG+OIBr5egIOuI7PYe90Q10C3oVZlQM8UJYmVmsXMpuEz6/eKNuTIDL
	xS9DCfulvOPDUVkcRNhwxeYNV9LWrDJAlDzhKW0OyzrhIkP9UZZs74xgb5Kq7y4j
	sWyDodypXxI37GOlKbGCghwlgKPlvcj/JRwto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mmlPuPTZ/CDIQ/7H38YZ8g82JAeNHdDC
	Eruix77ftgofdXcnXOuVu/1cmexrJVL77hauhwZDCeTCIFPxsJPKrkIOus7/Y9J3
	N+lQQXltJZMUGO899XLEC1wvj4R8fhFD/SFkO3OnAmUM7IBLgTSNX8nJYnR8LpOE
	8KxqcnLlzSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41E562864;
	Fri, 17 Jan 2014 14:57:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B8BA62862;
	Fri, 17 Jan 2014 14:57:29 -0500 (EST)
In-Reply-To: <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Jan 2014 11:17:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98597208-7FB1-11E3-999B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240619>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> diff --git a/pager.c b/pager.c
>> index 90d237e..2303164 100644
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -87,6 +87,10 @@ void setup_pager(void)
>>  		argv_array_push(&env, "LESS=FRSX");
>>  	if (!getenv("LV"))
>>  		argv_array_push(&env, "LV=-c");
>> +#ifdef PAGER_MORE_UNDERSTANDS_R
>> +	if (!getenv("MORE"))
>> +		argv_array_push(&env, "MORE=R");
>> +#endif
>>  	pager_process.env = argv_array_detach(&env, NULL);
>>  
>>  	if (start_command(&pager_process))
>
> Let me repeat from $gmane/240110:
>
>  - Can we generalize this a bit so that a builder can pass a list
>    of var=val pairs and demote the existing LESS=FRSX to just a
>    canned setting of such a mechanism?
>
> As we need to maintain this "set these environments when unset" here
> and also in git-sh-setup.sh, I think it is about time to do that
> clean-up.  Duplicating two settings was borderline OK, but seeing
> the third added fairly soon after the second was added tells me that
> the clean-up must come before adding the third.

Perhaps we can start it like this.  Then pager.c can iterate over
the PAGER_ENV string, parse out LESS=, LV=, etc., and do its thing.

We would also need to muck with git-sh-setup.sh but that file is
already preprocessed in the Makefile, so we should be able to do
something similar to "# @@BROKEN_PATH_FIX@@" there.

 Makefile         | 15 ++++++++++++++-
 config.mak.uname |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b4af1e2..c9e7847 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,14 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define PAGER_ENV to a SP separated VAR=VAL pairs to define
+# default environment variables to be passed when a pager is spawned, e.g.
+#
+#    PAGER_ENV = LESS=-FRSX LV=-c
+#
+# to say "export LESS=-FRSX (and LV=-c) if the environment variable
+# LESS (and LV) is not set, respectively".
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1506,6 +1514,10 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON = NoThanks
 endif
 
+ifndef PAGER_ENV
+PAGER_ENV = LESS=-FRSX LV=-c
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -1585,11 +1597,12 @@ PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 
 LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
+	$(COMPAT_CFLAGS) -DPAGER_ENV='$(PAGER_ENV_SQ)'
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
diff --git a/config.mak.uname b/config.mak.uname
index 7d31fad..8aea8a6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -188,6 +188,7 @@ ifeq ($(uname_S),FreeBSD)
 	endif
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
+	PAGER_ENV = LESS=-FRSX LV=-c MORE=-R
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
