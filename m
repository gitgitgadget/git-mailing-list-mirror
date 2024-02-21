Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429B7FBD2
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535477; cv=none; b=o3esjlOpvjLtt5NCUaEchiQ5LoI/RbLb06GwXFnDZfjQh+ny/kegHI/wuXMU3m/sRrpG+FbJv625C5ojnCOdSCxmyrQAMtCtPjF5TnNjnXNIIgYKeu7zIKVuecnA23Qyuz4x6clPxUt5zpIxuhgFQ4+pZiibKrX8nspUS7DScgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535477; c=relaxed/simple;
	bh=2INmwEHoOY8L8aJ7fqwlaPI1JGdvT+oHd+myP0FOkL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VYIMzcOWqzFOTZtiiK8qUSWFSFxZ1bLFRL1mBiqy1nQ+6hnXxEMdOsaIPryOyDZmjKp+dCPHBMxl/Ld4R3+Mgn7NTLOOHLVUIks9mjeyrIQ69CeAx5BUVtpH50h3SnXovCkA5gkgAwdxvP0C3MbmylG/xfBuUtm1IhjAS1QXsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AnCxfN2B; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AnCxfN2B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AF1C1C37B8;
	Wed, 21 Feb 2024 12:11:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2INmwEHoOY8L8aJ7fqwlaPI1JGdvT+oHd+myP0
	FOkL8=; b=AnCxfN2BhyZEJ/KW0jWBm9ykUg8lkzugQA7gjgOTWanh7pKzoGlOuR
	EjI+eYE97P4vyHfP79l6qUQL/As0tM/AjnY4FdbiLSrZ2UKjHYJowlqrPjo/I5H6
	W1kuUxnS13nbcxJkaq9fU841sxXCK3AU3Objd1E/fhAIIS8Ow4xUo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 441E51C37B7;
	Wed, 21 Feb 2024 12:11:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B27811C37B6;
	Wed, 21 Feb 2024 12:11:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: =?utf-8?Q?M=C3=A1rio_Guimar=C3=A3es?= <mario.luis.guimaraes@gmail.com>,
  git@vger.kernel.org
Subject: Re: Bug: impure renames may be reported as pure renames
In-Reply-To: <CABPp-BG2m3_fyxFL6Hw4o5HhoKVd7_tYchDxCdTaXxdxZke-9g@mail.gmail.com>
	(Elijah Newren's message of "Tue, 20 Feb 2024 18:12:00 -0800")
References: <CAF7CYk6dERu7Lb0iKeq7zwtZVVd_bG2FMZReSDeejcu1JGiaFw@mail.gmail.com>
	<CABPp-BG2m3_fyxFL6Hw4o5HhoKVd7_tYchDxCdTaXxdxZke-9g@mail.gmail.com>
Date: Wed, 21 Feb 2024 09:11:12 -0800
Message-ID: <xmqqttm1pwsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 377E0016-D0DC-11EE-8D0E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> Heh, good point.  And more generally, due to how the similarity checks
> work (split the file into lines/chunks, hash each to an integer, then
> sort the list of integers and compare the list of integers between two
> files), whenever you keep all the original lines of a file but permute
> their order, you will see a 100% match.

Stepping back a bit, there internally is a distinction between
"identical files" and "similar but not identical files".  The
file with permuted lines are not identical but are very similar.

The decision not to surface these two to end-users was made long
ago, and after finding identical renames, we skip similarity
computation when minimum_score is set to -M100 from the command
line, which is a documented UI that cannot change.

So you are right to say that similarity index of an inexact rename
should be capped at 99 and never reach 100.  I do not know offhand
if your "how about" computation ...

>  static int similarity_index(struct diff_filepair *p)
>  {
> -       return p->score * 100 / MAX_SCORE;
> +       return p->score * 100 / (MAX_SCORE+1);
>  }

... is the way to go, though.  We have filepair, so shouldn't we be
doing more like

	if (identical_rename(p))
		return 100;
	else
		return 99 * p->score / MAX_SCORE;

instead?

It will also keep working when a minor pet peeve of mine is fixed.
If you have a file with 1000 lines, all hashing to distinct values,
and if you change only one line, even though the similarity is
computed as 99% by the current logic, it actually is 99.9% that is
much closer to 100%.  But we always round down, which feels wrong.

Alternatively, we could cap p->score to (MAX_SCORE-1) when
similarity is _computed_ for filepair between non-identical blobs.
That should happen in diffcore-rename.c:estimate_similarity().
It would allow us to still _show_ "1 line changed among 1000 lines"
case as R100 and still reject inexact renames via "-M100" from the
command line, I think, as the "exact renames only" short-cut works
with the finer-grained "score" values and not the coarser "percent"
values, which might give us a better approach.




