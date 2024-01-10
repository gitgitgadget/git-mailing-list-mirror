Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6B4D121
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qQG0tDEE"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704908750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7vXgpgsexj2sOQkdKzO+WY4DQLaYvXYSbks8NVT39w=;
	b=qQG0tDEET4I6cHUVuL6G60wHkNVib6bJvwxvIQRt8prhC7N60UYHqxyT073Y6IM4rE3OkE
	tdmOZRmGrTTCrWP+7eP4dpDpV63X5771oUd5o7o7b8MTfOBAVGqxIxJf1yXcMhh8TeiFet
	sR9Qy/jfJejTBwGaYJzJAPOII3ssQIAtyquhr/25fA/HwwK08HCIMuI9uJgQiIIGQtkpSs
	n4Whw/7cc5tTcm/rVDyD+ME4uDKF+1RMGglrVwpWFq/xpG4/5W9n7/kv8YWX783ySX9tXq
	lJksVEEDsjXnbxMoyufMW2dDuegW1Zfifu3346tQpJCvK6fZ5vazUBSfXvh4HA==
Date: Wed, 10 Jan 2024 18:45:49 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Jeff King
 <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <xmqqil41duov.fsf@gitster.g>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
Message-ID: <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-10 17:22, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> No worries.  Regarding disabling the advices for disabling the advice
>> messages, maybe it would be better to have only one configuration knob
>> for that purpose, e.g. "core.verboseAdvice", as a boolean knob.
> 
> I am not sure if you understood Peff's example that illustrates why
> it is a bad thing, as ...
> 
>> That
>> way, fishing for the right knob for some advice message wouldn't turn
>> itself into an issue,
> 
> ... this is exactly what a single core.verboseAdvice knob that
> squelches the "how to disable this particular advice message" part
> from the message is problematic.  Before you see and familialize
> yourself with all advice messages, you may see one piece of advice X
> and find it useful to keep, feeling no need to turn it off.  If you
> use that single knob to squelch the part to tell you how to turn
> advice X off.  But what happens when you hit another unrelated
> advice Y then?  Because your core.verboseAdvice is a single big red
> button, the message does not say which advice.* variable to tweak
> for this particular advice message Y.

Makes sense, but please allow me to explain how I envisioned the whole 
thing
with the single, big core.verboseAdvice configuration knob:

1) You use git and find some advice useful, so you decide to keep it 
displayed.
    However, the additional advice about turning the advice off becomes 
annoying
    a bit, or better said, it becomes redundant because the main advice 
stays.

2) As a result, you simply set core.verboseAdvice to false and voila, 
the
    redundant additional advice disappears.  Seems perfect!  Of course, 
it
    isn't perfect, as the next point will clearly show.

3) You keep using git, and some advice becomes no longer needed, maybe 
even
    one of the advices that you previously used to find useful, or you 
find
    some newly added advice a bit annoying and, as a result, not needed.  
But,
    what do you do, where's that helpful additional advice?

4) As a careful git user that remembers important things, you go back to 
your
    git configuration file and set core.verboseAdvice to true, and the 
additional
    advices are back, telling you how to disable the unwanted advice.

5) After you disable the unwanted advice, you set core.verboseAdvice 
back to
    false and keep it that way until the next redundant advice pops up.

However, I do see that this approach has its downsides, for example the 
need
for the unwanted advice to be displayed again together with the 
additional advice,
by executing the appropriate git commands, after the above-described 
point #4.

Let's see what it would look like with the granular, per-advice on/off 
knobs:

1) You use git and find some advice useful, so you decide to keep it 
displayed.
    However, the additional advice about turning the advice off becomes 
annoying
    a bit, or better said, it becomes redundant because the main advice 
stays.

2) As a result, you follow the additional advice and set the specific 
knob to
    false, and voila, the redundant additional advice disappears.  Of 
course,
    it once again isn't perfect, as the next point will clearly show.

3) You keep using git, and one of the advices that you previously used 
to find
    useful becomes no longer needed.  But, what do you do, where's that 
helpful
    additional advice telling you how to turn the advice off?

4) Now you need to dig though the manual pages, or to re-enable the 
additional
    advices in your git configuration file, perhaps all of them at once, 
while
    keeping a backup of your original settings, to restore it later.  
Then, you
    again need to wait until the original advice gets displayed.

5) The additional advice is finally back, after some time passes or 
after
    specifically reproducing the exact git commands, telling you how to 
disable
    the unwanted advice.  Of course, you follow the advice and set the 
right
    knob in your git configuration file.

5) After you disable the unwanted advice, you restore the git 
configuration
    backup that you made earlier (you did that, right?), taking care not 
to
    override the newly made changes that disabled the unwanted advice.

Quite frankly, the second approach, although more granular, seems much 
more
complicated and more error-prone to me.

Of course, please let me know if I'm missing something obvious.
