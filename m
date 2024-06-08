Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F81391
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 00:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717806929; cv=none; b=tDEeEczR4cW9jt+wRDEgBQmdW8/a0pnfF7ssY+55DJAPdYJ8jcLwRn7kN83UT8/fCzcUP797FdLogAQ3Up3GWRsSWM2DusLm+YQwTZbpdjgCSRyohxlUvRaWns/Qh+7UTxikneuGytJXL+5ozYcm8KsNomGy3+Pneos7J0IzWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717806929; c=relaxed/simple;
	bh=FRefY4midCezKTB59/LR7qSUiYedaru0LWMYhsxwto8=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HWkh5NpkUQYgDRJSekRiZbqH/F1ZVydggzmSyaAcNod9UPO6IUquJ0gwf3j36jt+hyuRsu0AlHHbYav/842IZ1Leqpx/lvdOWHIZUD4DR7C5hPyXlM9aAW5tNSsjPsmNN7DB9Diw/PuAxszZWVAgdI6yOFQpO3gNcXrQjpCnQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4580ZNJZ1181544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 8 Jun 2024 00:35:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'ellie'" <el@horse64.org>, <git@vger.kernel.org>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org> <0be201dab933$17c02530$47406f90$@nexbridge.com> <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
In-Reply-To: <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
Subject: RE: With big repos and slower connections, git clone can be hard to work with
Date: Fri, 7 Jun 2024 20:35:18 -0400
Organization: Nexbridge Inc.
Message-ID: <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8D86lVlMiQEsTuxPOCK2qhFj8vwLR+fypAySGZOKwSqNGwA==
Content-Language: en-ca

On Friday, June 7, 2024 8:03 PM, ellie wrote:
>Subject: Re: With big repos and slower connections, git clone can be =
hard to work
>with
>
>Thanks, this is very helpful as an emergency workaround!
>
>Nevertheless, I usually want the entire history, especially since I =
wouldn't mind
>waiting half an hour. But without resume, I've encountered it regularly =
that it just
>won't complete even if I give it the time, while way longer downloads =
in the
>browser would. The key problem here seems to be the lack of any resume.
>
>I hope this helps to understand why I made the suggestion.
>
>Regards,
>
>Ellie
>
>On 6/8/24 1:33 AM, rsbecker@nexbridge.com wrote:
>> On Friday, June 7, 2024 7:28 PM, ellie wrote:
>>> I'm terribly sorry if this is the wrong place, but I'd like to
>>> suggest a potential issue with "git clone".
>>>
>>> The problem is that any sort of interruption or connection issue, no
>>> matter how brief, causes the clone to stop and leave nothing behind:
>>>
>>> $ git clone https://github.com/Nheko-Reborn/nheko
>>> Cloning into 'nheko'...
>>> remote: Enumerating objects: 43991, done.
>>> remote: Counting objects: 100% (6535/6535), done.
>>> remote: Compressing objects: 100% (1449/1449), done.
>>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
>>> CANCEL (err 8)
>>> error: 2771 bytes of body are still expected
>>> fetch-pack: unexpected disconnect while reading sideband packet
>>> fatal: early EOF
>>> fatal: fetch-pack: invalid index-pack output $ cd nheko
>>> bash: cd: nheko: No such file or director
>>>
>>> In my experience, this can be really impactful with 1. big =
repositories and 2.
>>> unreliable internet - which I would argue isn't unheard of! E.g.
>>> a developer may work via mobile connection on a business trip. The
>>> result can even be that a repository is uncloneable for some users!
>>>
>>> This has left me in the absurd situation where I was able to =
download
>>> a tarball via HTTPS from the git hoster just fine, even way larger
>>> binary release items, thanks to the browser's HTTPS resume. And yet =
a
>>> simple git clone of the same project failed repeatedly.
>>>
>>> My deepest apologies if I missed an option to fix or address this.
>>> But summed up, please consider making git clone recover from =
hiccups.
>>>
>>> Regards,
>>>
>>> Ellie
>>>
>>> PS: I've seen git hosters have apparent proxy bugs, like timing out
>>> slower git clone connections from the server side even if the
>>> transfer is ongoing. A git auto-resume would reduce the impact of =
that, too.
>>
>> I suggest that you look into two git topics: --depth, which controls =
how much
>history is obtained in a clone, and sparse-checkout, which describes =
the part of the
>repository you will retrieve. You can prune the contents of the =
repository so that
>clone is faster, if you do not need all of the history, or all of the =
files. This is typically
>done in complex large repositories, particularly those used for =
production support
>as release repositories.

Consider doing the clone with --depth=3D1 then using git fetch =
--depth=3Dn as the resume. There are other options that effectively give =
you a resume, including --deepen=3Dn.

Build automation, like Jenkins, uses this to speed up the =
clone/checkout.

