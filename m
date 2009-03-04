From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial
 branch
Date: Wed, 4 Mar 2009 09:56:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903040953080.8549@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de> <1236040414-19089-1-git-send-email-torarnv@gmail.com> <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-203502791-1236156964=:8549"
Cc: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 09:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lemv3-0007fJ-BI
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 09:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbZCDI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 03:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZCDI4J
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 03:56:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:49387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbZCDI4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 03:56:08 -0500
Received: (qmail invoked by alias); 04 Mar 2009 08:56:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp010) with SMTP; 04 Mar 2009 09:56:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fmxszU1tfA7RtWhWv0WHi1l9u0SXm1zGoZmNyCS
	TjWnFLUFn7mnPx
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112190>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-203502791-1236156964=:8549
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 3 Mar 2009, Junio C Hamano wrote:

> Tor Arne Vestbø <torarnv@gmail.com> writes:
> 
> > +		    if (!prefixcmp(branch, "refs/heads/"))
> > +			branch += offset;
> 
> I suspect that you are trying to protect your code against somebody
> miscounting the length of "refs/heads/" (perhaps when updating this
> codepath in git version 47 that keeps local branches somewhere else, such
> as "refs/local-heads/"), but this "const int offset" does not buy you
> anything.  He will likely to leave "offset" to 11 just the same.
> 
> It is a different story if it were done like this:
> 
> 		static const char heads_prefix[] = "refs/heads/";
>                 if (!prefixcmp(branch, heads_prefix))
>                 	branch += strlen(heads_prefix);
> 
> to let the compiler notice heads_prefix is a constant and optimize the
> strlen() out, but I personally think it is overkill.

Of course you could also do this instead (which I personally think would 
not be overkill):

		branch = skip_prefix(branch, "refs/heads/");

Ciao,
Dscho
--8323329-203502791-1236156964=:8549--
