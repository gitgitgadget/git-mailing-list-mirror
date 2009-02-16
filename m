From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: "add -p" + filenames with UTF-8 multibyte characters = "No changes"
Date: Mon, 16 Feb 2009 07:13:23 +0200
Message-ID: <87ljs7ynf0.fsf@iki.fi>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
	<87tz6vr0g4.fsf@iki.fi>
	<2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
	<87prhjqzwb.fsf@iki.fi>
	<20090216033634.GA12461@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYvp8-0000DS-Df
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 06:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZBPFNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 00:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbZBPFNn
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 00:13:43 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:48502 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZBPFNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 00:13:42 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A880520EC57; Mon, 16 Feb 2009 07:13:36 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LYvnH-0000vW-SC; Mon, 16 Feb 2009 07:13:23 +0200
In-Reply-To: <20090216033634.GA12461@coredump.intra.peff.net> (Jeff King's message of "Sun\, 15 Feb 2009 22\:36\:34 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110139>

On 2009-02-15 22:36 (-0500), Jeff King wrote:

> I am not opposed to setting this as a default, but I think there may
> be some encoding issues to be dealt with. At the very least,
> format-patch generates messages without a content-type header. E.g.,:

> But what is the right encoding to specify? We can guess that it is
> whatever the commit message is in (defaulting to utf-8). It is by no
> means correct, but it would probably work pretty well in practice.

I have a small script which adds/rewrites MIME headers. It defaults to
UTF-8/8bit:

    #!/bin/sh

    charset="${1:-UTF-8}"
    encoding="${2:-8bit}"

    formail -I "MIME-Version: 1.0" \
            -I "Content-Type: text/plain; charset=$charset" \
            -I "Content-Transfer-Encoding: $encoding" \
            -s

I have used the script this way:

    git format-patch --stdout [...] | add-mime-headers | \
        formail -s sh -c 'cat >$FILENO.patch'

It may be difficult and unreliable to try to detect the encoding of file
content so maybe "git format-patch" could be taught an option like
"--charset=<charset>". (And perhaps also a configuration variable.) That
would just write MIME headers (charset) as the user wishes.
