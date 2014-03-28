From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [BUG] MSVC: error box when interrupting =?utf-8?b?YGdpdA==?= =?utf-8?b?bG9nYA==?= by quitting less
Date: Fri, 28 Mar 2014 09:14:07 +0000 (UTC)
Message-ID: <loom.20140328T101113-154@post.gmane.org>
References: <20130220195147.GA25332@sigill.intra.peff.net> <20130220200136.GH25647@sigill.intra.peff.net> <loom.20140328T093203-852@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 10:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTSsc-0003Fm-1k
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 10:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbaC1JOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 05:14:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:43298 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaC1JOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 05:14:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTSrz-0002qF-OS
	for git@vger.kernel.org; Fri, 28 Mar 2014 10:14:35 +0100
Received: from 185.6.245.138 ([185.6.245.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 10:14:35 +0100
Received: from marat by 185.6.245.138 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 10:14:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 185.6.245.138 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245372>

Marat Radchenko <marat <at> slonopotamus.org> writes:

> 
> Jeff King <peff <at> peff.net> writes:
> 
> > 
> > The write_or_die function will always die on an error,
> > including EPIPE. However, it currently treats EPIPE
> > specially by suppressing any error message, and by exiting
> > with exit code 0.
> 
> This causes error box on Windows in MSVC=1 build:

After deeper investigation it turned out that Windows supports
much less signals [1] than POSIX and "If the argument is not a valid signal 
as specified above, the invalid parameter handler is invoked".

The question is - what is the proper way to fix this?
Patch mingw_raise in compat/mingw.c to map unsupported signals into
supported ones like SIGPIPE -> SIGTERM?

[1]: http://msdn.microsoft.com/en-us/library/dwwzkt4c.aspx
