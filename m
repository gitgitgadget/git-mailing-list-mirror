From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diesys calls die and also reports strerror(errno)
Date: Thu, 04 Jun 2009 14:13:03 -0700
Message-ID: <7v3aafwvmo.fsf@alter.siamese.dyndns.org>
References: <20090603015503.GA14166@coredump.intra.peff.net>
	<1244081105-7149-1-git-send-email-aspotashev@gmail.com>
	<20090604205055.GB17478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKFT-0006sl-J8
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbZFDVNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZFDVNE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:13:04 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64872 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbZFDVND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:13:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090604211304.HXZY17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jun 2009 17:13:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id zxD31b00F4aMwMQ04xD3fv; Thu, 04 Jun 2009 17:13:04 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=k8_L9D1VAZ4A:10 a=H2s_CUdDsewA:10
 a=PKzvZo6CAAAA:8 a=Q4Vb_e3Jk-2zjC52jEsA:9 a=-nCWYjEnQA1i_Da5EZI8nGbpJM8A:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090604205055.GB17478@sigill.intra.peff.net> (Jeff King's message of "Thu\, 4 Jun 2009 16\:50\:55 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120712>

Jeff King <peff@peff.net> writes:

> Should we be calling malloc here? One of the possible error conditions
> is that we're out of memory (though xmalloc itself just uses "die"). I
> don't think there is a good reason not to use a reasonably-sized static
> buffer, which should increase robustness (report() is already using a
> 1024-character buffer, so any message would be truncated there anyway).

Yup, and at that point, tacking strerror value while expanding possible %
becomes even easier.
