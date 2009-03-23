From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Method invokes inefficient Number constructor; use 
	static valueOf instead
Date: Mon, 23 Mar 2009 11:36:50 +0100
Message-ID: <551f769b0903230336v116ce40bn8ce6a1a28b997fd@mail.gmail.com>
References: <49C20D13.2050908@gmail.com> <20090319154958.GP23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhY7-00067l-S6
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbZCWKgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbZCWKgy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:36:54 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:36478 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbZCWKgx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:36:53 -0400
Received: by bwz17 with SMTP id 17so1685659bwz.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oLAxSR88leZhnYR7AU85e8H26hO5x51cwggLGALkV6g=;
        b=PrjkmJ2DZOEuEwFh1aigDjNzeypSBxbmWbEU4gK5F+5VZkpD3NhFtPEjFOxBavQnBU
         NmZS5tBsgyb8ealbn9V3WpJFTiLQ/Rqy5Wil/4Bz0AYkIY29jATgx6eDFpN3eAhxrVG8
         tXpiIA7yoXL9szeFbbXYTATvYwEvcwXPYT9Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bETH64IcXPZ+Q4f7pKp3W/jtp9byCSxY35ULO4XBecvJnZGcohqRImWQPvgZyGgPuo
         b5qlno0F1fRDDQAIjpcmHl5DTtGoeccacxb+xRTmxcbdW86DnTEgd8vAYu02A2mdu2Dl
         yon0+bOFV/igysoib8xRKz5JrfGzapqFE6VtA=
Received: by 10.223.115.12 with SMTP id g12mr5865688faq.92.1237804610461; Mon, 
	23 Mar 2009 03:36:50 -0700 (PDT)
In-Reply-To: <20090319154958.GP23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114278>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> Why I box with new Long() over Long.valueOf():
>
> =C2=A0The standard only requires -128..127 to be cached. =C2=A0A JRE =
can
> =C2=A0cache value outside of this range if it chooses, but long has a
> =C2=A0huge range, its unlikely to cache much beyond this required reg=
ion.
>
> =C2=A0Most pack files are in the 10 MB...100+ MB range. =C2=A0Most ob=
jects
> =C2=A0take more than 100 bytes in a pack, even compressed delta encod=
ed.
> =C2=A0Thus any object after the first is going to have its offset out=
side
> =C2=A0of the cached range.
>
> =C2=A0In other words, why waste the CPU cycles on the "cached range
> =C2=A0bounds check" when I'm always going to fail and allocate. =C2=A0=
I might
> =C2=A0as well just allocate
>
> =C2=A0These sections of code are rather performance critical for the
> =C2=A0indexing phase of a pack receive, on either side of a connectio=
n.
> =C2=A0I need to shave even more instructions out of the critical path=
s,
> =C2=A0as its not fast enough as-is. =C2=A0Using new Long() is quicker=
 than
> =C2=A0using Long.valueOf(), so new Long() it is.

It makes sense.
Thank you for the explanation.

Yann
