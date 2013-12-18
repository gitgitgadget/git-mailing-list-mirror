From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/12] Make starts_with() a wrapper of skip_prefix()
Date: Wed, 18 Dec 2013 10:16:17 -0800
Message-ID: <xmqqppouhvny.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
	<1387378437-20646-2-git-send-email-pclouds@gmail.com>
	<xmqqa9fyjbg0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 19:16:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLfX-0003iF-Fs
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 19:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab3LRSQW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 13:16:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab3LRSQW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 13:16:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E87CA5A3AA;
	Wed, 18 Dec 2013 13:16:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6b00osOaQW4l
	cCoQfuzKXFMFB3k=; b=C3BkKBHf8uZkq1GVd01+FDEq6nloQv98nRtcTr/y3OXm
	uxyuPfaME8f+bjVDVvDa5RO06E0Or+0QWf1CKw2sLW50SZElQ6a3inJfEO6P/sjZ
	pbJClZ3ePIauxYbW1r0ptL68bfg/F3esCrhOSSQN+Ge79sYuIDz0Ykh99EV04ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VuSsnp
	aSwWLUs1VrcJBDuD5pco5CeXhBanmdBCvUVjWbIEv+CFA6miQobAHtD9Ozbgk6np
	tSO1GPDsv/TwvIOs+rCvaIwGhZkFesHVlEYgtS5Pwqv52Q4BVPPb02/znjfMZw29
	/NwNvyDNzGmpD9IjmcvLDLJBlSNzDGR53ai9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D59505A3A9;
	Wed, 18 Dec 2013 13:16:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20F95A3A5;
	Wed, 18 Dec 2013 13:16:19 -0500 (EST)
In-Reply-To: <xmqqa9fyjbg0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Dec 2013 09:50:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E529B86-6810-11E3-9F8D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239466>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> starts_with() started out as a copy of prefixcmp(). But if we don't
>> care about the sorting order, the logic looks closer to
>> skip_prefix(). This looks like a good thing to do.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> Sure, but the implementation of skip_prefix() scans the prefix
> string twice, while prefixcmp() aka starts_with() does it only once.
>
> I'd expect a later step in this series would rectify this micro
> regression in the performance, though ;-)

=2E.. and I did not see one, but it would be trivial on top.

 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b72a80d..59265af 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -356,8 +356,11 @@ extern int suffixcmp(const char *str, const char *=
suffix);
=20
 static inline const char *skip_prefix_defval(const char *str, const ch=
ar *prefix, const char *defval)
 {
-	size_t len =3D strlen(prefix);
-	return strncmp(str, prefix, len) ? defval : str + len;
+	for ( ; ; str++, prefix++)
+		if (!*prefix)
+			return str;
+		else if (*str !=3D *prefix)
+			return defval;
 }
=20
 static inline const char *skip_prefix(const char *str, const char *pre=
fix)
