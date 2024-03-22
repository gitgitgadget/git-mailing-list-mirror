Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2761811E0
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145337; cv=none; b=CcTOoPOqPiFoHDzaJQRk7178CBuThuW2ojeE4hX4AlZNN3a4FG0enHw9EbwgcX7xjuZ19E74T5NMXKp90BJjXb+qZb13QJANByJ8NCfwfWE1NRwmNO7qDuJG+gQQvApkOzLXGr0TpgvtTn8skPZfZjoMszXgN0QME9yovpgFV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145337; c=relaxed/simple;
	bh=6L41YtzzxbSYbrsW8wsbBkzu2bCuWWnHmEumFNcbJts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D03rrpRbOSdkAXPPQwQ819If13a3/fEoD9KxCq8GZTG+QNCtpupUy9uK8tCnj0Ddl1OSJSomXOMSJijjciSXvobthFsr3YozasPYRjIRSoZFnXE+24DgMCn2FXFVZJZ2dZ+imOFn3QhgPUzJd1DR9lFF+diyDTl+NEJ4g8iJHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=gtA5PPil; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="gtA5PPil"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CE63019FD467;
	Fri, 22 Mar 2024 23:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711145333; bh=6L41YtzzxbSYbrsW8wsbBkzu2bCuWWnHmEumFNcbJts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gtA5PPil7qJedQcBGs408OCZZpsPyq9So/EXmS91EheERKfHPUnnAg8rwGy+siqoX
	 LGVcSf/nPKY/zXgNekrk14bHGKqephN4aYMqNS+XOnTEdPnQziDDcXCQnPvPQm5aNa
	 rmtems/WUYi84jWCO2J9ejOrPT5b+QQVGoMf4VNY=
Message-ID: <6e035003-0c08-4e44-811c-27d2cebe9fa8@schinagl.nl>
Date: Fri, 22 Mar 2024 23:08:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
Content-Language: nl, en-US
To: Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
 <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
 <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
 <xmqqle6zw6om.fsf@gitster.g>
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqqle6zw6om.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03-03-2024 18:45, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
> 
>> This tension is relieved somewhat when there *are* separate
>> plumbing commands, such as `git diff-index` and `git diff-tree`
>> and so on, or `git rev-list` vs `git log`. Unfortunately there
>> are some commands, including `git log` itself, that have options
>> that are missing from the roughly-equivalent plumbing command,
>> and there are commands (such as `git stash` and `git status`)
>> that either do not have, or at one time lacked, plumbing command
>> equivalents or options.
> 
> Yup.  It is my pet peeve that more and more contributors got lazy
> and tweaked only Porcelain commands, without bothering to improve
> plumbing commands to match, while adding more features during the
> last decade.  Unfortunately there is no easy remedy after such sins
> have been committed.  Once people start using `git log` in their
> scripts, it is way too late to tell them to update their scripts to
> use `git log --porcelain`.  The fact that you need to tell them is
> an admission that you already broke their scripts.
> 
To avoid this request from dieing quietly, I will ask (complain) again. 
Who's the client for. How important is the human UX?

Even introducing a new cli, 'git-cli-for-humans' it will be abused again 
for sure. So what's a good way forward? Personally, as I mentioned 
before, it's in the docs to not script around non-plumbing commands, 
which gives an opening to the admission. And why is admitting things a 
bad thing, when it improves things for the human? Even if it hurts.

One could argue 'git3 will break things! Human and machine control is 
split. Use --porcelain (or plumbing commands) in your scripts or expect 
breakage from time to time. You have been warned!'

We do in the end want progress, do we not? :)

Olliver
