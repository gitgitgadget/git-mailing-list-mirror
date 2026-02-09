Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016102D9EED
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770617994; cv=none; b=FA1GSDuFylNXFo2HK1t6ZGtlNejzLjYZpF7+kwHX9pYJnfkLzxIs/HiiDB+MO7qNGNQzb1FxER3T3CTyhXBkee3Y2JCc4v3DuH3f6RMiGq2kuMQQM7RtD2u2x3x1R0InnoMUG5DGsOECyqR4BhVY6u+lnPeBHZPCyHJ9ByhcX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770617994; c=relaxed/simple;
	bh=R4C2w3D4sJ+VGJCaEojoUBvT8chDc+DSp8D1yFhOmoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DB8ogjNDKvGeAqOpSGw458SutIdFyMujeJmf+7Ml/6Ew/xQ/I0RomdP5EM6TR0p5i1zBz/ppGWvErw/YozUqIUwjgumoJlhhU5/TQ4ZLoGyDwPcFRe1LRKqRpGvhuXWBmsl7pQa+cgKDL20JkIEZ5/ROHrIX2NrnPKH78oAGG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VyX+01Z1; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VyX+01Z1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770617990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7iEHgLcEt/yRDYpFXvt3n+761bRSLxJj7hO1KHZ4Xws=;
	b=VyX+01Z1wYI8Cj4qagpFcl3Pq/UTMSeyKTSoqtcGHq+Vk6dRlUjTK4pDK+8c0yRQXPK0gS
	MWVX7FIB/2Hwh3d6i2Vuo2uudI+JfZSC6gRv/MtrLLmE6FVU76SqlGeCRqv1v8CuONb8QS
	d3aZnX75bgusajnpdk6xDQioLTrLuso=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
In-Reply-To: <xmqqv7g9d0kw.fsf@gitster.g>
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
 <xmqqv7g9d0kw.fsf@gitster.g>
Date: Mon, 09 Feb 2026 07:19:35 +0100
Message-ID: <87jywmqw08.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> I would argue the problem here are not the merge commits, but it's the
>> way this is displayed.
>
> I am curious, as anybody else who has read this message up to this
> point, how your --untangle option improves the same section of the
> history you drew above (which I did not include).

I didn't want to clutter my email with a lot of examples, I would rather
have people give it a try. But since you asked.

Without --untangle:

    * 67ad42147a (tag: v2.53.0, origin/master, origin/maint, origin/HEAD, master) Git 2.53
    *   6f328bc9e3 Merge tag 'l10n-2.53.0-v1' of https://github.com/git-l10n/git-po
    |\
    | *   532543fa46 Merge branch 'jx/zh_CN' of github.com:jiangxin/git
    | |\
    | | * eb816ef79e l10n: zh_CN: standardize glossary terms
    | | * 3065daed59 l10n: zh_CN: updated translation for 2.53
    | | * eb3cfc6b2f l10n: zh_CN: fix inconsistent use of standard vs. wide colons
    | * |   5a83d800f3 Merge branch 'l10n/zh-TW/git-2-53' of github.com:l10n-tw/git-po
    | |\ \
    | | * | b47610d61d l10n: zh_TW.po: update Git 2.53 translation
    | * | |   e996719801 Merge branch 'po-id' of github.com:bagasme/git-po
    | |\ \ \
    | | * | | 6ef4d11472 l10n: po-id for 2.53
    | | |/ /
    | * | |   8ef65d7efd Merge branch 'l10n-ga-2.53' of github.com:aindriu80/git-po
    | |\ \ \
    | | * | | d534a373e7 l10n: ga.po: Fix git-po-helper warnings
    | | * | | 0c19f7f950 l10n: ga.po: Update Irish translation for Git 2.53
    | * | | |   b386b3aea7 Merge branch 'master' of github.com:alshopov/git-po
    | |\ \ \ \
    | | * | | | 06045e3984 l10n: bg.po: Updated Bulgarian translation (6091t)
    | * | | | |   af1a298e2c Merge branch 'fr_2.53' of github.com:jnavila/git
    | |\ \ \ \ \
    | | * | | | | 72dd507505 l10n: fr: v2.53
    | | | |_|/ /
    | | |/| | |
    | * | | | |   6f75c474d7 Merge branch 'tr-l10n' of github.com:bitigchi/git-po
    | |\ \ \ \ \
    | | * | | | | d63adbbbd5 l10n: tr: Update Turkish translations
    | | |/ / / /
    | * | | | |   3eaaa7fea4 Merge branch 'master' of github.com:nafmo/git-l10n-sv
    | |\ \ \ \ \
    | | |_|_|_|/
    | |/| | | |
    | | * | | | cba7353aed l10n: sv.po: Update Swedish translation
    * | | | | | 239b7f686c RelNotes: fully spell negation
    * | | | | | 2258446484 RelNotes: correct "fast-import" option name
    |/ / / / /
    * | | | | ea717645d1 RelNotes: a few spelling fixes
    * | | | | ab380cb80b (tag: v2.53.0-rc2) Git 2.53-rc2
    | |/ / /
    |/| | |
    * | | | ab689ea7f9 Revert "Merge branch 'cs/rebased-subtree-split'"
    * | | |   6959eee16e Merge branch 'master' of https://github.com/j6t/git-gui

