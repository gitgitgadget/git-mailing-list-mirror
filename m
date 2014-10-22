From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Wed, 22 Oct 2014 12:02:32 -0700
Message-ID: <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
References: <cover.1413990838.git.git@drmicha.warpmail.net>
	<13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xh1BB-0006ca-A1
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 21:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbaJVTCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 15:02:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753816AbaJVTCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 15:02:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C373517712;
	Wed, 22 Oct 2014 15:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Qz2gZFI3csGqLDXetuzg3KMtaw=; b=W7MIoR
	PHzq/KtoDsuuquVCoe6hkemmOB2YGM2Q/96ixitJ5ef1UeNExDGMO2j0F3P0iUIM
	Ie/PAtf2q4JsjA8uOs0sGJmw7ADs2xlLM0sWrqv28NvQAA/xSo0iNjzg5gcy07h+
	GxTsRxgS0+7QOVHZm6kfw5ykJih72DQhVlYuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qLxwv2giuEVcuER4O3gRBVPTe7m1U/KJ
	XKtL+Ddjdz4c/gtcFdO7BMxq4+w/sDnbjxKoltm/3PXGiQT9GTPViIGIWrTuUAnx
	orJsDG62b+IyBO+d+coeu78Z4rwiv+IJMPoV2FOMY2cIF8bCJxD2FJONMNfl05ar
	I8lDyCbjuY8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B94DD17710;
	Wed, 22 Oct 2014 15:02:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E96A1770D;
	Wed, 22 Oct 2014 15:02:34 -0400 (EDT)
In-Reply-To: <13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 22 Oct 2014 17:16:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB24E844-5A1D-11E4-B8A6-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Various formats for storing signatures have accumulated by now.
> Document them to keep track (and maybe avoid yet another one).

I haven't looked at the description closely, but it is a good thing
to describe signature in a tag and in a commit in detail, which we
failed to do so far.

The principle is essentially the same between the signature on a tag
and on a commit: a detached PGP signature over the remainder of the
object data is created, and then the signature is inserted into an
appropriate place in the resulting object.  That "appropriate place"
is influenced by the type and nature of the object.

A mergetag is not fundamentally a "signature" in the above sense,
though.  It is just a dump of the object content in a regular object
header field (hence indented by one SP), and its contents having PGP
SIGNATURE is merely a natural consequence of the object recorded
being a signed tag.  So the description of it in the same place as
description for signed tags and signed commits feels a little bit
out of place, but I do not think of a better place to describe it.

