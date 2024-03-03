Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5E8F40
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709448178; cv=none; b=XJDnAUxxRNi1ANJ6uAJc/ko4vwViZeeqgPe5rPq/w9uijHMyiRG31dhYnB6FkAjtvK4XvwT15en6xsDiC+Jq8EFUBV/X7bpz9HiX6SNT+bgIXdLSW4Azz1cv9Yb2H0lUfU+eSt2JVMUrWJPRH+Bxl+My/h2RZGH6YEexZDrb2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709448178; c=relaxed/simple;
	bh=JDp2zp0c0jofgzSAGum6ZeIvFZazolJwmSjVb0YgRHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4G3WhT+DPKMHONPuWnugo9AK+Aq+7wjyy+y1zU3RLjqEa0+Z0V+MOOBdSlgtOhG+9FSqe69VtvvIKwlwxDIlRToJuPu/P/kITwgh0658cR3iSUJs5PDjX6ChP3/I25iPbgvHnUp4yOBZJ2cmA0CSAcR3vbB7JQp1a7PQyqgWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=m0XsKJQC; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="m0XsKJQC"
Received: from localhost (ip-109-42-178-42.web.vodafone.de [109.42.178.42])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 4236ggaF027332
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 3 Mar 2024 07:42:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709448163; bh=JDp2zp0c0jofgzSAGum6ZeIvFZazolJwmSjVb0YgRHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m0XsKJQCXyOvHjYiwwkSuBnlUWJNZcftc9ERXJ17saYN/ez5yn+xf1PnivT8uKTBr
	 kJm3d2e1DY0EZzv5XnPJIKUND1xwARnpUHoBbbDETKcRsaHywoIDU4kBxhE5AiGqB9
	 7y89HR31o+pBpHlfnZ5z6yQRSUgcOJcdCegYLMck=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine
 <ericsunshine@charter.net>, git@vger.kernel.org,
        Aryan Gupta
 <garyan447@gmail.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
In-Reply-To: <xmqqbk7wy1di.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	02 Mar 2024 09:44:41 -0800")
References: <20240301204922.40304-1-ericsunshine@charter.net>
	<xmqqsf194n7a.fsf@gitster.g>
	<CAPig+cSt4Q0e+DioFiy7yjBgn5+gWNqQOYc0eCAgdYrZUp8VBQ@mail.gmail.com>
	<ghr0gtglhd.fsf@gouders.net> <xmqqbk7wy1di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 03 Mar 2024 07:42:36 +0100
Message-ID: <ghmsrfhl43.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> On Fri, Mar 1, 2024 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>>> Eric Sunshine <ericsunshine@charter.net> writes:
>>>> > A more accurate message might be "'foo' is empty but
>>>> > should not be (or doesn't exist)", but that's unnecessarily long-win=
ded
>>>> > and adds little information that the test author couldn't discover by
>>>> > noticing the file's absence.
>>>>
>>>> The "adds little information" version may be
>>>>
>>>>                 echo "'$1' is either missing or empty, but should not =
be"
>>>> ...
>>> I find "'$1' is either missing or empty, but should not be" suggestion
>>> clear and easily understood. I'll reroll with that.
>>
>> This is a view from a position with more distance:
>>
>> I find that not so easily understood -- the "but should not
>> be" part is rather unexpected and I feel, it doesn't provide necessary
>> information, e.g.:
>>
>> test_path_is_executable () {
>> ...
>> 		echo "$1 is not executable"
>> ...
>>
>> also doesn't state what is wanted and I doubt that message doesn't
>> clearly describe the problem.
>
> I cannot tell if you really meant the double negative involving
> "doubt", but assuming you did, you are saying that

I'm sorry about that double negative which was probably wrong wording of
a non-native speaker.

>     With "X is not Y", it is clear enough that we expect X to be Y
>     (if it were not clear to somebody who read "X is not Y" that we
>     want X to be Y, then "X is not Y, but it should be" may needed,
>     but "X is not Y" is clear enough).
>
> So you think "$1 is either missing or empty" is better without "but
> should not be" added to the end?  Am I reading you correctly?
>
> I think this takes us back pretty much to square one ;-) but that is
> also fine.
>
> But the above argument depends on an untold assumption.  The message
> "X is not Y" must be clearly understood as a complaint, not a mere
> statement of a fact.  I am not sure if that is the case.
>
> Instead of "X is not Y, but it should be", the way to clarify these
> messages may be to say "error: X is not Y", perhaps?

That is exactly what came to my mind when I was later re-thinking
what I had written.

>> While I looked at it: there is another `test -s` in test_grep () that
>> perhaps could be fixed the same way:
>>
>> 	if test -s "$last_arg"
>> 	then
>> 		cat >&4 "$last_arg"
>> 	else
>> 		echo >&4 "<File '$last_arg' is empty>"
>> 	fi
>
> If you are worried about "test -s" failing because "$last_arg" does
> not exist, then you are worried too much.  We upfront guard the
> test_grep() helper with "test -f" of the same file and diagnoses the
> lack of the file as a bug in the test.  And we do not assume gremlins
> removing random files while we are running tests.

Yes, thank you for clarification and sorry for the noise.

Dirk
