From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 16:14:13 +0200
Message-ID: <87tzstmqmi.fsf@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	<87r6nxo8iq.fsf_-_@rho.meyering.net>
	<81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
	<87d4zho74h.fsf@rho.meyering.net>
	<81b0412b0706270704y58c9e05bh6ec10118d7ee406c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 16:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3YHi-0002ct-8W
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 16:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbXF0OOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbXF0OOP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 10:14:15 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:40204 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbXF0OOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 10:14:15 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 29D465A19C;
	Wed, 27 Jun 2007 16:14:14 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 8CBD78D56; Wed, 27 Jun 2007 16:14:13 +0200 (CEST)
In-Reply-To: <81b0412b0706270704y58c9e05bh6ec10118d7ee406c@mail.gmail.com> (Alex Riesen's message of "Wed\, 27 Jun 2007 16\:04\:28 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51047>

"Alex Riesen" <raa.lkml@gmail.com> wrote:

> On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
>> "Alex Riesen" <raa.lkml@gmail.com> wrote:
>> > Check if this works in some exotic but common
>> > environments (like MacOSX, Cygwin or HP-UX).
>>
>> What do you mean?
>> I know that dup and fdopen work in those environments.
>
> Exactly as you described?

No, but why does that matter?

> Are you sure fdopen on Cygwin
> sets ENOMEM?

Are you suggesting not to use errno because
it won't contain useful information on Mingw32?

>> It's ok, but for the fact that when dup fails, all you get
>> is the uninformative EINVAL from fdopen.
>
> EBADF on Cygwin, 0 on Mingw32. Can't even imagine what msvc

EBADF is fine.  Setting errno to 0 upon error is a bug.
Don't cater to buggy systems.

> (which actually isn't a developers tool, but very common) will return.
>
>> > (Yes, I do think that "duplicate standard output" is useless,
>> > except for debugging. Exactly as strerror is, but that is shorter).
>>
>> I like to include *something* in the diagnostic so that when someone
>> sees it and reports it developers have an easier time finding where it
>> comes from in the code.  Especially with something as unlikely (and hard
>> to reproduce) as this, that might be useful.
>
> Then put file name and the line number in!

Surely you're playing devil's advocate, now...
If you go that route, you might as well use assert() for both conditions,
and we all know *that* is silly.
