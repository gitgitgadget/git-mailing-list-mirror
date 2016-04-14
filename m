From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: weird diff output?
Date: Thu, 14 Apr 2016 06:56:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1604140639230.8340@zino>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com> <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com> <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com> <20160330045554.GA11007@sigill.intra.peff.net> <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com> <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com> <20160331134750.GA29790@sigill.intra.peff.net> <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com> <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jacob Keller <jacob.keller@gmail.com>, davidel@xmailserver.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 16:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqhtB-0006Z1-1n
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbcDNOEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 10:04:52 -0400
Received: from x35.xmailserver.org ([64.71.152.41]:38774 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbcDNOEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 10:04:52 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Apr 2016 10:04:52 EDT
X-AuthUser: davidel@xmailserver.org
Received: from zino
	by x35.xmailserver.org with [XMail 1.27 ESMTP Server]
	id <S48D189> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 14 Apr 2016 09:56:18 -0400
X-X-Sender: davide@zino
In-Reply-To: <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291523>

On Tue, 12 Apr 2016, Stefan Beller wrote:

> On Wed, Apr 6, 2016 at 10:47 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > I started attempting to implement this heuristic within xdiff, but I
> > am at a loss as to how xdiff actually works. I suspect this would go
> > in xdi_change_compact or after it, but I really don't understand how
> > xdiff represents the diffs at all...
> 
> I agree that this seems like the right place.
> 
> On the off chance that David, the author of xdiff remembers that
> part, I cc'd him. (The whole discussion on better diffs is found at
> http://thread.gmane.org/gmane.comp.version-control.git/290093)

That was a zillions of years ago :) , but from a quick look at email 
thread, if you want to do it within xdiff, xdi_change_compact would be the 
place.
The issue is knowing in which situations one diff look better than 
another, and embedding an if-tis-do-tat logic deep into the core diff 
machinery.
In theory one could implement the same thing higher up, working with the 
unified diff text format, where maybe a user can provide its own diff 
post-process hook script.
In any case, that still leaves open the issue on what to shift in the diff 
chunks, and in which cases. Which is likely going to be language/format 
dependent. IMHO, it gets nasty pretty quickly.