With --untangle:

    * 67ad42147a (tag: v2.53.0, origin/master, origin/maint, origin/HEAD, master) Git 2.53
    *   6f328bc9e3 Merge tag 'l10n-2.53.0-v1' of https://github.com/git-l10n/git-po
    |\
    | *   532543fa46 Merge branch 'jx/zh_CN' of github.com:jiangxin/git
    | |\
    | | * eb816ef79e l10n: zh_CN: standardize glossary terms
    | | * 3065daed59 l10n: zh_CN: updated translation for 2.53
    | | * eb3cfc6b2f l10n: zh_CN: fix inconsistent use of standard vs. wide colons
    | *   5a83d800f3 Merge branch 'l10n/zh-TW/git-2-53' of github.com:l10n-tw/git-po
    | |\
    | | * b47610d61d l10n: zh_TW.po: update Git 2.53 translation
    | *   e996719801 Merge branch 'po-id' of github.com:bagasme/git-po
    | |\
    | | * 6ef4d11472 l10n: po-id for 2.53
    | *   8ef65d7efd Merge branch 'l10n-ga-2.53' of github.com:aindriu80/git-po
    | |\
    | | * d534a373e7 l10n: ga.po: Fix git-po-helper warnings
    | | * 0c19f7f950 l10n: ga.po: Update Irish translation for Git 2.53
    | *   b386b3aea7 Merge branch 'master' of github.com:alshopov/git-po
    | |\
    | | * 06045e3984 l10n: bg.po: Updated Bulgarian translation (6091t)
    | *   af1a298e2c Merge branch 'fr_2.53' of github.com:jnavila/git
    | |\
    | | * 72dd507505 l10n: fr: v2.53
    | *   6f75c474d7 Merge branch 'tr-l10n' of github.com:bitigchi/git-po
    | |\
    | | * d63adbbbd5 l10n: tr: Update Turkish translations
    | * 3eaaa7fea4 Merge branch 'master' of github.com:nafmo/git-l10n-sv
    | * cba7353aed l10n: sv.po: Update Swedish translation
    * 239b7f686c RelNotes: fully spell negation
    * 2258446484 RelNotes: correct "fast-import" option name
    * ea717645d1 RelNotes: a few spelling fixes
    * ab380cb80b (tag: v2.53.0-rc2) Git 2.53-rc2
    * ab689ea7f9 Revert "Merge branch 'cs/rebased-subtree-split'"
    *   6959eee16e Merge branch 'master' of https://github.com/j6t/git-gui

>> There are still some bugs in this implementation. And a bunch of memory
>> leaks. Also am I not sold on the name `--untangle`. It sounds catchy,
>> but it's name isn't very meaningful for most users. I've been thinking
>> about `--ignore-merge-base` or `disconnect-merge-base`, but I'm open to
>> better suggestions. That's why I'm submitting this as a RFC. Before I
>> continue work on this, I'm curious if the project is open to such
>> contribution? And if so, which direction it should go?
>
> In any case, I am very happy to see another person who is not afraid
> of our C codebase to have looked at this part of the system (I have
> a long-standing pet peeve, unrelated to this issue, in this area).

I'm happy to learn more about those pet peeves. git-log(1) --graph could
definetily use some love.

-- 
Cheers,
Toon
