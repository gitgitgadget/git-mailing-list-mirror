From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case"
 but not with other regexp-related options?
Date: Fri, 17 Apr 2015 16:26:57 +0200
Message-ID: <55311831.6010004@drmicha.warpmail.net>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 16:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7Ee-0008Ea-6S
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbbDQO1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:27:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58567 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964833AbbDQO07 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 10:26:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id EA76720A7A
	for <git@vger.kernel.org>; Fri, 17 Apr 2015 10:26:58 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 17 Apr 2015 10:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=U6tm7VuhxM6K3Fk0I5jiYojfvT8=; b=MepWy5
	PbOfakULEjWK9h0Xvf10rbSeNsqInBIra3bAXyPbObA76NdTQMlJVO7sTBfIon5O
	pkW+lHqF8nNVVEC+g09F3UTGAAvQZ/Wa5MqGNBLxRfobPtJzvhQ5TmmRClxIiSXk
	dyAAkFph9IhbcJZ8vdhe0cC8oVyYdOpQpljE4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=U6tm7VuhxM6K3Fk
	0I5jiYojfvT8=; b=ElijG+YAtkoRlPgkuMRHks80uffud6FmS4m1xhLlI4AOqg8
	h+EHvvwbYXoitQnfm6QcWxkE9Lx9wSGie95N/F/8HU2pTyqX8SWI59BR3aHNjUq0
	eSjTMBBUbYlUhBL6VHxhaVwih8qpBj6U1WrPjC6TTogDpIo1996sGJ+oJUIs=
X-Sasl-enc: MgEpiD5U0sbahiP5MST6AEfeQhgjpdxU7xG8BvBvovGB 1429280818
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6A69C68013B;
	Fri, 17 Apr 2015 10:26:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267357>

Tim Friske venit, vidit, dixit 17.04.2015 12:00:
> Hi,
> 
> I wonder why  "git log -G<regexp>" works with the "regexp-ignore-case"
> option but not with the other regexp-related options? Wouldn't it be
> useful to make the "G<regex>" option support the following options?
> 
>   * basic-regexp
>   * extended-regexp
>   * fixed-strings
>   * perl-regexp
> 
> Similarly I think it is not very consistent that one cannot combine any of
> the above options with the "S<string>" but instead have yet another option
> called "pickaxe-regex" to toggle between "fixed-string" and
> "extended-regexp" semantics for the argument passed to option "S".

The defaults are different, and it is likely that users want to switch
one without switching the other.

E.g., with -S you often use strings that you'd rather not have to quote
to guard them against the regexp engine.

> The description of the above options in the git-log(1) manpage of Git
> version 2.1 do not explicitly say that they do not support the "G<regex>"
> and "S<string>" option.

They are in different sections, since --grep etc. are log options
pertaining to matching the commit header and log message (commit
object), while S and G match in the diff and are described in the diff
section (although they are commit limitting as well).

> Wouldn't it be nice to have all of the above options collaborate with each
> other?

I'm afraid it's important to keep the different defaults.

Personally, I found it surprising that --regexp-ignore-case applies to
-G at all. It turns out that it was "bolted on" retroactively - it used
to apply to commit object greps only, and was made to switch also diff
grep behaviour later, as a convenience matter. The reason probaly is
that "-S" originally was directed at script usage and turned out to be
used by end users quite a bit.

I'd say most of our inconsistencies are due to convenience...

If you want to work on this, I suggest you introduce the missing long
option names such as "--grep-diff" (-G) and maybe "--grep-log" (--grep)
first and then find consistent and convenient names and defaults for the
regexp options.

Michael
