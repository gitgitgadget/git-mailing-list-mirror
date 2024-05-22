Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337561CD13
	for <git@vger.kernel.org>; Wed, 22 May 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360052; cv=none; b=SgmzgIVL52qznELE8BU4+xWoff9hsDLKO4wCnbrZBGN6OBVXkW+zikp4qlH/Y52YM6TPoCvcAXp/WGGpUCB2yBORiLywRz5yVYTdTVNhIynqZ6bj2eaaPxyPhmMragKctyDGS/PGSSw2Ko3ksIJuP/s3aMFtc3vynvtaEoP39T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360052; c=relaxed/simple;
	bh=Zm6Jt+h2GQNdG1FXgUw7wti16iZGWDHkCAo0GgNRRfo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j4pHn2VLP2poQiMDFUuw7ANujygwLPRzOisyxZBKOKoaz2ABMOedV7FlOg0MyfZVGmF4pYsGl3iYnkJD0OptE0uwICfFWhJo9AS63RvvZFELov8U3yziOBbm9OX1yjcwhHblpes5C+kKR2L/TmYoZcOuOrt+u+z8JYDrjGHtdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tdxb25Kj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tdxb25Kj"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716360048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDuTQVzY15S+tcDFICDQ+RZX5Li0uQqV/HUjwd379GM=;
	b=tdxb25KjSjl8Hg7MTkqY99B9a/Flklkg6OM+tZ3fGyNu2tXq0M8n7fY2gG0IF8Txt2pGUp
	8nZ6PfdTelD/kYsIaKMvBv7lHryShqPhCwgpm240LxhvCRNjRSvzBr1vxhtj+masImHPip
	daOqzClMzwlZJeByfvjSXSqBBdHYuhwqe5GxwlnqpBC77BIBfqtrNgYTkppRC5OKoniRjf
	EJeVHqLytBYcdnM8DRaw0+9xnLUU8HMxbD0B1Fe+N2GN717MV7p0OQutIRUolhf0EgKSga
	Sj7XNaxg8l3AHfaHk/FXrxF94fP2wTT3gOgg4lE2Tqh1LQZOPjBxkM7ozFJ5Ig==
Date: Wed, 22 May 2024 08:40:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2] add-patch: enforce only one-letter response to prompts
In-Reply-To: <xmqqh6eqiwgf.fsf@gitster.g>
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
Message-ID: <fbb9c7d3e7c2129bc1526dfa5a8eca0c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

Please see my comments below.

On 2024-05-22 01:20, Junio C Hamano wrote:
> In an "git add -p" session, especially when we are not using the

s/In an/In a/

> single-char mode, we may see 'qa' as a response to a prompt

Perhaps s/single-char/single-character/

> 
>   (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
> 
> and then just do the 'q' thing (i.e. quit the session), ignoring
> everything other than the first byte.
> 
> If 'q' and 'a' are next to each other on the user's keyboard, there
> is a plausible chance that we see 'qa' when the user who wanted to
> say 'a' fat-fingered and we ended up doing the 'q' thing instead.
> 
> As we didn't think of a good reason during the review discussion why
> we want to accept excess letters only to ignore them, it appears to
> be a safe change to simply reject input that is longer than just one
> byte.
> 
> The two exceptions are the 'g' command that takes a hunk number, and
> the '/' command that takes a regular expression.  They has to be
> accompanied by their operands (this makes me wonder how users who
> set the interactive.singlekey configuration feed these operands---it
> turns out that we notice there is no operand and give them another
> chance to type the operand separately, without using single key
> input this time), so we accept a string that is more than one byte
> long.
> 
> Keep the "use only the first byte, downcased" behaviour when we ask
> yes/no question, though.  Neither on Qwerty or on Dvorak, 'y' and
> 'n' are not close to each other.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * This version fixes the breakage in t3701 where we exercise the
>    '/' command.  Further code inspection reveals that 'g' also needs
>    to be special cased.
> 
>    The previous iteration was <xmqqr0dvb1sh.fsf_-_@gitster.g>.
> 
>  add-patch.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 79eda168eb..a6c3367d59 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1228,6 +1228,7 @@ static int prompt_yesno(struct add_p_state *s,
> const char *prompt)
>  		fflush(stdout);
>  		if (read_single_character(s) == EOF)
>  			return -1;
> +		/* do not limit to 1-byte input to allow 'no' etc. */
>  		switch (tolower(s->answer.buf[0])) {
>  		case 'n': return 0;
>  		case 'y': return 1;
> @@ -1506,6 +1507,12 @@ static int patch_update_file(struct add_p_state 
> *s,
>  		if (!s->answer.len)
>  			continue;
>  		ch = tolower(s->answer.buf[0]);
> +
> +		/* 'g' takes a hunk number, '/' takes a regexp */
> +		if (1 < s->answer.len && (ch != 'g' && ch != '/')) {

To me, "s->answer.len > 1" would be much more readable, and
I was surprised a bit to see the flipped variant.  This made
me curious; would you, please, let me know why do you prefer
this form?

> +			error(_("only one letter is expected, got '%s'"), s->answer.buf);
> +			continue;
> +		}
>  		if (ch == 'y') {
>  			hunk->use = USE_HUNK;
>  soft_increment:

The patch is looking good to me, and I find it good that it
improves the strictness of the user input, which should also
improve the overall user experience.
