Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1A1BDC4
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HkGSrB+K"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EBD4C
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 15:25:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 05CFC3686D;
	Sun, 12 Nov 2023 18:25:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fqDY6Xc5Q4xL7rU9l9NwTYLSKFhsHzhsYWtE0M
	Yk0tw=; b=HkGSrB+KVeJuNDtwAEwW9jK0qTRRGLi6c2UEQkFvsEb/VmvLB/FVws
	sMaBc1qfM5+six+qpY0wahNS8NAhwVsrqsBrp+fni6IBety30aWUvjNxaCLtv/D5
	A8tzEEscpopYpXAI4DLg1fA+zzKfW8cGGtgzGzNOMcfQBj7EcUXDg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DED8E3686C;
	Sun, 12 Nov 2023 18:25:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7047236867;
	Sun, 12 Nov 2023 18:25:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Sandra Snan <sandra.snan@idiomdrottning.org>,  git@vger.kernel.org,
  Dragan Simic <dsimic@manjaro.org>,  rsbecker@nexbridge.com
Subject: Re: first-class conflicts?
In-Reply-To: <20231112152143.GD35991@mit.edu> (Theodore Ts'o's message of
	"Sun, 12 Nov 2023 10:21:43 -0500")
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
	<002901da1101$7d39a420$77acec60$@nexbridge.com>
	<Gr..Y5kkszDx87g@idiomdrottning.org> <ZUmJyFs7z7wdmLVK@mit.edu>
	<xmqqh6ltrs6t.fsf@gitster.g> <20231112152143.GD35991@mit.edu>
Date: Mon, 13 Nov 2023 08:25:25 +0900
Message-ID: <xmqqr0kumu56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C33CAFA4-81B2-11EE-8CC1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Sat, Nov 11, 2023 at 10:31:54AM +0900, Junio C Hamano wrote:
>> ... 
>> I wonder if it would help users to add a new configuration option
>> for those who want to live safer that tells "commit -a" to leave
>> unmerged paths alone and require the unmerged paths to be added
>> explicitly (which may have to extend to cover things like "add -u"
>> and "add .").
>> 
>> Perhaps not.  I often find myself doing "git add -u" after resolving
>> conflicts and re-reading the result, without an explicit pathspec.
>
> Maybe the configuration option would also forbit "git add -u" from
> adding diffs with conflict markers unless --force is added?

Historically we left it to pre-commit hooks, but I agree that
protection at the time of "git add" may be more helpful.

I also alluded to being careful about "git add" with an overly vague
pathspec (like "."  to add everything addable under the sun), but I
do not think it is possible to define "overly vague" in a way that
satisfies everybody (would "git add \*.h" be still overly vague when
5% of your header files have conflicts in the merge you are
concluding?) and keep the new users safe.

Unless the configuration forbids patterns and say "each and every
individual path must be named to add and resolve conflicted paths",
that is.  Come to think of it, that may not be too bad.

> I dunno.  I personally wouldn't use it myself, because I've always
> made a point of running "git diff", or "git status", and almost
> always, a command like "make -j16 && make -j16 check" (or an aliased
> equivalent) before commiting a merge.
>
> But that's because I'm a paranoid s.o.b. and in my long career, I've
> learned is that "you can't be paranoid enough", and "hope is not a
> strategy".  :-)

Being careful and paranoid is good ;-) I wouldn't use it myself,
either, but the discussion started while trying to allay new users'
worries about recording a half-resolved state by mistake, and in
that context, I think it would have non-empty audiences.

Thanks.

