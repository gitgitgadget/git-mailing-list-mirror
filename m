From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] pathspec: add tree_recursive_diff parameter
Date: Mon, 27 Sep 2010 15:20:07 -0700
Message-ID: <7vocbivnfs.fsf@alter.siamese.dyndns.org>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
 <1284939000-16907-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M3b-0006jY-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760252Ab0I0WUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 18:20:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0I0WUO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:20:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB109DA382;
	Mon, 27 Sep 2010 18:20:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=9Yy3+aGa9/LrDyMfLHs+W6oIG
	8c=; b=YItN2tlRxZiPsxZoaSakSW9JgJwsCNqKfiYsVadgqgVGdUfEPVEixll2U
	o1tadlUe5X/VP2S8558dUrthoOPTRk5iSVH2r/UugaE+FLJFHgvFuoxNTY2iSfgw
	hKjkmGZrMCCZqnV3912i0RAXOVNlzbcBZNosDJRVaPJD0DLcqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fqGbM0Q8GaTSjaE9UOk
	DPMt/yZ/DapIZKZTIVexfP1/xRTjYdpZOw4PdTH5A4y5zKCmYdRfzIqFVTUBtI7q
	fLXRoqy48uysvF7e0+2noEIlR04zvbchlRzsTM5oBLXLNo+3HTxImBKchryjtWsa
	C3yDxrpbDZFguFKducVASkDo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B50BDDA381;
	Mon, 27 Sep 2010 18:20:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18E7EDA37F; Mon, 27 Sep
 2010 18:20:08 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64ED6562-CA85-11DF-884E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157374>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When wildcard match is implemented, a full path is needed to do final
> match. What type of diff_tree is performed determines how to treat
> directories:
>
>  - If it's recursive diff, directories are just an intermediate step.
>    All path must end with a file name. Thus, directories will be
>    unconditionally matched.

Hmm, I am not sure what you mean by this.  If the pathspec says a/b*/c,
you are in "a" and are deciding if you should descend to its subdirecto=
ry,
then you would surely want to be able to say:

 (1) Ah, the subdirectory I am looking at is "bar" and it does match "b=
*".
     It might contain "c"; I should descend into it.

 (2) Nope, the subdirectory I am looking at is "frotz" and it can never
     match "b*", so there is no point recursing into it.
