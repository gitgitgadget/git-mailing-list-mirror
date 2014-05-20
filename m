From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 14:24:43 -0400
Message-ID: <20140520182443.GA30533@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmoiX-0007kJ-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbaETSYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:24:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:55933 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbaETSYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:24:45 -0400
Received: (qmail 15260 invoked by uid 102); 20 May 2014 18:24:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 May 2014 13:24:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2014 14:24:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249719>

On Tue, May 20, 2014 at 10:53:11AM -0700, Junio C Hamano wrote:

> I actually think these "supress extra LFs" trying to be overly smart
> and inviting unnecessary surprises.  Unlike log messages people type
> (in which we do squash runs of blank lines and other prettifying),
> mail-signature string is not something people keep typing, and it
> would be better to keep it simple and consistent, i.e. we can
> declare that the users who use non-default mail-signature can and
> should learn to:
> 
>     --signature='this is the first line of my long sig
> 
>     with a blank line and then it ends here'
> 
> and be done with it, I think.

If it were just "--signature", I'd agree. After all, nobody is even
complaining. But this is also in preparation for --signature-file.
Should the user create a file without a trailing newline?

We can special-case --signature-file to strip the final newline from the
read file, but it seems friendlier to handle it at the printing stage
(and then we handle the unlikely but possible --signature as above for
free). I don't think it would adversely impact any real-world case,
because somebody would have to:

  1. already be including an extra trailing newline

  2. really _want_ three newlines at the end

> The trailing blank after the mail-signature is a different issue.  I
> think it is safe to remove it and I also think the result may look
> better, but at the same time, it is very close to the "if we were
> writing format-patch today, then we would..." category, I would say.

Yeah. I think it is probably extraneous and would not hurt to remove.
But it may not be worth worrying about (it's really the _two_ lines
caused by the unconditional newline above that bugs me).

-Peff
