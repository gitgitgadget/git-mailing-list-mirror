Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC348CC5
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959913; cv=none; b=CqMsiGlA2nt5WmKF8jC1mExX0SsBgLoXdoLaqYimK9cIFdibsgtwQKW18i+U8avOuGYHfNE05G4oFmIfSluiEh0QFiIh/taXkFkeUEbc21eDwiwXU14JJ4qj6Hk1eYRxi0JFh8ngKBqz3r4XWvF+qCcj5JapFMI/JpjgrhZlzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959913; c=relaxed/simple;
	bh=rtQOCWXN5Zpk9ytPyRi/KiusPk+yRrKZBbEpsVy9pOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MpirItbS6er6267LnH1PurmcxRz89dYrOWxcVaMZK21D+RBdN242Pk9Uxcl0zwXSbqLnYQ1KqIbi9r3pTeKgs1vh3ICjcQL5o15/7q/eR4cFqgpHDCDUqr7J/9t4FGZZiS7NVUXfNS+W2UU0bQjKqUztLfW+c5aVgWjJNBBDK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nwMZPB4I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nwMZPB4I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDE0633F6F;
	Mon, 22 Jan 2024 16:45:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rtQOCWXN5Zpk9ytPyRi/KiusPk+yRrKZBbEpsV
	y9pOw=; b=nwMZPB4ISGqCELyVAPydlcZPF6fsOFjpn6J86tAz9PQrTeZSvEKCXg
	4MurJ9M20gLhd6BetvWschp2lQ34xFpZ4j7CkfN/jmCYZmh8M7CYWO2wj6DO7g+G
	UDAxO2z1epRImb1IXqe408QgEWhNCv81mRN/LBecPawe+3MJK2Jm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D5C5533F6C;
	Mon, 22 Jan 2024 16:45:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 48A5D33F6A;
	Mon, 22 Jan 2024 16:45:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>,
  git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using
 --others --exclude-from, and a .gitignore file which resides in a
 subdirectory
In-Reply-To: <20240122213410.GA811766@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Jan 2024 16:34:10 -0500")
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
	<CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
	<20240122213410.GA811766@coredump.intra.peff.net>
Date: Mon, 22 Jan 2024 13:45:05 -0800
Message-ID: <xmqq1qa9rqji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8244C3AC-B96F-11EE-BC3A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> PS I hadn't realized that --exclude-per-directory had been marked as
>    deprecated. I do agree with e750951e74 (ls-files: guide folks to
>    --exclude-standard over other --exclude* options, 2023-01-13) in its
>    goal of guiding people to the easiest option, but I don't know that
>    there has been any discussion about removing the other ones.

I do not think there is any value in _removing_ the perfectly well
working --exclude* options, even though I think --exclude-standard
should be what users and scriptors should be using if they want to
emulate what Git does internally.

