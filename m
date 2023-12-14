Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hpzCZv3E"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A28E
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 08:49:55 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E11C51CBDA;
	Thu, 14 Dec 2023 11:49:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LU+GZ3YBT+MBXv1eESYhnDY2TkD5xnYR7pdUQm
	atUfk=; b=hpzCZv3Ef4mxy2j085GFfCOg1781Y5YrMNB4sYqrMWPa5cMKwvuI2b
	KXUXYlf6ju8OC4OXFTAOjXgJ3cj+Uh175/2RUscVk3es+vS2BMNqA67fYWOTYjYw
	EbTahYB6MA4EDwAmHvK9U4dNnM++ubDP3mr5OCcL6bctuuAlnUMaA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DA1041CBD9;
	Thu, 14 Dec 2023 11:49:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82DCE1CBD8;
	Thu, 14 Dec 2023 11:49:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,  Eric
 Sunshine <ericsunshine@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: drop dependency on `git diff` in check-chainlint
In-Reply-To: <ZXq3YdK2RSKF3npE@tanuki> (Patrick Steinhardt's message of "Thu,
	14 Dec 2023 09:05:53 +0100")
References: <20231214032248.1615-1-ericsunshine@charter.net>
	<ZXq3YdK2RSKF3npE@tanuki>
Date: Thu, 14 Dec 2023 08:49:49 -0800
Message-ID: <xmqqo7esohjm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCBE34C4-9AA0-11EE-85C2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This strongly reminds me of the thread at [1], where a similar issue was
> discussed for git-grep(1). Quoting Junio: 
>
>> I actually do not think these "we are allowing Git tools to be used
>> on random garbage" is a good idea to begin with X-<.  If we invented
>> something nice for our variant in "git grep" and wish we can use it
>> outside the repository, contributing the feature to implementations
>> of "grep" would have been the right way to move forward, instead of
>> contaminating the codebase with things that are not related to Git.
>
> So this might not be the best way to go.

That is not a conclusion I want people to draw.

Like it or not, "git diff --no-index" will be with us to stay, and
"--no-index" being "we have abused the rest of Git code to implement
'diff' that works _outside_ a Git repository---now go and do your
thing", we would eventually want to correct it, if it is misbehaving
when a repository it finds is in a shape it does not like, no?

We should have what you quoted in mind as a general principle, and
think twice when we are tempted to hoard useful features for another
tool we initially wrote for Git and allow them to be used with the
"--no-index" option, instead of contributing them to the tool that
does not know or care "git" repositories (like "diff" and "grep").
