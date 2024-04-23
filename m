Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00113CA96
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894759; cv=none; b=r8D8kBwFcapv04imUlWi4QhhlmAm0dxOFdBC2Uu4C8uPfuDsRNU29g/IN/AgMdwRYRX6p0DaZGfRe1ALUZS0c4lR1JfqFS8m+W1ttwUWWWmwBGlIksQHukKdZao6/gIucNQ6hKz4Gym7sYdPLp5U3LmM2rjazuqedgPVOei1zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894759; c=relaxed/simple;
	bh=prh/osoUE6xrmFDMdUrLWx5lgI5Q3Si3prfaA1HRCQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxrzg1n5zg0+8HCwQtyWHWFzQ9dq/OZYc/3J1E0vG4X4sV89YiqUPUyLVg0WYJFgCbcVhg2aQFatA+bYJS2QfI1NdxRmgQJW3h9fbjd4y6EByqXJZMn3Lg5YJvbYbNW+aansUkVW26LLdPrKoVqY2AOzKM2a5Su71GmQgm9SZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xKNLr2Xj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xKNLr2Xj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7B9D1F3F9D;
	Tue, 23 Apr 2024 13:52:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=prh/osoUE6xrmFDMdUrLWx5lg
	I5Q3Si3prfaA1HRCQI=; b=xKNLr2XjkSooG0+xC6rhu5s0o9XElnKzqU47qs2jk
	UU/rtQUBHdZ9CzoFrBUjJapJ4EOop5rS17oXiM8ak1dINML16kPkOsp/q/XFmCoi
	+NU16xuhdR0jXtMab0BXMPUfeyCb7LiQjXAHRWYNwMK84gGClmp+6HtAgc5SNQFv
	rU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E8561F3F9C;
	Tue, 23 Apr 2024 13:52:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 091931F3F9B;
	Tue, 23 Apr 2024 13:52:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v4 0/2] format-patch --rfc=WIP
Date: Tue, 23 Apr 2024 10:52:32 -0700
Message-ID: <20240423175234.170434-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-rc0-3-g00e10ef10e
In-Reply-To: <20240421185915.1031590-1-gitster@pobox.com>
References: <20240421185915.1031590-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 44AD543C-019A-11EF-9AAA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

In the previous iteration, I botched the implementation of the
"--no-rfc" case and somehow the test was "lucky" enough to leave
uninitialized pieces of memory filled with '\0's and did not catch
it.

The proposed log message for the second one has been reworded, and
the documentation (obliquely) cautions against abusing the suffix
form just to be different.

Junio C Hamano (2):
  format-patch: allow --rfc to optionally take a value, like --rfc=3DWIP
  format-patch: "--rfc=3D-(WIP)" appends to produce [PATCH (WIP)]

 Documentation/git-format-patch.txt | 21 ++++++++++++++++-----
 builtin/log.c                      | 27 +++++++++++++++++++++++----
 t/t4014-format-patch.sh            | 28 +++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  7e022c85f7 ! 1:  30798e1211 format-patch: allow --rfc to optionally t=
