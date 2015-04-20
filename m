From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case"
 but not with other regexp-related options?
Date: Mon, 20 Apr 2015 10:49:11 +0200
Message-ID: <5534BD87.8020709@drmicha.warpmail.net>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app> <55311831.6010004@drmicha.warpmail.net> <CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk7OK-0001sF-Au
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 10:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbbDTItP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 04:49:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54171 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbbDTItO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2015 04:49:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 70CEF208A1
	for <git@vger.kernel.org>; Mon, 20 Apr 2015 04:49:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 20 Apr 2015 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Wl09A3ygvjpLSq1zs8F++PPbJHU=; b=SnEi28
	Plz9p5VjW1U574nw/Ehq3CBGOpONhBTTBmY55p20GvbOWLEwtZLoEfYKKk5NSqa6
	0OpnIxOwaN/KLZwJV5VeTF+VPiV3i3Y9IgTu3YNeozjf45IduroYQpJq8zaXxCQL
	wK6884GHknGtyX9PW1afDh0+5kuUKTUDm6AZ8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Wl09A3ygvjpLSq1
	zs8F++PPbJHU=; b=kg8rQclWQVNhtvxg9yz+eeoRF6WjFpacrgm5qt1kOuGDFFW
	H5FJBXtM5dqjH4pH7Z8pD2cEDtXC4d8+NSQsEapCkhW85lodVfgir4a3eER/tZyj
	yRIcDYbdiR3pUu8oP9emAOdThn19Ur9cLzK5t3UzKp6m/SepGKbmULCWwEjA=
X-Sasl-enc: 3aVRrchzKhRK9K/QWjeK6mgvzrEpERRFIKYdyd6QES5a 1429519753
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D05B3C00015;
	Mon, 20 Apr 2015 04:49:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267458>

Junio C Hamano venit, vidit, dixit 17.04.2015 19:45:
> On Fri, Apr 17, 2015 at 7:26 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>>
>>> Similarly I think it is not very consistent that one cannot combine any of
>>> the above options with the "S<string>" but instead have yet another option
>>> called "pickaxe-regex" to toggle between "fixed-string" and
>>> "extended-regexp" semantics for the argument passed to option "S".
>>
>> The defaults are different, and it is likely that users want to switch
>> one without switching the other.
>>
>> E.g., with -S you often use strings that you'd rather not have to quote
>> to guard them against the regexp engine.
> 
> But the hypothetical -G that would look for a fixed string would be
> vastly different from -S, wouldn't it?
> 
> The -S<string> option was invented to find a commit where one side
> of the comparison has that string in the blob and the other side
> does not; it shows commits where <string> appears different number
> of times in the before- and the after- blobs, because doing so does
> not hurt its primary use case to find commits where one side has one
> instance of <string> and the other side has zero.
> 
> But -G<regexp> shows commits whose "git show $that_commit" output
> would have lines matching <regexp> as added or deleted.  So you get
> different results from this history:
> 
>     (before)    (after)
>     a           b
>     b           a
>     c           c
> 
> As "git show" for such a commit looks like this:
> 
> diff --git a/one b/one
> index de98044..0c81c28 100644
> --- a/one
> +++ b/one
> @@ -1,3 +1,3 @@
> -a
>  b
> +a
>  c
> 
> "git log -Ga" would say it is a match.  But from "git log -Sa"'s
> point of view, it is not a match; both sides have the same number of
> 'a' [*1*].
> 
> I think it would make sense to teach --fixed-strings or whatever
> option to -G just like it pays attention to ignore-case, but "-G
> --fixed-strings" cannot be "-S".  They have different semantics.

Of course they cannot, that's not what I meant. They have different
semantics, and *therefore* they have different defaults, and *therefore*
a user may want to switch one of them (or --grep or --author or...) to
--fixed--strings and keep the other to --regexp.

One idea would be to make

--regexp -S --fixed-strings -G

work the obvious way (match option affects following grep options), but
we have position independent options for most commands. Alternatively,
we could distinguish at least between two groups of greppish operations
and let them have independent modifying arguments and defaults:

- commit header/object (--grep, --grep-reflog, --author, ...)
- diff (-S, -G)

But that would require some changes to current behavior.

> [Footnote]
> 
> *1* This is because -S was envisioned as (and its behaviour has been
>     maintained as such) a building block for Porcelain that does
>     more than "git blame".  You feed a _unique_ block of lines taken
>     from the current contents as the <string> to quickly find the
>     last commit that touched that area, and iteratively dig deeper.
>     The -S option was meant to be used for that single step of
>     digging, as a part of much more grand vision in $gmane/217,
>     which I would still consider one of the most important messages
>     on the mailing list, posted 10 years ago ;-)
> 
> 
> 
> [jc: My mail provider seem to be queuing but not sending out SMTP
> outgoing traffic, so I am trying to (re)send this in an alternate route.
> If you got a duplicate of this message, my apologies.]
> 
