Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33291CFBC
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936060; cv=none; b=dUmcRA6kGgyyABCR2jD7xlAaPW4U7rGu6UOAKmycvxBMgRcjdaeAXfPbHOWPNYUEHFXnrmip1XUGK/cGxDVtgZujF/Etkzv/LKv18S1EvcJooqABJscK0F5k22dj3eIdVeXJtlQOZ2DHw7SH6XC5OodRZQ/HMGtTYSq8VXEU/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936060; c=relaxed/simple;
	bh=6igFFhplDqzZ2mqtocdAEArBvjwwqN/jhxekQybqcOE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GAgyKa+rYKDWTprOqn9ZPWOgnckk8z/fcAZItUeJOT7/SbTpntKbPZNl0usxiFwPR94RU577rkpoEjl4TBZwWq7OM2tPQC+weNEWfs7P/xjRNh8fz4b3fAkGgN55qD/ww/OLX2mz1kIyfgYaDyo0oyEMaGvilRxmnXcdN73ufVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RaEGJ/3y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RaEGJ/3y"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715936048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z13lz5RK8dCnbL++5SsYpt83S8n8tWe+UW8HOKlPMqI=;
	b=RaEGJ/3yU5XbQzmi/Q0Nmu6ctFq3Hzdq71ZVo4qNZmnftJesJMlK+KDw3ABJy6spQ3Uf56
	s/P65I6s2B/si4NB/yxOn2ZDq38FqDx69e/VXumQh/LO+iPjKcNR4H9wR2qhKWkOUo2k5F
	tie7LiOKdHqSaU19bcQsc6tl1PD3p/0hpYRSzbh/koCtgGYwA/ewoMrie+zKcQMVkPXyuP
	mHZrmSdecr6mhGapIH6LKaNthJtxhVav6/fTlXOrho9uwr0J7I4GHHcr/8cXsqKfEM7K89
	AuW5vnfKmfELTMNkbd6SrQSNsYkPyuLTDDlLo0Jf1OpkxUzJ7KXEHszELl+mIA==
Date: Fri, 17 May 2024 10:54:06 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Sean Allred <allred.sean@gmail.com>,
 git@vger.kernel.org
Subject: Re: [Q] rebase -i: turn "pick" to "edit", make no change, what should
 happen?
In-Reply-To: <ZkcH-LAkLkf_wvfq@tanuki>
References: <xmqqy189o94c.fsf@gitster.g> <m0seyhs8o2.fsf@epic96565.epic.com>
 <xmqqmsoonccd.fsf@gitster.g> <ZkcH-LAkLkf_wvfq@tanuki>
Message-ID: <233aefd10fbe965c190541d353822fe5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-17 09:32, Patrick Steinhardt wrote:
> On Fri, May 17, 2024 at 12:09:54AM -0700, Junio C Hamano wrote:
>> Sean Allred <allred.sean@gmail.com> writes:
>> 
>> > Setting aside the obvious reality that an actual change here could have
>> > pretty serious UX considerations for folks with muscle-memory, what in
>> > your opinion would be the right thing to do? Why? Are rebase commands
>> > 'shortcuts' or are they intended to be orthogonal? Do they have designed
>> > purposes?
>> >
>> > I'm wondering if you can tease out what the 'ideal' state looks like to
>> > you, then you can identify what if anything there is to be done about
>> > it.
>> 
>> Oh, it would be very simple.
>> 
>> If I say "edit", whether I made a tree change or not, I want to get
>> an editor when I said "rebase --continue".  If I say "reword", I
>> want to get an editor _without_ having a chance to muck with the
>> tree status.  That would be the "ideal" behaviour, iow, the "mental
>> model" is just "edit" gives the users a chance to edit both trees
>> (by first giving control back to a shell prompt) and the log message
>> (by opening the editor upon "--continue"), while "reword" is only
>> about the message so does not give shell prompt back to the user
>> (unless absolutely necessary, that is.  If the "reword" were to
>> conflict due to tree changes in earlier steps, it would need to give
>> control back to a shell prompt to ask the user's help to resolve the
>> conflict.  It is just that when there is no need to edit the tree
>> otherwise, that is skipped).
> 
> I quite frequently use "edit" just to inspect commits, stop at random
> points in the history, run tests and whatnot. So this would be a UX
> regression for me because I do not want to change commit messages and
> don't want to be bothered.
> 
> With the introduction of the "break" command you can certainly argue
> that "edit" is the wrong command to use in my case. Muscle memory is
> hard to retrain though :)
> 
> One could potentially make the behaviour configurable so that you get 
> to
> choose how "edit" behaves.

I agree that it would be best to introduce a new configuration option
for this purpose.  Making such a change in the behavior of interactive
rebase permanently would probably result in more than a few raised
eyebrows, while a new configuration option would be a safe choice.
