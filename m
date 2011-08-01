From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 12:06:03 -0600
Message-ID: <20110801180603.GB10636@sigill.intra.peff.net>
References: <4E362F8E.1050105@gmail.com>
 <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
 <4E36B8E4.5080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwsX-0001ji-Jr
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1HASGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:06:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37172
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314Ab1HASGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:06:07 -0400
Received: (qmail 20820 invoked by uid 107); 1 Aug 2011 18:06:39 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 14:06:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 12:06:03 -0600
Content-Disposition: inline
In-Reply-To: <4E36B8E4.5080900@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178371>

On Mon, Aug 01, 2011 at 07:32:04AM -0700, Jon Forrest wrote:

> On 8/1/2011 2:58 AM, Sverre Rabbelier wrote:
> >Heya,
> >
> >On Mon, Aug 1, 2011 at 06:46, Jon Forrest<nobozo@gmail.com>  wrote:
> >>        fprintf(options->file, "%s", line_prefix);
> >>        fprintf(options->file,
> >>-              " %d files changed, %d insertions(+), %d deletions(-)\n",
> >>-              total_files, adds, dels);
> >>+              " %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
> >>+              total_files, total_files == 1 ? "" : "s", adds, adds == 1 ?
> >>"" : "s", dels,
> >>+               dels == 1 ? "" : "s");
> >>  }
> >
> >Also, this is rather detrimental to the i18n effort methinks?
> 
> If the goal if the i18n effort is also to produce grammatically
> correct output in all the supported languages then the
> tests that my patch would break would have to be rewritten
> anyway.

I think he means that auto-pluralization like this cannot be done in an
i18n world, as many languages do not simply add "s". Your patch would
have to use ngettext, something like this (totally untested and just
copying a similar spot in suggest_reattach, as I have never done any
i18n myself):

  fprintf(options->file,
    Q_(" %d file changed,",
       " %d files changed",
       total_files),
    Q_(" %d insertion(+)",
       " %d insertions(+)",
       adds),
    Q_(" %d deletion(-)",
       " %d deletions(-)",
       dels),
    "\n",
    total_files, adds, dels);

And that gives translators a chance to specify the entire singular and
plural versions separately.

-Peff
