From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Mon, 8 Oct 2007 20:48:31 +0200
Message-ID: <20071008184831.GB3123@steel.home>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home> <20071007145355.GC10024@artemis.corp> <20071007160707.GA3270@steel.home> <20071007165218.GE10024@artemis.corp> <20071007215041.GB2765@steel.home> <20071008072947.GB22552@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 20:49:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iexeq-0004KE-Ll
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 20:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXJHSsj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbXJHSsj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 14:48:39 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61323 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbXJHSsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 14:48:38 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo51) (RZmta 13.4)
	with ESMTP id a00c37j98GS2zd ; Mon, 8 Oct 2007 20:48:31 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43FB8277AE;
	Mon,  8 Oct 2007 20:48:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 23F6CC502; Mon,  8 Oct 2007 20:48:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071008072947.GB22552@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60331>

Pierre Habouzit, Mon, Oct 08, 2007 09:29:47 +0200:
> On Sun, Oct 07, 2007 at 09:50:41PM +0000, Alex Riesen wrote:
> > Pierre Habouzit, Sun, Oct 07, 2007 18:52:18 +0200:
> > > Though, those are both things that I find ugly to "know" in conve=
rt.c.
> > > How things are allocated in strbufs is one of the few things we d=
on't
> > > want to assume anywhere outside of the strbuf module.
> >
> > src is outside of strbuf scope. It is not internal to struct strbuf=
=2E
> > The caller must already know if it is inside of the given strbuf
> > instance.
> >
> > need_realloc is covered by make_room, isn't it?
>=20
>   Internally yes, but make_room may move the buffer, if that happens,
> there is nothing we can do, in the case where we point inside (or at =
the
> begining of - fwiw it's the same here) the buffer

update the outside pointer you can. But I actually lost all interest:
personally I never use the filters and deeply despise the reasons
caused their existence.

> > I'd suggest just fix the caller, it is simple in convert.c: just us=
e
> > ret, which contains exactly this information. If you insist on edit=
ing
> > in-place, which makes your routines really need the in-placeability
> > informaion. Just give it to them, better explicitely. All of this
> > makes the routines very convert.c specific, which is the reason why=
 I
> > argument to have them just there and nowhere else.
> >=20
> > Alternatively, one can memdup ->buf (as it is the input for next
> > filter) every time a filter modifies it (which is safe, but simple,
> > slow, requires memory, and may fragment heap):
>=20
>   This is exactly what we are trying to avoid with the current form.

I take this suggestion back. Do not use memdup, as it is slow,
requires lots of memory and may fragment heap. Sorry for repeating.

> Given how you try to micro-optimize strbuf_cmp I'm a bit lost here=E2=
=80=A6
>=20

I didn't. It just happened. If I _wanted_ to optimize anything I
wouldn't start with a function which is used exactly one time in a
program with a name like "rerere" which is not even used in default
configuration.
