From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: restrict pathspec limitations to diff b/f case only
Date: Wed, 20 Nov 2013 14:43:58 -0800
Message-ID: <xmqqvbzm66dt.fsf@gitster.dls.corp.google.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 23:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjGVJ-0004Vl-QX
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab3KTWoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Nov 2013 17:44:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab3KTWoH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Nov 2013 17:44:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F8A454370;
	Wed, 20 Nov 2013 17:44:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=LtnDL1Y27yxjvOWOHEJ/q29oM
	JQ=; b=VMqC3mpmr/gVuCPKDwijJWOjxKV0QMRuu93oLqHlWpoDipK+C4Fzes46S
	wlYbBPqMN63V7KHbPOWfe/PYMMQxMzuj9stVes5+857JZYAtBSARCada3AqnHUUs
	5hM7x4fU4zo5FJn4l2GM+2UVhxhlCdx9+a7tw1ssDkSX/wPu38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=OIKwvxaEHIwInflzBgS
	2CeEFEDbyoa0IcEDB1LUS++f9TtBemYbOomUp9jhvnwkN2147XGYJCR+3E4yo//m
	0KMdU4caBakhFC0jaKOB1aKyOp5PW1Byt/188p+h4xKwpVvHS3cu008JUMfldnLV
	x9GunP/G1VUb+uvsRWu7sE2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECCB45436F;
	Wed, 20 Nov 2013 17:44:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1A2154368;
	Wed, 20 Nov 2013 17:44:00 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FB365F4-5235-11E3-B90C-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238104>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> builtin_diff_b_f() needs a path, not pathspec. Other modes in diff
> can deal with pathspec just fine. But because of the current
> GUARD_PATHSPEC() location, other modes also reject :(glob) and
> :(icase).
>
> Move GUARD_PATHSPEC(), and the "path" assignment statement, which is
> the reason of this GUARD_PATHSPEC(), inside builtin_diff_b_f().
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Makes sense.

Let me squash this in.


diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 8d4a7fc..a7c7ff5 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -100,4 +100,10 @@ test_expect_success 'match_pathspec_depth matches =
:(icase)bar with empty prefix'
 	test_cmp expect actual
 '
=20
+test_expect_success '"git diff" can take magic :(icase) pathspec' '
+	echo FOO/BAR >expect &&
+	git diff --name-only HEAD^ HEAD -- ":(icase)foo/bar" >actual &&
+	test_cmp expect actual
+'
+
 test_done

Thanks.
