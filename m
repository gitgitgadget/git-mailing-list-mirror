Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C91482C3
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175758; cv=none; b=QBfj+vfmSE+oGB/gSXgIctdM29Z9ba6BVwtcfRtAGsBxO3+VccB0ykFLeEHBieVi88FpdjysjYPur2UbMRFgB1MIIaiGfgILwasWpGEmDy5QeBldhnM/lw71/QwN/8y3WChC+WDPoum4nYLLJEQTtnSs8+zNRod38WrhwpgqG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175758; c=relaxed/simple;
	bh=Ba5NdvNbm2qwb6kVXqog5UFUIGcTuqh31Py+m5p71q8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kASfd2qsgWmlKZ1QgyiQ12X3ddM9iRMKa0OwO0N2PkLZ8UtIcgL3Z90nONhbTVqkTFWOZ5FnwaECgfoMfGQPy/TcjTBgOwgYAYB5SZBzVMI4dHYFHp6eQKGLB/dI5c5mcxlJ0CO7j+uzb0Yvtf7A6vKmw+WruIVl26R77XdVqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42BGmgki1181178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:48:42 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Dragan Simic'" <dsimic@manjaro.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Ralph Seichter via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Ralph Seichter'" <github@seichter.de>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com> <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com> <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
In-Reply-To: <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
Subject: RE: [PATCH v2] config: add --comment option to add a comment
Date: Mon, 11 Mar 2024 12:48:37 -0400
Organization: Nexbridge Inc.
Message-ID: <0b8701da73d3$fa0f2080$ee2d6180$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFlUIbffV0Kx6ugRLQuqCoXSigUjAIBeUnZAda4N5oBcGPiHLHywCZg

On Monday, March 11, 2024 12:17 PM, Dragan Simic wrote:
>Subject: Re: [PATCH v2] config: add --comment option to add a comment
>
>On 2024-03-11 13:55, Junio C Hamano wrote:
>> "Ralph Seichter via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Ralph Seichter <github@seichter.de>
>>>
>>> Introduce the ability to append comments to modifications made using
>>> git-config. Example usage:
>>>
>>>   git config --comment "changed via script" \
>>>     --add safe.directory /home/alice/repo.git
>>>
>>> based on the proposed patch, the output produced is:
>>>
>>>   [safe]
>>>     directory =3D /home/alice/repo.git #changed via script
>>
>> For readability, you probably would want to have a SP before the =
given
>> string, i.e.,
>>
>> 	variable =3D "value" # message comes here
>
>Let me interject...  Perhaps also a tab character before the "# =
comment",
instead of a space character.  That would result in even better
>readability.

Does adding a tab following data change the parse semantics of =
.gitconfig?
My na=EFve understanding is that .gitconfig follows a basic rule of =
leading
tab within a section, followed by text. Is there a formal syntax =
description
of what valid input is? The value does not need to be quoted, so what =
does
the following actually resolve to:

(TAB)variable =3D value(TAB)# comment.

Does variable mean value or value(TAB)? Obviously TABS should be =
correctly
be interpreted as whitespace to be ignored. However, what about:

(TAB)variable =3D value(TAB)s(TAB) # comment.

Does that mean value(TAB)s, value(TAB)s(TAB), value s, value s(TAB), =
values?

The definition according to git-config is

"The syntax is fairly flexible and permissive; whitespaces are mostly
ignored. The # and ; characters begin comments to the end of line, blank
lines are ignored."

"Mostly" does not make me comfortable that this is formally allowed or
disallowed or ignored. I would suggest that this change needs to =
formalize
the grammar on that documentation page for clarity.

