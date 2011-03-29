From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 17:16:52 +0200
Message-ID: <4D91F7E4.1040707@drmicha.warpmail.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net> <201103291439.17197.johan@herland.net> <20110329143357.GA10771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 17:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4aif-0005HP-Rp
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 17:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab1C2PU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 11:20:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38978 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753783Ab1C2PU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 11:20:27 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2C67220C9F;
	Tue, 29 Mar 2011 11:20:27 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 29 Mar 2011 11:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5cwb18w9SvXNTZ27KSwdougiM8M=; b=Xinhnp/XCPQKj46nUMU31XE8y8eZYl/O+85n9tJAhXX+YGrmsTQh8HoddJQT7rouBFj4X8r7TXMmLPrQ4IBQ3Fqkv27tmeeIaCMMdmjbnTE+E97xjdWG/wJeKarMKLuv0xQt5QminaO8hQkwfxCPJOxEP862u1NSaYDpYUgqIs4=
X-Sasl-enc: Dgd+uw3uiLO68dthP56EwgUj8BksiM+DjhOD6/IZMPUD 1301412026
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 718D740513B;
	Tue, 29 Mar 2011 11:20:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110329143357.GA10771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170276>

Jeff King venit, vidit, dixit 29.03.2011 16:33:
> On Tue, Mar 29, 2011 at 02:39:17PM +0200, Johan Herland wrote:
> 
>> On Tuesday 29 March 2011, Michael J Gruber wrote:
>>> As notes become increasingly popular, it's often interesting to show
>>> notes from a particular notes ref only. Introduce '--notes-ref=<ref>'
>>> as a convenience shortcut for '--no-standard-notes
>>> --show-notes=<ref>'.
>>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>> The idea is to use the same name as in "git notes --ref=<ref>" but
>>> make it clear for the rev-list option to be about notes, thus
>>> "--notes-ref=<ref>".
>>
>> The idea and implementation look good to me. Not sure I like the 
>> option "bloat" (somehow feels it should be possible to express the same 
>> behavior using fewer options), but if there's not a better way to 
>> reorganize the options, then you can consider it Acked-by me.
> 
> I feel this would be more consistent with most other options that take
> an optional argument:
> 
>   1. "--show-notes" uses default refs
> 
>   2. "--show-notes=<ref>" shows _just_ <ref>, no defaults
> 
>   3. "--show-notes=<ref1> --show-notes=<ref2>" shows <ref1> and <ref2>
> 
>   4. (Probably) "--show-notes --show-notes=<ref>" should show default
>      refs and <ref>. This is the one I'm least sure of, as it leaves no
>      way to override what came earlier on the command line (which is
>      useful if, for example, we end up with Michael's proposed ui.log).

My "git log" shows notes from ref/notes/commits by default without alias
or config, and that is what I want to override per command (to show
Thomas' notes, e.g.).

>      Perhaps "--no-notes" would reset, so:
> 
>        --show-notes --no-notes --show-notes=<ref>
> 
>      would be equivalent to:
> 
>        --show-notes=<ref>
> 
> Of course a total behavior change of what --show-notes currently does.

I somehow stopped proposing behavior changes. Guess why? (I know I have
my occasional relapse, but still...)

> 
> Speaking of which, it is kind of weird that --show-notes is negated by
> --no-notes. So maybe it makes sense to introduce "--notes[=<ref>]" to do
> what I wrote above, and deprecate --show-notes.

Also, "git notes" has "--ref". Maybe this (which may be what you
proposed above):

--notes: show standard notes
--notes=<ref>: show notes from <ref> only
--notes --notes=<ref>: show standard notes + those from <ref>
(i.e., if any notes argument was given they accumulate; a single
argument does not add to, but replaces the default)
--no-notes: you guess it

One could deprecate --[no-]stand-notes as well, then.

Changing status "PATCH" back to "PATCH/RFC"...

Michael
