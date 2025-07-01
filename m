Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718223504D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383279; cv=none; b=No7pqYiL0qPNi45ss+PKdFz2WPE4TmaCDQ47Lxh931q1ir4AZeqzUKYp8KPZCPoOjdZGYFlaZvUxL47qfeTeT3ehzEdIa3+lBNX7TtKaP36Z5qSFZvmweDF0JBCF2aUogGT49L8OP1p0qOofGEvKRFBlJOVgvbaskyg8L7oOQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383279; c=relaxed/simple;
	bh=cZx74y0wvefWkuAfSd9eUOChpaSrFnPXIT+Z1iN65kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiD7ugU4EKd4AtljwHkpR+ruaXIWL3baHmagkPIwn3T+Ys5beMLSHPsI/D6yNLX58SzR56Wjzbgx7+8D3PaQNaYDfKur9Yduxxbj7WYE6vdk5k36FtWlZIBeR4jXEDX7tHh/xo29I32TSJmy+39hnvwUP1CJ8J9lHHroVZqdKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RXj3odbj; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RXj3odbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751383272; x=1751988072; i=l.s.r@web.de;
	bh=3COS/yJy0J8HMCwE6ZIgQu3XbO79H9SHgV1BrMWMcWQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RXj3odbj8ld/H4J2sODPWJrR2QMrXtrqFLjfzlI1SWfdoTzgmslDmTmAkcScg4rb
	 UsnqKhisYtUOLogly8BePGWLddL5k4+j6Z3UwbsmbFikjR3yrTUIaMWz+CWZYsXuZ
	 FIbpMPZL1LLlZjKbapbMtHwwWES5ggtjt8x3b01n5I91MdbRzSFq8uAPlC347u5gH
	 ijgeB5XCM1pNn9ucGDVgHHNoAsimrCal13qCtMWqCTruWVKfus7m9gDQHdQKdK56j
	 qOc2qajsEQCYRgjD8v8+8ZgaEKFYhwSZ/525NW5ycfE+O+uFwTkQ4Zh8tYdiwSaHR
	 +J1tBAiFoP/uh7+3BA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4N98-1ufjLV4BBm-00xkaW; Tue, 01
 Jul 2025 17:21:12 +0200
Message-ID: <978e38e1-45b4-4c74-856d-255a87d6c817@web.de>
Date: Tue, 1 Jul 2025 17:21:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] parse-options: add precision handling for
 OPTION_BITOP
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7b970f48-05a8-40c6-8e5b-95ce830705c0@web.de> <aGO-kbdAgMMef-A5@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aGO-kbdAgMMef-A5@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3+LmqM3TnRwAlGLPSdpAlj+QXepRmI3vSNextKbjR5fJHYND2Df
 M6qeEM9INLUzmLUJMApkNKP4XOqDY4pUD7hF0KQ57eWtc0VAeTz+2yHe+aE95mltdx/kEv3
 HDWROlus8aGqFL4ycraBLZvmIByuO5n+vVmWE2c7keS1TuZYFy9nF8TpI/egvOiJEe5wKNd
 syDmItG/UidJRCnWihnDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wy7mBSp8ClA=;Db6bICkMs3pSvGdl5vF91DzLTRT
 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
 dgD759Xyf/XjHz55dnzg==

On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> On Sun, Jun 29, 2025 at 01:51:19PM +0200, Ren=C3=A9 Scharfe wrote:
>> Similar to 09705696f7 (parse-options: introduce precision handling for
>> `OPTION_INTEGER`, 2025-04-17) support value variables of different size=
s
>> for OPTION_BITOP.  Do that by requiring their "precision" to be set,
>> casting their "value" pointer accordingly and checking whether the valu=
e
>> fits.
>>
>> Checking "defval" has the side-effect of also requiring PARSE_OPT_NOARG=
.
>=20
> Hm, requiring PARSE_OPT_NOARG for what? I cannot see it being touched in
> this patch at all, so I'm a but puzzled.

For options with OPTION_BITOP.  Adding the defval check also adds the
no-argument check by falling through to it:

diff --git a/parse-options.c b/parse-options.c
index 6bd7158806..0dc9b0324a 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -620,18 +623,19 @@ static void parse_options_check(const struct option =
*opts)
 			optbug(opts, "uses feature "
 			       "not supported for dashless options");
 		if (opts->type =3D=3D OPTION_SET_INT && !opts->defval &&
 		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
 			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
 		switch (opts->type) {
 		case OPTION_SET_INT:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
+		case OPTION_BITOP:
 			if (!signed_int_fits(opts->defval, opts->precision))
 				optbug(opts, "has invalid defval");
 			/* fallthru */
 		case OPTION_COUNTUP:
 		case OPTION_NUMBER:
 			if ((opts->flags & PARSE_OPT_OPTARG) ||
 			    !(opts->flags & PARSE_OPT_NOARG))
 				optbug(opts, "should not accept an argument");
 			break;

