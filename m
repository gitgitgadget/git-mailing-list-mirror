Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731C12E7F
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255106; cv=none; b=bABx9/1M7GtNIDKiFDdE3HPHjlEBEbBGn7qwdx/wo9FuAtCA1PYk3U8C9dO/kF8ZHz62G3d06sGK8JX7NgR0BXL0XsFW30kdrmuYptip6MZbLsLtrwJYk3i/eOLujFt25p0XOW+gAFtJfvxMgI6nqVW14BHByB9qhaQxXifnDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255106; c=relaxed/simple;
	bh=DktENqTWC3SGxSX4BODMI5FsUEeTqY7vmhBPKtJNEMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6VyZ01g1w4RK5r5BhzwpqX6DPkpIeyPEmfqXDvyr2y8igRGi/rJtY6EWgcFqeqw6MMjsHryBXdDTIA1rDhLyE2syXJS8bd31Bpafsq5Wd+adaoERur+AcCez2CxnW+l27E5+Fcl/BEF+1YFtfkNoKWRvsVzrRBAIgcBaPTp48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oI6EUOe/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oI6EUOe/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F15C1C4B25;
	Fri, 26 Jan 2024 02:45:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DktENqTWC3SGxSX4BODMI5FsUEeTqY7vmhBPKt
	JNEMg=; b=oI6EUOe/xkzb225supoiKpzqoX8ialzizYtV9Oh0FTJGS9P5gRw1lx
	0ptIF9Dd214UNoQpQQt0KgK+CO7PRduOkm9P86fM/3U6S2zT6zvBpdzQhtAfSt7H
	x8NzruhUe3P7u1sdrPbHKpzEm27pNDTEoiGPIXPags8jHBnvkixMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EFF51C4B23;
	Fri, 26 Jan 2024 02:45:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA63F1C4B1F;
	Fri, 26 Jan 2024 02:45:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <87a5ot6tos.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	25 Jan 2024 23:31:47 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
Date: Thu, 25 Jan 2024 23:44:59 -0800
Message-ID: <xmqqzfwspmh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF69D850-BC1E-11EE-89A2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> ..
>>> ...  If the original semantics
>>> were "you must force with -f to do anything useful", instead of "you
>>> must choose either forcing with -f or not doing with -n", then it
>>> would have led to the above behaviour.
>> ...
>> If we agree on the behavior above for sane "dry run"...

Not so fast.  I said "if the original semantics were ... then it
would have led to the above behaviour".  As the original semantics
were not, that conclusion does not stand.

The "-n" option here were not added primarily as a dry-run option,
and haven't been treated as such forever.  As can be seen by the
"you must give either -f or -n option, and it is an error to give
neither" rule, from the end-user's point of view, it is a way to say
"between do-it (-f) and do-not-do-it (-n), I choose the latter for
this invocation".  And in that context, an attempt to make "-f -f"
mean a stronger form of forcing than "-f" was a mistake, because it
makes your "I want to see what happens if I tried that opration that
requires the stronger force" request impossible.

And there are two equally valid ways to deal with this misfeature.

One is to admit that "-f -f" was a mistake (which I already said),
and a natural consequence of that admission is to introduce a more
specific "in addition to what you do usually, this riskier operation
is allowed" option (e.g., --nested-repo).  This leads to a design
that matches real world usage better, even if we did not have the
"how to ask dry-run?" issue, because in the real world, when there
are multiple "risky" things you may have to explicitly ask to
enable, these things do not necessarily form a nice linear
"riskiness levels" that you can express your risk tolerance with the
number of "-f" options.  When you need to add special protection for
a new case other than "nested repo", for example, the "riskiness
levels" design may need to place it above the "nested repo" level of
riskiness and may require the user to give three "-f" options, but
that would make it impossible to protect against nuking of nested
repos while allowing only that newly added case.  By having more
specific "this particular risky operation is allowed", "-f" can
still be "between do-it and do-not-do-it, I choose the former", and
the "--nested-repo" (and other options to allow specific risky
operations we add in the future) would not have to have funny
interactions with "-n".

The other valid way is to treat the use of the "riskiness levels" to
specify what is forced still as a good idea.  If one comes from that
position, the resulting UI would be consistent with what you have
been advocating for.  One or more "-f" will specify what kind of
risky stuff are allowed, and "-n" will say whether the operation
gets carried out or merely shown what would happen if "-n" weren't
there.

It is just that I think "riskiness levels" I did in a0f4afbe (clean:
require double -f options to nuke nested git repository and work
tree, 2009-06-30) was an utter mistake, and that is why I feel very
hesitant to agree with the design that still promotes it.
