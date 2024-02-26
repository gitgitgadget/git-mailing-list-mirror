Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F480058
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970617; cv=none; b=EVjHx7wjK3oZFwpckIUYvFRPq76uyVMf7cpeUl/D2obVhxoR4i/WVM7pMZFJIS6DnfrX9RA6cTn55Q8I9aaemucfrg1JGmzVEzAfnyvkGJJkUsEQQvBX/rWD9ViQXHGGu75XInwQeKtwY1nWHFeIfU1fReIj9BZPZ/ISCs/o/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970617; c=relaxed/simple;
	bh=6E6ErtNOb7rmRs1rRBmbMqA9LnMZK62Nro02PePofpA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GM8Sr8VstwcpRvTKwa9JrRmtzUeUW58JCNZh9KZguP+F9gpMVqDCtG+sSYnTd5XZhgppIGS2EHZlmkdmRgTu1fr8k769dliOLimPSIo5ypsBGRuY+Aovy3XIaYG2blUdmmNALdKGxd/+U0XHH3WLXh/QuaTejTt9k20sgyBSgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41QI3QJ42182311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:03:27 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <phillip.wood@dunelm.org.uk>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc: <git@vger.kernel.org>, "'Patrick Steinhardt'" <ps@pks.im>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com> <01be01da681e$0c349090$249db1b0$@nexbridge.com> <20240225191954.GA28646@tb-raspi4> <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com> <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com> <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
In-Reply-To: <76962a0c-adfd-47a5-a017-a117ba14ae09@gmail.com>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Mon, 26 Feb 2024 13:03:21 -0500
Organization: Nexbridge Inc.
Message-ID: <023c01da68de$196615c0$4c324140$@nexbridge.com>
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
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NoQLej1jbAXwNbRICuPECnQG1wVidAfcdzTGwh2SeQA==

>From: Phillip Wood <phillip.wood123@gmail.com>
On Monday, February 26, 2024 11:00 AM, Phillip Wood wrote:
>To: rsbecker@nexbridge.com; 'Torsten B=C3=B6gershausen' <tboegi@web.de>
>Cc: git@vger.kernel.org; Patrick Steinhardt <ps@pks.im>
>Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
>
>On 26/02/2024 15:32, Phillip Wood wrote:
>> Hi Randal
>>
>> [cc'ing Patrick for the reftable writer]
>>
>> On 25/02/2024 20:36, rsbecker@nexbridge.com wrote:
>>> On Sunday, February 25, 2024 2:20 PM, Torsten B=C3=B6gershausen =
wrote:
>>>> On Sun, Feb 25, 2024 at 02:08:35PM -0500, rsbecker@nexbridge.com =
wrote:
>>>>> On Sunday, February 25, 2024 1:45 PM, I wrote:
>>>>>> To: git@vger.kernel.org
>>>> But I think that this should be used:
>>>> write_in_full()
>>>
>>> My mailer autocorrected, yes, xwrite. write_in_full() would be safe,
>>> although a bit redundant since xwrite() does similar things and is
>>> used by write_in_full().
>>
>> Note that unlike write_in_full(), xwrite() does not guarantee to =
write
>> the whole buffer passed to it. In general unless a caller is writing =
a
>> single byte or writing less than PIPE_BUF bytes to a pipe it should
>> use write_in_full().
>>
>>> The question is which call is bad? The cruft stuff is relatively new
>>> and I don't know the code.
>
>I should have been clearer that I do not think any of these calls are =
the likely
>problem for the cruft pack code. I do think the reftable writers are =
worth looking at
>though for git in general.
>
>For the cruft pack problem you might want to look for suspect xwrite() =
calls where
>the caller does not handle a short write correctly for example under =
builtin/ we have
>
>builtin/index-pack.c:                   err =3D xwrite(1, input_buffer =
+
>input_offset, input_len);
>builtin/receive-pack.c:         xwrite(2, msg, sz);
>builtin/repack.c:       xwrite(cmd->in, oid_to_hex(oid),
>the_hash_algo->hexsz);
>builtin/repack.c:       xwrite(cmd->in, "\n", 1);
>builtin/unpack-objects.c:               int ret =3D xwrite(1, buffer +
>offset, len);
>
>Best Wishes
>
>Phillip
>
>>>>> reftable/writer.c:              int n =3D w->write(w->write_arg,
>>>>> zeroed,
>>>>> w->pending_padding);
>>>>> reftable/writer.c:      n =3D w->write(w->write_arg, data, len);
>>
>> Neither of these appear to check for short writes and
>> reftable_fd_write() is a thin wrapper around write(). Maybe
>> reftable_fd_write() should be using write_in_full()?
>>
>>>>> run-command.c:                  len =3D write(io->fd, =
io->u.out.buf,
>>
>> This call to write() looks correct as it is in the io pump loop.
>>
>>>>> t/helper/test-path-utils.c:                     if (write(1,
>>>>> buffer,
>>> count)
>>>>> < 0) >>> t/helper/test-windows-named-pipe.c:             write(1,
>>>>> buf, nbr);
>>>>> t/helper/test-windows-named-pipe.c:             write(1, buf, =
nbr);
>>
>> In principle these all look like they are prone to short writes.
>>
>>>>> trace2/tr2_dst.c:       bytes =3D write(fd, buf_line->buf,
>>>>> buf_line->len);
>>
>> This caller explicitly says it prefers short writes over retrying

I'm getting caught a bit behind the curve. After rebuilding from master, =
I'm now getting:

+ test 1708960150 -lt 1708970156
+ test_line_count =3D 3 cruft.before
+ test_line_count =3D 2 cruft.after
test_line_count: line count for cruft.after !=3D 2

This is looking more like a different problem than xwrite().

