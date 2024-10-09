Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D94C69
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 00:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433161; cv=none; b=HYZxltOs+93cmkqnRRMATkXAK0eobwoKAbL6iYubpGLACDkF0lBEOYTzV+Q3t5UzYQ06S53Kg+f0tGOg0phpFIkjpNn+mMJbDkwwFJJ1h9UvI60ewbJX9i0QAFg/+7ffouybXvm//WP3o9iWaXObCd1fssVkflPf+ilZiQbeM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433161; c=relaxed/simple;
	bh=VMzp5Py3Cibbxw6lLgpQdrtipa5mwOnacQSdSyKjD6I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBkJ98cJfXRL6GMixcnJI1MExD8/mzhYjjZoldRYPOL29LxM6c/PVkpFlEyV9uRalhSkzAw7T0+g+CYGKHjb7CE1qsTVFE+rilMlOWseCETuovSlZIGUK5KdiHE1EjTKLyOSaUSEK2hT34w23u2G+TRSMIyl6+Sg47cemZ+nBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4990CM0M4121692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Oct 2024 00:12:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Josh Steadmon'" <steadmon@google.com>
Cc: <git@vger.kernel.org>, <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>, <mh@glandium.org>,
        <sandals@crustytoothpaste.net>, <ps@pks.im>, <sunshine@sunshineco.com>,
        <phillip.wood123@gmail.com>, <allred.sean@gmail.com>
References: <cover.1723054623.git.steadmon@google.com>	<cover.1728429158.git.steadmon@google.com>	<2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com> <xmqqed4qxior.fsf@gitster.g>
In-Reply-To: <xmqqed4qxior.fsf@gitster.g>
Subject: RE: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs and libgit-rs-sys
Date: Tue, 8 Oct 2024 20:12:18 -0400
Organization: Nexbridge Inc.
Message-ID: <02a401db19df$eaca75e0$c05f61a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAEkT8GpAlEA22ECSRBqxbOA8ipQ

On October 8, 2024 7:46 PM, Junio C Hamano wrote:
>Josh Steadmon <steadmon@google.com> writes:
>
>> Add environment variable, INCLUDE_LIBGIT_RS, that when set,
>> automatically builds and tests libgit-rs and libgit-rs-sys when `make
>> all` is ran.
>
>Is this unusual, or is it just like how other makefile macros like say
USE_NSEC (to
>cause the resulting Git to use subsecond mtimes) are meant to be used to
control
>the build?  IOW, shouldn't this be documented near the top of the Makefile,
e.g.
>
>    diff --git i/Makefile w/Makefile
>    index 41ad458aef..2b55fe9672 100644
>    --- i/Makefile
>    +++ w/Makefile
>    @@ -392,6 +392,9 @@ include shared.mak
>     # INSTALL_STRIP can be set to "-s" to strip binaries during
installation,
>     # if your $(INSTALL) command supports the option.
>     #
>    +# Define INCLUDE_LIBGIT_RS if you want your gostak to distim
>    +# the doshes and ...
>    +#
>     # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON
>compilation
>     # database entries during compilation if your compiler supports it,
using the
>     # `-MJ` flag. The JSON entries will be placed in the
`compile_commands/`
>
>It might make sense to follow naming convention to call it NO_RUST and flip
its
>polarity.  Those who do not have or want libgit-rs and friends can say
NO_RUST but
>otherwise it gets built by default.  It would give you a wider developer
population
>coverage.

Some of us who do not have Rust (yet) approve this message. I hope our
situation
will change on having Rust on NonStop.

