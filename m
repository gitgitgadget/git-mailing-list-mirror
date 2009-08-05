From: Jeff King <peff@peff.net>
Subject: Re: Making git push output quieter
Date: Wed, 5 Aug 2009 16:19:37 -0400
Message-ID: <20090805201937.GB9004@coredump.intra.peff.net>
References: <200908042327.10912.aacid@kde.org>
 <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com>
 <200908052113.06373.aacid@kde.org>
 <20090805192658.GI1033@spearce.org>
 <alpine.LFD.2.00.0908051545300.16073@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmxh-0008MQ-UF
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbZHEUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZHEUTm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:19:42 -0400
Received: from peff.net ([208.65.91.99]:54426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbZHEUTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:19:42 -0400
Received: (qmail 12182 invoked by uid 107); 5 Aug 2009 20:21:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 16:21:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 16:19:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908051545300.16073@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124963>

On Wed, Aug 05, 2009 at 03:51:27PM -0400, Nicolas Pitre wrote:

> > -	progress = isatty(2);
> > +	progress = isatty(1);
> 
> Doesn't this break progress reporting on a push since stdout is never a 
> tty in that case?  Same issue on a fetch although in that case the 
> progress level is provided explicitly by the caller.

It also doesn't entirely fix the original poster's problem. There are
actually two outputs: the progress report and the push status. I think
we actually just want a "--quiet" flag here which is passed along to
pack-objects, and which suppresses the push status. Patch series
to follow:

  1/3: push: add --quiet flag
  2/3: transport: pass "quiet" flag to pack-objects
  3/3: transport: don't show push status if --quiet is given

-Peff
