From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues with --graph
Date: Mon, 7 Apr 2008 12:01:41 -0700
Message-ID: <20080407190140.GA21025@adamsimpkins.net>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net> <1207555281-9362-1-git-send-email-adam@adamsimpkins.net> <1207555281-9362-2-git-send-email-adam@adamsimpkins.net> <7vod8mqdlw.fsf@gitster.siamese.dyndns.org> <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org> <20080407131728.GA20319@sigill.intra.peff.net> <7vhcedpnma.fsf@gitster.siamese.dyndns.org>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:02:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiwbt-0005pv-4e
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 21:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYDGTBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbYDGTBo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 15:01:44 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:47111 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbYDGTBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 15:01:44 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 67DE11B5C3F;
	Mon,  7 Apr 2008 15:01:43 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 3D6BE1B5C37;
	Mon,  7 Apr 2008 15:01:43 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id EFF5214100BC; Mon,  7 Apr 2008 12:01:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhcedpnma.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78988>

On Mon, Apr 07, 2008 at 10:43:09AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > The main drawback is that dropping the automatic separator breaks
> > existing uses. We could work around this by automatically appending '%n'
> > if there is no use of "%n" or "%N",...
> 
> Yeah, I agree that sounds quite bad, and that is why I favor more explicit
> and independent way to choose between separator and terminator (like the
> "tformat" thing).

How about an extra option to explicitly toggle the separator on or
off?  For example, how about "--sep=<count>"?  Using --sep=0 would put
no separator between entries.  --sep=N would put N separators between
entries.

If this option isn't explicitly specified, the default should be
--sep=0 for ONELINE, and --sep=1 for everything else.  Using --sep=2
with USERFORMAT would achieve the behavior of getting an extra line of
padding between entries.


This still leaves unresolved the fact that the USERFORMAT output ends
with a missing newline in most cases.  I can see the argument for
doing this when using -z, which is primarily aimed for programmatic
consumption.  However, without -z, I don't think this is the behavior
most users expect.  For example, try running
"git --no-pager log -1 --pretty=format:%H".

If we were starting from scratch, and didn't have to worry about
breaking existing behavior, I would say that USERFORMAT should always
terminate entries in a newline, and then default to --sep=0.  As it
is, it might be easiest just to leave the current behavior, without a
terminating newline.

-- 
Adam Simpkins
adam@adamsimpkins.net
