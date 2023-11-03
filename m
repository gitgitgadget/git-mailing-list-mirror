Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE233E2
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC2194
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 12:19:02 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A3JFlK7061347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Nov 2023 19:15:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: <git@vger.kernel.org>
References: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com> <007101da0e65$13e3c170$3bab4450$@nexbridge.com> <20231103155220.GA1470570@coredump.intra.peff.net> <007f01da0e6f$d5031a40$7f094ec0$@nexbridge.com> <20231103162119.GC1470570@coredump.intra.peff.net>
In-Reply-To: <20231103162119.GC1470570@coredump.intra.peff.net>
Subject: RE: [BUG] Git 2.43.0-rc0 - t4216 unpack(Q) invalid type
Date: Fri, 3 Nov 2023 15:18:51 -0400
Organization: Nexbridge Inc.
Message-ID: <00a801da0e8a$97acc950$c7065bf0$@nexbridge.com>
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
Thread-Index: AQEUd8/EnQEVsughERcpf+Q0yFJ6MQFgCjSkAPsMJGUCQz3GsAMnYayAsbX3tfA=
Content-Language: en-ca

On November 3, 2023 12:21 PM Jeff King wrote:
>On Fri, Nov 03, 2023 at 12:07:17PM -0400, rsbecker@nexbridge.com wrote:
>
>> What I get from Perl is
>> $ perl -e '
>> >     my $bytes =3D "\1\2\3\4\5\6\7\8";
>> >     my $q =3D eval { unpack("Q>", $bytes) };
>> >     print "Q =3D ", defined($q) ? $q : "($@)", "\n";
>> >     my ($n1, $n2) =3D unpack("NN", $bytes);
>> >     print "n1 =3D $n1\n";
>> >     print "n2 =3D $n2\n";
>> >     print "computed quad =3D ", ($n1 << 32) | $n2, "\n";  '
>> Q =3D (Invalid type 'Q' in unpack at -e line 3.
>> )
>> n1 =3D 16909060
>> n2 =3D 84281144
>> computed quad =3D 84281144
>
>OK, that matches what I expected. Hopefully the patch I just sent (our =
mails just
>crossed) will fix it for you.
>
>> Because perl itself is 32-bit, not 64-bit on this platform. So even
>> moving git to 64-bit will not correct the issue.
>
>Yep, exactly.

Your patch worked! Thanks.

