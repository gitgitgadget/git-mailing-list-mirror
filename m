Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A6021146C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452747; cv=none; b=XJbUj4UVDRIlLvoi3cLwX3aLloELzLeQDZpl6BFm9/pOsUZCJqItEYVnUhu9icfdrZteh6v1ucEHWXzylf90ial27awc5v2aXg0zaMtTJXIBy2OO9SeQTpD164prIOE3Nc1YQLTfdXNBYMWfTN1sgHDCZAFVbtfCjzanJg2k4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452747; c=relaxed/simple;
	bh=Hwpj4tp1Aa4PNsfMrd5c8JzR5P24QNrMM04wzyWceuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pk5EWdmfvdhhiX9RKMwZ0rhDePQ/giIjSZDJMv+UQChBq2qegLPBW3uc4vQjTqknfNMj+YUMNV89H1u/tTKFoSDZbfmo4f7UDCkoZUcRli9wxH5ULb9zZXCFRIVgFL+ZaIU1mnnTkCLtkp/nJHKS4nOMqMyt0e011hvaJFg7n1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QT1C7LuW; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QT1C7LuW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774452743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2T7CPj1Gu7fJH/J79ZZHlBL/CSzXkEb1UD1NUbbLTEI=;
	b=QT1C7LuWJaH9QLAqhmlJKXxlxGmY+SY4hWSI6L/LUwHsSiUhLBsZxlN58Qhr6BMVvj95gm
	Y/2GRaeUJe5SSZKZuUbRbiWkayZs2o5Sv3WGehxFD7CqNiD95EXoq1fJ0DbOUkSy226iYw
	qrGLSgM+EARMXnE8LExIkFr1zboDvYQ=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
 <xmqqtsu5xaw0.fsf@gitster.g>
 <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
Date: Wed, 25 Mar 2026 16:32:17 +0100
Message-ID: <87a4vv2ada.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 24, 2026 at 8:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>>
>> Toon Claes <toon@iotcl.com> writes:
>>
>> > git-replay(1) doesn't allow replaying commits all the way down to the
>> > root commit. Fix that.
>> >
>> > Signed-off-by: Toon Claes <toon@iotcl.com>
>> > ---
>> > These changes might conflict Siddharth's series[1] to add '--revert' to
>> > git-replay(1), although resolving that should be trivial.
>>
>> True.  This round looks great to me.  Will queue.
>>
>> Shall we mark the topic for 'next' now?
>
> The patch looks good to me, but I wonder if the docs should be updated
> somehow, especially to try to avoid confusion in case users don't
> properly specify a range.
>
> For example, before this, `git replay --onto main topic` would fail,
> but emit "fatal: replaying down from root commit is not supported
> yet!".

I'm fixing that in a separate series.

> This would likely help users understand that they might need to
> properly specify a range like "main..topic" instead of 'topic".
>
> Now it would likely fail without any error message.
>
> Maybe something like the following could help:
>
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
> `git update-ref --stdin`
>
>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
> +Note that `git replay --onto main topic` replays the topic branch starti=
ng
> +from the root commit, not from main. What you might want instead is
> +`git replay --onto main main..topic`.
> +

Definitely would help, not sure it needs to be part of this series.

--=20
Cheers,
Toon
