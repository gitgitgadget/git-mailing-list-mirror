Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C52BB04
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399037; cv=none; b=TqNCFYdxnkqf8dCRhfZKf7p1ipkVmvf7q3R2VVJm5/7/2VeYCWXh1e5JlbZRdxyN0Jfc3UiaHBYl1R3BotbLWcyc4lB+f7MeOTQUDVhZl/qELxIMote+W+eDXznlEO0kvEFCtSPHA+8SHolzlv3aaNDze41Ml1rmdbcDSraZWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399037; c=relaxed/simple;
	bh=PiNwMZKr/UT2A+bQQWXWbQa2zBQULjyeu8OZcSNqKNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lc4J9IO8yLCptuQW7FGrpBTeRpjP52Eh8sgpgpwr5J9y6kCCB16w9ZU2ygRI5Ks2n0jOWv4pZx4wFv50Prvffuz5K8zDzX+1pIzqyt5JPPd4K962bhs31B/DpHGYSEvz+y3y0SIU6SIt/LNJlSV7h+kjqmiHyH8B1gduVDrrE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wpmo7bRC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wpmo7bRC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 582171E12AB;
	Sat,  2 Mar 2024 12:03:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PiNwMZKr/UT2A+bQQWXWbQa2zBQULjyeu8OZcS
	NqKNo=; b=wpmo7bRC74hyUFmrM/qYz8s+y+Xo7Gd5BYlqzRnF0TS3D2KqL9i1rC
	t0EVpcleby/UE1yWrDMuPxhtLrzp3DFrx0dJ/e+UUrVsPR/T2z9Jdx3c5RpjfcQd
	+1Q7ITMi7cg3QJ1LdjQcxxjwWB8p6o/vLxm/7oInEW66Wl9tT3NH8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F1E71E12AA;
	Sat,  2 Mar 2024 12:03:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B306A1E12A9;
	Sat,  2 Mar 2024 12:03:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: oliver@schinagl.nl,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
In-Reply-To: <20240302095751.123138-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Sat, 2 Mar 2024 10:57:49 +0100")
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
	<20240302095751.123138-1-karthik.188@gmail.com>
Date: Sat, 02 Mar 2024 09:03:53 -0800
Message-ID: <xmqqedcszhty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9F6060E-D8B6-11EE-B1EF-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This patch series adds the diff.wordDiff config option. This mimics the
> '--word-diff' option of `git-diff(1)`.

Is it even be sensible to introduce this configuration variable in
the first place?  What would this do to users who set this variable
and use third-party or their own scripts that run "git diff" under
the hood?

The usual answer is "these tools should be using the low-level
plumbing commands like diff-files, diff-index, and diff-tree", so I
am not worried about it too much myself, and the above is purely the
devil's advocate comment.

Having said that, running

	$ git grep -e 'git diff '

in the collection of scripts I use [*] to work on this project, I am
reminded that I may have to be a bit more conservative than I
currently am about the risk of breaking scripts with the changes
like the one being proposed.

The proposed feature also may break those who use the git-prompt and
diff-highlight available in conrib/, even though I am not sure how
badly they would break, because I only looked at the lines given by
this command:

	$ git grep -e 'git diff ' -- \*.sh ':!t/'

and didn't check how the output from 'git diff' is used.


[Footnote]

 * They can be seen in the 'todo' branch, if anybody is interested.
