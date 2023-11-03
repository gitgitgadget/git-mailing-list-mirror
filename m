Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8181F618
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PjeIWWLq"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9001B9
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 11:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699035744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGhj+X+XHxAa+7TnexBXUtBbzrP32Dn/eUcDm3heCxM=;
	b=PjeIWWLqBYGxV4Ea67N+FTlo+ws6QVd7DXG5CRmnI7soCzbPKoSSZtMkHQ1fEVl9wokBgX
	/qUuRoNbhLP8kHWo39nt3BjSdEA0qDmuii+yQeCMLvrsaRibsLtf9TLj1nJalOkVynTjB0
	L/058Irm6rdaJHVZ/zjxUTrR8EWK+ayB2u9FTYmBL701HDB3xGUPwB7NxOWqzT6hU6hIYQ
	h9i57ETTuHDBBER8Ct0FXsQx35yd1etAhNjuFJdu0X674DQ1+NVC+hDkZ7YKWTfrwlTBph
	p6pxmzDh8939MpBGWyR0UkPGpsuURZiB/MTVuMHyyI0mIr+fcwoo8+1srLd/NA==
Date: Fri, 03 Nov 2023 19:22:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
 <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
 <24c46f25-6b31-437d-9f89-1e8eb74136c8@gmail.com>
Message-ID: <ba144b9b5ee0dd7cb51500fd7c8214e2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-03 12:47, Thomas Guyot wrote:
> On 2023-11-02 10:19, Dragan Simic wrote:
>> On 2023-11-02 14:19, Thomas Guyot wrote:
>>> That's correct, you need both and also -y0
>> 
>> Hmm, I tried the following:
>> 
>>       GIT_PAGER='less -R -F -X -c -y0'
>> 
>> In my environment (Xfce), the result after scrolling the output of 
>> "git
>> log -p" up and down a bit was about 20 copies of the same screen 
>> "page"
>> in the scrollback, plus a couple of blank "pages".  Not good,
>> unfortunately, and actually much worse than having just "-R -F -X".
> 
> Indeed, I did notice it with xfce4-term - I suspect different controls
> are used to clear the screen, with rxvt-unicode the initial one
> scrolls anything in the current display to the scrollback (which is
> important to avoid clearing the last commands/output form the
> scrollback), but afterward screen updates do not update the
> scrollback, it remains within the screen.
> 
> These options may actually affect the behavior (I have put my current
> values there)
> 
>     secondaryScreen: True
>         Turn on/off secondary screen (default enabled).
> 
>     secondaryScroll: True
>         Turn on/off secondary screen scroll (default enabled). If this
>         option is enabled, scrolls on the secondary screen will change 
> the
>         scrollback buffer and, when secondaryScreen is off, switching
>         to/from the secondary screen will instead scroll the screen up.
> 
> So it appears I could disable secondaryScroll to avoid getting
> scrolled lines into the scrollback buffer. It's also noteworthy that
> with secondaryScreen disabled, rxvt-unicode instead scroll things up
> to avoid the current screen form being wiped out.

This is quite interesting.  However, we can't expect that the users 
perform such adjustments to their environments, if you agree.  Tweaking 
one's own environment is fine, but the shipped solution should "just 
work" in most environments, or ideally in all environments in their 
original form.

>>> Indeed, but when less update from the bottom, it can add new lines 
>>> and
>>> let the overflow lines scroll up into the scrollback buffer.
>>> 
>>> Then updating it from the top, it draws the whole page, top to 
>>> bottom.
>>> That's fine for a full page but not desired for a partial one. Also
>>> note that on my terminal (rxvt-unicode) when less clears the screen 
>>> to
>>> draw the first page the current screen is rolled up into scrollback -
>>> iirc that's a configurable option, it would be worth testing other
>>> terminal's behavior on that. IIRC it may also erase it when using the
>>> wrong termcap file.
>>> 
>>> I haven't looked at the code, but I think it could be possibly to
>>> start the -c behavior only after a full page is drawn, after exiting
>>> on partial pages, which would give us the best of both worlds.
>> 
>> Does the GIT_PAGER setup, as I described it above, work for you 
>> without
>> the described artifacts, in any of the environments you have access 
>> to?
> 
> Yes, rxvt-unicode, with the settings mentioned above.

Good to know, thanks.  Looking forward to see will the 
"--redraw-on-quit" option work as expected in your rxvt-unicode 
terminal.

>> One of the solutions is to edit the terminfo entry manually and remove
>> the escape codes that cause the switching to and from alternate 
>> screen,
>> which I tested, but that also introduced another issue -- the screen
>> contents was always present after less(1) exited, which isn't always 
>> the
>> desired behavior.
> 
> But when less scrolls down (line by line, not page by page), it always
> append lines and let them scroll up. Won't you see these?
> (page-by-page otoh will redraw the full screen without scrolling).
> 
> Also won't it wipe the *current* screen so that you won't see the
> commands/output you had *before* running less?
> 
> This is why rxvt-unicode has an option to disable secondary screen,
> and scroll contents all the way to the buffer on switch to/from
> secondary screen.

IIRC, when I tested by removing the escape codes manually from the 
terminfo entry, it all worked fine, but the screen contents always 
remained displayed after less(1) exited.  That isn't always the desired 
behavior.

>>> Actually I just tested my
>>> solution on xfce4-terminal and it doesn't work, the terminal still
>>> push up stuff above on redraw (noteworthy is with rxvt-unicode the
>>> first draw pushes the current screen contents up but no other redraw
>>> does, which is what makes it work so well - I haven't tried to find
>>> out what is being done exactly... OTOH the redraw on scroll down is
>>> slightly noticeable there, while impossible to see on xfce4-terminal.
>>> I'll install the latest less and see what happens with --redraw on
>> 
>> Please test the "--redraw-on-quit" option, so far it's the best
>> available solution, IMHO.
> 
> I will, not now though - need it compile less form source I guess...

Great, thanks.  Looking forward to the results of your testing.  As a 
reminder, this is what I use:

     GIT_PAGER='less -R -F --redraw-on-quit'

My LESS environment variable contains only some coloring-related 
options, which don't matter in this case.

>>> Now, if all other terms misbehave here, that's an issue, making this
>>> suggestion mostly useless. And considering the number of Windows 
>>> users
>>> we absolutely need to test Windows Terminal, and should probably test
>>> MacOS's term too (whatever that is).
>> 
>> Quite frankly, I think that such a solution would be like "fixing the
>> fix, which is actually an abuse", as I described it above, eventually
>> introducing even more issues, instead of solving the original issue.
> 
> I'll let you know my findings... I'm not convinced --redraw-on-quit is
> actually going to fix it for all unless this does a lot more than the
> option name implies (but quite happy if it does).

Actually, it's more about not (ab)using the "-X" option, because 
skipping the terminal initialization may cause various issues.  The 
"--redraw-on-quit" option is there just to have the screen contents 
preserved after less(1) exits.
