From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] gitignore: do not do basename match with patterns
 that have '**'
Date: Thu, 04 Oct 2012 10:59:49 -0700
Message-ID: <7vsj9uyv6y.fsf@alter.siamese.dyndns.org>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
 <1349336392-1772-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtew-00033L-0q
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab2JDR7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 13:59:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455Ab2JDR7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 13:59:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB2482DF;
	Thu,  4 Oct 2012 13:59:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sqV4UNrY29ov
	WRoOFysjsMF3eW8=; b=dtTPKJDsXA09kqnjVZWLPLnq+b0F09XB4TdnlDW+Ca1v
	RpsVN1Sk6TvbRrf6ygFFYSvT5lgcq1yT9q05vPULq8+A2SzKE+jUyWAR/+ZfpTtm
	AT2MV6DmEVBPqpK3ThBlVZ851HPqenOHDQcBP0GircgQr30kFg/lVBY5CLhE3AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=naDYWS
	MwHW4GW0s5iK2WINkypWmrLvWmYH0T0hbk56b2SUbMjonahFcdecUN4QGLkNUBrH
	GJLL7c2Kbv0LQ2t16eFfIvToskz3DvRW8GBJhq/WZsnk8tYip3871tv2C6RKYLUk
	2GbENH9tp0n2FgVKvIA9kQl6bfNClf1QK4/B0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0ED382DB;
	Thu,  4 Oct 2012 13:59:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66DE782D9; Thu,  4 Oct 2012
 13:59:50 -0400 (EDT)
In-Reply-To: <1349336392-1772-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Oct
 2012 14:39:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC5D986-0E4D-11E2-9C46-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207034>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> -		if (!strchr(p, '/'))
> +		if (!strchr(p, '/') && !strstr(p, "**"))

Doesn't wildmatch allow these to be quoted, similar to the way usual
glob works, e.g.

	$ >ff
        $ >\?f
        $ echo ??
        ?f ff
        $ echo \?f
        ?f

Even If wildmatch out-of-the-box doesn't, I would assume that we
would want to fix it so that it does.  And if that is the case,
we would want to be careful about "two/asterisks\**in path" to
avoid triggering this logic, no?
