Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84F16ABC3
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333561; cv=none; b=tga3tVBcFgoaEXvfwpspE37Ros+FkC85Dn4kd+Bfd+DC9StXIrQWzz/vACBO1MS+vJX0fm11O7GrACBtnlMeqm6+Lib8qq/SLABPA/qFLM5c9VYVwKSyYy2eU99dTPiAEhUNZQG32b9toLj8G515nyBHANxUJm63oub/hc30gbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333561; c=relaxed/simple;
	bh=+eiL50IVdZBqoyJbsna0SiHAPTQUIb59VV/fUI27xdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npGJib5CWntVsER3DmVZXfha8SXXhrcjvKHHbyhSs5XIQco5SSlhP9dBZwCV763JKm9j1K6qV+QENBvGn0XjL9swfi8GE0AyEnrR9aXSR2gp24ZMvtcYVK7IO1wpZLm+ZNqBG118DErNMljwYQnHHkr5Jg00Nuru2K/mIdUCRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P+nP22am; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P+nP22am"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A19E12111B;
	Fri,  5 Apr 2024 12:12:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+eiL50IVdZBqoyJbsna0SiHAPTQUIb59VV/fUI
	27xdw=; b=P+nP22amLTAt2t+X+3+FwE7G3JmUJ+8DDgaQt3B64VbcNGLYXdjyII
	AdJwSp4Ys7EOrC86kEk2Sl4vph2gf/2x2JyU37RyBoyJPVcWlPFT28rILGsA5Q5v
	xtWU3sQa3KpkhRbmsf2SKQPZDVKQIhcBdixJR2gB3S8NH7Xi695Tk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 995482111A;
	Fri,  5 Apr 2024 12:12:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A66721119;
	Fri,  5 Apr 2024 12:12:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>,
    =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
In-Reply-To: <xmqqmsq7yezc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	05 Apr 2024 09:02:47 -0700")
References: <cover.1712235356.git.ps@pks.im>
	<c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
	<xmqqmsq7yezc.fsf@gitster.g>
Date: Fri, 05 Apr 2024 09:12:34 -0700
Message-ID: <xmqqbk6nyej1.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5100A00E-F367-11EE-91FC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
lets the shell erroneously perform field splitting on the expansion
of a command substitution during declaration of a local or an extern
variable.

The explanation was stolen from ebee5580 (parallel-checkout: avoid
dash local bug in tests, 2021-06-06).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The coding guidelines now forbids use of local/export var=$val
   without having $val quoted inside a pair of double quotes to
   avoid portability bugs.

> Isn't this the same as what ebee5580 (parallel-checkout: avoid dash
> local bug in tests, 2021-06-06) fixed?

 Documentation/CodingGuidelines | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git i/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index 32e69f798e..8aa76094ca 100644
--- i/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -188,6 +188,20 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
 
+ - Some versions of dash has broken variable assignment when prefixed
+   with "local", "export", and "readonly", in that the value to be
+   assigned goes through field splitting at $IFS unless quoted.  
+
+   DO NOT write:
+
+     local variable=$value           ;# wrong
+     export variable=$(command args) ;# wrong
+
+   and instead write:
+
+     local variable="$value"
+     export variable="$(command args)"
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.
