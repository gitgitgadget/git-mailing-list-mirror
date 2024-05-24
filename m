Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A705F84F
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580720; cv=none; b=MebZJQvVqFZGbX09VWUBW24O5x/Hqtm+/Rc0xmYfUIcVe8GlXoo4zH1ZKEeRZ2UBV027XRLr3FfzJBwIOjEBjznwugmLpcRMwwN+gLR678Sh+h6Zj95JS5p9XXAFPoRahZ3JlzxQqy0mHqP2vuFlAqev3esjPzX5Zp8tAjB+62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580720; c=relaxed/simple;
	bh=f404fTxmkXzjBhiJka7JJxMolwIqE9S7K5TWl/tAYW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KIypzcooXCejNLsh598WGSpIvFRZtdVFBb10OIG71yXfRvc1HRSk3+V0k656D8o0j3WdUPOG/0zClAxA9qOvFAXiyV7RiufdHqn4YeF3gCG9Nz7FC6MbS9if90rP2XX/k/FwuNt9HIGO4ikAnasMR2ymaueL20qO1HsQDf4nRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ClcMgf4w; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ClcMgf4w"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F2C32B425;
	Fri, 24 May 2024 15:58:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f404fTxmkXzjBhiJka7JJxMolwIqE9S7K5TWl/
	tAYW0=; b=ClcMgf4wySn9ct+MH21Xjrpq4nRFBn9F7+HLSpVhfABEgidUaRTio0
	ROx0guGauEsfyc66aYOkej9X0YIouwPyEzuyWeOOeWP/dBmk9QzRhiasJc50j8GN
	peqGy3BCjN/PqGNEEmOvOnsGS8xAw0BDSB5Kui/z02exEhhTiWFGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 690DB2B424;
	Fri, 24 May 2024 15:58:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AB722B423;
	Fri, 24 May 2024 15:58:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] run-command: show prepared command
In-Reply-To: <xmqqzfsfja0d.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 May 2024 12:16:34 -0700")
References: <20240523043806.1223032-1-iwienand@redhat.com>
	<20240524073411.1355958-1-iwienand@redhat.com>
	<20240524073411.1355958-3-iwienand@redhat.com>
	<xmqqzfsfja0d.fsf@gitster.g>
Date: Fri, 24 May 2024 12:58:34 -0700
Message-ID: <xmqqttinj82d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0145BBFE-1A08-11EF-8EC7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	test_grep "^trace: prepare_cmd:.*" output
>> +'
>
> If you run
>
>     $ cd t && sh ./t0014-alias.sh -d && cat trash*.t0014-alias/output
>
> you'll see two "prepare_cmd" logged, because you added one to
> prepare_shell_cmd() and another to prepare_cmd().

To avoid similar issues, perhaps the test can try to see a bit more
into the output?  We already know that we cannot expect the output
to be identical everywhere, but we can do something along the lines
of the attached patch, or is the expected pattern below a bit too
specific?

 t/t0014-alias.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git c/t/t0014-alias.sh w/t/t0014-alias.sh
index b7affbe93a..a3c133be96 100755
--- c/t/t0014-alias.sh
+++ w/t/t0014-alias.sh
@@ -45,9 +45,17 @@ test_expect_success 'run-command formats empty args properly' '
 '
 
 test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
+	cat >expect <<-EOF &&
+	trace: exec: git-echo argument
+	trace: run_command: git-echo argument
+	trace: run_command: ${SQ}echo \$*${SQ} argument
+	trace: prepare_cmd: SHELL -c ${SQ}echo \$* "\$@"${SQ} ${SQ}echo \$*${SQ} argument
+	EOF
 	git config alias.echo "!echo \$*" &&
 	env GIT_TRACE=1 git echo argument 2>output &&
-	test_grep "^trace: prepare_cmd:.*" output
+	# redact platform differences
+	sed -e "s/^\(trace: prepare_cmd:\) .* -c /\1 SHELL -c /" output >actual &&
+	test_cmp expect actual
 '
 
 test_done

