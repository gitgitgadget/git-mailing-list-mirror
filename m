Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44745EED0
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962425; cv=none; b=h4RHiL45kyhJp8bPo5Xl+D5qjfKxYIe+NPQcAhf/IN1VdiWOq0Mv75hwOILL2OzLP8FhE61bvSOZIUw57ssX/RB90uRB7H3K7PdFBeJQPHZdvVjceXPxmegLUh70OrkcV/WXrDVNn2ujpmMjXxPE4GYP0etGQlY30Ab1CTooTME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962425; c=relaxed/simple;
	bh=C25yADk7tf1+jsS9/RE94cOGL07BlG/d2WaVar9M2SE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJq6ixYk1RzD0MKaehYHWRJU9skp3xqsEWaneSdFjyGecKb88swMteyok9TjtvmPrnUTORPed8fKvcdi5sq2gXRnFdXbsg8EC8Es8N65sSYSH9yQk0044PMs2lgjibslWH+ODh+mGhm3dZNDRCGWSvJcBKGQDNHlanU3hMG9eFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=wHZ44Rtk; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="wHZ44Rtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962422; x=1712221622;
	bh=d3MMctHrD5xf4cnUkyw0vt9f6c01SGxZKisG30iZGqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=wHZ44RtkmipWqLUeo7GXgPtWG5XeyDTVXp5V6xdZypDGMlXg8rip7vuXBN5nuXiQa
	 mmDhUnhlJwzS6Jw19f82C0Q998+Fny88I8pJ/Ew4HrD7Xou1itMN8o0TfHH0zy574p
	 tklO3/Q+5L7KsCnqve/wbv6zOYogu4oPnH7Wl6iq3woQWKhlj7xq4+3lltRpbMsvuZ
	 7+6p0l53ZxV9oqG2p8aKyJnXtEtdr7lXY+WaTe4N43Ohbcc23z73EZDum9BUy/xK3X
	 kxke6Yl/GZJCFrzhvKFuz83aCa00SWKMzpbaNl95rzRXWunNBhyV/LedxiaDTdNDm0
	 Hc2Es4r2pXvGQ==
Date: Mon, 01 Apr 2024 09:06:55 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/6] fast-import: document C-style escapes for paths
Message-ID: <4C726A5B-902B-4E2F-BFB1-11660E551187@archibald.dev>
In-Reply-To: <ZgUog3UFu3WIc0L0@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev> <20240322000304.76810-6-thalia@archibald.dev> <ZgUog3UFu3WIc0L0@tanuki>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Sending again as plain text)

On Mar 28, 2024, at 01:21, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, Mar 22, 2024 at 12:03:47AM +0000, Thalia Archibald wrote:
>>=20
>> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-=
import.txt
>> index 271bd63a10..4aa8ccbefd 100644
>> --- a/Documentation/git-fast-import.txt
>> +++ b/Documentation/git-fast-import.txt
>> @@ -630,18 +630,23 @@ in octal.  Git only supports the following modes:
>> In both formats `<path>` is the complete path of the file to be added
>> (if not already existing) or modified (if already existing).
>>=20
>> -A `<path>` string must use UNIX-style directory separators (forward
>> -slash `/`), may contain any byte other than `LF`, and must not
>> -start with double quote (`"`).
>> +A `<path>` string may contain any byte other than `LF`, and must not
>> +start with double quote (`"`). It is interpreted as literal bytes
>> +without escaping.
>=20
> Paths also mustn't start with a space in many cases, right?

It talks about starting with double quote, because that's what determines
whether it's parsed as a quoted or unquoted string.

Containing spaces is different. When unquoted, a path can only contain a sp=
ace
if it's the last field on the line; that's all paths except the source path=
s of
filecopy and filerename. That note was already remarked in the filecopy and
filerename sections, but it would help to note it in the general <note> sec=
tion,
so I've done that and clarified quoting in patch v2 5/8 (fast-import: impro=
ve
documentation for unquoted paths).

Thalia
