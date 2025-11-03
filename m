Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B719F127
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133684; cv=none; b=GEclI+ZgXE1SAQ7lJEhtzdOe4UX2t1Nzsy0T5VVpYgYL/axji96rh62i008hE2KAXQfiyFEBLCBXfOm9tezX1n7M+kXda/GN4T0Lua/E1SmMKgM3K69C2ZCRVvT/Ii3Q2TgSjgMy+l2CzP6GI3BdHnYFOxHPG5TpTHYno5Azo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133684; c=relaxed/simple;
	bh=jOA2Sb5wUjeqScsXM4JERL02xQOrefEQnzBeF/a5tqo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oE7Jez8kVHN8C4iin/ooC8xSa3dhl8EkDKhaepDU0z/SdMV+dapw9dfWrNBTsb0Gr5Mbuf2xloMO5cRobG19k6WsiLjl6lYsZ+/PJnCLKOGeYtR3fDFujL0i6lyXs2QyGc3ZYKIOBNKNl0MAYBfH957dCEtvCJ3Vun3dhRaUJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5A31Ybe92590078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 01:34:38 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'David Bohman'" <debohman@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com> <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
In-Reply-To: <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
Subject: RE: git-2.51.0: Fetching tags does not work
Date: Sun, 2 Nov 2025 20:34:32 -0500
Organization: Nexbridge Inc.
Message-ID: <01b001dc4c62$04943500$0dbc9f00$@nexbridge.com>
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
Thread-Index: AQIJGRkyyjRKm2EGbni1csKn3PqpKAICYXguATPxFZS0bN7sMA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251102-6, 11/2/2025), Outbound message
X-Antivirus-Status: Clean

On November 2, 2025 7:47 PM, David Bohman wrote:
>I am sorry to have to bring this up again, but I am still occasionally =
seeing this
>problem with git 2.51.2.
>
>What is happening is that I am cloning a repository as bare, and then =
later I try to
>fetch the new content including the tags:
>
>% ( cd bind9.git; git fetch --tags )
>>From https://gitlab.isc.org/isc-projects/bind9
> * branch                  HEAD       -> FETCH_HEAD
> ! [rejected]              stable     -> stable  (would clobber =
existing tag)
> * [new tag]               v9.18.41   -> v9.18.41
> * [new tag]               v9.20.15   -> v9.20.15
> * [new tag]               v9.21.14   -> v9.21.14
>% ( cd bind9.git; git fetch --tags )
>>From https://gitlab.isc.org/isc-projects/bind9
> * branch                  HEAD       -> FETCH_HEAD
> ! [rejected]              stable     -> stable  (would clobber =
existing tag)
> * [new tag]               v9.18.41   -> v9.18.41
> * [new tag]               v9.20.15   -> v9.20.15
> * [new tag]               v9.21.14   -> v9.21.14
>% print $?
>1
>% ( cd bind9.git; git tag ) | grep v9.20.15 %
>
>As you can see, it is getting an error for one of the tags, but it is =
also failing to record
>the other new tags into the repository.

git fetch --tags --force

should clear your situation, where the tag is different on the upstream =
compare to
your local clone.

