From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 0/8] Documentation: XSLT/asciidoc.conf cleanup; tty literals
Date: Tue, 24 Mar 2009 03:04:18 -0500
Message-ID: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1ep-0006ZF-Fu
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZCXIEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756522AbZCXIEx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:04:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756631AbZCXIEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:04:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E5A81A4BC6;
	Tue, 24 Mar 2009 04:04:48 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 07C9CA4BC5; Tue, 24 Mar 2009 04:04:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
X-Pobox-Relay-ID: 7221EBC0-184A-11DE-A90F-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114417>

I had a go at wrangling with the documentation generation tools
to fix a couple of issues that I had noticed.

First, I could never get reasonable output for generated
manpages.  I have asciidoc 8.3.1 and docbook-xsl 1.74.0 on my
system. They chew through the documentation OK, but I was never
sure which flags I should use with them.

ASCIIDOC8 never seemed to do much (I was probably not looking in
the right places), but I decided to leave it enabled since it is
entirely outside the scope of the git code/configuration.

The other variable was DOCBOOK_XSL_172, and no matter which way I
turned it, I always got flawed output. If I set it, I would get
funky characters in the callout sections. If I unset it, I would
get ".ft C" and ".ft" bracketing literal blocks.

Second, the inline literal text of both the official and my
generated manpages was indistinguishable from the surrounding
text when viewing manpages in a terminal. It turns out the
official manpages end up with no markup for inline literal
text. The ones I generated did have some markup, but it was
flagged as monospace text, which is not all that distinguishable
from the normal, roman text when viewing through a terminal.

So I set about trying to solve these problems along with the
meta-problem of code duplication between callouts.xsl and
manpage-1.72.xsl.

The following series is my attempt to

  eliminate the XSLT code duplication,

  tease apart the uses of the "1.72" label that apply only to
    docbook-xsl 1.72 and those that also apply to some other
    versions of docbook-xsl,

  unify some of the items that look like they were applied to
    only one side of various "1.72" configurations but still
    seemed applicable to the other,

  fix a mostly unrelated, small, latent bug in asciidoc.conf,

  and provide an option to differentiate inline literal text when
    viewed on a terminal.

  Documentation/Makefile                 |   37 ++++++++++++++++++++++--
  Documentation/asciidoc.conf            |   15 +++++----
  Documentation/callouts.xsl             |   30 --------------------
  Documentation/manpage-1.72.xsl         |   28 ++++++------------
  Documentation/manpage-base.xsl         |   48 ++++++++++++++++++++++++++++++++
  Documentation/manpage-bold-literal.xsl |   17 +++++++++++
  Documentation/manpage-normal.xsl       |   12 ++++++++
  7 files changed, 129 insertions(+), 58 deletions(-)

-- 
Chris
