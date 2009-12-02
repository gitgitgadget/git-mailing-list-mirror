From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 07:56:32 +0200
Message-ID: <20091202055632.GD31244@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFiCg-0006aX-PW
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZLBF4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbZLBF4b
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:56:31 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:45595 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZLBF4a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 00:56:30 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 1F4A9EF464;
	Wed,  2 Dec 2009 07:56:36 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A062011AE92; Wed, 02 Dec 2009 07:56:36 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id B9240403C;
	Wed,  2 Dec 2009 07:56:32 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134302>

On Tue, Dec 01, 2009 at 12:42:29PM -0800, Junio C Hamano wrote:
> 
> It is somewhat unfortunate that a few changes I liked (e.g. the "debug"
> bit), even though it was somewhat painful to read them due to coding style
> differences, were not at the beginning of the series but instead buried
> after changes that are much bigger and controversial (e.g. [6/8]).

Funny, I considered some other stuff in series much more controversial than
the 6/8 one.

And 6/8 large? Its smallest (source code files only) or second smallest (all
files) in number of line changes in the series.

If one looks at 6/8, what it basically does is:
- Alias remote-curl as remote-{http,ftp}{,s} since the special case dispatch
  rules are no more (.gitignore + makefile).
- Remove the special case dispatch rules (transport.c).

Taking diffstat of fixed version of 6/8 (I'll send that later as second round,
possibly with additional fixes):

 .gitignore  |    4 ++++
 Makefile    |   19 +++++++++++++++++++
 transport.c |    8 --------
 3 files changed, 23 insertions(+), 8 deletions(-)

And here's what it does to transport.c:

-       } else if (!prefixcmp(url, "http://")
-               || !prefixcmp(url, "https://")
-               || !prefixcmp(url, "ftp://")) {
-               /* These three are just plain special. */
-               transport_helper_init(ret, "curl");
-#ifdef NO_CURL
-               error("git was compiled without libcurl support.");
-#endif

That's 8 lines killed in transport.c, 4 new binary aliases (yeah, I'm not that
good with makefiles plus this seems to be somewhat nasty case).

-Ilari 
