From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] sparse checkout: do not eagerly decide the fate for
 whole directory
Date: Mon, 09 May 2011 15:22:36 -0700
Message-ID: <7vei47o6oj.fsf@alter.siamese.dyndns.org>
References: <BANLkTikgNR1G5_TO3rmMZy3fN2PNF2Pqjg@mail.gmail.com>
 <1304955781-13566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thiago@cobalt.pobox.com,
	Farina@cobalt.pobox.com, tfransosi@gmail.com, skillzero@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYqw-00054L-3W
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1EIWWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 18:22:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab1EIWWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 18:22:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7C184945;
	Mon,  9 May 2011 18:24:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SDUddGJgqtqa
	uSlt2iIuto5zuKA=; b=a9QjQ2WeW7yosEPWvj1P2sAyKh6e70essGIt0ujOcm14
	oNH8zYcyq8ijl95am2306AK4AoMEFdFv6LJauFCjjMedqYOAxzHinxcJtFtGNCkL
	lWi7TfJlL9OzuKIVe41siTjtWwcUu6qNp1ZjuW7qxPoaeazFROsy0C1uyzR4DX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UZsq8M
	1WPASSP2VUOi7+Or7iYFSZvqA+Bmfbr96pDEL2dv6UvsYFH2SIpHMCqxYdmFJ0rq
	kIzgU3CY4Hfhieygm6ZNsY0uqbSgAE3M8L7ITT8MWvdzC0f9YdPLNDoxAWhw3stu
	PZqelOyRIiNutmNwKfK7UMpPTb8aei+Tfu57k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 748EE4944;
	Mon,  9 May 2011 18:24:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B4A214937; Mon,  9 May 2011
 18:24:43 -0400 (EDT)
In-Reply-To: <1304955781-13566-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 May
 2011 22:43:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2827A802-7A8B-11E0-83FB-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173276>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Sparse-setting code follows closely how files are excluded in
> read_directory(), every entry (including directories) are fed to
> excluded_from_list() to decide if the entry is suitable. Directories
> are treated no different than files. If a directory is matched (or
> not), the whole directory is considered matched (or not) and the
> process moves on.
>
> This generally works as long as there are no patterns to exclude part=
s
> of the directory. In case of sparse checkout code, the following patt=
erns
>
>   t
>   !t/t0000-basic.sh
>
> will produce a worktree with full directory "t" even if t0000-basic.s=
h
> is requested to stay out.

That roughly corresponds to having

	!t
        t/t0000-basic.sh

in gitignore mechanism, right?  Generally t/ is not to be excluded, but
only t0000-basic.sh should be.  Sounds like a right thing to do.

> Noticed-by: <skillzero@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Fix some comments as Thiago suggested. 1/3 of this series should be
>  dropped apparently.

I am not quite sure what to do with this patch though.

You marked this as 3/3 without saying anything about where 1 and 2 are =
(or
if they even exist).  You hint there is a 1 that should be dropped here=
=2E

Is this a re-rolled round, and if so where are the previous ones?  Coul=
d
you make things easier to find (just saying something like [PATCH v2 3/=
3]
in the Subject: is good enough) next time?
