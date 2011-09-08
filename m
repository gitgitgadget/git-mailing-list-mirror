From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Thu, 08 Sep 2011 15:17:03 +0200
Message-ID: <4E68C04F.9060804@drmicha.warpmail.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com> <4E6769E3.4070003@drmicha.warpmail.net> <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Kyle Neath <kneath@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 15:17:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1eTh-00046Z-3M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 15:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab1IHNRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 09:17:07 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:56166 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932708Ab1IHNRF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 09:17:05 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B99428FE9;
	Thu,  8 Sep 2011 09:17:05 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 08 Sep 2011 09:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=xTAZISQc6elOECsx1jR5EI
	9qlwA=; b=PC5QXQTZ0Jbcgif/kH6UHR9X2sEPrxc+q+xtLDAlFqLOXKtKuRbYcn
	dgZjg97nH2RGBUVWcPSjmGryN+zP3IGR0FL7mIQ+WQbj8jDOilRH6jscRVDGdS/o
	dzqB/XKt079qzP6cA0OcqqRDG+IPCxO4OJFBZl6ZBqm8qT2O3kzXI=
X-Sasl-enc: QokE6DgWU44LdOuArsd/aKqMcHFz7SCBtVlHnbTLJaaj 1315487824
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6900A78044E;
	Thu,  8 Sep 2011 09:17:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180969>

Kyle Neath venit, vidit, dixit 07.09.2011 22:14:
> Junio C Hamano <gitster@pobox.com> wrote:
>> If this were a new, insignificant, and obscure feature in a piece of
>> software with mere 20k users, it may be OK to release a new version with
>> the feature in an uncooked shape.
> 
> For the sake of my paycheck, I should certainly hope not! I'm not at all
> suggesting we merge what we have in. However, I do think this feature is
> important enough to delay the release. I trust in the judgement of the core
> members to know when something is ready for inclusion in master.
> 
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> So, it's been a year or more that you've been aware of the importance of
>> this issue (from your/github's perspective), and we hear about it now,
>> at the end of the rc phase.
> 
> I apologize if it sounds like that. I've been discussing this situation with
> many people (including Jeff King) for a very long time now, and it was my
> understanding that the credential caching was done and simply waiting for a
> new release. This is the first I've heard that it will not be included in
> 1.7.7, so I'm voicing my opinion now. Admittedly, late in the game - and I
> apologize for that.

OK, I've calmed down :)

> I'd be happy to help in any capacity I can. Unfortunately I'm no C hacker, and
> I've accepted that as a character flaw (it's something I'm working on). I'm
> afraid I can't be of much help with the actual code. What I can provide is an
> alternate viewpoint to the core team. A viewpoint of someone who's spent 3
> years trying to make git easier for newcomers.

It would be interesting to know what we can rely on in the user group
you're thinking about (which I called ssh-challenged). Setting up ssh
keys is too complicated. Can we require a working gpg setup? They do
want to check sigs, don't they?

What I have in mind is a very simple, but secure version of Jeff's
credential-store, respectively his example, somewhat like:

---%<---
STORAGE=$HOME/.credentials

for i in "$@"; do
	case "$i" in
	--unique=*)
		unique=${i#--unique=} ;;
	esac
done

key=$(git config get credential.gpgkey) # or error out

if ! test -e "$STORAGE/$unique"; then
	mkdir -m 0700 "$STORAGE"
	git credential-getpass "$@" | gpg -ear $key >"$STORAGE/$unique"
fi

gpg <"$STORAGE/$unique"
---%<---

Or that in C, probably using Junio's gpg-lib. That would be secure and
useful *if* we can rely on people having a convenient gpg setup
(gpg-agent or such).

So: What credential store/password wallet/etc. can we rely on for this
group? Is gpg fair game?

Michael