ake a value, like --rfc=3DWIP
    @@ builtin/log.c: static int subject_prefix_callback(const struct opt=
ion *opt, cons
     +	const char **rfc =3D opt->value;
     +
     +	*rfc =3D opt->value;
    -+	if (!unset)
    ++	if (unset)
    ++		*rfc =3D NULL;
    ++	else
     +		*rfc =3D arg ? arg : "RFC";
     +	return 0;
     +}
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, c=
onst char *pre
      			    N_("cover-from-description-mode"),
      			    N_("generate parts of a cover letter based on a branch's des=
cription")),
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
    + 	if (cover_from_description_arg)
      		cover_from_description_mode =3D parse_cover_from_description(cove=
r_from_description_arg);
     =20
    - 	if (rfc)
    +-	if (rfc)
     -		strbuf_insertstr(&sprefix, 0, "RFC ");
    ++	if (rfc && rfc[0])
     +		strbuf_insertf(&sprefix, 0, "%s ", rfc);
     =20
      	if (reroll_count) {
2:  474041bdf8 ! 2:  fdbe198cd7 format-patch: "--rfc=3D-(WIP)" appends to=
 produce [PATCH (WIP)]
    @@ Commit message
    =20
         In the previous step, the "--rfc" option of "format-patch" learn=
ed
         to take an optional string value to prepend to the subject prefi=
x,
    -    so that --rfc=3DWIP can give "[WIP PATCH]".  This commit shows t=
hat
    -    the mechanism can be extended easily to allow "--rfc=3D-(WIP)" [=
*1*]
    -    to signal that the extra string is to be appended instead of get=
ting
    -    prepended, resulting in "[PATCH (WIP)]".
    -
    -    Having worked on the patch, I am personally not 100% on board wi=
th
    -    this part of the feature myself, and that is why this update is =
a
    -    separate step from the main "--rfc takes an optional string valu=
e"
    -    step.
    -
    -    If a way to prepend an arbitrary adornment is added to the syste=
m,
    -    and people can now say "--rfc=3DRESEND" to produce "[RESEND PATC=
H]",
    -    those who used to use "[PATCH RESEND]" by tweaking the subject
    -    prefix in other ways [*2*] would do one of three things:
    -
    -     (1) keep using their existing ways and keep sending their messa=
ge
    -         with the "[RESEND PATCH]" prefix.
    -
    -     (2) rejoice in the new automation, switch to use "--rfc=3DRESEN=
D",
    -         and start sending their messages with "[RESEND PATCH]" pref=
ix
    -         instead of "[PATCH RESEND]" prefix.
    +    so that --rfc=3DWIP can give "[WIP PATCH]".
    =20
    -     (3) complain and demand a way to append instead of prepend so t=
hat
    -         they can use an automation to produce "[PATCH RESEND]" pref=
ix.
    +    There may be cases in which the extra string wants to come after=
 the
    +    subject prefix.  Extend the mechanism to allow "--rfc=3D-(WIP)" =
[*] to
    +    signal that the extra string is to be appended instead of gettin=
g
    +    prepended, resulting in "[PATCH (WIP)]".
    =20
    -    I do not believe in adding slightly different ways that allow us=
ers
    -    to be "original" when such differences do not make the world bet=
ter
    -    in meaningful ways [*3*], and I expect there are many more folks=
 who
    -    share that sentiment and go to route (2) than those who go to ro=
ute
    -    (3).  If my expectation is true, it means that this patch goes i=
n a
    -    wrong direction, and I would be happy to drop it.
    +    In the documentation, discourage (ab)using "--rfc=3D-RFC" to say
    +    "[PATCH RFC]" just to be different, when "[RFC PATCH]" is the no=
rm.
    =20
         [Footnote]
    =20
    -     *1* The syntax takes inspiration from Perl's three-arg open syn=
tax
    -         that uses pipes "open fh, '|-', 'cmd'", where the dash sign=
als
    -         "the other stuff comes here".
    -
    -     *2* ... because "--rfc" in released versions does not even take=
 any
    -         string value to prepend, let alone append, to begin with.
    -
    -     *3* https://lore.kernel.org/git/b4d2b3faaf2914b7083327d5a4be390=
5@manjaro.org/
    -         gathered some stats to observe that "[RFC PATCH]" is more
    -         common than "[PATCH RFC]" by a wide margin, while trying to=
 see
    -         how common "[RESEND PATCH]" (or "[PATCH RESED]") were used =
(the
    -         answer: much less common).  But it wouldn't have needed to
    -         count "[PATCH RFC]" and "[RFC PATCH]" separately if using a
    -         prefix and not a suffix (or vice versa) were established mo=
re
    -         firmly as the standard practice.
    -
    -         It is a fine example that useless diversity making needless
    -         work.
    +     * The syntax takes inspiration from Perl's open syntax that ope=
ns
    +       pipes "open fh, '|-', 'cmd'", where the dash signals "the oth=
er
    +       stuff comes here".
    =20
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    @@ Documentation/git-format-patch.txt: RFC means "Request For Comment=
s"; use this w
      "--rfc=3DWIP" may also be a useful way to indicate that a patch
      is not complete yet ("WIP" stands for "Work In Progress").
     ++
    -+If the string _<rfc>_ begins with a dash ("`-`"), the rest of the
    -+_<rfc>_ string is appended to the subject prefix instead, e.g.,
    -+`--rfc=3D'-(WIP)'` results in "PATCH (WIP)".
    ++If the convention of the receiving community for a particular extra
    ++string is to have it _after_ the subject prefix, the string _<rfc>_
    ++can be prefixed with a dash ("`-`") to signal that the the rest of
    ++the _<rfc>_ string should be appended to the subject prefix instead=
,
    ++e.g., `--rfc=3D'-(WIP)'` results in "PATCH (WIP)".
     =20
      -v <n>::
      --reroll-count=3D<n>::
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, c=
onst char *pre
      	if (cover_from_description_arg)
      		cover_from_description_mode =3D parse_cover_from_description(cove=
r_from_description_arg);
     =20
    --	if (rfc)
    +-	if (rfc && rfc[0])
     -		strbuf_insertf(&sprefix, 0, "%s ", rfc);
    -+	if (rfc) {
    ++	if (rfc && rfc[0]) {
     +		if (rfc[0] =3D=3D '-')
     +			strbuf_addf(&sprefix, " %s", rfc + 1);
     +		else
--=20
2.45.0-rc0-3-g00e10ef10e

