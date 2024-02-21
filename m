Received: from renault.us.lt (renault.us.lt [79.98.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A920A35
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.98.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492863; cv=none; b=FzBpdEdaeXn1r5lG9CTODV/GYN4k8RfwDuEEy0ltn71I8AZwfRTfWahkybMa2nrEeh1dQGNY9ecoCzY4dZiLElQ4s3GQ+hkepQjRo9lSSxe3S7KBzQl1ltcG7GBa9YM7p4xFFkaq95ptgUc1Lf63fTNHDgBIqZLsNGylC9cgbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492863; c=relaxed/simple;
	bh=X0GgRu4n7FmXOiFrW5KJgIuoB4H/KLiLxZXjOXsQfLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkJsX32hkCICS/CYUqXWWk3k7PMd9mRJMF92l0pk6JxEpcJ0p6V/rIWeN5CKeY9lLOG0ejGXJZssKoif4XenhTFhkTp5+QnMwVq4mfPEZCFQwZ4Mr4xkCA/LExpKUMiCDg6yHcftSdSEG6wXoAsiDbQBRJtCjfla9cHJ+f7yZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org; spf=pass smtp.mailfrom=kipras.org; arc=none smtp.client-ip=79.98.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kipras.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kipras.org
Received: from [157.230.0.129] (helo=localhost.localdomain)
	by renault.us.lt with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <kipras@kipras.org>)
	id 1rcf2F-0003DU-Ay; Wed, 21 Feb 2024 07:20:47 +0200
From: Kipras Melnikovas <kipras@kipras.org>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	greenfoo@u92.eu,
	kipras@kipras.org
Subject: Re: [PATCH v4] mergetools: vimdiff: use correct tool's name when reading mergetool config
Date: Wed, 21 Feb 2024 07:20:41 +0200
Message-ID: <20240221052041.53239-1-kipras@kipras.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <xmqq8r3fyhhg.fsf@gitster.g>
References: <xmqq8r3fyhhg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: kipras

On 24/02/19 06:52PM, Junio C Hamano wrote:

> That's curious.  This is v4 and no changes from v3?

My bad. The patches are slightly different [1], I just managed to screw up the
range-diff args [2]. Won't happen again [3].

Sorry, I know this is wasting your time; this whole submission should've
been a single reroll not 3. I'll be more thorough next time.

Thank you for your time, help and quick responses.

Kipras

---

[3] https://github.com/kiprasmel/git-reroll/commit/3aa14a2860b19f86bb51f70ce0d5cec99a5aca59#diff-59ce06aeaf7a77de81c8f24c0301d95d017a83fdaec8bc1dce9877af708d1ad3R213-R227

[2]
What essentially happened was: I marked a new checkpoint "v4" *before*
sending the email, and ran format-patch with --range-diff "<checkpoint>..@",
which of course was "v4 against v4" instead of "v3 against v4"..

[1] fwiw,
Range-diff against v3:
1:  60be87c3d5 ! 1:  0018c7e18c mergetools: vimdiff: use correct tool's name when reading mergetool config
    @@ Documentation/config/mergetool.txt: mergetool.meld.useAutoMerge::
     -	windows appear. Applies even if you are using Neovim (`nvim`) or
     -	gVim (`gvim`) as the merge tool. See BACKEND SPECIFIC HINTS section
     +mergetool.<vimdiff variant>.layout::
    -+	Git's vimdiff backend uses this variable to control how the split windows of
    -+	`<vimdiff variant>` appear. Here `<vimdiff variant>` is any of `vimdiff`,
    -+	`nvimdiff`, `gvimdiff`. To configure the layout and use the tool, see the
    -+	`BACKEND SPECIFIC HINTS`
    ++	Configure the split window layout for vimdiff's `<variant>`, which is any of `vimdiff`,
    ++	`nvimdiff`, `gvimdiff`.
    ++	Upon launching `git mergetool` with `--tool=<variant>` (or without `--tool`
    ++	if `merge.tool` is configured as `<variant>`), Git will consult
    ++	`mergetool.<variant>.layout` to determine the tool's layout. If the
    ++	variant-specific configuration is not available, `vimdiff`'s is used as
    ++	fallback.  If that too is not available, a default layout with 4 windows
    ++	will be used.  To configure the layout, see the `BACKEND SPECIFIC HINTS`
     +ifdef::git-mergetool[]
     +	section.
     +endif::[]
    @@ Documentation/config/mergetool.txt: mergetool.meld.useAutoMerge::
      mergetool.hideResolved::
      	During a merge, Git will automatically resolve as many conflicts as
     
    + ## Documentation/mergetools/vimdiff.txt ##
    +@@ Documentation/mergetools/vimdiff.txt: Instead of `--tool=vimdiff`, you can also use one of these other variants:
    + 
    + When using these variants, in order to specify a custom layout you will have to
    + set configuration variables `mergetool.gvimdiff.layout` and
    +-`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout`
    ++`mergetool.nvimdiff.layout` instead of `mergetool.vimdiff.layout` (though the
    ++latter will be used as fallback if the variant-specific one is not set).
    + 
    + In addition, for backwards compatibility with previous Git versions, you can
    + also append `1`, `2` or `3` to either `vimdiff` or any of the variants (ex:
    +
      ## mergetools/vimdiff ##
     @@ mergetools/vimdiff: diff_cmd_help () {


 Documentation/config/mergetool.txt   | 19 +++++++++++++------
 Documentation/mergetools/vimdiff.txt |  3 ++-
 mergetools/vimdiff                   | 12 ++++++++++--
 3 files changed, 25 insertions(+), 9 deletions(-)

