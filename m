Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB7390212
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295215; cv=none; b=GqUQOC7PgwviRCP8Fc1bH3o9rE0A9FcBHWJ2HjzkwllNUkqcV2wA4hkXI1gH4cOOEAoTdtyh5uPOI25wKNx5wHn3QOS5FqFmVGjjMolcg6N/agCUsB1kNWoEO7kBD1F7R4RVlcAGZIt8CfjNU3C+gWFoESjz+wNIleXyH2YNRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295215; c=relaxed/simple;
	bh=ML+jLUWVbIwDtX+yN6bYA+D610Q8CuTWURHAv2MpoAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1vsJMW3PFouWq4fS5jtLm/TQqLMEpwtRidJwCrszE2+KfIEaMxBQYNiDlAuzzvlO+YIpXL+nxW8QcAbjZfIDKQiA8/2C3Hh/l5wYtDY6IVOEICFqNFqR3gQDEFwna7LeGk2H9kZOTn9pbn9/UbIye3H6yLLeHJIc8Sy+nYN4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VLnPaMOY; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VLnPaMOY"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:1169:f360:cc17:a551:23bf:2964])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 978C713F861;
	Sun, 13 Sep 2026 12:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789295200;
	bh=ML+jLUWVbIwDtX+yN6bYA+D610Q8CuTWURHAv2MpoAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLnPaMOYKVeX5NV2IZFQvNfki2nU7XaY1bCcyNIU4JDjqFG/fwWZcKFETV3Bv1Gxq
	 LEqOuCUX/2YFnBBhK++ZkezCDD1RhEu0FDL104P5RUljIxBbZGGTtjL8k2e/y9DjEM
	 ND6VWlLIUV87FEF5l/uOUpSDU+/hyE5brlQ6Tsu+g02iYE1sprm/+UFpsFA232kvi5
	 YcFtyeomBH0FTdO1jrYExKLiWMc2pqBGXNHH9gfWFpaiACZ3woV2DpGFkSy08QGcKT
	 EyXAUI6gu2dMqaCeWaUHKYiJgRlZ34xV9z9MH4Qsqez5VQjMZGrvtHJ6GB9QcAhy7V
	 mSZttDS/UYHJg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] doc lint fixes for pack-refs and refs
Date: Sun, 13 Sep 2026 12:26:39 +0200
Message-ID: <Uds1uZlUTZi1p6vFK4zhWg@free.fr>
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 12 September 2026 21:14:59 CEST Todd Zullinger wrote:
> I was reading git-refs(1) after noticing it learned some new tricks in the
> 2.56.0 release notes.  The formatting stood out because the first two 
commands,
> migrate and verify are bold (in the man pages) but subsequent commands are 
not.
> The HTML is similarly affected, with those commands colored differently than
> the rest in our online documentation:
> 
>     https://git-scm.com/docs/git-refs
> 
> This is due to inconsistent backtick-quotes.
> 
> This led me to the lint check, which I think might benefit from the small
> change here to match commands as well as options.  Running something like 
this
> reports a number of files which could also use some tweaks:
> 
>     cd Documentation && for i in *.adoc; do
>         output=$(perl lint-documentation-style.perl <$i 2>&1)
>         [[ -n $output ]] && printf '\n%s:\n%s\n' $i "$output"
>     done
> 
> I _think_ we want to backtick-quote those when using the synopsis style.  
(If
> not, then the change is wrong and we should remove the backticks from the 
two
> commands in git-refs.adoc and other places.)
> 
> As git-refs.adoc includes pack-refs-options.adoc, I updated it to 
consistently
> use backtick quoting and converted the only other file which includes it,
> git-pack-refs.adoc.
> 
> Todd Zullinger (3):
>   doc lint: match commands as well as options for synopsis style check
>   doc/pack-refs: convert synopsis and options to new style
>   doc/refs: backtick-quote commands and options consistently
> 
>  Documentation/git-pack-refs.adoc            |  8 ++++----
>  Documentation/git-refs.adoc                 | 14 +++++++-------
>  Documentation/lint-documentation-style.perl |  4 ++--
>  Documentation/pack-refs-options.adoc        | 10 +++++-----
>  4 files changed, 18 insertions(+), 18 deletions(-)

When I put this linting in place, I was specifically targeting the options. 
The other cases of use of definition list could range from commands to real 
definitions of words (see gitglossary.adoc and git-add.adoc), and extending 
the match can trigger false positives. Backticked terms are supposed to be 
immutable for translators, so this formatting should not be used for real 
definitions. 
For this reason, the regex is restricted on purpose, but selecting the files 
to check to allow to extend the range of checks.
, 
FWIW, the proposed change triggers false positives for git-add.adoc, git-
push.adoc, git-difftool.adoc, git-daemon.adoc and git-fetch.adoc.