Thanks.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/Makefile                       |   1 +
>  Documentation/technical/signature-format.txt | 126 +++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/technical/signature-format.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index cea0e7a..2638c0c 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -74,6 +74,7 @@ TECH_DOCS += technical/protocol-common
>  TECH_DOCS += technical/racy-git
>  TECH_DOCS += technical/send-pack-pipeline
>  TECH_DOCS += technical/shallow
> +TECH_DOCS += technical/signature-format
>  TECH_DOCS += technical/trivial-merge
>  SP_ARTICLES += $(TECH_DOCS)
>  SP_ARTICLES += technical/api-index
> diff --git a/Documentation/technical/signature-format.txt
> b/Documentation/technical/signature-format.txt
> new file mode 100644
> index 0000000..80f0a47
> --- /dev/null
> +++ b/Documentation/technical/signature-format.txt
> @@ -0,0 +1,126 @@
> +Git signature format
> +====================
> +
> +== Overview
> +
> +Git uses cryptographic signatures in various places, currently
> +objects (tags, commits, mergetags) and transactions (pushes).
> +In every case, the command which is about to create an object or
> +transaction determines a payload from that, calls gpg to obtain
> +a detached signature for the payload and embeds the signature
> +into the object or transaction.
> +
> +Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
> +and end with `-----END PGP SIGNATURE-----`.
> +
> +== Tag signatures
> +
> +- created by: `git tag -s`
> +- payload: annotated tag object
> +- embedding: append the signature to the tag object
> +- example: tag `stag` with tag message `tagmess`
> +
> +----
> +object 8cbad082a020b7d4ef729b14e1a654c4f60791c6
> +type commit
> +tag stag
> +tagger Michael J Gruber <git@drmicha.warpmail.net> 1351067460 +0200
> +
> +tagmess
> +-----BEGIN PGP SIGNATURE-----
> +Version: GnuPG v1.4.12 (GNU/Linux)
> +
> +iQIcBAABCgAGBQJQh6dPAAoJELR76rQkz552ZBEP/3vkpftZnhsUkGhqXXptnRhz
> +5A3n+BqFTsh4d4C15lcRcevwTyyQF61vrFKFRE7Cl5XVqVHowW0al+Dx7j5p35Mz
> +PqBZUbEkBFc9xY8WasQYbJl5yDboc8Ora71SEJ1k59duETXmZ67ISpEe6HF3d2xK
> +3BGfqaBMwU+Aql0pDMtysoOgEgs7d/Vin9gIXJcqAvw71bpNyZvFUln3do2eLC/v
> +VW0bVvAN3B66fLx3li8hEZ4wfrg0Uui5zSN95+uc2DUGW03BNR/sKhYXstHAoqef
> +4WIAD70e+9vArh8WqPTIUWl0w+1ixgVvGckHXHW10MdwkoVtwo4tawRxngLBKuI9
> +pUu7dc/TIVl15z/y1EmQ25rB4WV9M9W+uRauUi/T3c0hfSuZkB6B1tCu3QStPbWz
> +AK3O6Neoni2NgMDLmrWzgDZA3Z/+h9RBV/kNda0RpbWZYJOJILBR+Q8+BZOwDZX/
> +hu/tITC7IHVJgMXYGlEFybEn/clbtLsZr8zLlSZyropl0mvUBLeBCrjYBQuDN86g
> +yew/Tzs9T5MEFagUkbRERz5rP5OIE9XpXcHMsZve7cCL3YQy0LOkZk3RZKUsbv8g
> +MVU1px5/ImBkr0MU0XZxstsAV0YPiON3+qMOnrdGuFx11YQi6cmIA2eww2KPqzHY
> +YKirAGNintaD8yXAlwLd
> +=wF8p
> +-----END PGP SIGNATURE-----
> +----
> +
> +== Commit signature
> +
> +- created by: `git commit -s`
> +- payload: commit object
> +- embedding: header entry `gpgsig`
> +  (content is preceded by a space)
> +- example: commit with commit message `sigtest`
> +
> +----
> +tree 14461762125c079e55a9684ae3a96e27de5b3f2f
> +parent da19995926ec89e48297a3163b0f5190af3a8650
> +author Michael J Gruber <git@drmicha.warpmail.net> 1325088101 +0100
> +committer Michael J Gruber <git@drmicha.warpmail.net> 1325088101 +0100
> +gpgsig -----BEGIN PGP SIGNATURE-----
> + Version: GnuPG v1.4.11 (GNU/Linux)
> + 
> + iQIcBAABCgAGBQJO+z1lAAoJELR76rQkz552xOoQAJgV6sstR8cge760X7awb00V
> + svN+pcc1TtJZecYWakCIe6dGPAK2Yk1AwExV0tbAQskPxYIqwnuysXHvVlmyJh5P
> + 1N033YSRc8j59YNQNaLIAh6+c59cKcZdWQyrA1HFVWGqoafCD2+nMglb/JbN9jqQ
> + 5gsxfFGoE0blT+BnMrchzPL4kjMJQBszV5ccATu3iIgSv23p5rA4tm3/P44enIsH
> + U9nYODlKmzsAulThQoSd4Qk0MNIg86MjIXanPkj4S+TLLgDa6Zf8W3m28IiRwPF1
> + WemWpQ9VwSSHKuGVyHGG2OErtDDftILcYtjW5c/UnLw38hWPwc+KxVmAdEBY3vgk
> + OACDEDLqAWgc4rLdWgkoxieIi0aKN+iN4kogbEtSl4VzgvX0iGLZP8cyJnGxHria
> + Qz2UcesNqVPPqOxsIJKpr3CByrh2WDzH8W3tvGuy5q8EsTx5uF1HGoYb3PIx76QG
> + 3ClhL5Wtjk3/iQnycWo60eKMJccLbv+uoXzUP3LA0prt0K3a+52pWVppt8RW1L6u
> + kALJjsc44gr04v/fo5x6zkgFFt+8e/YWDZO+vwCJDmCyqggEvA5dj6i0y2B+hZjL
> + RVG0RATLroPgMa6oHSEVEbP+Ui4JZ3k3fRLIOupb0qjHtv/cvB7kcXevpdQUFGs0
> + 6kmaMJBcWutA6HrosuP/
> + =9PhX
> + -----END PGP SIGNATURE-----
> +
> +sigtest
> +----
> +
> +== Mergetag signature
> +
> +- created by: `git merge` on signed tag
> +- payload/embedding: the whole signed tag object is embedded into
> +  the (merge) commit object of header entry `mergetag`
> +- example: merge of the signed tag `stag` as above
> +
> +----
> +tree ceb2177fea91ec9369e012dbe794419ee0731ce7
> +parent 9c20ba82367dab0fe4789e2be400a7fb0c447c34
> +parent 8cbad082a020b7d4ef729b14e1a654c4f60791c6
> +author Michael J Gruber <git@drmicha.warpmail.net> 1412951117 +0200
> +committer Michael J Gruber <git@drmicha.warpmail.net> 1412951117 +0200
> +mergetag object 8cbad082a020b7d4ef729b14e1a654c4f60791c6
> + type commit
> + tag stag
> + tagger Michael J Gruber <git@drmicha.warpmail.net> 1351067460 +0200
> + 
> + tagmess
> + -----BEGIN PGP SIGNATURE-----
> + Version: GnuPG v1.4.12 (GNU/Linux)
> + 
> + iQIcBAABCgAGBQJQh6dPAAoJELR76rQkz552ZBEP/3vkpftZnhsUkGhqXXptnRhz
> + 5A3n+BqFTsh4d4C15lcRcevwTyyQF61vrFKFRE7Cl5XVqVHowW0al+Dx7j5p35Mz
> + PqBZUbEkBFc9xY8WasQYbJl5yDboc8Ora71SEJ1k59duETXmZ67ISpEe6HF3d2xK
> + 3BGfqaBMwU+Aql0pDMtysoOgEgs7d/Vin9gIXJcqAvw71bpNyZvFUln3do2eLC/v
> + VW0bVvAN3B66fLx3li8hEZ4wfrg0Uui5zSN95+uc2DUGW03BNR/sKhYXstHAoqef
> + 4WIAD70e+9vArh8WqPTIUWl0w+1ixgVvGckHXHW10MdwkoVtwo4tawRxngLBKuI9
> + pUu7dc/TIVl15z/y1EmQ25rB4WV9M9W+uRauUi/T3c0hfSuZkB6B1tCu3QStPbWz
> + AK3O6Neoni2NgMDLmrWzgDZA3Z/+h9RBV/kNda0RpbWZYJOJILBR+Q8+BZOwDZX/
> + hu/tITC7IHVJgMXYGlEFybEn/clbtLsZr8zLlSZyropl0mvUBLeBCrjYBQuDN86g
> + yew/Tzs9T5MEFagUkbRERz5rP5OIE9XpXcHMsZve7cCL3YQy0LOkZk3RZKUsbv8g
> + MVU1px5/ImBkr0MU0XZxstsAV0YPiON3+qMOnrdGuFx11YQi6cmIA2eww2KPqzHY
> + YKirAGNintaD8yXAlwLd
> + =wF8p
> + -----END PGP SIGNATURE-----
> +
> +Merge tag 'stag' into HEAD
> +
> +tagmess
> +
> +Conflicts:
> +	...
> +----
