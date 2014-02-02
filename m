From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Sun, 2 Feb 2014 18:00:38 -0500
Message-ID: <20140202230038.GB16196@sigill.intra.peff.net>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, dpotapov@gmail.com, tboegi@web.de,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 00:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA61t-0005pY-4L
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 00:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbaBBXAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 18:00:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:43346 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752498AbaBBXAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 18:00:41 -0500
Received: (qmail 31163 invoked by uid 102); 2 Feb 2014 23:00:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 02 Feb 2014 17:00:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Feb 2014 18:00:38 -0500
Content-Disposition: inline
In-Reply-To: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241387>

[+cc Joshua Jensen, who wrote 50906e0]

On Sun, Feb 02, 2014 at 07:13:04AM -0600, Reuben Hawkins wrote:

> fast-import should not use strncmp_icase.

I am not sure of that. My gut feeling is that core.ignorecase is
completely about the _filesystem_, and that git should generally be
case-sensitive internally. But I do not know that everyone agrees. Your
commit is basically a revert of 50906e0 (Support case folding in git
fast-import when core.ignorecase=true, 2010-10-03). And here's some
additional discussion specifically regarding fast-import:

  http://thread.gmane.org/gmane.comp.version-control.git/200597

So I think there is a discussion to be had[1].

> When it does, files with
> similar names, but different case can be lost in the import.  For
> example...
> 
> M 100644 :1 FileName.txt
> D Filename.txt
> 
> ...would end up deleting FileName from the index during the fast-
> import when strncmp_icase is used and core.ignorecase=true.  The
> intent in the above snippet is to rename the file, not delete it.

There may be a separate bug where fast-import needs to be smarter about
ordering operations in such a case (or perhaps fast-export generators
need to be more careful about the order of their output). But it might
be fixable without disabling case-insensitivity entirely.

-Peff

[1] I am mostly trying to connect people on various sides of the
    discussion here. So take my "gut feeling" above with a grain of
    salt, as it does not come from experience nor thinking too hard
    about the issue.
