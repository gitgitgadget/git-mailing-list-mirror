From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: make all test files executable
Date: Tue, 6 Oct 2009 06:00:16 -0400
Message-ID: <20091006100016.GA30404@coredump.intra.peff.net>
References: <4ACAA15E.6090403@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Oct 06 12:05:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv6tj-0005Lh-Px
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 12:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbZJFKBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 06:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbZJFKBD
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 06:01:03 -0400
Received: from peff.net ([208.65.91.99]:49453 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857AbZJFKBC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 06:01:02 -0400
Received: (qmail 23992 invoked by uid 107); 6 Oct 2009 10:03:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Oct 2009 06:03:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Oct 2009 06:00:16 -0400
Content-Disposition: inline
In-Reply-To: <4ACAA15E.6090403@mailservices.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129618>

On Mon, Oct 05, 2009 at 09:46:06PM -0400, Mark Rada wrote:

> 	No changes, just a resend. This should work; I assume
> 	the problem last time was a human error (me :(), or
> 	something weird that happens with saving e-mail drafts
> 	between	Apple Mail and Thunderbird (they share).

This version looks fine (though I fixed up and applied the old one, so
it is only useful as an experment). Whatever you did differently worked=
=2E
:)

> 	Jeff, please explain what you meant by `inscrutable
> 	binary'? It is an ASCII text file according to file.
> 	=C2=AF\(=C2=B0_o)/=C2=AF

When I looked at in mutt, it was full of binary garbage. But looking at
it more closely, the attachment is bogus. Look at:

  http://article.gmane.org/gmane.comp.version-control.git/129522/raw

You have a message/rfc822 attachment which claims to be encoded using
base64. But there's a bunch of extra text at the top before the base64
starts, which throws off the decoding, leading to the binary garbage.

So the .eml format appears to be a subset of the headers, followed by
the base64-encoded body. But your mail client, in attaching it, marked
it as base64-encoded, which is just wrong. But in theory that is a
problem in transporting the file to the list. For you to "git am" it
yourself, we'll assume you saw the raw contents.

Even then, it is still a confusing format. Instead of the headers
looking like

  From: whatever

there is a line break, so they appear as

  From:
  whatever

and of course there are no mime headers indicating that body is
base64-encoded. So it is definitely not an rfc822 message, which is wha=
t
"git am" is expecting.

-Peff
