From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] worktree lock/unlock
Date: Fri, 03 Jun 2016 22:14:37 -0700
Message-ID: <xmqqporxzgaq.fsf@gitster.mtv.corp.google.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
	<20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 07:14:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b93v4-0006Z4-0s
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 07:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbcFDFOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 01:14:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750758AbcFDFOl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2016 01:14:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D829221CEC;
	Sat,  4 Jun 2016 01:14:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MScmirtdmMfT
	rYAzYowmwbB6yB0=; b=mzYgcpAEWzwN7UCs0nyvUAqjqRmF4BiNC8xw783R6iq8
	L2kR1tYofqd254NrZ8JWRGMEJoFIScADgTCHX9IKdGTNGf6hgKqxITOudVYVLsG3
	srpv070rOX2yY2u7xCFzKlH96a6vG5aIRspfadSLXhVZ1amCMP8Z6BaOxp/KUrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MqfLhT
	FnMawX8B5dNHe4LY/BQh989RsAYMIt2ydJ1QHL2yqsGZhF3cHmOa0jGE6cR89l1r
	/cEpw7kixGUQo6lYH0tGGeapdXlQZh7kgDgR8PIuLQmfUDnT2YbjFX04PY44qE4X
	avzsRNl/YxzugRFAB2ZHG8Q+3aE4fpzEfgbt4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D100021CEA;
	Sat,  4 Jun 2016 01:14:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 566B421CE9;
	Sat,  4 Jun 2016 01:14:39 -0400 (EDT)
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 3 Jun 2016 19:19:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CC49D1E-2A13-11E6-9734-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296441>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v4
>
>  - fixes some documentation bugs in v3
>
>  - updates is_main_worktree commit message a bit
>
>  - brings back is_worktree_locked() as API with value lazily obtained
>    and cached in worktree->lock_reason and fixes a memory leak
>
>  - extends basename search to path suffix search. I moved this patch
>    to the bottom so that the relevant documentation part is included
>    in the patch (previously it was part of the "add lock command"
>    patch).
>
> This series is based on nd/worktree-cleanup-post-head-protection

Will replace the one in 'pu'.  A few things I noticed:

 * Documentation and messages talk about "working tree" and "working
   directory" when they refer to "worktree", which is not a normal
   "working tree".  I think this was done as an attempt to avoid
   being too precise and technical in phrasing, but I suspect that
   is a false reader-friendliness.  At least, "working directory" in
   messages should be "worktree", e.g.

	wt =3D find_worktree(...);
	if (!wt)
        	die("'%s' is not a working directory", av[0]);

   does not make much sense (imagine "git wt lock ." and being told
   that '.' is not a working directory).

 * You are probably trying to be frugal by not introducing a
   separate bit for is_lock_checked to struct worktre and instead
   using a sentinel value for lock_reason, but I think that is a
   false economy, after seeing that you have to cast away constness
   in number of places and having to be extra careful not to free
   that sentinel value.

Thanks.
