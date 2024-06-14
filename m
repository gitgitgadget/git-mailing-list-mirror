Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E21393
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399131; cv=none; b=aFnpVm6QZtQk/nYN0lAOQaMEF+zsAHRa6eZVJOum9XU4rafC5IghH5oJt7wM0mQc/gMOljibngEKrz33/Mf1R957jtyAlJST5gBXmbVJcFCrloXm5+LiYAV7R2pOKTNwU71ZosjYsIpUx21GJjVWhd5BrPRwjOIJU9pSDvVBH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399131; c=relaxed/simple;
	bh=33FMoiK3LyAoB++0UnrhHPCemcZz1cGRWBT/QxfdTtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1b76pRDFMQQiV0Gy1VdkbSKly5j/i0Fre5V9xvXUZfsE/RrE6QiHifsbkEvofwT7E7FKKljS12xE8Ro8WsVWfdgATpPZduE1RQzpf+Au8t+412XlNb9QfvFDRcp64DbCV5BpP7MEJDLHOvQxQyEyV28tO/jmy2ft9EH75nVH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MJvEClT7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MJvEClT7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C4036211D0;
	Fri, 14 Jun 2024 17:05:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=33FMoiK3LyAo
	B++0UnrhHPCemcZz1cGRWBT/QxfdTtk=; b=MJvEClT7NpZ1RG+oo4J/rM3MjfpU
	rhn4fVUo65iS8fEfIq77vt+266jbClxjWpe2mptkb+1eqN0O9amVPxVRilwIT97a
	XRglZ9UcZjfJ/og51y4tzUQla45VeSRWn4ZzDuDfpBXPtSc9OxeOepPlbdkNiVFx
	dd9WiJtyXF3kmB0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BCAC8211CF;
	Fri, 14 Jun 2024 17:05:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E783B211CC;
	Fri, 14 Jun 2024 17:05:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Rickard Andersson <rickard.a1992@gmail.com>,  git@vger.kernel.org
Subject: Re: git grep bug replacing - with :
In-Reply-To: <CAPig+cRGnAcfpr4JWp9WWC0b4yvjKx-_0up_S2iaXCBxgcSLjQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 14 Jun 2024 15:36:58 -0400")
References: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
	<CAPig+cRGnAcfpr4JWp9WWC0b4yvjKx-_0up_S2iaXCBxgcSLjQ@mail.gmail.com>
Date: Fri, 14 Jun 2024 14:05:24 -0700
Message-ID: <xmqqbk43dyln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D25BD46E-2A91-11EF-A3CC-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jun 14, 2024 at 3:22=E2=80=AFPM Rickard Andersson
> <rickard.a1992@gmail.com> wrote:
>> What did you do before the bug happened? (Steps to reproduce your issu=
e)
>>    Added 2 files to my repo with words in them
>>    text-file.txt
>>    text-file-file.txt
>>    ```
>>    git grep -l ExtremelyInterestingWord
>>    ```
>>
>> What happened instead? (Actual behavior)
>>    I get
>>    ```
>>    text:file.txt
>>    text:file-file.txt
>>    ```

If the command line were "git grep -l <pattern> text", and there is
a branch whose name is "text", and in the top level tree of that
"text" branch's commit there are file.txt and file-file.txt both of
which have the pattern, the symptom observed may appear.

But ...

> I am unable to reproduce this problem:
>
>     $ git version
>     git version 2.45.2
>     $ git init foo
>     Initialized empty Git repository in .../foo/.git/
>     $ cd foo
>     $ echo ExtremelyInterestingWord >text-file.txt
>     $ echo ExtremelyInterestingWord >text-file-file.txt
>     $ git add text-file.txt text-file-file.txt
>     $ git commit -m msg
>     [main (root-commit) 765269f] msg
>      2 files changed, 2 insertions(+)
>      create mode 100644 text-file-file.txt
>      create mode 100644 text-file.txt
>     $ git grep -l ExtremelyInterestingWord
>     text-file-file.txt
>     text-file.txt

... with your (i.e. Eric's) reproduction setup, which agrees with
the way how I interpreted the problem description in the original
report, I do not see there is any other possible output from it.

Thanks.
