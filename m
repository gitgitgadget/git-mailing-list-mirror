From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Documentation: don't link to example mail addresses
Date: Sat, 15 Dec 2012 18:24:09 +0000
Message-ID: <20121215182408.GD2725@river.lan>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:24:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjwPc-0006PL-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab2LOSYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:24:13 -0500
Received: from woodbine.london.02.net ([87.194.255.145]:57300 "EHLO
	woodbine.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab2LOSYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:24:13 -0500
Received: from river.lan (188.222.177.116) by woodbine.london.02.net (8.5.140)
        id 4FED9DF1046C36C7; Sat, 15 Dec 2012 18:24:09 +0000
Content-Disposition: inline
In-Reply-To: <20121215172018.GA18696@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211553>

On Sat, Dec 15, 2012 at 12:20:18PM -0500, Jeff King wrote:
> On Sat, Dec 15, 2012 at 03:03:15PM +0000, John Keeping wrote:
>> Mail addresses in documentation are converted into mailto: hyperlinks in
>> the HTML output and footnotes in man pages.  This isn't desirable for
>> cases where the address is used as an example and is not valid.
>> 
>> Particularly annoying is the example "jane@laptop.(none)" which appears
>> in git-shortlog(1) as "jane@laptop[1].(none)", with note 1 saying:
>> 
>> 	1. jane@laptop
>> 	   mailto:jane@laptop
> 
> Thanks, this is definitely worth fixing.
> 
>> Fix this by quoting example mail addresses with "$$", preventing
>> Asciidoc from processing them.
>> 
>> In the case of mailmap.txt, render the address monospaced so that it
>> matches the block examples surrounding that paragraph.
> 
> I think I'd just render them monospace everywhere. We are very
> inconsistent about which form of quotes we use in the documentation (I
> think because most of the developers read the source directly and not
> the rendered asciidoc). And then we don't have to worry about the "$$"
> construct (and IMHO it makes the source much more readable, and marking
> the address as a literal looks good in the output, too).

I agree that the source is more readable as monospaced, but I think we
need to keep the quotes around the text in git-tag(1) and probably
git-fast-import(1) so that it is differentiated from the surrounding
text in the man page output.

I just tried this and got strange results.  Taking the example in
git-tag(1):

    ...of the form ``Your Name <your@email.address>''

I tried this to preserve the quotes and make the entire quoted text
monospaced (I don't think we want to have just the email address
monospaced):

    ...of the form ```Your Name <your@email.address>`''

which had the desired effect - smart quotes and everything inside
rendered monospaced - BUT the email address is hyperlinked!

Switching the smart Asciidoc double quotes (``...'') for "normal" double
quotes ("...") produces the desired result, but IMHO doesn't look quite
as good (on the other hand it looks like there are many more use of
"..." than ``...'' in the Git documentation).

[While searching, the only other example I could find is in
git-commit(1) where `A U Thor <author@example.com>` is rendered
monospaced without quotes, but I think this hurts readability in the man
page output - expect a follow-up patch if we resolve this in the
direction of having quotes and monospaced text.]

At this point I've exhausted my Asciidoc knowledge and I'm not entirely
happy with any of these options.  Suggestions?

John
