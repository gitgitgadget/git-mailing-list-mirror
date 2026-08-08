Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53024339395
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206227; cv=none; b=HlBwcJP8KjfUfTX5fYQtRVcS7/+yUjB/yefOMGNqPGHnFo4il7WIolyiiQHYT2wrx7gxnuX5A0bk9sEXyPXoQH/XcdH10Xvt61dSp1ni+FnN5eKoRxAeJzReSLQq1kYHFY3MyhXxyqnstseCvzsj4wcLEoYR/xbqz5vHE1kUG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206227; c=relaxed/simple;
	bh=76yktwsktLUrk770uGoS4oO0eo9FjBHXlKeVCWox2fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+0ORASJtIX5oQTNq/KfF3KiMWCGMwWa/DjYiRiZxQ0LAQrmn9AIw0+s56dYgCeGvCRd9QLkb6Er20lvUC+ObOLSKQm63Vxz/w/WQV53ya5j6dKbZc8VTaghRcU322WCjcMt1xYMSFueXD8Zgtijh00lF7kDOkUdzTWlLLYAlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=p/3OzFUG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="p/3OzFUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786206214; x=1786811014; i=l.s.r@web.de;
	bh=3xXHb/5Y4q2VWIbTUWeyHWp/p7j00ZarIrTSaQpSFiU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p/3OzFUGq75jiLvgNFjEbWuF/cs6AxVujHsa7TsJfMxXJ82JP88tJS1320W1u6iO
	 OzDA9rIsCtORmlGNiKPJLArAR0+yvvee6/pYNevG/8GFY3BnQG79sAp4fpv53sM5Y
	 joaYA1RrpKjJBMVhKc/UabDoEwEr8nE/GTPXRgQ+JMjqfT/VnxBuzE7dy4eF+cJ3n
	 GX9xDdbjY+u0iA/o58IQehcPWFukN4+xWTZwzo0J5LYnK6yOesm/DMlntdECcMYyh
	 MlHhGeE53H8TQk2t4tRxmmWNupkYaqdL6R711MIvqcV6Jc5GC63uhTJSrJZPHgGSv
	 pWYg4NvvKZxcF11twg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1wYZUV1bNx-00SHJI; Sat, 08
 Aug 2026 18:23:34 +0200
Message-ID: <506880fc-5557-46a1-b26d-63349781849b@web.de>
Date: Sat, 8 Aug 2026 18:23:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] object-name: avoid use-after-free in
 get_oid_with_context_1()
To: Shlok Kulshreshtha <diy2903@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de
References: <20260807195941.99473-1-diy2903@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260807195941.99473-1-diy2903@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TDhEh+FwoH8tEJ7mTwJfNSmvlOuSOICMx7laEj9aHqP8dYAWJgh
 +gjEDuO4G4EH21J8Gxh9+g6QzlxVLZTNd3FqU3jf8I5jyk51hCHduWvhipSrmrH9DrMinf+
 TyvUUJyfWslUhQ2bpCtZDGg0Qg6URillRzx9FA++5DmSC3r5Aopsg/4aPMPJDjCkjpc9pV9
 PmyhnmU15UPMDE1UFtO6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YZetFrUIpyo=;KWG1KnbnxVFXxUdRs39mqYRzOhk
 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

On 8/7/26 9:59 PM, Shlok Kulshreshtha wrote:
> When a ":<path>" argument names a relative path, resolve_relative_path()
> returns a newly allocated string and "cp" is pointed at it:
>=20
> 	new_path =3D resolve_relative_path(repo, cp);
> 	if (!new_path) {
> 		namelen =3D namelen - (cp - name);
> 	} else {
> 		cp =3D new_path;
> 		namelen =3D strlen(cp);
> 	}
>=20
> From there on "cp" and "new_path" name the same allocation. Later the
> memory location that "new_path" points to is freed.
>=20
> 	free(new_path);
> 	if (reject_tree_in_index(repo, only_to_die, ce, stage, prefix, cp))
>=20
> But here the reject_tree_in_index() passes "cp" to
> diagnose_invalid_index_path(), which calls strlen() on it, looks it up
> in the index, and formats it into its messages, allocating as it goes.
> All of this reads memory that has already been freed.
>=20
> Collapse the two exits into one to ensure a single free() that happens
> after the last use.
>=20
> Three things have to coincide to reach this:
>=20
> 1. The path has to be relative, or nothing is allocated and "cp"
> still points into the argument.
>=20
> 2. The entry found has to be a sparse
> directory, which needs a sparse index.
>=20
> 3. The argument has to get past the check in die_verify_filename() that
> skips a leading ':' followed by a non-alphanumeric, so ":0:./dir/"
> arrives here where ":./dir/" does not.
>=20
> Add a test to t1092 that covers the combination. It fails under
> SANITIZE=3Daddress without the change to object-name.c.
>=20
> This was reported in [1], and the shape used here was suggested in
> review [2], but that series was not rerolled and the fix never landed.
>=20
> [1] https://lore.kernel.org/git/cf6bcdb43e5b4abab464c30a914d64dc8e7a9925=
.1655336146.git.gitgitgadget@gmail.com/
> [2] https://lore.kernel.org/git/xmqqy1xxw7rc.fsf@gitster.g/

