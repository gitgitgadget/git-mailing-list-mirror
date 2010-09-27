From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] repack: add -F option that passes --no-reuse-delta to
 pack-objects
Date: Mon, 27 Sep 2010 07:53:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009270742250.1146@xanadu.home>
References: <20100927133104.25ce5285@jk.gs>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zrKfoCvN7H+wSvof8gjVLQ)"
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 27 13:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0CGf-0003O8-AN
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 13:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012Ab0I0LxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 07:53:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23085 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab0I0LxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 07:53:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L9E00CWWMCG9J20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Sep 2010 07:53:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100927133104.25ce5285@jk.gs>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157325>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_zrKfoCvN7H+wSvof8gjVLQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 27 Sep 2010, Jan Krüger wrote:

> In 479b56ba ('make "repack -f" imply "pack-objects --no-reuse-object"'),
> git repack -f was changed to include recompressing all objects on the
> zlib level on the assumption that if the user wants to spend that much
> time already, some more time won't hurt (and recompressing is useful if
> the user changed the zlib compression level).
> 
> However, "some more time" can be quite long with very big repositories,
> so some users are going to appreciate being able to choose. Hence, this
> adds a new -F option that uses the old behaviour of recalculating deltas
> only and keeping the zlib compression intact.
> 
> Measurements taken using this patch on a current clone of git.git
> indicate a 17% decrease in time being made available to users:
> 
> git repack -Adf  38.79s user 0.56s system 133% cpu 29.394 total
> git repack -AdF  34.84s user 0.56s system 145% cpu 24.388 total
> 
> Signed-off-by: Jan Krüger <jk@jk.gs>
> ---
> 
> The concrete case that prompted me to write this patch was a repository
> of 25 GB that some guys were trying to repack. 17% of the time needed to
> repack -f that much data is... substantial.
> 
> Discussion point: it might make more sense to switch the meanings
> around, making -F do the 'bigger' routine and reverting -f to what it
> used to be. I don't feel strongly about that, however.

That's exactly what I was about to propose before I read through your 
email down to this part.

I personally don't find --no-reuse-object particularly useful.  I hardly 
imagine that people are changing the pack compression level that often 
if at all.  So I doubt moving the current --no-reuse-object behavior to 
-F and reverting -f to  --no-reuse-delta would cause any serious 
inconvenience.  It certainly won't _break_ anything.  So you have my ACK 
to do that change.

In addition to that change, perhaps a note could be added to the 
documentation for pack.compression indicating that for the new setting 
to take effect for existing packs, they must be repacked with -F.


Nicolas

--Boundary_(ID_zrKfoCvN7H+wSvof8gjVLQ)--
