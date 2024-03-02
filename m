Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A031876
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363288; cv=none; b=mmAdatlX7DWqH3bzpUwBTsVdty28iREvhp39loZY4SzUur28SvQVNCv4Nw9XJglBqmlvf9+ULQBf+B5dK8oAlBLiwZ4+BfffMfag9b9LLTpOpSVqFHMcYs5FFZHtJHPfGOLJsVcwJ4NnuZAuMwYEzPdbM0pBCHWSm5tDgi8xd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363288; c=relaxed/simple;
	bh=v7tD9LkY0sEbOJrm/qhjowxA6EQxmw1qyHQYvXJMkJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXRDBTlNSrKWDzaF1X4wGfo1vHxJ3I+NenRSgsNvwHMHXU8DDZFjntAdOVUzxGKbs6Rz10of6jiyxuUW9SH0LHrlxNESpnuRTXGEEXwzPsGM6oNATyHAueUINLNCzzyrauYD8YJG03BBHDyN48XDkeLuyjcDqXa2hWHkkipOLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Mnh9qLGB; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Mnh9qLGB"
Received: from localhost (ip-109-42-178-42.web.vodafone.de [109.42.178.42])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42277lDg006506
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 2 Mar 2024 08:07:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709363269; bh=v7tD9LkY0sEbOJrm/qhjowxA6EQxmw1qyHQYvXJMkJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Mnh9qLGBnO4CgtnFePUjCdHMg/wDQz8/92zdz3aRY9ZVPr2PSCMSupFlo3xhUDdEg
	 V7x11Z73KvLZZKCXbPiY4kivuty3dI7mue1K0RAjuEqZwWqIbS65wCThNgPtMcNtwI
	 mAtnjaIz6s9jJG7pUfvyzqhZ3PHRPTe9UzWbvtSc=
From: Dirk Gouders <dirk@gouders.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine
 <ericsunshine@charter.net>, git@vger.kernel.org,
        Aryan Gupta
 <garyan447@gmail.com>
Subject: Re: [PATCH] test-lib-functions: simplify `test_file_not_empty`
 failure message
In-Reply-To: <CAPig+cSt4Q0e+DioFiy7yjBgn5+gWNqQOYc0eCAgdYrZUp8VBQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 1 Mar 2024 17:59:42 -0500")
References: <20240301204922.40304-1-ericsunshine@charter.net>
	<xmqqsf194n7a.fsf@gitster.g>
	<CAPig+cSt4Q0e+DioFiy7yjBgn5+gWNqQOYc0eCAgdYrZUp8VBQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 02 Mar 2024 08:07:42 +0100
Message-ID: <ghr0gtglhd.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Mar 1, 2024 at 5:11=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>> Eric Sunshine <ericsunshine@charter.net> writes:
>> > A more accurate message might be "'foo' is empty but
>> > should not be (or doesn't exist)", but that's unnecessarily long-winded
>> > and adds little information that the test author couldn't discover by
>> > noticing the file's absence.
>>
>> The "adds little information" version may be
>>
>>                 echo "'$1' is either missing or empty, but should not be"
>>
>> And avoiding "X is Y, but should  be ~Y" construct, perhaps
>>
>>                 echo "'$1' should be a file with non-empty contents"
>>
>> would work better?  I dunno.
>
> I find "'$1' is either missing or empty, but should not be" suggestion
> clear and easily understood. I'll reroll with that.

This is a view from a position with more distance:

I find that not so easily understood -- the "but should not
be" part is rather unexpected and I feel, it doesn't provide necessary
information, e.g.:

test_path_is_executable () {
...
		echo "$1 is not executable"
...

also doesn't state what is wanted and I doubt that message doesn't
clearly describe the problem.

While I looked at it: there is another `test -s` in test_grep () that
perhaps could be fixed the same way:

	if test -s "$last_arg"
	then
		cat >&4 "$last_arg"
	else
		echo >&4 "<File '$last_arg' is empty>"
	fi

Dirk
