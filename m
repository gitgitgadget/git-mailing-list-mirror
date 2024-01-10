Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5074C3C1
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (ec2-99-79-189-168.ca-central-1.compute.amazonaws.com [99.79.189.168])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40AHpSLD1657033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:51:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Mohit Marathe'" <mohitmarathe@proton.me>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc: <git@vger.kernel.org>, <gitster@pobox.com>, <britton.kerin@gmail.com>,
        <peff@peff.net>
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me> <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com> <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
In-Reply-To: <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
Subject: RE: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
Date: Wed, 10 Jan 2024 12:55:11 -0500
Organization: Nexbridge Inc.
Message-ID: <004601da43ee$2b6cd0c0$82467240$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQJ5DOmfqW7jSMfzP26k7WvTwFDDvAJhEw67AljiVW6vb/HgwA==

On Wednesday, January 10, 2024 12:38 PM, Mohit Marathe wrote:
>>In https://public-inbox.org/git/xmqqjzpjsbjl.fsf@gitster.g/ Junio =
says:
>>
>>"Some places use atoi() immediately followed by strspn() to skip over
>>digits, which means they are parsing an integer and want to continue
>>reading after the integer, which is incompatible with what
>>strtol_i() wants to do.  They need either a separate helper or an
>>updated strtol_i() that optionally allows you to parse the prefix and
>>report where the integer ended, e.g., something like:"
>>
>>and then he suggests the above helper.
>>
>>So it seems that the two instances you found look like good places
>>where Junio says the new helper could be useful.
>>
>>Now if you want to continue further on this, I think you would need to
>>take a closer look at those two instances to see if replacing atoi()
>>there with the new helper would improve something there or not. If you
>>find it would improve something, be sure to explain what would be
>>improved in the commit message.
>
>I took a closer look at `builtin/patch-id.c` and it seems replacing =
`atoi()` (which is
>used to parse numbers in the hunk header) wouldn't improve anything, =
unless I'm
>missing something.
>
>So then I tried finding other places where `atoi()` can be replaced but =
I find it
>difficult to find any reason that would justify the change.
>So far I've only looked at few of the MANY occurrences of `atoi()`.
>As far as I understand, the only advantage of `strtol_i()` over =
`atoi()` is better error
>handling. And most of places I've seen either already takes care of =
that or does not
>need that at all.

I am not sure this is a good idea. The error detection inside strtol_i() =
reports a -1 if the supplied text value is invalid. This does not =
differentiate between an invalid value and a valid "-1" supplied. =
Replacing all instances of atoi() with strtol_i() will likely cause =
breakages as the error semantics are different between the two.
--Randall

