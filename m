Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847513777C
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307942; cv=none; b=IRTy8siTCxHLwBca5O2DrhGjdHZozv/zxlfequn9eyaN4fODMnwmeHx2fcLMbGO1YJUP+pX1i1g1UmhbNelVXwNqtBwSwjE/AKEslxoeeHmIE/cOClMj/Bz33PWvUBjXdn35fRe3gzStC5FsttqVLc8dTElJEDfiVcQIhEVlTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307942; c=relaxed/simple;
	bh=/QZHoML9WRUCBTuRw9vg+UnwmcHuXFi1+fzxFkS9Xv4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2UpybnqQuNJlQsX857shbBHkjBLB+Ku8hcEOfxH09txOdT4GIlFprrUNRfJKSdZyw4bU8duFQX6RbR/ALiiPcyJHI48YaGAwleguboBSsCaqFO6P50K2NEx1Uy/jI/xVnFNZkhhhT0XcIFOrnt13zcYLi+bWjcuX89lPT+Jh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-251-108.cpe.net.cable.rogers.com [99.228.251.108])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 43GMqFTg1513343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:52:16 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Josh Triplett'" <josh@joshtriplett.org>, <git@vger.kernel.org>
References: <0a7b9172add0a0107e0765a59a798b92161788dd.1708921148.git.josh@joshtriplett.org>	<Zh7NZhB1n2o1k7jI@localhost> <xmqq7cgxdp0i.fsf@gitster.g>	<046c01da903e$d6d97ac0$848c7040$@nexbridge.com> <xmqqv84hc53e.fsf@gitster.g>
In-Reply-To: <xmqqv84hc53e.fsf@gitster.g>
Subject: RE: [PATCH] advice: Add advice.scissors to suppress "do not modify or remove this line"
Date: Tue, 16 Apr 2024 18:52:11 -0400
Organization: Nexbridge Inc.
Message-ID: <047301da9050$bae58b80$30b0a280$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH15YgOsnvE2GL/LQgkW5nkEwXIMQIpP8J+AiodRQUCWWLU1gKQtLtesOrpxMA=
Content-Language: en-ca

On Tuesday, April 16, 2024 6:31 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>>> This is useful advice for new users, but potentially redundant for
>>>>> experienced users, who might instead appreciate seeing two more
>>>>> lines of information in their editor.
>>>>>
>>>>> Add advice.scissors to suppress that explanation.
>>>>
>>>> Following up on this patch. Happy to rework if needed.
>>>
>>>I am not personally interested in the feature myself, and I doubt it
>>>would
>> help the
>>>end-user experience very much.  You'd need to find somebody else to
>>>cheer
>> for the
>>>topic ;-)
>>
>> I am having a bit of trouble understanding the use-case for this. Is
>> it limited to linkgit? Under what circumstances would I need to use
>> such capabilities?
>
>When you run "git commit" from the command line without specifying any
>message, you'd get an editor spawned for you with something like this in
the file ("--
>- >8 ---" and "--- 8< ---" are for illustration purposes in this message).
>
>    --- >8 ---
>
>    # Please enter the commit message for your changes. Lines starting
>    # with '#' will be ignored, and an empty message aborts the commit.
>    #
>    # On branch next
>    # Untracked files:
>    #	+runme.sh
>    #	P
>    #
>    --- 8< ---
>
>But when you run "git commit --cleanup=scissors" (or use the equivalent
>configuration variables), you'd get this instead.
>
>    --- >8 ---
>
>    # ------------------------ >8 ------------------------
>    # Do not modify or remove the line above.
>    # Everything below it will be ignored.
>    #
>    # On branch next
>    # Untracked files:
>    #	+runme.sh
>    #	P
>    #
>    --- 8< ---
>
>The new advice configuration is to suppress the two lines from that message
>template.
>
>I agree that a bit more background information should be given in the
proposed log
>message to help readers.  It should mention when this new setting is
relevant (e.g.,
>when the "--cleanup=scissors"
>option is in effect), at least.
>
>I suspect that the same configuration variable wants to also control the
"helpful"
>comment in the "normal" case, in which case the name of the configuration
variable
>would need to be rethought.

Thanks. I hope that the default "helpful" comment in the "normal" case would
not change anything. I personally have course material that references
examples with the current commit message structure that would be impacted -
No problem changing it, but I am not sure what the new result would be.

As a comment on this, the scissors option might need some NLS consideration
in organizations where there are more than one languages/encodings in use. I
could see some global settings conflicting with local, but that would need
documentation.

