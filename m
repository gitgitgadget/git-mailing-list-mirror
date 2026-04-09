Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEF307AC6
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764106; cv=none; b=XCFIq4SQeCbJFv5HcjuX5UT5WDnyQOJ+bQmfdybRWXO0JoC6fpAK89vxSnRWWG6bWMpatJjjil4fRS8sSCrwRB3I1zRmVyJksruPOo+RkxMRjiZmwMIuYvc1qCXXFaQCYQ7iyl6ewJJa1kd43cSCynUWQQTTHQiASFRhnqWRLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764106; c=relaxed/simple;
	bh=b8n5KcRKmRU8K2DWJVQg7642/+kYmHU22DJ+KQxVJ2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=peEssk2hfgvZgM0A4dPooA26YB5IBW0/z59uRkcppTXAJWy6nkm0AziM+g8SmgHdp7YdoBk7V2Ny6dDHKwiFU+gxGiRZXme+5gDjZDSe7rLUlISppC7qxdipnGnEbh8GY8K3jc8yn0AxV7f1fr8fxC9ig8gHBhZQv9fMrB9yex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 639JmLXP3657999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 9 Apr 2026 19:48:22 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: 2.54.0-rc1 NO_WRITEV=Nope  does not work
Date: Thu, 9 Apr 2026 15:48:16 -0400
Organization: Nexbridge Inc.
Message-ID: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
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
Thread-Index: AdzIVhmHh0dGYx9nRQmmGl3fJAgzgA==
X-Antivirus: Norton (VPS 260409-6, 4/9/2026), Outbound message
X-Antivirus-Status: Clean

With a completely clean build, we are getting writev() being used anyway =
on
NonStop:

/usr/coreutils/bin/make NO_TCLTK=3DNoThanks NO_WRITEV=3DNope V=3D1
prefix=3D/usr/local-ssl3.5 CFLAGS=3D-g -O2 -D_LARGEFILE64_SOURCE=3D1
-D_FILE_OFFSET_BITS=3D64 -Winline -I/usr/local-ssl3.5/include
-I/usr/coreutils/include -I/usr/tandem/xml/T0625L01_AAE/include
LDFLAGS=3D-D_LARGEFILE64_SOURCE=3D1 -D_FILE_OFFSET_BITS=3D64
/usr/coreutils/lib/libz.a -L/usr/local-ssl3.5/lib -L/usr/coreutils/lib
-L/usr/tandem/xml/T0625L01_AAE/lib SHELL=3D/usr/coreutils/bin/bash
GIT_VERSION=3D2.54.0.rc1

Down to the first instance:

Cloning into bare repository 'clone.git'...
remote: Enumerating objects: 629, done.
fatal: writev error: Invalid function argument
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
not ok 25 - clone from bitmapped repository
#
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rm =
-fr clone.git &&
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git =
clone --no-local --bare . clone.git &&
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git =
rev-parse HEAD >expect &&
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git =
--git-dir=3Dclone.git rev-parse HEAD >actual &&
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
test_cmp expect actual
#

Did I mess this up?

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


