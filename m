Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68071254B18
	for <git@vger.kernel.org>; Sat,  9 May 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342131; cv=none; b=ZSoAtBtwftqxgimyIa7E+QBz4lw9FScSpHydehUhIOHeI++YWzWzQq64XQs0M5xffygOPnH5SZHJRU+wBWqZAS3pXncXCWkOl2bmIGVxvsgEmyLqOzd0xrko+2QrHyKjyI0jN0MtkgfeWXOhwS3BJGmv7dHhq6/BCVFEV6jeQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342131; c=relaxed/simple;
	bh=dhKhjGq/4fztnSia5C2ASNgjU7f8mwJjLEk88TojsVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLmDg1FsBF9DwPAsJMR6w9+VlAdvxbxWr0M11aMzFLMJSTYQe7j5KHk8m2nQPrHyycqM3rb24oXWVjbwIQ3ECxDa0K7ZOHap/YSl2aNqkpfn5x5lOzq/L5nOjpgYJV+7rm4HeXxTuU4cWMtBuCMcXEhl8rpTcljyrPJSpc8aiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (2a02-8428-1b1d-4d01-96a9-491d-7b48-ba31.rev.sfr.net [IPv6:2a02:8428:1b1d:4d01:96a9:491d:7b48:ba31])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 56E96469;
	Sat,  9 May 2026 17:55:28 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 71C1CCA43E3; Sat, 09 May 2026 17:55:26 +0200 (CEST)
Date: Sat, 9 May 2026 17:55:26 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Message-ID: <20260509155526.GQ5260@qaa.vinc17.org>
References: <20260506010927.GE5260@qaa.vinc17.org>
 <7cedf86c-5db7-45ef-b8d4-034b792f0def@kdbg.org>
 <20260508213943.GP5260@qaa.vinc17.org>
 <cb359a26-2878-41a0-a554-9bcd28c7404c@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb359a26-2878-41a0-a554-9bcd28c7404c@kdbg.org>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3+4 (71f3e314) vl-169878 (2026-01-27)

On 2026-05-09 08:16:48 +0200, Johannes Sixt wrote:
> Am 08.05.26 um 23:39 schrieb Vincent Lefevre:
> > On 2026-05-08 14:48:01 +0200, Johannes Sixt wrote:
> >> This is expected behavior.
> >>
> >> git diff --word-diff is not agnostic to whitespace; if you drop
> >> --word-diff, you see the line-diff that the word-diff is based on. If
> >> you want whitespace-agnostic word-diff, you have to add -w.
> > 
> > This is not how it is documented. Even when using "git diff" without
> > --word-diff, but with GNU wdiff instead, the output is fine:
> > 
> > $ git diff file1 file2 | wdiff -d
> > diff --git a/file1 b/file2
> > index da04344..0074613 100644
> > [--- a/file1-]
> > {+++ b/file2+}
> > @@ -1,5 +1,5 @@
> > 1
> >  2
> >  3
> >  2
> >  4
> 
> It would have helped if you had pointed to, or cited, the documentation.
> I cannot find documentation from which I can derive that the above
> *must* be the correct output. In particular, I don't find any mention
> that --word-diff operates exactly like GNU wdiff.

For wdiff, it is just described as "display word differences between
text files", and it does exactly that. For instance, if there are no
differences in words, it shows no differences.

For git with the --word-diff, there is actually no documentation,
except the use of "changed words" and "word diff". No mention of
line diff at all! So this is quite confusing.

Note: This isn't even a line-based diff with highlighted word diff
as done by some tools, such as Emacs diff-mode.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
