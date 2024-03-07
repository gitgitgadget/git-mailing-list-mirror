Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F012AAFD
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819622; cv=none; b=CVDQ+Nq+vmUCcY1hvuHu6mYToJV7itb8tWmddt9uZSAiT63TxpGF81OnmENTh7IGlK2VvwhFJ9mtGiBtmxZWNGr8UjdLfJf86O4yHSoBYj4v60ghL2B3TkrWbuPAJ2iyMdGQEDef/xkDnTIPKiXtVeFLn11v1lAFIJilFFhAYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819622; c=relaxed/simple;
	bh=is5OIHsYKEGgprDwTKp+oUo/Gxd56S5xTg0xWimRuC4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKc+pW+CK1nclj3hpLxLZGo2+0FbDGfRIrGF8v0iillIJTEA/7oi8FybOfWEtFxIkmBTywxCCn/QdvmH/jn8H2eZkc3/WKRLhLzKh9yxxomyogjKofXopNgBidWYUdkIA0Hf7x8RwLkZi2KpfRXKKyoTnpyKiQDeTeSDZRu6Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 427DrFbk212902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 13:53:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Ralph Seichter'" <github@seichter.de>
Cc: "'Ralph Seichter via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>	<xmqqttljtkn4.fsf@gitster.g>	<2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de> <xmqqplw6nsuz.fsf@gitster.g>
In-Reply-To: <xmqqplw6nsuz.fsf@gitster.g>
Subject: RE: [PATCH] Allow git-config to append a comment
Date: Thu, 7 Mar 2024 08:53:09 -0500
Organization: Nexbridge Inc.
Message-ID: <098101da7096$cd773d40$6865b7c0$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQFlUIbffV0Kx6ugRLQuqCoXSigUjAHnrHP3AasKI1AB66HTSrHqmFSw

On Thursday, March 7, 2024 7:12 AM, Junio C Hamano wrote:
>Ralph Seichter <github@seichter.de> writes:
>
>>> If you are illustrating a sample input, please also explain what
>>> output it produces. What do the resulting lines in the config file
>>> look like after you run this command?
>>
>> The result of running the above command looks as follows:
>>
>>   [safe]
>> 	directory = /home/alice/somerepo.git #I changed this. --A. Script
>
>That would have been a crucial piece of information to have in the proposed
log message, as limiting ourselves to a comment that is
>tucked after the same line as the value, things can become somewhat
simplified.  We may not have to worry about deletion, even
>though the point about "we need to look at and typofix them with our
viewers and editors" still stands.
>
>By the way, you may or may not have noticed it, but my example deliberately
had a multi-line comment:
>
>    $ git config --global --comment 'the reason why I added ~alice/
>    is because ...' --add safe.directory /home/alice/somerepo.git
>
>How such a thing is handled also needs to be discussed in the proposed log
message, and perhaps in the documentation as well.
>
>> ... My patch only supports
>> single-line comments, and only as a suffix to newly added key-value
>> pairs. This is a deliberate design choice.
>
>Such design choices need to be described in the proposed log message to
help future developers who will be updating this feature,
>once it gets in.
>
>Thanks for writing quite a lot to answer _my_ questions, but these
questions are samples of things that future developers would
>wonder and ask about when they want to fix bugs in, enhance, or otherwise
modify the implementation of this "add comment"
>feature.  They may even be working on adding other features to complement
the "add comment" feature, by designing support for
>viewing or typofixing existing comments.  When they do so, it would help
them to know how this existing feature was expected to be
>used and how it would fit in a larger picture (which may not have yet
existed back when the feature was invented).  Answering these
>anticipated questions is one of the greatest things that a commit log
message can do to help them.
>
>Thanks.

I am concerned about the compatibility of this series with the community.
While comments are permitted in .gitconfig files, I am not 100% sure that
all stakeholders, particularly those who parse .gitconfig files in their own
scripts outside of git - sure, it is their own responsibility, but this
might be unexpected. I worry that this might unintentionally introduce
incompatibilities into repository configurations. Is there broad consensus
to do this?

--Randall

