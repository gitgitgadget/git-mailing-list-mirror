From: Jeff King <peff@peff.net>
Subject: Re: Help a sed noob
Date: Sat, 4 Aug 2007 08:40:05 -0400
Message-ID: <20070804124005.GA15334@sigill.intra.peff.net>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com> <20070804103126.GA28402@lapse.madduck.net> <20070804115003.GA9716@coredump.intra.peff.net> <20070804121811.GA1605@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 14:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHIvU-0000yq-LW
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 14:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598AbXHDMkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbXHDMkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 08:40:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3657 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756598AbXHDMkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 08:40:08 -0400
Received: (qmail 29816 invoked from network); 4 Aug 2007 12:40:12 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Aug 2007 12:40:12 -0000
Received: (qmail 15450 invoked by uid 1000); 4 Aug 2007 12:40:05 -0000
Content-Disposition: inline
In-Reply-To: <20070804121811.GA1605@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54840>

On Sat, Aug 04, 2007 at 02:18:11PM +0200, martin f krafft wrote:

> The behaviour is absolutely unclear from the manpage and defies my
> logic. Can you elaborate a bit, even though this is off-topic?

The original sed code in question was:

                sed -ne '/^URL: */{
                        s///p
                        q
                }' "$GIT_DIR/remotes/$1"

There are a few things to note:
  1. -n means "do not print lines by default"
  2. sed addresses consist of an address (in this case a regex meaning
     "do this for lines that match the regex") and a command
  3. The braces start a set of commands, so that for lines matching the
     address, we do all of the commands.
  4. An empty matching portion for a regex means "use the last regex".

So this script comes down to:
  - don't write any lines except the ones we match
  - find a line that starts with URL:
    - replace the URL: part with nothing
    - print the result
    - quit

It could be more simply written as:

sed -ne 's/^URL: *//pq'

which uses the substitution as an address, but I don't know whether that
was allowed in the original sed.

-Peff
