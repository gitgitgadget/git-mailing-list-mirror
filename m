Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2AC17B4E8
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030628; cv=none; b=a5iHq/Th8MagkjreiHxtHjQs+NogOgwCfC2zRwV7B08HE1BR6GX31q1lIwjs9Zo1PunO7Op6guq9FnbKu5bneqZ6FePNNAadEVU27N3nQbfWxr+R13Y+UAh2831OHVzSXG2stVsZqYb1pDBuZJSVLh9jytkO05wzxez6aLI1zoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030628; c=relaxed/simple;
	bh=AY/xs7J8lTM/PTF32TTg7wune9q5/KCf6iUusoRy8oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GZQiNLx5Fx2wy6mB4BkEU7pXBivhkDb1UKvjwxTix9IDLF9xRIZ7mZab+BBjaQxxkMoWLjKu7Ma8ODyk2dV8iptI5Lx9U34MazynSSbApYHS67IScivYPfpLjYRBF4sqwj8WCNW3CtCDUOW0zunQFH+Pyqxn1BvvbxE4NYB6TIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AlbEwgPT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AlbEwgPT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4497E2BB16;
	Wed,  3 Jul 2024 14:17:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AY/xs7J8lTM/PTF32TTg7wune9q5/KCf6iUuso
	Ry8oo=; b=AlbEwgPTSCDrsIOzhMp5y4vbNe9Gb122KnQeaMRQWm9Dtvslf0DObc
	Llgep246QnrqAAvdD4yvOQa7GiaZN6y5iWzi2Jki38D3Tk77EhQy/SrQTJgs+yTA
	8KykHi8CUPDlm0pb6g3J5WF3pqWn0BXbnIETypTo1dlcx4NBt4DKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3672B2BB15;
	Wed,  3 Jul 2024 14:17:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DE692BB13;
	Wed,  3 Jul 2024 14:17:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,  git@vger.kernel.org,  Paul
 Millar <paul.millar@desy.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Elijah Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
In-Reply-To: <CAOLa=ZR-g4G0FaxnQjjkOST-zeRxBXXK1gpJ=P3xdbi_9eN_rg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 2 Jul 2024 10:13:30 +0000")
References: <xmqqpls3zhc2.fsf@gitster.g>
	<20240626190801.68472-1-abhijeet.nkt@gmail.com>
	<03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
	<xmqqfrsyv155.fsf@gitster.g>
	<CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com>
	<xmqqle2lvsmz.fsf@gitster.g>
	<CAOLa=ZR-g4G0FaxnQjjkOST-zeRxBXXK1gpJ=P3xdbi_9eN_rg@mail.gmail.com>
Date: Wed, 03 Jul 2024 11:17:04 -0700
Message-ID: <xmqq1q4acpcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 73EBA586-3968-11EF-98A7-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This explains for why 'broken' must use a subprocess, but there is
>>> nothing stopping 'dirty' from also using a subprocess, right? It
>>> currently uses an in-process index refresh but it _could_ be a
>>> subprocess too.
>>
>> Correct, except that it does not make sense to do any and all things
>> that you _could_ do.  So...
>
> Well, In this context, I think there is some merit though. There are two
> blocks of code `--broken` and `--dirty` one after the other which both
> need to refresh the index. With this patch, 'broken' will use a child
> process to do so while 'dirty' will use `refresh_index(...)`. To someone
> reading the code it would seem a bit confusing.

Yes, that much I very much agree.

> I agree there is no
> merit in using a child process in 'dirty' by itself.

Yes, that made me puzzled why you brought it up, as it was way too
oblique suggestion to ...

> But I also think we
> should leave a comment there for readers to understand the distinction.

... improve the "documentation" to help future developers who wonder
why the code are in the shape as it is.

In this particular case, I think it is borderline if the issue
warrants in-code comment or if it is a bit too much.  Describing the
same thing in the log message would probably be a valid alternative,
as "git blame" can lead those readers to the commit that introduced
the distinction (in other words, this one).

Thanks.

diff --git i/builtin/describe.c w/builtin/describe.c
index e936d2c19f..bc2ad60b35 100644
--- i/builtin/describe.c
+++ w/builtin/describe.c
@@ -648,6 +648,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (argc == 0) {
 		if (broken) {
+			/* 
+			 * Avoid doing these "update-index --refresh"
+			 * and "diff-index" operations in-process
+			 * (like how the code path for "--dirty"
+			 * without "--broken" does so below), as we
+			 * are told to prepare for a broken repository
+			 * where running these may lead to die().
+			 */
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			strvec_pushv(&cp.args, update_index_args);
