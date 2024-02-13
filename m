Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4065EE81
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845212; cv=none; b=lu0NvTEagxTOpwwNu33fefZwZAgEWkssRfHj6MugSHb0q2mc2pke3eMgBeNLmb77QfdHCgx+CR/Dfbtwe/z3EYKnbtyjja2N1IBgqDjciowYZUctcW8WQ5ZXnF6EKDI+0AF2Q8cBxwXBn157kvAGlAiR7EZe6RtUJuqnf/KG47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845212; c=relaxed/simple;
	bh=MgoNcI8VzIrG8EqB5PSdiaVsUvxg69Zvr7EEV9ugisY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ME0DgB2CgJ+EhYbp2qpL1SQzXKVY7HaoR1pwMBmkmQPmE4cOz52VOe+dMLtIJgE+VXV3J1KLqnWlrKgn+josJdBoMh3USdUnmb+jjrrKmHvXJXpUIFDU4TkmfiN5xQv86vEU2+dzDGStFQf6xlKuaGvDF4SsBPyQ3zwdgCf4gxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttvwgBdI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttvwgBdI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0898C1C53EA;
	Tue, 13 Feb 2024 12:26:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MgoNcI8VzIrG8EqB5PSdiaVsUvxg69Zvr7EEV9
	ugisY=; b=ttvwgBdIs4/3TtQuFgy8WtCLAPs4m3SnWR7h3AxG+9fSEJ2s/ehZVP
	iEEg8iwllx6OCrxdH8ve8qYy8Ij0G6qiWo7qfiJAIACYduOdO+1/o/CI75u2DwBa
	2xF0LzJvCTqPhPK1Vw0+YYeMlmcWTzHAZ4xoTV2Uljj5MhicK+i8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3EAC1C53E9;
	Tue, 13 Feb 2024 12:26:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 657201C53E7;
	Tue, 13 Feb 2024 12:26:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Xiaoguang WANG <wxiaoguang@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  git@vger.kernel.org
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
In-Reply-To: <c243c260-b346-4b53-b8a2-685389ad344e@gmail.com> (Phillip Wood's
	message of "Tue, 13 Feb 2024 11:07:58 +0000")
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
	<xmqq8r3p7glr.fsf@gitster.g>
	<c243c260-b346-4b53-b8a2-685389ad344e@gmail.com>
Date: Tue, 13 Feb 2024 09:26:47 -0800
Message-ID: <xmqqle7o6zs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 114D948A-CA95-11EE-8FC1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Given we're in a rc-period a minimal fix like this looks appropriate
> (though it is missing some braces according to our coding
> guidelines). The interaction of "skip_stdout_flush" and git_env_bool()
> is unfortunate, It might be clearer if we changed to having
> "force_stdout_flush" instead but that would be a more invasive change.

I admit that I did find the polarity of the existing variable
annoying, and it does make sense to flip it like you did here.

Unfortunately the minimum fix is already in 'next', so let me turn
what you wrote into an update relative to that.  I'll assume your
patch in the discussion is signed-off already?

------- >8 ------------- >8 ------------- >8 -------
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: maybe_flush_or_die(): flip the polarity of an internal variable

We take GIT_FLUSH that tells us if we want to flush (or not) from
the outside, but internally use a variable that tells us to skip (or
not) the flushing operation, which makes the code flow unnecessarily
confusing to read.

With the understanding of the original motivation behind "skip" in
06f59e9f (Don't fflush(stdout) when it's not helpful, 2007-06-29),
we can sympathize with the current naming (we wanted to avoid
useless flushing of stdout by default, with an escape hatch to
always flush), but it is still not a good excuse.

Retire the "skip_stdout_flush" variable and replace it with "flush_stdout"
that tells if we do or do not want to run fflush().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 write-or-die.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git c/write-or-die.c w/write-or-die.c
index 3ecb9e2af5..01a9a51fa2 100644
--- c/write-or-die.c
+++ w/write-or-die.c
@@ -18,23 +18,20 @@
  */
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
-	static int skip_stdout_flush = -1;
-
 	if (f == stdout) {
-		if (skip_stdout_flush < 0) {
-			int flush_setting = git_env_bool("GIT_FLUSH", -1);
+		static int force_flush_stdout = -1;
 
-			if (0 <= flush_setting)
-				skip_stdout_flush = !flush_setting;
-			else {
+		if (force_flush_stdout < 0) {
+			force_flush_stdout = git_env_bool("GIT_FLUSH", -1);
+			if (force_flush_stdout < 0) {
 				struct stat st;
 				if (fstat(fileno(stdout), &st))
-					skip_stdout_flush = 0;
+					force_flush_stdout = 1;
 				else
-					skip_stdout_flush = S_ISREG(st.st_mode);
+					force_flush_stdout = !S_ISREG(st.st_mode);
 			}
 		}
-		if (skip_stdout_flush && !ferror(f))
+		if (!force_flush_stdout && !ferror(f))
 			return;
 	}
 	if (fflush(f)) {
