From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Add `log.decorate' configuration variable.
Date: Tue, 16 Feb 2010 23:59:46 -0800
Message-ID: <7vk4uc70nh.fsf_-_@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
 <7vljespt2l.fsf@alter.siamese.dyndns.org>
 <36ca99e91002162342v2f151962p4d8f85f06c32205f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:00:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhepL-0001TO-SX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934092Ab0BQH76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:59:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934078Ab0BQH76 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 02:59:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAC809A21A;
	Wed, 17 Feb 2010 02:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=o/6KitAAq1w3
	DbPqG42e+VFTieE=; b=x7JjyOY7l5F29b6SGxxqJQT1NA+oMgvcoGJITYYlF+3m
	E3vMmpKid+7T6/WJpKfCRTXrJgMVdwesH0vuompdORw7kRNPuM48CO2dtKMk4WeZ
	5n3iUbHnaPyZgFx+Qg5QQTsmN/Ov9Bp1nZAkd6gG1eIcDMneimXSZyj9zi6134o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JeeYJs
	CDnh7v4wLi2HI44rSJsVob5ThYuO8mY8itSPpjyM6VwJ2KWJiGC2rSgTYceMwU62
	itehX99AcPeCu0AZG7ejVxGKzx1qxQr8CEF9b5C4XaOeD5Awc3SyejJpG301E4lv
	2e+WZxdRXbOCQHVofwCr9PiiuupHwQgSp3BfU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 886779A219;
	Wed, 17 Feb 2010 02:59:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A078C9A218; Wed, 17 Feb
 2010 02:59:48 -0500 (EST)
In-Reply-To: <36ca99e91002162342v2f151962p4d8f85f06c32205f@mail.gmail.com>
 (Bert Wesarg's message of "Wed\, 17 Feb 2010 08\:42\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DCA3F7E-1B9A-11DF-A336-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140213>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>> +int git_config_bool_or_int(const char *name, const char *value, int=
 *is_bool)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int v =3D git_config_maybe_bool(name, value);
>> + =C2=A0 =C2=A0 =C2=A0 if (0 <=3D v)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return v;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_config_int(name, value);
>> =C2=A0}
> What happened with the is_bool parameter?

Good eyes.  That was why it was "Perhaps something like this" without a=
ny
serious commit message ;-).

How about this?

-- >8 --
Subject: git_config_maybe_bool()

Some configuration variables can take boolean values in addition to
enumeration specific to them.  Introduce git_config_maybe_bool() that
returns 0 or 1 if the given value is boolean, or -1 if not, so that
a parser for such a variable can check for boolean first and then
parse other kinds of values as a fallback.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h  |    1 +
 config.c |   21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..dd3be0a 100644
--- a/cache.h
+++ b/cache.h
@@ -924,6 +924,7 @@ extern int git_config_int(const char *, const char =
*);
 extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
+extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *=
);
 extern int git_config_pathname(const char **, const char *, const char=
 *);
 extern int git_config_set(const char *, const char *);
diff --git a/config.c b/config.c
index 6963fbe..64e41be 100644
--- a/config.c
+++ b/config.c
@@ -322,17 +322,30 @@ unsigned long git_config_ulong(const char *name, =
const char *value)
 	return ret;
 }
=20
-int git_config_bool_or_int(const char *name, const char *value, int *i=
s_bool)
+int git_config_maybe_bool(const char *name, const char *value)
 {
-	*is_bool =3D 1;
 	if (!value)
 		return 1;
 	if (!*value)
 		return 0;
-	if (!strcasecmp(value, "true") || !strcasecmp(value, "yes") || !strca=
secmp(value, "on"))
+	if (!strcasecmp(value, "true")
+	    || !strcasecmp(value, "yes")
+	    || !strcasecmp(value, "on"))
 		return 1;
-	if (!strcasecmp(value, "false") || !strcasecmp(value, "no") || !strca=
secmp(value, "off"))
+	if (!strcasecmp(value, "false")
+	    || !strcasecmp(value, "no")
+	    || !strcasecmp(value, "off"))
 		return 0;
+	return -1;
+}
+
+int git_config_bool_or_int(const char *name, const char *value, int *i=
s_bool)
+{
+	int v =3D git_config_maybe_bool(name, value);
+	if (0 <=3D v) {
+		*is_bool =3D 1;
+		return v;
+	}
 	*is_bool =3D 0;
 	return git_config_int(name, value);
 }
