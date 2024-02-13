Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D21119A
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853703; cv=none; b=pK9g6LBMuAq02hqJuhIOAWeVyfjCtFIxIb0aAg4eO1+yClJZkiX+czaQCbwkJxa1xWUGNh7k3E0vPRQ4p7QL1xqjr9ar+IOVPvnQx+Rqdzq72y4GlSRbCerp4oBPd5tfVbcAS7MAvL2vdUR+1lo06wj9qWelkLyXn5XiJ661N9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853703; c=relaxed/simple;
	bh=K8k9rH+QkAh+D06HROd87onb0774ALJOFbpD3y4V64Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dsojkskb3+C2/ECre1e2Bu125Ef+6wEhXK11jmvf7TucC3EfeSmRbx7ftmVl+TIQGz3GcAmxzpBrKWqHgSENY3mBu5qGjTqkKm3KhE9B2jmkCN/vcKNmmXDtyc4t/CNb0RngoJU49absXPxVb0zijG+54hfZSYbcpCj6EhSe5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QPlBFFHk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QPlBFFHk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 57A40198EB;
	Tue, 13 Feb 2024 14:48:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K8k9rH+QkAh+D06HROd87onb0774ALJOFbpD3y
	4V64Q=; b=QPlBFFHkDXfSvdai4EtWKEtppE5Bn+XGGfn9qv13qbusmNqnVxTbvL
	6avYXHIqyxoXJm0h6vwRrt/0G5ncS664Pd5epcR4Fw4rQrRe8Kfq4L4BBrzXnhDZ
	uQTivpsFjd9qyp/l+aZ+73MbB1raqkL9/b5fJqV9MbLWX7FMajpP8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 500B7198EA;
	Tue, 13 Feb 2024 14:48:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2DFF198E9;
	Tue, 13 Feb 2024 14:48:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Xiaoguang WANG <wxiaoguang@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  git@vger.kernel.org
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
In-Reply-To: <xmqqle7o6zs8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	13 Feb 2024 09:26:47 -0800")
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
	<xmqq8r3p7glr.fsf@gitster.g>
	<c243c260-b346-4b53-b8a2-685389ad344e@gmail.com>
	<xmqqle7o6zs8.fsf@gitster.g>
Date: Tue, 13 Feb 2024 11:48:15 -0800
Message-ID: <xmqqbk8k5eo0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4E41550-CAA8-11EE-838B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately the minimum fix is already in 'next', so let me turn
> what you wrote into an update relative to that.  I'll assume your
> patch in the discussion is signed-off already?

Nah, my mistake.  The topic still is outside 'next', so I'll replace
it with the attached while queuing.

Thanks.

------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] write-or-die: fix the polarity of GIT_FLUSH environment variable

When GIT_FLUSH is set to 1, true, on, yes, then we should disable
skip_stdout_flush, but the conversion somehow did the opposite.

With the understanding of the original motivation behind "skip" in
06f59e9f (Don't fflush(stdout) when it's not helpful, 2007-06-29),
we can sympathize with the current naming (we wanted to avoid
useless flushing of stdout by default, with an escape hatch to
always flush), but it is still not a good excuse.

Retire the "skip_stdout_flush" variable and replace it with "flush_stdout"
that tells if we do or do not want to run fflush().

Reported-by: Xiaoguang WANG <wxiaoguang@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 write-or-die.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/write-or-die.c b/write-or-die.c
index 3942152865..01a9a51fa2 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -18,20 +18,20 @@
  */
 void maybe_flush_or_die(FILE *f, const char *desc)
 {
-	static int skip_stdout_flush = -1;
-
 	if (f == stdout) {
-		if (skip_stdout_flush < 0) {
-			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
-			if (skip_stdout_flush < 0) {
+		static int force_flush_stdout = -1;
+
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
-- 
2.44.0-rc0-46-g2996f11c1d

