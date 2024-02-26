Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD91292FF
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977877; cv=none; b=RUHcebkQHZRq9wKjmynQyOMSH4ECZlmtoQAMHKqd12T8Hoby2OF6cLSGWnmkyDZIQBQmjGlJzXKcXrz+qNkzR8qXDO25x7oWiIdMaZxXTegDyoqWh3W2Bzw4eBU/qjeixIi1BeHQ5FyKR61id8cT0sHaOM0dyB7H7tg1th156zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977877; c=relaxed/simple;
	bh=4xQQT/yuD67N+IOYFcf4OAfBmen3lEQ3ZXL9Tb+YQxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqRforjPRRkTbJrKGOZc0TCoQH2ZjZonWPkNg7zUG/kRBa8iwnowUu6rCR6ggPxfFsiu9whlDgchGGFLGJcUrVh1MC0+jKu/Y6QGRhSEyauJwuxZvk/OxaA8bL9lS7ork9vZ446Hi0yRoZz80bo9/R5itidHIccc1wJ9HE40ZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eLr8X955; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eLr8X955"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708977868; x=1709582668; i=l.s.r@web.de;
	bh=4xQQT/yuD67N+IOYFcf4OAfBmen3lEQ3ZXL9Tb+YQxc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=eLr8X9551i9oig6M5mXYr7/GljPl6MFkqkub+9849QQN9wcmUQjDCwF6hibkKtjH
	 FWoBo28O3/TSpXNkwji0dWhbM6yAPqWyeqXCcnXgkbpUsZd7s8ShhYqASVsBzBb6c
	 SOiptJSsHSvVXCEjb3h2M62tLUy1L3qNSb7d4N/001uhEJvp5jc4vkOgntPgve8Ra
	 EcMrk8xAzRGyKGlOKbv4FXg9VopfgPm0MItA7w+4m6ZxSq0+CIFe1yM6jSJ7eiltr
	 ZUxG6W4/ItNpN4U8+qQAtoC9QzYtS0fY19A7kZDlsAjeAhJe7y7OSDmmvKfrwWrsk
	 0AB5IOU+uvYoPAXX5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vNQ-1qvLxv3QAe-010hQK; Mon, 26
 Feb 2024 21:04:27 +0100
Message-ID: <08db9346-d10d-4b32-ae55-3ee5a8adf89d@web.de>
Date: Mon, 26 Feb 2024 21:04:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fetch: convert strncmp() with strlen() to starts_with()
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>
 <xmqqfrxhjujr.fsf@gitster.g> <xmqq1q8zduas.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1q8zduas.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sE592pcM1XtYzJbdRoDaI760S6ftpg3m8XxWH0RWlCB/iFm9gkV
 hcGbpAAVBa5+qbQplW9nexPAXQWBUhkYzOoFdERx0Wc4LlYhXPxyFsbCWbAuXE+G5OMEoDA
 0UEXZpBTEdvIFvfQXN0CBrp2Y79Yt8DWARnIAH90Og9/8hb40+VscUrQam4IY2FsmqHOqF1
 njOzPym4vtJ8uOGLMSGyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KDgGmsTp1gM=;2o4y+I9tQj2YywBaadtgp1K8tAM
 9Ce9SNLXkxJtmeeQngxesc6s50o5gDwLgRnLeF0mJ1C0GYJY0FHFfLWL3k8OWtzePTEHRepr8
 1YYo/6AvOCFZyhqMcj6JMPhG4EVDmmpCM+wl1qgzOaMs+SfhLvVroquYu0yRfs4RdhS0p1IZB
 4ZgJyYp5M2gYcHWlDVpPFR5chwCaNEnaRQ5jLFMPaLAGxGc6jQoDyxEmS8zOMfbZ0sCecSk0a
 1b8QieCaO4bLk/yhSVbuuLg7TjIe8UWOewj25eNckXEJG4Ac5zqNTqR7Z+/j5ODGvQa7oqYkH
 +nMPKvv9zum44WVFKYSJ12NuaILyF1VHy678KqqLG1W5xlBHgRCHoK4k23Oxsxpp5TzlrJ543
 Ewq++gWrKMR1BDuX35NvRlmEY9rjS42+Tg1GaD7U5OdvCaOW+wfNX2fQDU/RHwEn+kQn5boVS
 8FZfaiMWIAkCmyBcxKFxzMtzU8MhjkxRv0vgW0IEcVsw/ljiwh2EnR43MM4wcEkbDqec1HEeo
 UinwBmngKda/yWvSy2zzctruMOksDgFU0PqUVfH1vipYpkQW36pDcO/mbsxARm25gBilMNQRD
 pnGtiaQssRgD7h28KdJa5gHoeTxJ1oG8gBC93UJC1wSY+dUjfkNdtj2jw8s8lKfqPiW3Imt06
 ROc/+YfzdRubh4rnlzyIUi2Hcr2RF/jG0C3muAcosPxtQ9WkUoVx3z2IeoQEs6MBnQdTeMVIv
 p1Ry6CIRnK5Lah8J6yJdXE+b2v6Emxe2tQy77BFMWbqiGvXqeQfM0R71v74qp/UxmKzaeeFMq
 hbr84vH7598DDj/Set13bZh5U+f0OOFvqRkUixPkcNqxg=

