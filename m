From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: do not switch branch during a rebase unless -f
 is given
Date: Mon, 27 Sep 2010 22:38:11 -0700
Message-ID: <7vfwwuv35o.fsf@alter.siamese.dyndns.org>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 07:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0StU-0007wu-1f
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 07:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab0I1FiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 01:38:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0I1FiS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 01:38:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03EA7D9BFA;
	Tue, 28 Sep 2010 01:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lfiqhuUZtn66
	TzyoKVlloTWHfNY=; b=VzKtoSJR45s+MiHiR2apLX3NXOEk/hp674BDSS9tVdP8
	H9sYe5yTVHnSZXlXFrrfwN4M4x+yh1PzH8ltWhpvweVOFEVkDvav5cCOwjWfavdw
	eXSGwy0mBDRFq1k+x1+AcnKAObMY3PCprAUDSNVH5zv/lYqJbJyeJ4LQLunYgTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZVFzSk
	CFvyssEjIko6IG0BUxIuTpf4R9pYCxrzvCaFm4CeBzzvFGnZzzObL1RHCeDPCcxO
	4meFWle19KgdYRCIZQbLjyH9EiO/DyT9s+Ch7phIBqI8Sa0x68SVMKpZ+k2EoQfv
	K9oE3fr7H5HLDIx8DjH8yI2elA5zhWxMa7xpE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5957D9BF9;
	Tue, 28 Sep 2010 01:38:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B48CD9BF6; Tue, 28 Sep
 2010 01:38:12 -0400 (EDT)
In-Reply-To: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue\, 28 Sep
 2010 14\:52\:44 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 977DAD88-CAC2-11DF-88F1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157389>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> It does not make much sense to switch branch when you are in a middle
> of a rebase. Sometimes you might want to switch away for a moment the=
n
> back with "git checkout - ". But I find myself so many times switchin=
g
> away then forget that I was rebasing something.
>
> Avoid doing that by default. Users can use -f if they really want to.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

I think you need to retitle the patch.

You should realize that overloading "-f" and conflating its totally
different meaning, which is to discard local changes, with this new usa=
ge
to say "override the 'you are in rebase' switch" closes the door to fut=
ure
improvements we could make to rebase so that it does not to require a
totally clean working tree.  It would be Ok with today's rebase, as you
wouldn't have local changes when it runs, but we might regret this 9
months down the road.

>  I know there are other commands like rebase ("git am" comes to mind)
>  but I don't use those. Feel free to put some more on top if somebody
>  finds it a good thing to do.

If you envision something similar to be used during "git am", then you
really shouldn't be reusing "-f", as "git am" is designed to be usable =
in
a dirty working tree.
