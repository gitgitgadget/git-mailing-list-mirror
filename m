From: Jeff King <peff@peff.net>
Subject: Re: [RFC 2/3] Delete reflogs for dead references to allow pruning
Date: Tue, 21 Aug 2012 04:33:45 -0400
Message-ID: <20120821083345.GB13252@sigill.intra.peff.net>
References: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <1345310086-20089-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Aug 21 10:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3juV-0000KD-B6
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 10:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab2HUId6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 04:33:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43589 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab2HUIds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 04:33:48 -0400
Received: (qmail 29849 invoked by uid 107); 21 Aug 2012 08:34:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Aug 2012 04:34:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2012 04:33:45 -0400
Content-Disposition: inline
In-Reply-To: <1345310086-20089-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203955>

On Sat, Aug 18, 2012 at 07:14:45PM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> This test is broken by "retain reflogs for deleted refs".  Explicitly
> delete the reflogs in the graveyard to allow the corresponding commits
> to be pruned.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> 
> Probably there should be a "git reflog" subcommand to do this.
> 
>  t/t9300-fast-import.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 266ae30..dc6c67d 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -1700,6 +1700,7 @@ INPUT_END
>  
>  test_expect_success 'P: verbatim SHA gitlinks' '
>  	git branch -D sub &&
> +	rm -rf .git/logs/graveyard &&

I think "git reflog expire --expire=now refs/heads/sub" would be less
leaky. That didn't work in my initial version, but it obviously should.
I'll include a tweaked version of your fix when I re-roll.

-Peff
