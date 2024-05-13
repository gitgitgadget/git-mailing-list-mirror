Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00EC53E30
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640779; cv=none; b=am9YtZAh7rl5+xLfou6wer3y2QA9xTWbFTxD/Oh8rjeXK2KHX/lNpUkYjayLa+0jYcQlpD/OyMpShhZ4s5RA3oEu/+FCoXWFpJNwgJFe4uoGdDXjJe0TvpLiPaMI6U33ZVUxrEVShINSEF1T6E7o1MeCNcW9Eqj2kIrnE7sbFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640779; c=relaxed/simple;
	bh=MlN6WVheepB1vObNEnQ2cSMpExDX5oD17Z4634s7af4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HvmFmNsLOg4G0wMNWuX3HOt0XVAFXtsiSk+rlEgMF+dbX/wRgWUALFX830GkI+3YfOf+4sl0XnRzaxWE04+ZPUi+uljicDopmN6whHK0PrgC5rhE9AuLTJgJ9BhbdvFdqm4BtExBJ0ZvArK54cz2Y9s6ujAnFwn2nY5v9OCAAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vLzcXcSr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vLzcXcSr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 615EB37B0A;
	Mon, 13 May 2024 18:52:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MlN6WVheepB1vObNEnQ2cSMpExDX5oD17Z4634
	s7af4=; b=vLzcXcSrC0UmjgeTiA3AAsTpIObu21lAnl5kpP/TFm+LlSZRJu82vW
	G0PCdEcxYNz3i6ufD3edU8oSdpwRg3fi50xucTCJ65+KwpK2gDJbyD7kMWQEf/Az
	AqPYAdcaSqKMyQeYrrgapvxxxqSwTo5LHOhrrwOHHx1NzA6rPndnU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59A4837B09;
	Mon, 13 May 2024 18:52:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C128437B08;
	Mon, 13 May 2024 18:52:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: u34@net9.cf
Cc: git@vger.kernel.org
Subject: Re: Options to have git log presents commits of a non linear
 history in a meaningful order
In-Reply-To: <E1s6cl5-0003nc-3D@mx1.net9.cf> (u34@net9.cf's message of "Mon,
	13 May 2024 20:58:55 +0000")
References: <E1s6cl5-0003nc-3D@mx1.net9.cf>
Date: Mon, 13 May 2024 15:52:51 -0700
Message-ID: <xmqqmsotcojg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87C203A8-117B-11EF-9AD5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

u34@net9.cf writes:

> Am I right by default, git log present commits of a non linear history in
> a meaningles order? Am I right git log has options, such as --graph, to 
> get the order of commits presented in a more meaningful way?

I wouldn't say --graph gives much meaningful ordering.  

Rather, "--graph" is a way to present the list of things that is
fundamentally not an ordered list by giving an extra information
(information that cannot be captured by orders alone) to make it
visually apparent in the output which ones form partial ordering
among them.

If you have two branches, one has commits A and B and the other has
commits X, Y, and Z, since they forked, your history may look like:

    o---A---B
     \
      X---Y---Z

and your command "git log ^O B Z" can present them in any order as
long as B is shown before A, Z is shown before Y and X, and Y is
shown before X.  There is a partial ordering among the commits that
are ancestors of B, and there is another partial ordering among the
commits that are ancestores of Z.  But there is no "meaningful"
ordering between sets (A, B) and (X, Y, Z).  This is especially true
if the two branches were done by different people, perhaps in
different timezones, possibly with one of them using a wrong clock.
Their timestamps cannot tell you the relative ordering of the
commits across these two sets.

> As of git 2.45.0, gittutorial states 
>     
>    The git log command has a weakness: it must present commits in
>    a list. When the history has lines of development that
>    diverged and then merged back together, the order in which git
>    log presents those commits is meaningless.
>
> Is it accurate?

I wouldn't read the tutorial with such a fine toothed comb.  It is
good if it is filled with white lies to make the initial learning
process smoother.  When it tells that users shouldn't read too much
into the ordering of commits, readers should just stick to what was
suggested.

