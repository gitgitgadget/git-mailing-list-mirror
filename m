Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1238155A59
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732080020; cv=none; b=Y5ZcRtZuDe961Kixxn8uVcj7iE+8YW4Dl1ianVGj+0G8vBzQJwmgxlHi3Un7qaa68XMGjgz/hIs5nTOw/WsmHKqt5RXw9Zx5Av2vk6mPWOEJPaJxnME1lAme/dgJ5CHOSwXh06Wb5hy9QbGqAhSuL2EQN/WUgWwTxq40QNo29Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732080020; c=relaxed/simple;
	bh=ZmWaFIfQccgjpSNree8m8R9ndXOPyWHul7uY4vTdXlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab1Us4olTxv29GuIwAEQHGJlRNR0cRypJOXSPGHAeTzj4Bix9+xK1ljR7Zj38w351qPi4KEXNpplXyb0Csthb9u1yb4tLy+znsyyzwTCyWQqzKwLRzvQ1Q7diQxGoBSUE9Acqgr7FWxtl57tiR16hSznxV0mrrsnYP5Y2pjFlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RihyGTHb; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RihyGTHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732080016; x=1732339216;
	bh=eamoleH/irSMkDFBJTeIBGRrKi0AEwWq0ilUtPHWYsE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RihyGTHbcv2MS0CMVuijS2J8kuw32/UsELMjUcT7CzNtXxPX0rS54PMWhxoOO3sTM
	 EWDNON8TI+WK9qg7Ng+4437E10Ffp8SqOcBV+oz23ngDUC61eoq3UMaXneBQJM30/t
	 LdYr9D2ILyus1Sw7z1sZc+Z/wV/8B/EZc38a665R6IuzgbZOBCWq56d9gBcVQgAukz
	 P3mb5s5fVxr0tMK/4NHRQ95+0kZ0GCdxv6lCrt1A3bKbfsOaX0H6GeGaPWH36qcGWu
	 XfpjQ5m92mm7sOH9umwEoSWecItaf0zEnBh1Hw3Sc8WQC0kTQHndgD/QDMREnK2JkW
	 AEWZ64ekbEOfQ==
Date: Wed, 20 Nov 2024 05:20:12 +0000
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/8] worktree: refactor infer_backlink return
Message-ID: <D5QR4BHKBZH9.231NGDY7RCV0L@pm.me>
In-Reply-To: <977c1e75-1fef-4827-91ae-cc1a6ce7508e@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me> <977c1e75-1fef-4827-91ae-cc1a6ce7508e@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 0b57af0df6bc41f6199799485f2f6b55ad0e8d03
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Nov 19, 2024 at 9:08 AM CST, Phillip Wood wrote:
> Hi Caleb
>
> Thanks for splitting this out into a separate patch
>
> On 01/11/2024 04:38, Caleb White wrote:
>> -static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>> +static ssize_t infer_backlink(const char *gitfile, struct strbuf *infer=
red)
>>   {
>>   =09struct strbuf actual =3D STRBUF_INIT;
>>   =09const char *id;
>>
>> +=09strbuf_reset(inferred);
>
> I think the code was clearer when we reset the buf just before using it.
> That way it is easy to see that we add the path to an empty buffer.

I moved it up to the top of the function to make it more clear that the
buffer is reset before being used. But I can move it back.

>>   =09if (strbuf_read_file(&actual, gitfile, 0) < 0)
>>   =09=09goto error;
>>   =09if (!starts_with(actual.buf, "gitdir:"))
>> @@ -741,18 +744,16 @@ static int infer_backlink(const char *gitfile, str=
uct strbuf *inferred)
>>   =09id++; /* advance past '/' to point at <id> */
>>   =09if (!*id)
>>   =09=09goto error;
>> -=09strbuf_reset(inferred);
>>   =09strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id=
);
>>   =09if (!is_directory(inferred->buf))
>>   =09=09goto error;
>>
>>   =09strbuf_release(&actual);
>> -=09return 1;
>> -
>> +=09return inferred->len;
>>   error:
>>   =09strbuf_release(&actual);
>>   =09strbuf_reset(inferred); /* clear invalid path */
>> -=09return 0;
>> +=09return -1;
>
> Why don't we need to update the callers of this function to account for
> the new return value?

Originally this function was called inside an `if` statement, however,
another topic extracted the call to a separate line and so this return
was no longer used. I decided to keep the return anyway in case it was
useful in the future.


Best,

Caleb

