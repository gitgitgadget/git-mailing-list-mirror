Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B546450
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757880; cv=none; b=Dqg6ZbJ0GHmas8YSj6d+vhF9JKjSq9/bQpGcTJog0/c3rut6sYjuMNcb/U63ALNPFVTJoZZdos2eq3hXZAGl/Qc4OvOeHQ3S7S4+Y6hozETFm5CWYVZJPP6EBU4GkvwCLL+I+mr9/YlHEqnoiZJXe+o6WQqb2/HgMtu7C+LJf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757880; c=relaxed/simple;
	bh=N/AdP/XD6GqvHDNFfk4dETZH0Rgi9FQu/DHUyuZnhLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VC1y3RMdL12jC7mwDGV7JBIc25DWNYK7+w1vOO/kyMq73bmqfMUh3pGBWaOjmuIIusu2Nypl5Xd5EyG3H7eFqpF8l0IPulH4FilRT+FdytQIABU0aQlavI9NhMVuVcb1LW7+8M3+oeuTVh8cAa24bI2YBcpTa8XAz5D6TvTjBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vy+iGxNc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vy+iGxNc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 01D882C2DD;
	Mon, 12 Feb 2024 12:11:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N/AdP/XD6GqvHDNFfk4dETZH0Rgi9FQu/DHUyu
	ZnhLk=; b=Vy+iGxNcYQX/kv9PRmqvTrrXeoM6pEyT0OgH+jwZMq/ZvtxGuI4w1z
	J7KYqiV4b4x86UQN2ZjEyCxyuad4QfLHvqL0/7x6QZJH+WlwUL4vj9eYR8XxNdax
	ACCAfALGnx4qtdbCww/77BO542XmTZclqa4WDuw5pKYKTCLDRhAwE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE66C2C2DC;
	Mon, 12 Feb 2024 12:11:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93FF72C2DB;
	Mon, 12 Feb 2024 12:11:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Xiaoguang WANG <wxiaoguang@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
In-Reply-To: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
	(Xiaoguang WANG's message of "Mon, 12 Feb 2024 23:18:38 +0800")
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
Date: Mon, 12 Feb 2024 09:11:12 -0800
Message-ID: <xmqq8r3p7glr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA4C46FC-C9C9-11EE-952C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Xiaoguang WANG <wxiaoguang@gmail.com> writes:

> If GIT_FLUSH=true, it should mean to "do the flush". But that commit
> made skip_stdout_flush=true when GIT_FLUSH=true.

Thanks for reporting.  I am surprised that this flipping of polarity
slipped through.

> And by the way, only accepting GIT_FLUSH=true is quite breaking, it
> drops the compatibility of GIT_FLUSH=1

I do not think so. If the polarity is corrected, git_env_bool()
would say "that's affirmative" when any one of the "1", "true",
"yes", "on", etc. is given.  If you have been passing "1", you
should get the "always flush" behaviour.


Perhaps something like this would fix it?


 write-or-die.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git c/write-or-die.c w/write-or-die.c
index 3942152865..3ecb9e2af5 100644
--- c/write-or-die.c
+++ w/write-or-die.c
@@ -22,8 +22,11 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 
 	if (f == stdout) {
 		if (skip_stdout_flush < 0) {
-			skip_stdout_flush = git_env_bool("GIT_FLUSH", -1);
-			if (skip_stdout_flush < 0) {
+			int flush_setting = git_env_bool("GIT_FLUSH", -1);
+
+			if (0 <= flush_setting)
+				skip_stdout_flush = !flush_setting;
+			else {
 				struct stat st;
 				if (fstat(fileno(stdout), &st))
 					skip_stdout_flush = 0;
