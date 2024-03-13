Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDE55C0A
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351787; cv=none; b=mDXL8Ob6dSXEcZ8oCOBx3UaPbeZPqS1aVCwmevRzjSiOvga+kChMmDYindrXkoyA7gScjA1VGbyawY5q/t7rrXYxom0apGTey0SNdwUnXGn29fZBafKsDv5loI6+kSUzcy3v1HeQroIcynb26zUme/SsFFJRjIH4xwS7IB68TKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351787; c=relaxed/simple;
	bh=0fFQsm8RsZkrHmzFPLjWqZa5UKDO/+FeLBG9GkuBeQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4/NIxro68VEqz9seeegYND2B9ILXgKS4r+01pJiqb5NR5NCrMwOhXGjPDHbej6GIzRRidpBptoiN8/9XicuY0djKiDT+PLP94fNu21jkqPXt2W0Z9TC+/qiEReJ71dKaiiy9hbfOKdIB/ZUpLvSSE2U6qasLvihIkXKpA73pcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NwygpiPV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwygpiPV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 48C2119F39;
	Wed, 13 Mar 2024 13:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0fFQsm8RsZkrHmzFPLjWqZa5UKDO/+FeLBG9Gk
	uBeQg=; b=NwygpiPVIMJmzjg30UKsRcQaayPMb4h/rZzhAwjgD79qQiE+rc3eM7
	sQVJZzvQ8r5txABcpeKdnqFBKsV1J+bVz5CJZ4Jtkse389sAIeoeszNl12TkrcrD
	9sie0ed+0Pb0IOpwaqreARP+hnA9Eicps1hhAnKGA3BeVzUPwoL/w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FED519F38;
	Wed, 13 Mar 2024 13:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E50619F35;
	Wed, 13 Mar 2024 13:43:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  barroit <barroit@linux.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] bugreport.c: fix a crash in `git bugreport` with
 `--no-suffix` option
In-Reply-To: <xmqqle6mdsw7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	13 Mar 2024 08:59:52 -0700")
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
	<xmqqle6mdsw7.fsf@gitster.g>
Date: Wed, 13 Mar 2024 10:42:59 -0700
Message-ID: <xmqqmsr2c9jw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 22C80582-E161-11EE-828A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps we should update the documentation a bit while at it?  Here
> is what I can find in its documentation.
> ...
> The above does not say that it is possible to ask the code not to
> use suffix at all with "--no-suffix".  If we want it to happen and
> behave sensibly (which I think the code with your patch does, from
> my cursory read), we probably should document it.  At least two
> developers, considered to be expert Git developers and consider
> themselves to be expert Git users, did not even anticipate that
> "--no-suffix" will hit their code.

And such a documentation update may look like this.  Feel free to
use it in an updated version of the patch but please make sure it
formats correctly (I didn't test it).

Thanks.

 Documentation/git-bugreport.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/Documentation/git-bugreport.txt w/Documentation/git-bugreport.txt
index ca626f7fc6..112658b3c3 100644
--- c/Documentation/git-bugreport.txt
+++ w/Documentation/git-bugreport.txt
@@ -8,7 +8,8 @@ git-bugreport - Collect information for user to file a bug report
 SYNOPSIS
 --------
 [verse]
-'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+'git bugreport' [(-o | --output-directory) <path>]
+		[(-s | --suffix) <format> | --no-suffix]
 		[--diagnose[=<mode>]]
 
 DESCRIPTION
@@ -51,9 +52,12 @@ OPTIONS
 
 -s <format>::
 --suffix <format>::
+--no-suffix::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named 'git-bugreport-<formatted-suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
+	`--no-suffix` disables the suffix and the file is just named
+	`git-bugreport` without any disambiguation measure.
 
 --no-diagnose::
 --diagnose[=<mode>]::
