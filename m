Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA482210F
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xJedPF2V"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE43448C
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 17:31:56 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05CEF1C482E;
	Fri, 10 Nov 2023 20:31:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n8Hf8Ka2cRalclU60tRhL2f0Au7UWos4iBqN1M
	yuSdU=; b=xJedPF2VWASdUso7sGRYljm2wRHkC+ekTcg8SHvGBlKM11HfcXZT1W
	JiiSKxuU/lh2G5ve31YCf6rLZCiQGESkHw9ij5WP3pUYkDK0Cw4f0BhlEqSz/PeP
	tfca7jR5ZGmrj+e+CuZOQ+8lsfGaM897XVYKjlxvEJzQbes98XHrY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F160C1C4820;
	Fri, 10 Nov 2023 20:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 653341C4819;
	Fri, 10 Nov 2023 20:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>,  git@vger.kernel.org,
  Dragan Simic <dsimic@manjaro.org>,  rsbecker@nexbridge.com
Subject: Re: first-class conflicts?
In-Reply-To: <ZUmJyFs7z7wdmLVK@mit.edu> (Theodore Ts'o's message of "Mon, 6
	Nov 2023 19:50:16 -0500")
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
	<002901da1101$7d39a420$77acec60$@nexbridge.com>
	<Gr..Y5kkszDx87g@idiomdrottning.org> <ZUmJyFs7z7wdmLVK@mit.edu>
Date: Sat, 11 Nov 2023 10:31:54 +0900
Message-ID: <xmqqh6ltrs6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 192F150A-8032-11EE-8AFF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Theodore Ts'o" <tytso@mit.edu> writes:

> And if you attempt to commit the merge without resolving the
> conflicts, git won't let you:
>
>    error: Committing is not possible because you have unmerged files.
>    hint: Fix them up in the work tree, and then use 'git add/rm <file>'
>    hint: as appropriate to mark resolution and make a commit.
>
> So it's hard to miss the indications of the content conflict, because
> if you try to commit without resolving them, it's not a warning, it's
> an outright error.

Correct but with a caveat: it is too easy for lazy folks to
circumvent the safety by mistake with "commit -a".

I wonder if it would help users to add a new configuration option
for those who want to live safer that tells "commit -a" to leave
unmerged paths alone and require the unmerged paths to be added
explicitly (which may have to extend to cover things like "add -u"
and "add .").

Perhaps not.  I often find myself doing "git add -u" after resolving
conflicts and re-reading the result, without an explicit pathspec.


