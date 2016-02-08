From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid interpreting too-long parameter as file name
Date: Mon, 08 Feb 2016 12:46:51 -0800
Message-ID: <xmqq4mdj7ww4.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1602071317330.2964@virtualbox>
	<1454908588-22475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ole@tange.dk, Johannes.Schindelin@gmx.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:47:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsiL-0007nt-P3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbcBHUrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 15:47:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756045AbcBHUqy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 15:46:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9A7D42784;
	Mon,  8 Feb 2016 15:46:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JuyocxSYOPMk
	uH1um9giWXJWIVQ=; b=BJ4LPQbOiWKeom0OCdGc3Kly1xL3NgkYrA7xBmzfsiFg
	eLIB/Efq4ipTVzjH4csSXI2n549rZq5lsRGSfIyUjM4er6748AX4gnWG7oSE7rXg
	CuzdW9IckdxvtnqwiagQ53LHz7n+gIRP/eBRMg9Lia9mtKrnvy53aJv2c00gIYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OXkBdZ
	LavHwPg7TF8wFPJNabAXFwCxCTH2XruSDHBKZ2HS2aevHihoT8Xm6Rlf3EPx4Ciy
	d7N0mDZqICdQ8q1kARqENg9hArjl0Zj5TDi/po0feEindrnaNVdfbWPJKpomKpFq
	LXKkdoAMdjTBVg8WcUWT4QJ2/4xoHgfmbZt8I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FEEC42782;
	Mon,  8 Feb 2016 15:46:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 225F64277F;
	Mon,  8 Feb 2016 15:46:53 -0500 (EST)
In-Reply-To: <1454908588-22475-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 8 Feb
 2016 12:16:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1592C686-CEA5-11E5-A78A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285803>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Even if it is easier to write HEAD~2000, it is legal to write
> HEAD^^^... (repeats "^" 2000 times in total). However, such a string =
is
> too long to be a legal filename (and on Windows, by default even much=
,
> much shorter strings are still illegal because they exceed MAX_PATH).
>
> Therefore, if the check_filename() function encounters too long a
> command-line parameter, it should interpet the error code ENAMETOOLON=
G
> as a strong hint that this is not a file name instead of dying with a=
n
> error message.
>
> Noticed-by: Ole Tange <ole@tange.dk>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

While I think it is a good thing to try solving, i.e. it would be
nicer to the user if "git foo HEAD^^^^..." can be spelled without
needing a "--" disambiguation, I am not sure this patch solves it at
the right level.  The log message is unclear if the patch author
even thought about ramifications of the callers not involved in the
case written in it.

=46or example, verify_filename() calls this function, saying "This
string must name a file and otherwise I want you to die".

There is a direct call to check_filename() in builtin/checkout.c; it
is unclear how it would interact with this change, either.
