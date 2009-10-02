From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
 arguments
Date: Fri, 2 Oct 2009 03:50:12 -0400
Message-ID: <20091002075012.GB27664@coredump.intra.peff.net>
References: <20090925233226.GC14660@spearce.org>
 <20091001201648.GA12175@localhost>
 <20091001202301.GB12175@localhost>
 <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de>
 <20091002074317.GB9444@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtcuK-0003zU-Da
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbZJBHuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbZJBHuR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:50:17 -0400
Received: from peff.net ([208.65.91.99]:39155 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbZJBHuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:50:16 -0400
Received: (qmail 26359 invoked by uid 107); 2 Oct 2009 07:53:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 03:53:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 03:50:12 -0400
Content-Disposition: inline
In-Reply-To: <20091002074317.GB9444@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129426>

On Fri, Oct 02, 2009 at 09:43:17AM +0200, Clemens Buchacher wrote:

> On Thu, Oct 01, 2009 at 11:55:03PM +0200, Johannes Schindelin wrote:
> 
> > And this patch looks even more straight-forward than 1/2, _but_... what 
> > about cases where there are short options that are digits?
> 
> Could you point me to one of those? I did not find any during my
> non-exhaustive search. We should be able to handle them easily by adding
> PARSE_OPT_MANY.

The one that comes readily to mind is "git log -1", but that is actually
parsed by the revision options parser, which doesn't use parseopt. But
there are a few done by parseopt:

  $ git grep "OPT_.*'[0-9]'"
  archive.c:              OPT__COMPR('1', &compression_level, "compress faster", 1),
  archive.c:              OPT__COMPR_HIDDEN('2', &compression_level, 2),
  archive.c:              OPT__COMPR_HIDDEN('3', &compression_level, 3),
  archive.c:              OPT__COMPR_HIDDEN('4', &compression_level, 4),
  archive.c:              OPT__COMPR_HIDDEN('5', &compression_level, 5),
  archive.c:              OPT__COMPR_HIDDEN('6', &compression_level, 6),
  archive.c:              OPT__COMPR_HIDDEN('7', &compression_level, 7),
  archive.c:              OPT__COMPR_HIDDEN('8', &compression_level, 8),
  archive.c:              OPT__COMPR('9', &compression_level, "compress better", 9),
  builtin-checkout.c:             OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
  builtin-checkout.c:             OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",

-Peff
