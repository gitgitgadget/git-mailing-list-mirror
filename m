From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] find_pack_entry(): do not keep packed_git pointer locally
Date: Mon, 30 Jan 2012 23:19:54 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201302301150.2759@xanadu.home>
References: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
 <7v62fsai1i.fsf@alter.siamese.dyndns.org>
 <CACsJy8AS0nZOoXZZfz0OEwoWe88wp2aGR5NGqpG7xQmUvwi7TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_1aBQFGQnPqLsu/Tc3vfhmg)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 05:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs5Cq-0007Tl-5V
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 05:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2AaET4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 23:19:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40130 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab2AaETz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 23:19:55 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYN00LMPAIBEG70@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 Jan 2012 23:15:47 -0500 (EST)
In-reply-to: <CACsJy8AS0nZOoXZZfz0OEwoWe88wp2aGR5NGqpG7xQmUvwi7TA@mail.gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189442>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_1aBQFGQnPqLsu/Tc3vfhmg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 31 Jan 2012, Nguyen Thai Ngoc Duy wrote:

> (Pulling Nico in for Q2 below. No snipping so he has a context)
> 
> 2012/1/31 Junio C Hamano <gitster@pobox.com>:
> > Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> >
> >> Commit f7c22cc (always start looking up objects in the last used pack
> >> first - 2007-05-30) introduces a static packed_git* pointer as an
> >> optimization.  The kept pointer however may become invalid if
> >> free_pack_by_name() happens to free that particular pack.

Hmmm, good point.

> >> Current code base does not access packs after calling
> >> free_pack_by_name() so it should not be a problem. Anyway, move the
> >> pointer out so that free_pack_by_name() can reset it to avoid running
> >> into troubles in future.
> >>
> >> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> >> ---
[...]
> >  - Could we make the magic (void *)1 value a #define'd constant? Perhaps
> >   we could even use NULL for that purpose?
> 
> Q1. Sure.

Indeed.  The idea might have been to use a non null value that cannot 
match any pointer...

> Q2. No NULL is probably not suitable. I think Nico wanted to express
> "we tried to find but found none (i.e. NULL)" too and 1 means "no we
> have not tried".

Well, I could imagine I might have thought about something like that.  
However, looking at the latest code in the master branch I can't see 
any way for last_found to ever be assigned a NULL value.  So if the
(void*)1 value might have been useful, it is certainly not anymore.


Nicolas

--Boundary_(ID_1aBQFGQnPqLsu/Tc3vfhmg)--
