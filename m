Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1708154C0F
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740382; cv=none; b=FRj22ZQ8VSaPmDPFOefIT+3Sa5PQMGVtNsN/7piInq/Zwt/vFi/PpFnqbrBD9yN5o3jjfNFbY1HkcYLFVxSFnY5gdpbk/UgVPlZnNPrJ/kVbhBvMRSGOmumMDfQo7TDmtTt+4XuLM5ZAa4Wp8AW/036ePaoo/ry7KGMJoEV7lCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740382; c=relaxed/simple;
	bh=9HAaZ2NFcSBZKXR2Uw7I4/U0XiOzn+VIOkSY/UcHH8g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrm+MSArPcwNdb2cjhCWpzkQLZB+HxQlzAs429fksK1Z9hixOXi/MHplgRwccdOeaK/no0huMYMQlFfdfBaOxNrfK9hRW0cRQhEQEzRkNHAg77vrC9fnhHReEDa8POtAAQdDtnW7/4JOUqk8pBDL9P2OaPwCl204kdlbX/8jWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=aj0G2WGJ; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="aj0G2WGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712740377; x=1712999577;
	bh=Vyqh0P9UxZTSom8VuOfVDIQDFjp7FoZdOqR2EzbdriY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aj0G2WGJDpSV35WkEqAsXLIuJQHGl1GYRChn8Zkyo9suqKE6g0sIpIcKz2arGUoxa
	 jC7U1obmp+OW+NUGApVr0syw5Degg8RUwf+irrxtr0Fzawu+ZZbDaiFun33L9TBBma
	 39//vBkjujibZ+YP/IMgMo2ltr8GH/lOLzlXuxuGmcXEGaccEiTr/8tnaUvNFrqpeP
	 aTY8lE5LvXZJToYgGTHs1g8E8Z3cHDQkUUhz5Hwr+FSOjN2dltgvGMZcpX+OJGNivW
	 gza75AVzlsSqPZtetuYLS4bOioAYLBjY2LNqWE+ee124++lEHImtZflNMSqa/G7ZLf
	 9T4yuRCLivCsA==
Date: Wed, 10 Apr 2024 09:12:44 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <11351F50-D21D-4C9B-8441-43513A11336A@archibald.dev>
In-Reply-To: <ZhYxNYR33ftEfcPk@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev> <ZhYxNYR33ftEfcPk@tanuki>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Sorry for re-sending)

On Apr 9, 2024, at 23:27, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Apr 01, 2024 at 09:02:47AM +0000, Thalia Archibald wrote:
>>=20
>> - if (!*endp)
>> + if (!p)
>> die("Missing dest: %s", command_buf.buf);
>=20
> So this statement right now doesn't make a whole lot of sense because
> `p` cannot ever be `NULL` -- we'd segfault before that. Once we update
> `parse_path()` to handle this correctly it will work as expected though.
>=20
> I was briefly wondering though whether we really want `parse_path()` to
> set `p` to be a NULL pointer. If we didn't, we could retain the previous
> behaviour here and instead check for `!*p`.

Good catch. There should be a deref there.

This mistake was because I originally planned to not allow unquoted empty
strings and had factored that condition into parse_path. After your round 1
feedback, I changed my mind after reanalysis. The condition you see here is
supposed to match the behavior for before and is removed in patch 3/8. Ther=
e was
no test before my series exercising this branch and my test for it is added=
 in
3/8, so it wasn't caught in this intermediate version.

>> + ( printf "100644 blob $blob2\t'"$unquoted_path"'\n" &&
>> +   printf "100644 blob $blob1\thello.c\n" ) | sort >tree_m.exp &&
>=20
> Also, there is no need to do `'"$unuoted_path"'` here. You should be
> able to refer to `$unquoted_path` just fine even without unquoting again
> because we use eval to execute the code block. In fact, it can even be
> harmful as it is known to break shells under some circumstances. See
> also 7c4449eb31 (t/README: document how to loop around test cases,
> 2024-03-22), which I think should apply in your case, too.

I agree it makes it less finicky. The one upside to string splicing is that=
 when
a test fails, the substitutions are visible in the dump of the shell script=
. I
found that useful while debugging. The titles can uniquely identify the
$prefix/$path/$suffix values when looking in the source, since they're all
1-to-1. Considering the downsides, I've switched to plain substitutions.=20

Thalia
