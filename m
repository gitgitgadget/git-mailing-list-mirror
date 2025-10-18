Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A21DE8BF
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797649; cv=none; b=E/wV3acKZqZLohZGZ87oQuac4Bg8q6lkuRlAei/oMy8G3WlmcaQeT7pLuU4JHatZe/7R9AOlR/cB4fVNmC2EGrrE3dg4rWxkTe76qAn+OUapN7LhbHNkot34jzUOZgpmE9kZEqOwsqgg8Y6/tpuGGHr1OpYbsZJcLdG3BB8iQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797649; c=relaxed/simple;
	bh=V7ndHMhq2kigUGjuRgv2w8AlaIBhv1W/pyQpCRQFqK0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/uedvydo7FQNp3N+kX9/mvTnG8Eg+y3Jwc2qAmBvAK+g+O0/iRrJtTWDEhKOfrDdna576wp87ReRb6t7fJEfITJG+I8z26w4ve65X/cRks1apaXtSkYmhTQzyKbB9+tlKb2drLYtjRIQXF8nqHwRgnMgOyvkL1eg8Lj7QSZcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59IEGvRk3595906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Oct 2025 14:16:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Thomas Braun'" <thomas.braun@virtuell-zuhause.de>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, "'El_Hoy'" <eloyesp@gmail.com>,
        <git@vger.kernel.org>
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com> <xmqqsefhxlmd.fsf@gitster.g> <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de> <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
In-Reply-To: <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
Subject: RE: Making git grep ignore binary the default
Date: Sat, 18 Oct 2025 10:16:52 -0400
Organization: Nexbridge Inc.
Message-ID: <00af01dc4039$dd45e090$97d1a1b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLsKBeokHN9dXt0saN3RrfzSNhZtgNg7o9EAXJiehYCgFG6PrJthhfA
X-Antivirus: Norton (VPS 251018-2, 10/18/2025), Outbound message
X-Antivirus-Status: Clean

On October 17, 2025 8:52 PM, brian m. carlson wrote:
>On 2025-10-17 at 23:29:22, Thomas Braun wrote:
>> Am 17.10.2025 um 23:29 schrieb Junio C Hamano:
>> > Simply because we have never needed to do something similar to "-a"
>> > and "-I" that we added in early 2006 for the past nearly 20 years.
>> > Also because GNU does not have any such thing to force "-a" or "-I"
>> > as default.  The biggest reason is that it would be surprising if
>> > such a change does not break existing scripts that have been =
written
>> > by people over the years.
>>
>> And if we only would have the config option "grep.ignoreBinary"
>> defaulting to false with no default change whatsoever? I always want
>> to ignore binaries when grepping and find it a bit tedious that I =
have
>> to spell it out all over again. And yes I do have an alias as well =
but
>> usually don't remember to use it.
>
>As Junio said, this could break existing scripts.  If I write a command =
which uses `git
>grep` and expects to find all matching files, it would not work on your =
system with
>`grep.ignoreBinary` set to true.
>
>For instance, if I am working on a project for a company and must =
exclude source
>code with a certain vendor's copyright (because we don't have =
permission to
>distribute their code), then it would be very bad if I accidentally =
distributed that
>company's binary files due to `git grep -l PATTERN | xargs rm -f` not =
matching them
>since it would violate the license.
>
>This is just an example, but there are lots of cases where people do =
really want to
>search every file.
>
>> I'm also curious what people are looking for in binary files with git =
grep.
>
>It's common to mark PDFs or PostScript files as binary because they =
often contain
>embedded binary fonts, but they are actually mostly text and can be =
usefully
>searched with grep.  For instance, I once created some awards for a =
non-profit
>based on combining standalone text-based PostScript code along with =
output from
>groff, so those independent pieces could end up being source that you =
might store
>in Git and search, even if many configurations would use `*.ps -text` =
in a system
>gitattributes file.
>
>Sometimes you also have images or such for a website, which contain XMP
>metadata (a form of XML-serialized RDF).  Finding those images which =
have certain
>author metadata or a certain license URL embedded in them could be =
valuable.

I agree that this will break scripts. There are quasi-binary files in =
some SQL
spaces that really benefit from git grep working. Please do not make =
this the
default.

