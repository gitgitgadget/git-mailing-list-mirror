From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Unresolved issues #3
Date: Sun, 20 Aug 2006 21:05:18 -0700
Message-ID: <44E930FE.3030704@gmail.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>	<44E546F2.7070902@gmail.com>	<Pine.LNX.4.64.0608181041420.11359@localhost.localdomain>	<44E5D522.8030407@gmail.com>	<Pine.LNX.4.64.0608181119410.11359@localhost.localdomain>	<44E68DCD.8010603@gmail.com>	<Pine.LNX.4.64.0608201840310.11359@localhost.localdomain> <7vk653xa3a.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 06:05:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF12T-0004U1-Nq
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 06:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWHUEFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 00:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWHUEFW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 00:05:22 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:26672 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932596AbWHUEFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 00:05:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so2282360pyg
        for <git@vger.kernel.org>; Sun, 20 Aug 2006 21:05:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=g9bZec84Ic7EIdw+euMjplPUCweYr10Mtw6g47hrguGgcfh8/Q6wJbw7b8stx24JCa3gma6Hm7XFoNNsR9zXfmlw0yPmkoSZ9RbfkQnLSN5UATyW7tfvH0mPVZT8UrEVtOGRdKIEtWBKpmdBzC3by0/gk+ywIt+a4e9ZkaMyTao=
Received: by 10.35.135.12 with SMTP id m12mr12331811pyn;
        Sun, 20 Aug 2006 21:05:21 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.234.172.127])
        by mx.gmail.com with ESMTP id c12sm309709nzc.2006.08.20.21.05.19;
        Sun, 20 Aug 2006 21:05:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk653xa3a.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25778>

Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
>> On Fri, 18 Aug 2006, A Large Angry SCM wrote:
>>
>>> Historic fact. Between Thu May 19 08:56:22 2005 and Thu Feb  9 21:06:38
>>> 2006 bit 6 of the first byte of a delta hunk was interpreted to mean
>>> that the source of the copy was the result buffer. From Thu May 19
>>> 08:56:22 2005 on, the code to decode delta hunks in type 2 packs was
>>> available to everyone and anyone interested could make a pack encoder
>>> that would create packs that the core Git code would correctly read. The
>>> commit of Thu Feb  9 21:06:38 2006, d60fc, actually introduced a bug
>>> that would treat valid type 2 packs as invalid.
> 
> It is more like the said commit made the pack format extensible
> by declaring the bit reserved for the future use, by declaring
> retroactively that a type 2 pack that used that bit invalid.
> And it was deemed a reasonable and safe decision because no
> official git ever produced a type 2 pack that used that bit,
> 
> Yes, that was a backward incompatible change, strictly speaking,
> and probably I should have made an announcement that looked
> similar to this by Linus:
> 
>         From: Linus Torvalds <torvalds@osdl.org>
>         Subject: CAREFUL! No more delta object support!
>         Date: Mon, 27 Jun 2005 18:14:40 -0700 (PDT)
>         Message-ID: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
>         To: Git Mailing List <git@vger.kernel.org>
> 
> So you could argue I was incompetent not to make a big fuss
> about this backward incompatibility back then, if you like.
> 
> I did not think it was worth it back then, and I do not think it
> is worth it now, either.  But if it makes you feel better, I
> could retroactively make such an announcement about the
> unofficial bit 6.
> 
> The announcement would have read like this:
> 
>     The current git code does not support type #2 packs that
>     uses delta with bit 6 to mean "copy inside destination
>     buffer".  Although the code that interpreted delta data
>     supported bit 6 that way for a brief period of time, no
>     official git ever released produced delta that used the
>     bit that way.
> 
>     In other words, if you have created packs with your own,
>     modified git, that took advantage of "copy inside
>     destination buffer" feature in the delta interpretation
>     code, such packs are not usable by the official git, so
>     you need to unpack them using your own version of git
>     and then repack with the official version of git.

Please read the commit message for commit d60fc. It's type _3_ pack
files that redefined bit 6 to add the extra byte of copy length, not
type 2. Thus, no need to retroactively invalidate the type 2 pack files
that used copy from result.
