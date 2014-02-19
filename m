From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Wed, 19 Feb 2014 12:19:41 -0800
Message-ID: <xmqqlhx697oi.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDcY-0000Ol-PR
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbaBSUTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:19:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbaBSUTt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:19:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649F86D609;
	Wed, 19 Feb 2014 15:19:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sZ4gkmV2Mevc
	cnGigCuL7P9z0Ew=; b=w/tG0qnP9MAnMrNrTaOvmcTFXSdKNEVSpkcfTapuwHOh
	vus8Cyv0cdcTv78I3JvuDX18EpJ8pgMF3slipOK5pVxqiFxq8hZhirugZADEBVLh
	a0H0qsKrbO0YgNsbS9o2yjyTMA13oGUf/xZeWmX0v8mVVKrYX73izjiKzbHkEZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EEsK3x
	k5NlZfRmMLIYYcFO1vNDLExo3aUPc8ab/KxAwRtsPb+p96ZkxmqDdJmI6yYZenU0
	HCQ5+va69gRRuCx8LLPp/wfienGXKGHNjtmrbD7OEhGpVu94duFf5hG0APIKvKPn
	exeTYaWluH3PSXvwdb+dke1HA3ykjEGFnkVc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A7D6D605;
	Wed, 19 Feb 2014 15:19:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 175C56D5FC;
	Wed, 19 Feb 2014 15:19:44 -0500 (EST)
In-Reply-To: <1392730814-19656-19-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B93395E-99A3-11E3-88C8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242404>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

(Only nitpicks during this round of review).

> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 8f36aa9..d8bdaf4 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -346,4 +346,80 @@ test_expect_success 'relative $GIT_WORK_TREE and=
 git subprocesses' '
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success 'Multi-worktree setup' '
> +	mkdir work &&
> +	mkdir -p repo.git/repos/foo &&
> +	cp repo.git/HEAD repo.git/index repo.git/repos/foo &&
> +	unset GIT_DIR GIT_CONFIG GIT_WORK_TREE

Are these known to be set always when we get to this point?
Otherwise please use sane_unset.