Oh, from 2022, good find.

> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Original-patch-by even, no?

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
> ---
> The three conditions make this awkward to reach by hand, so here is the
> recipe:
>=20
> 	git init sparse && cd sparse &&
> 	mkdir folder1 folder2 &&
> 	echo a >folder1/a && echo b >folder2/b &&
> 	git add -A && git commit -m init &&
> 	git sparse-checkout init --cone --sparse-index &&
> 	git sparse-checkout set folder1 &&
> 	git show :0:./folder2/
>=20
> Without the change below, no sanitizer is needed to see it. On 2.52.0
> the buffer has already been reused by the time the message is formatted,
> so the path printed is whatever now sits in that memory, and it differs
> from run to run:
>=20
> 	fatal: path '' does not exist (neither on disk nor in the index)
> 	fatal: path 'M-6?:xM-@M-:M-L??X' does not exist (neither on disk nor in=
 the index)
> 	fatal: path '?M-*JM-^M->M-YM-tn?H' does not exist (neither on disk nor =
in the index)
>=20
> Still without the change, built with SANITIZE=3Daddress, the same comman=
d
> reports
>=20
> 	ERROR: AddressSanitizer: heap-use-after-free
> 	READ of size 3 at 0x607000002a20
> 	    #1 diagnose_invalid_index_path object-name.c:1653
> 	    #2 get_oid_with_context_1      object-name.c:1807
> 	    #3 maybe_die_on_misspelt_object_name
> 	    #4 die_verify_filename         setup.c:216
> 	    #6 setup_revisions             revision.c:3103
> 	    #8 cmd_show                    log.c:694
> 	freed by thread T0 here:
> 	    #1 get_oid_with_context_1      object-name.c:1806
> 	previously allocated by thread T0 here:
> 	    #5 prefix_path                 setup.c:149
> 	    #6 get_oid_with_context_1      object-name.c:1784
>=20
> With the change, the message reads "folder2/" every time and the
> sanitizer stays quiet.
>=20
> "git diff" and "git rev-parse" reach it the same way, and so does "../"
> from a subdirectory.
>=20
> The new t1092 test fails without the object-name.c hunk and passes with
> it, under SANITIZE=3Daddress.
>  object-name.c                            | 15 +++++++++------
>  t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/object-name.c b/object-name.c
> index 83efba0ba6..bffe795830 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1803,13 +1803,16 @@ static enum get_oid_result get_oid_with_context_=
1(struct repository *repo,
>  			    memcmp(ce->name, cp, namelen))
>  				break;
>  			if (ce_stage(ce) =3D=3D stage) {
> +				int ret =3D -1;
> +
> +				if (!reject_tree_in_index(repo, only_to_die, ce,
> +							  stage, prefix, cp)) {
> +					oidcpy(oid, &ce->oid);
> +					oc->mode =3D ce->ce_mode;
> +					ret =3D 0;
> +				}
>  				free(new_path);
> -				if (reject_tree_in_index(repo, only_to_die, ce,
> -							 stage, prefix, cp))
> -					return -1;
> -				oidcpy(oid, &ce->oid);
> -				oc->mode =3D ce->ce_mode;
> -				return 0;
> +				return ret;

OK

>  			}
>  			pos++;
>  		}
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-c=
heckout-compatibility.sh
> index 4140c4d8ef..e88946c254 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1357,6 +1357,17 @@ do
>  	"
>  done
> =20
> +test_expect_success 'relative path to a sparse directory' '
> +	init_repos &&
> +
> +	# A ":<stage>:<path>" argument whose path is relative is resolved
> +	# into a heap-allocated buffer, and a sparse directory found at that
> +	# path is reported through it.  Cover that combination, so that the
> +	# reporting does not read the buffer after it has been released.
> +	test_sparse_match test_must_fail git show :0:./folder1/ &&
> +	test_sparse_match test_must_fail git rev-parse :0:./folder1/
> +'
> +
>  test_expect_success 'submodule handling' '
>  	init_repos &&
> =20

Good idea to add a test.

Ren=C3=A9

