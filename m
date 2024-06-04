Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF5146D6E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522877; cv=none; b=CHHsBSEOcO4E4/oIJA0EWF4TVXNkyggROVl0Ifj/hKJAfeWvBlKD31Q3DHWaBDKHMSPWRvkrLc+1hxgrrqX9yGc6cyHUBHTxy2V34e64X/I+9bH6XwjJ05WIR64Wwzr2vmNp+hRFSqPIxHmKR3gKrDc/AhgvB8YCTpnb56B6x5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522877; c=relaxed/simple;
	bh=gs14K0LQObaCGeF84+zJVyGI/lifN+pszHmLoB3ie3Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pXZYZclwvZSsBkXwwy/nmEDPbk5K/yvSH4Z9AgQ+n0emNdYJ/vtATDMTP5TXycpggb5NHGvXzIpIp93iiM6vdMxB92JsdHpWVLivFISBMIOl4WgAR1N47RP6SnM4W18I9zmOoeRkBlIaJ8sPPD2Mz1iDvCQ98YWefnde9UT6Z+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EJYXDLb3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EJYXDLb3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717522873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XohYgkoC6Z+WGH8jMhdMnwLdQ5mt7XQKmYw+YKv42IQ=;
	b=EJYXDLb3678iflUQ5RgW9lbmk0x9THZEZ8tH5dTYO0cD5u/8ftyPVhYv1cpRPjKX0/xYLg
	xWjt9Xv9olWSolXxqhdYO6njQKe3OzVj/AJSrATWTFaBSeUwaD/2UB0C+pY44TCspUH3uT
	gX15ATmM6IrAeIp0OXQLOqpRMcOym21rmWudHgaVcsys8OOVrzX8uN796KB26+caO+Y6bv
	lxvyJMxoFu9vVv3zwlAUImKCMMgckmSuaZEA8oXe7kebdUfjG3pO4TspfPfzW8AGAarI21
	a6+fE7oyyvLQgNDwZN7gEdW41LxR78oOuQv+Ir6uqYuGJ5Vb2dVFbLyV8JiKUQ==
Date: Tue, 04 Jun 2024 19:41:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqqcyoy6mnl.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <81d52b31ce4c287765a43d87d94f526b@manjaro.org> <xmqqcyoy6mnl.fsf@gitster.g>
Message-ID: <c9888ea1e70d892e9f21db70977e0631@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-03 18:01, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Thus, when piping to a custom program, the escape codes that
>> perform the coloring should be stripped.
> 
> I tend to agree that if we do not give a way to toggle between
> "with" and "without" color when piping to a program, it is safer to
> make the default uncolored.

Good point.  The default behavior or "|xyz" should be to strip
the coloring escape sequences, because we don't know is "xyz"
capable of handling those escape sequences properly, and to keep
the coloring with "||xyz" or whatever we come up with for our
equivalent "--color=always", so to speak.

> The user's configured pager is expected to deal with colors just
> fine (or the user has globally configured colors to be off).  As we
> are capable of telling if the user is asking to spawn the default
> pager (by not giving a custom command or by clearing the previous
> custom command given in the same session) or a custom one, it should
> be easily doable to give colored version to the configured pager and
> uncolored version to a custom/one-shot command.  Unlike the existing
> support for (e)dit command, we do not read back from what the
> command does using the hunk and present it again to the user, it
> should be a relatively easy and safe thing to do.

Exactly.
