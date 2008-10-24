From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 18:56:05 -0400
Message-ID: <20081024225605.GA16774@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <7v3ail3dfy.fsf@gitster.siamese.dyndns.org> <20081024225001.GA13978@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:57:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVau-00042z-Ln
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYJXW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYJXW4K
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:56:10 -0400
Received: from peff.net ([208.65.91.99]:2576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbYJXW4J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:56:09 -0400
Received: (qmail 25072 invoked by uid 111); 24 Oct 2008 22:56:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 18:56:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 18:56:05 -0400
Content-Disposition: inline
In-Reply-To: <20081024225001.GA13978@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99080>

On Fri, Oct 24, 2008 at 06:50:01PM -0400, Jeff King wrote:

>     However, I'm not sure exactly _where_ we would want to do this.
>     The obvious places are for patch, for diffstat, or for whitespace
>     checking. But all of those places use mmfile, so we can munge them
>     in the same way. I haven't looked at using this with blame, but I do
>     think "git blame --textconv foo.jpg" would be useful.
> 
>     (Actually not true. I did just look for 30 seconds at using this
>      with blame, but blame doesn't seem to to use builtin_diff at all).

Ah, I see. It looks like we would have to munge fill_blob_sha1 in
builtin-blame.c. In which case totally splitting this out from
diff_filespec is even better, since we don't have one there.

So let me try to re-roll my series based on your suggestion, and then
I'll see if I can add "blame --textconv" on top.

-Peff