Am 26.02.24 um 18:11 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> -		     !strncmp(rs->items[i].src,
>>> -			      ref_namespace[NAMESPACE_TAGS].ref,
>>> -			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
>>> +		     starts_with(rs->items[i].src,
>>> +				 ref_namespace[NAMESPACE_TAGS].ref))) {
>>
>> The original tries to check that "namespace" fully matches the
>> initial part of .src string, which is exactly what starts_with()
>> does.  Makes sense.
>
> There are two more such instances in the codebase, easily found with
>
>         $ cat >contrib/coccinelle/starts_with.cocci <<\-EOF
>         @@
>         expression string, prefix;
>         @@
>         - !strncmp(string, prefix, strlen(prefix))
>         + starts_with(string, prefix)
>
>         @@
>         expression string, prefix;
>         @@
>         - strncmp(string, prefix, strlen(prefix))
>         + !starts_with(string, prefix)
>         EOF
>         $ make contrib/coccinelle/starts_with.cocci.patch
>
> which finds the one you just fixed (naturally, since the Cocci patch
> was written by taking inspiration from your fix).
>
> Here is one in the reftable code.  The other one is in xdiff/ I'd
> rather not touch (as starts_with() is probably not available there).

Indeed, starts_with() is not available in xdiff/xpatience.c.  That whole
file is a Git-specific extension to libxdiff, though.  We could add an
include or copy the function definition.

It might make sense for performance reasons alone if there are lots of
anchors or they are very long, as with starts_with() we no longer would
have to call strlen() on all of them for each line to diff.  Never used
the anchored diff algorithm, though, so I don't know whether that's a
problem in practice.

>
> diff -u -p a/reftable/refname.c b/reftable/refname.c
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -103,7 +103,7 @@ static int modification_has_ref_with_pre
>  			}
>  		}
>
> -		if (strncmp(ref.refname, prefix, strlen(prefix))) {
> +		if (!starts_with(ref.refname, prefix)) {
>  			err =3D 1;
>  			goto done;
>  		}


That file has another one with reversed argument order:

diff --git a/reftable/refname.c b/reftable/refname.c
index 7570e4acf9..10fc8b872d 100644
=2D-- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -78,8 +78,7 @@ static int modification_has_ref_with_prefix(struct modif=
ication *mod,
 			.want =3D prefix,
 		};
 		int idx =3D binsearch(mod->add_len, find_name, &arg);
-		if (idx < mod->add_len &&
-		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
+		if (idx < mod->add_len && starts_with(mod->add[idx], prefix))
 			goto done;
 	}
 	err =3D reftable_table_seek_ref(&mod->tab, &it, prefix);

