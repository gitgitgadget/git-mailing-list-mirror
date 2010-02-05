From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 5/6] receive-pack: Wrap status reports inside
	side-band-64k
Date: Fri, 5 Feb 2010 13:53:44 -0800
Message-ID: <20100205215344.GC27498@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org> <1265403462-20572-6-git-send-email-spearce@spearce.org> <7vd40j1j2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:54:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdW7f-0004ic-EE
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882Ab0BEVxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:53:49 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:61108 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933861Ab0BEVxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:53:48 -0500
Received: by ywh27 with SMTP id 27so3824667ywh.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 13:53:48 -0800 (PST)
Received: by 10.101.213.32 with SMTP id p32mr1373852anq.175.1265406827784;
        Fri, 05 Feb 2010 13:53:47 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm563658ywd.27.2010.02.05.13.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 13:53:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd40j1j2a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139099>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If the client requests the side-band-64k protocol capability we
> > now wrap the status report data inside of packets sent to band #1.
> > This permits us to later send additional progress or informational
> > messages down band #2.
> >
> > If side-band-64k was enabled, we always send a final flush packet
> > to let the client know we are done transmitting.
> 
> Two questions.
> 
>  - Why does use_sideband, the variable with the same name as a boolean
>    variable used by other parts of the system to decide whether we should
>    or should not use the sideband communiocation, get a value other than 0
>    or 1?  What is the benefit of using it to keep an actual value?  Does
>    the benefit outweigh the confusion factor?

I was following the existing convention of use_sideband is
maximum-packet-size in server code, and boolean in client code.

Well, I do diverage a bit in the client, in the client side
use_sideband = 2 in builtin-fetch-pack.c for side-band-64k and
use_sideband = 1 in builtin-send-pack.c for the same thing.
 
>  - What happens if client wants only side-band, not 64k?  This is just
>    theoretical and "we don't bother" is a perfectly acceptable answer.  I
>    am just curious ;-).

Why bother?  What client doesn't understand side-band-64k but would
understand this?

-- 
Shawn.
