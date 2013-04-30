From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack_entry: invalidate newly added cache entry in case of error
Date: Tue, 30 Apr 2013 15:39:42 -0700
Message-ID: <7vfvy7abip.fsf@alter.siamese.dyndns.org>
References: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
	<87ppxcxw1i.fsf@linux-k42r.v.cablecom.net>
	<CACsJy8Bi6UpfA-0BCFY6H=BAKMmWYgwbf-94yJXEn5Zi4gwPCA@mail.gmail.com>
	<87d2tcw571.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 01 00:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJDC-0006aU-5z
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864Ab3D3Wjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 18:39:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933732Ab3D3Wjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 18:39:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD48A1A586;
	Tue, 30 Apr 2013 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6vRXBh63sgK8
	oFgEwyPznynXL2g=; b=Iop8ijGZuSSUjCrOzDLWXEBRudPdj61qmjr93XwII784
	AM+YgTDXN2c+y4IeSp7UabJskeRH5Zy4MpBGeTvx4PRwhqGhv9oOOxAZQvXyJtrq
	ldAduRnJTc/dtLM2cHihOka6gaFmyqCZgelwtuEhTC23mGObmCiJ0E06HEHBHTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gk4gLY
	L0qADHXYnRRbF+5cAA01Ci4vrvBFgQo07oJOC8I6EDd2TYANHovjBQH1X7E+keqm
	AQFlSm5Kme99BgfI0xN5l6905LKC6vmncRR6kEyYq1dZrHDMXbJKxssOBJg16A9f
	HsOc4aspltq/zR6uNqJ+zFLcSXAxgZahIRhY0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07BE1A585;
	Tue, 30 Apr 2013 22:39:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155441A57F;
	Tue, 30 Apr 2013 22:39:43 +0000 (UTC)
In-Reply-To: <87d2tcw571.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 30 Apr 2013 14:53:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA803138-B1E6-11E2-B49B-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223034>

Thomas Rast <trast@inf.ethz.ch> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Apply this patch on top of master (no need to apply full series) and=
 run t5303
>>
>> http://article.gmane.org/gmane.comp.version-control.git/222895
> [...]
>> OK since you know this code much better than me, I withdraw my patch
>> (consider it a bug report) and let you work on a proper fix. I see y=
ou
>> already have the commit message ready :) Happy to test it for you if
>> the above instruction is still not reproducible for you.
>
> Ok.  So I really think just dropping the free() is the way to go.  Ca=
n
> you test this?  Your series didn't apply cleanly on anything I had
> locally, and 'am -3' doesn't work.  A simpler reproducer, and using
> valgrind to detect the use-after-free, didn't get me anywhere either.
>
> -- >8 --
> Subject: [PATCH] unpack_entry: avoid freeing objects in base cache
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

I see you used "git-pu format-patch --inline-single" here, and the
above is the reason why it is marked as "not ready for public
consumption" ;-).

> In the !delta_data error path of unpack_entry(), we run free(base).
> This became a window for use-after-free() in abe601b (sha1_file:
> remove recursion in unpack_entry, 2013-03-27), as follows:
>
> Before abe601b, we got the 'base' from cache_or_unpack_entry(..., 0);
> keep_cache=3D0 tells it to also remove that entry.  So the 'base' is =
at
> this point not cached, and freeing it in the error path is the right
> thing.
>
> After abe601b, the structure changed: we use a three-phase approach
> where phase 1 finds the innermost base or a base that is already in
> the cache.  In phase 3 we therefore know that all bases we unpack are
> not part of the delta cache yet.  (Observe that we pop from the cache
> in phase 1, so this is also true for the very first base.)  So we mak=
e
> no further attempts to look up the bases in the cache, and just call
> add_delta_base_cache() on every base object we have assembled.
>
> But the !delta_data error path remained unchanged, and now calls
> free() on a base that has already been entered in the cache.  This
> means that there is a use-after-free if we later use the same base
> again.
>
> So remove that free().

I wish I saw "We are still going to use it, and it will be freed
after we are done" or something like that after this sentence.

But other than that, I think the logic is correct.

> Reported-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  sha1_file.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 64228a2..67e815b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2128,7 +2128,6 @@ void *unpack_entry(struct packed_git *p, off_t =
obj_offset,
>  			error("failed to unpack compressed delta "
>  			      "at offset %"PRIuMAX" from %s",
>  			      (uintmax_t)curpos, p->pack_name);
> -			free(base);
>  			data =3D NULL;
>  			continue;
>  		}
