Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BE79E4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711305279; cv=none; b=PK7lEXC4x2iQB40fDpFK/JIJztrvtJH7zeoaUwRfnVo2PkvTWgrb7AJyza3PanIRDJG0DKqzzhYPeV1h8Js6Kc3VBBFbOZmZJI7vQ/qnfJek3gGmHLRc62br8kJluhXe7JK5R/b10Zf1p1C1kLcZK0YzsRYi8x5DfclrbYkS0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711305279; c=relaxed/simple;
	bh=RPnFWbGXAp58OfWR1F14kn6SnRKwhbcwq0p02lWDbAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crNirgMSIyCatLrjGNg4b17CAG4Va1Ls9Z6QamcLd1wt9srv9QlSjmpQxO0VkgnZhxUvTpi283NlKN+/JUFnWidm3rrzvRMgr/JpDZPaw1nLGbZHBqJxqT9xk08QjnfToIkjSMa/JOD1I1TNxvtPcuseJiglZYTDJmdlonrO2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=r3KC+1ue; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r3KC+1ue"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 359F2298F1;
	Sun, 24 Mar 2024 14:34:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RPnFWbGXAp58OfWR1F14kn6SnRKwhbcwq0p02l
	WDbAI=; b=r3KC+1ueVZieNhy+ghngAs92Jfyo9LK75oqsrYBlivrzcFGbiwQYT6
	a74C7RBF2+QRY5F4N1zqsi5J1LwHQur7XCaHq0xo36o044m5uImGC9rxnI2gLfQt
	ruvrDOP2w2FU1INWb8hGGTUci27F7qfySXYFNcRwvyjSnhzpfJZBY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DBE8298F0;
	Sun, 24 Mar 2024 14:34:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE51B298EF;
	Sun, 24 Mar 2024 14:34:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>,  Olliver Schinagl
 <oliver@schinagl.nl>,  git@vger.kernel.org
Subject: Re: Allow git bisect to auto-skip
In-Reply-To: <CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
	(Christian Couder's message of "Sun, 24 Mar 2024 15:29:15 +0100")
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
	<xmqqwmptzyny.fsf@gitster.g>
	<01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
	<xmqqle68x008.fsf@gitster.g>
	<e896da79-c87b-4475-9890-10051d8ddf76@haller-berlin.de>
	<CAP8UFD2DhkmVias+RfMESJz9Z-rKKHWHB+MFHcDb9QLO16TOhg@mail.gmail.com>
Date: Sun, 24 Mar 2024 11:34:26 -0700
Message-ID: <xmqq8r27sclp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 255BA466-EA0D-11EE-9329-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Also, how much better would this be compared to tracking  "git bisect
> run" scripts in the repo, even if they have to be copied somewhere
> else before they are launched? I wonder about this because writing the
> conditions that decide whether the current commit is good or bad might
> not be so easy either. So if the goal is to simplify things for users,
> then simplifying all the way by providing example scripts with
> comments about how they could be customized might be even better.

If we are driving our bisection session via "bisect run" script,
computing the condition that we need to skip in the script is the
most natural and obvious thing to do, but the way I guessed (because
it was not explicitly written down) what the OP wanted was a way for
bisect_next() called after even a manual "git bisect (good|bad)" to
automatically skip certain set of commits.  Because there are cases
where you have to be testing manually and cannot afford to write
"bisect run" script, giving a manual bisection a way to compute if a
commit need to be skipped may be worth having, and that was where my
"git bisect --skip-when <script>" came from.  It would not be
necessary if you are doing "bisect run", which can dynamically tell
if the commit is untestable.  And if the user is going to decide
after manually testing the one that is suggested, it is not useful
either, as the point would be to avoid even asking to test ones that
need to be skipped.  So it is likely that the set of commits that
need skipping is known a-priori before the bisect session even
begins.  The end user experience may look like:

 * "git bisect start" takes "--skip-when <script>" and remembers it,
   together with other options "start" can take (like <good>, <bad>,
   <terms>, <pathspec>).

 - If <good> and <bad> are already given upon "start", the command
   may check out a revision and ask you to test.

 * Every time the command checks out a revision to be tested by the
   user, the command guarantees if it satisfies the --skip-when
   condition (and internally doing "git bisect skip").

 * Otherwise the interaction between the user and the session is
   exactly the same as usual.

