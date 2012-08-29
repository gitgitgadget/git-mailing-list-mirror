From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] checkout: reorder option handling
Date: Wed, 29 Aug 2012 11:55:38 -0700
Message-ID: <7v3935wms5.fsf@alter.siamese.dyndns.org>
References: <CACsJy8Cjbg2tb_E+D7hMwPZNFWhvEF1eNpf5HUBzJnBoQQaMAg@mail.gmail.com>
 <1346248524-11616-1-git-send-email-pclouds@gmail.com>
 <1346248524-11616-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 20:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6nQa-0004yp-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 20:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366Ab2H2Szm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 14:55:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab2H2Szl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 14:55:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B4ED83D7;
	Wed, 29 Aug 2012 14:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jJ6YIopcqCpA
	er+Z5nD7YPP/50s=; b=LAc+b41UeaitabZmhbLwPSSXEKGaDpDNvBsk9qtjJ1EJ
	aSJXRTYln+p5vYT7GVEFSs9SQVewhLeGA3Zg1sONf78dlLYAtXN/hhmGpiJRET8u
	eKqdFfmaqL68LAFwMgEDjNgoa+QoeWmhYJ0OQTYnD21Ei9npD9BEUOzIMAHInkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dlv487
	MUTatY1yslhg9Pg7+kfl8VqKgAHLwdCQY5UaqTGDXm/SQaWxoqTNSiii53I3KFP8
	PAt2DKh0uvmYF5YsFEw4EIWBDMuPPQ8NDljLppCS0ApegBFUNmXyrnj0t/JDI3E8
	tk0+tuJ/Gqgi1mjH1UMP+y2mqH8pwtcaEYylI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69CE883D5;
	Wed, 29 Aug 2012 14:55:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1288083D1; Wed, 29 Aug 2012
 14:55:39 -0400 (EDT)
In-Reply-To: <1346248524-11616-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 29 Aug
 2012 20:55:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2073B08A-F20B-11E1-9556-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204493>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	if (opts.patch_mode || opts.pathspec)
> +		return cmd_checkout_entry(&opts, &new);
> +	else
> +		return cmd_switch(&opts, &new);
>  }

Yeah, patch_mode is really part of checking out paths, so separating
the actions into two makes sense.

Even though I am not sure about "cmd_" prefix (as these are not
commands), I'll rename the former "cmd_checkout_paths" to be
consistent with the underlying checkout_paths() function, and the.
latter "cmd_checkout_branch" for consistency with the former (you
either check out one-or-more paths, or check out a branch).
