Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1845C1C
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163072; cv=none; b=DsI7PdsQ8dWw/5PiXm9tqbLi2Zsp/jYq6Ktrr3ndX2nbKxe1CtKWiZMKd36UzKhRA9/kjY5hDeagL+82VbeBJPHKvND+aUw/g0LRLnKvXl1kWOIVbZMiGXMljI2ogdHjonmcOW+3Ri5RfvgOcKB1OD2XPhBuD5Dcy9qm+L0qmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163072; c=relaxed/simple;
	bh=M+dv/nN0y4e4JSr07isoJxvCH6Y1gmOxzydyWgdmSEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPTrMbCni669jfDb9R8bUZbsG6eGLnLJrJAMmFX3UW8g7ItAGjeh35M2ZLz+syo8foENSjHgALGcN9OKXlV954eGEMZdmfoJJuFb575R6UIkVJGl2b03Ho6DWApbyJOStVXzOaUzHpdk++gOx4PYXnYiUodRsRP0igydcwnhp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XrjN3oeM; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XrjN3oeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707163067; x=1707767867; i=l.s.r@web.de;
	bh=M+dv/nN0y4e4JSr07isoJxvCH6Y1gmOxzydyWgdmSEo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=XrjN3oeMoe1SG79+LXAcGgfuBTVseyBvZBkGZoxFeNqzFCy12V/QA37H3wS2ugaO
	 //a9m3kSfcXMIshS8LPdeMZY8pDTX6fieiXiK8J3rnwUmiZ+wOQv7uhYhul+HiwG1
	 YFOyOgLcMmPu+dCQ58tK8PRQFfp9Gl9ztnWlG6clSt3uKLNTwRqhnWE85eFCBnrFu
	 llqQegbVvrLVMIOsHPsXWiHYIFhO4p35LlE0oYOPQoilMB+xIgFm95KmiA5UW4Q5V
	 4/5DVZ3jNm7msso4Vm+ektlli+3zNp6OXMVeCZXzzyEyxRx9x2a7QHCmzgLhg+efq
	 +Spbe7hyIvMHivN/QQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.60]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFhg-1r2xGz1SXi-00eXVu; Mon, 05
 Feb 2024 20:57:47 +0100
Message-ID: <ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
Date: Mon, 5 Feb 2024 20:57:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BfzJoMYmpW45eEfiWnPZB88u/IOvKMg+GdeaCl63p3w9smJpRY
 QANqjMbNzURnAVhm/LUv5MXWTGVQCxghuTNsjvTTaOIfoy98x6c/daKmqlOvkzYrslX9Wx/
 PgBeW4epxt8JKzCLbkn3V2g9M5Dv12qo4jOgI3blm9xcAoJMEAvQV+G90ldp8UmjMxzXmWK
 QsXJLlI4A/KATmpb/s4JQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZJ8MmHMkktQ=;q6AigO9p9sgfdRmEqzQLhpB7L3c
 n+ShFgUZBiBOIvZ/TriwD1/S65MtgQ3cW89B3RB0Ipp4IYlpkWxcO8+Zsrvcu71bVLDcqnHnI
 l4Rr8wxorMknw5sdcG0g9AdtprW7NXJOI/jW5C765hGEkFqyCON6hfexha5JSrq+PW39MX+op
 /3Yyb4zJSdk4G984fCy914mMHU71CB1fLeqD0HY0VvOJCnzjgWnGkQ78njPL871ouF6+wzvXg
 msnhJFb04hiBy0AMx5oCtx15AxjEslDen7rxWdX/PQXksOyPcc2nv9YUrPg76q9Y8ULLgBvz+
 S764Z/VIbycum5wIkk/69xPD0Vo8L9EmYYxCQ/egLVtocrECoCY5PJB+P1xewAsH4KMBY01k6
 rvLacIMTX8tlT0llQ4SdPpnzLx0Y1v4Gtz4zLRMwstgQUp6RrpD/xxVMYiFV/UBhfALBxoISf
 hjnCoCPKXcbIWiU6L06eiXoxxsw6uvrEpT3j61ASCEd3vttuwoKCQMBzJzcs0dTW69Z2CDVRa
 VctPg4+0PPdDS3IJofZ1Fh75WuUBFs+hSAGM4lLRxUhpvCMGGmNZkZkB1CgAu/9hlgWDgYn5M
 98cJmrSEqojfZFldgU/RhYwGUUPqLJs4qaguRGyx8yjZEEEoEK0TL6Nm/hXo0LW+tWoUub4oJ
 spI0MToegNH96jmSBN4iOHY9w3T/MPg2X+R11NCNAZb0Qw08E1b51xZ1rlEq18AEGpw6EdKFe
 fQKZkTRO354MvQCbmzerIC61XTzcprVc/Oco/4a0i/A66Sq1mTRFu83Cfm3g464OkFf5lIezT
 85WRyrYQoodIPF75tskNyN8gCmCH32OMut6S5iD3TyhYs=

Am 05.02.24 um 18:21 schrieb Chandra Pratap via GitGitGadget:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     commit.c: ensure strchrnul() doesn't scan beyond range
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1652%2=
FChand-ra%2Fstrchrnul-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1652/Chan=
d-ra/strchrnul-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1652
>
>  commit.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index ef679a0b939..a65b8e92e94 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1743,15 +1743,9 @@ const char *find_header_mem(const char *msg, size=
_t len,
>  	int key_len =3D strlen(key);
>  	const char *line =3D msg;
>
> -	/*
> -	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
> -	 * given by len. However, current callers are safe because they comput=
e
> -	 * len by scanning a NUL-terminated block of memory starting at msg.
> -	 * Nonetheless, it would be better to ensure the function does not loo=
k
> -	 * at msg beyond the len provided by the caller.
> -	 */
>  	while (line && line < msg + len) {
>  		const char *eol =3D strchrnul(line, '\n');
> +		assert(eol - line <=3D len);

Something like this might work in Verse, but C is more simple-minded.
You can't undo an out-of-bounds access after the fact, and assert()
would be compiled out if the code is built with NDEBUG anyway.

If you want to make the code work with buffers that lack a terminating
NUL then you need to replace the strchrnul() call with something that
respects buffer lengths.  You could e.g. call memchr().  Don't forget
to check for NUL to preserve the original behavior.  Or you could roll
your own custom replacement, perhaps like this:

char *strnchrnul(const char *s, int c, size_t len)
{
	while (len-- && *s && *s !=3D c)
		s++;
	return (char *)s;
}

A test with the new unit-test framework would be nice.  It should be
possible to show that the current code runs over the passed len,
without causing undefined behavior.  E.g. find_header_mem("foo bar",
2, "foo", &len) is safe, but returns "bar" instead of NULL.

>
>  		if (line =3D=3D eol)
>  			return NULL;
>
> base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b

