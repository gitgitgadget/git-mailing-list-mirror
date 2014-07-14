From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/31] Support multiple checkouts
Date: Sun, 13 Jul 2014 21:45:42 -0700
Message-ID: <xmqqvbr0zgy1.fsf@gitster.dls.corp.google.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
	<1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 06:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Y9B-0002Uo-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 06:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbaGNEpv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 00:45:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51484 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbaGNEpt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2014 00:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD42722446;
	Mon, 14 Jul 2014 00:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=flc1IaU7D+g5
	YxZmEhFEkx8e22g=; b=sdlxM4XcOzYBoULvFtg1Qm75/lSceYnmr6HcTm5A4RaG
	eqDFiFEa6iQUlIvlHQBGSg+yThvNr4GRYt+5gMKk+x3KDz/hjLCFCaOOjoavst8p
	KA9gTKjNzskjTMLza1Jcc4HxVMXFkdBh5iNQGoKODVHdxPJFng/GslLIRbK0ZSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NagtCE
	1X09EqnGHT2JupLl1481AzQHHw9c8rlxTTVe5qka/BM1gbHYAjWz25Ho6N1n2eeP
	gqpkOPzQ5qePSrB79uCNGZZdorNweZZCHCWzdBzW92uaMB0VKWPuTBb+F1JCCSMx
	KDqQ8EUeK/I6/55qBrytcJL4n6O2kXa4ZvA68=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D410D22445;
	Mon, 14 Jul 2014 00:45:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6F45A22443;
	Mon, 14 Jul 2014 00:45:26 -0400 (EDT)
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13
 Jul 2014 11:50:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC847408-0B11-11E4-9D88-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253469>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
> ...
> -	while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r')
> +	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\=
r'))
>  		len--;

Do we anticipate (or even allow/endorse) that end users will edit
this file with a random editor?  And, to a lessor degree, the same
question on the reading side.  Do we encourage users to directly
read from this file to learn something about their repository?

If we are the only tool that writes into this file, and if we are
the only tool to be used to read (and use) the contents of this
file, I do not see the need to cater to LF vs CRLF line endings.
