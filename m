From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: bug in git-send-mail (the 'next' branch)
Date: Wed, 19 Mar 2008 09:03:18 +0100
Message-ID: <20080319080318.GX18624@mail-vs.djpig.de>
References: <f36b08ee0803180652g68caa4cci21b0c59020c0fd07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Tw-0001jY-UG
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbYCSTzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760832AbYCSTzk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:55:40 -0400
Received: from pauli.djpig.de ([78.46.38.139]:35318 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756773AbYCSTzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:55:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 8722E90077;
	Wed, 19 Mar 2008 09:03:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ietLx-W1JuMw; Wed, 19 Mar 2008 09:03:20 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id D2FD590075;
	Wed, 19 Mar 2008 09:03:19 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbtGY-0002ZJ-Ff; Wed, 19 Mar 2008 09:03:18 +0100
Content-Disposition: inline
In-Reply-To: <f36b08ee0803180652g68caa4cci21b0c59020c0fd07@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77528>

On Tue, Mar 18, 2008 at 03:52:58PM +0200, Yakov Lerner wrote:
> There is a bug in git-send-mail in the 'next' branch. If first
> paragraph of the file in all indented by 1 space, and 1st line of the
> paragraph is at the first line of the file, then the whole
> paragraph disappears silently. If it's intentional, there should be a warning
> or something. And If it's *not* indented (as if it expects message
> header lines at this place), then it appears in the message body, so
> there is some inconsistency here.

If the first line of the file doesn't match either /^From / or
/^[-A-Za-z]+:\s/ send-email assumes the file is using the legacy format
from the original send_lots_of_email.pl script which is apparently
"first line of the message is who to CC, and second line is the subject of the
message." (comment from source code). The code doesn't use only the
first two lines but eats everything up the first whitespace line.
Which explains the behaviour you have seen.

There are a few things that could be fixed here:
1) Document the file formats this script expects in the man page. It
   doesn't talk about this at all atm.
2) Fix the legacy format support to only use the first two lines and
   warn/die if there is no whitespace line after that
3) Warn if the first line looks neither like a email header nor a
   email address
4) Perhaps in the future at some point deprecate the legacy support
   (1.6.0?)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
