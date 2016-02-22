From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v2 3/6] clean: read user input with strbuf_getline()
Date: Mon, 22 Feb 2016 08:40:59 +0100
Message-ID: <56CABB8B.2070502@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de> <56CA6264.1040400@moritzneeb.de>
 <CAPig+cSi-4R-a=HVmpCWAZ3kr=yQtJ9GdT-JZ4hJ2kmqg-edVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:41:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXl7G-00069t-3d
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 08:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbcBVHlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 02:41:04 -0500
Received: from moritzneeb.de ([78.47.1.106]:55960 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbcBVHlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 02:41:01 -0500
Received: from [192.168.1.3] (x4db34e7f.dyn.telefonica.de [77.179.78.127])
	by moritzneeb.de (Postfix) with ESMTPSA id BA2841C090;
	Mon, 22 Feb 2016 08:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456126859;
	bh=OS+zKrf42Fah/Nrmxl6xiz5x5rbD+gBxigVAqUI/i0s=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=qSPshoxx9EU7TMtc+Pbuw1egDFtDnGJTg89VY8tizlaNdrvKggmYG4xPe+z4nn22a
	 4IBBgNfXqLqUyT89W6Ce8HrQmaTGd8WEpV8zMs8mmpaCsby46iMnLwxde967uzZeh5
	 qapLL6OW0jr7BvvwWTPi9d189eBDzMatAbzfFKhw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cSi-4R-a=HVmpCWAZ3kr=yQtJ9GdT-JZ4hJ2kmqg-edVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286889>

On 02/22/2016 03:27 AM, Eric Sunshine wrote:
> On Sun, Feb 21, 2016 at 8:20 PM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> The inputs that are read are all answers that are given by the user
>> when interacting with git on the commandline. As these answers are
>> not supposed to contain a meaningful CR it is safe to
>> replace strbuf_getline_lf() can be replaced by strbuf_getline().
>>
>> Before the user input was trimmed to remove the CR. This would be now
>> redundant. Another effect of the trimming was that some (accidentally)
>> typed spaces were filtered. But here we want to be consistent with similar UIs
>> like interactive adding, which only accepts space-less input.
> 
> I don't at all insist upon it, but this behavior change feels somewhat
> like it ought to be in its own commit.

You're right, two commits would be nicer. I was also thinking about
splitting up the three codepaths, but I decided all of the
clean-interaction belongs together.

> I'm also not convinced that
> making this consistent with the less forgiving behavior of
> "interactive adding" is desirable (rather the reverse: that that case
> should be more flexible). However, I wasn't following the discussion
> with Junio closely, and perhaps missed you two agreeing that this is
> preferable.

To summarize the discussion with Junio: We were not directly talking
about that. Two aspects from the whole discussion were that I should
decide something and justify a stance (which I did) and that it's also
beneficial to think aloud (which I forgot).

In fact, I was surprised, that interactive adding is that strict. I
should've added that to the discussion. I am at the moment sometimes
unsure whether I find things weird because git standards are different
than what I'd expect or because things really should be changed. So I
went for the former and decided to go for consistency with the base. I'd
expect, from my own behaviour, interactive adding is used by far more
than interactive cleaning, which might be an argument to adapt the latter.

But now that we're discussing this, I don't really see a benefit from
the user perspective, it's more code cleanup.
