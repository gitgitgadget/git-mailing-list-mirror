From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 14:41:55 -0400
Message-ID: <20091030184155.GC19901@coredump.intra.peff.net>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <20091030182331.GC10671@ikki.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Klaus Ethgen <Klaus@Ethgen.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wQM-00044e-Up
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 19:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbZJ3SmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbZJ3Sl7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 14:41:59 -0400
Received: from peff.net ([208.65.91.99]:36537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932795AbZJ3Sl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 14:41:59 -0400
Received: (qmail 2143 invoked by uid 107); 30 Oct 2009 18:45:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 14:45:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 14:41:55 -0400
Content-Disposition: inline
In-Reply-To: <20091030182331.GC10671@ikki.ethgen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131726>

On Fri, Oct 30, 2009 at 07:23:31PM +0100, Klaus Ethgen wrote:

> Well ls-files is used to see such broken files. (Another example is if
> you accidentally add a file which you (later) decide to be ignored. You
> will have no change to find that files at all anymore.) With the patch
> that use case of ls-files has been gone without a replacement.

I think your reasoning is a little bit circular. They are not actually
broken with respect to git. But they might represent an error on the
part of the programmer, and one which they would want to investigate.
You could also catch it by looking at diffs ("why is this file in my
diff, it is supposed to be ignored"), but I am not opposed to accessing
the information via git-ls-files (and I think you are right that the
query cannot be easily done any other way).

> I have two more options:
> 
>    5. Revert the patch and rework it to have a option to ignore or
>       respect the excluded files (Such as --use-excludes for example) or
>       respect them anyway if a --exclude* option is given on command
>       line.

I think that is basically equivalent to (1). There is already a way for
callers to avoid the bug, which is not to provide --exclude* at all. So
you are already setting that one bit of information in whether or not
you provide any excludes.

>    6. Revert the patch and rework it so that it will only have effect if
>       there is no -i option on the command line. (That is similiar to a
>       mix of 3 and 4.)

Yeah, that would actually be the least invasive change, and would keep
"-i" just as it is. If we do anything except a simple, I think your (6)
makes the most sense.

Let me see if I can make a patch.

-Peff
