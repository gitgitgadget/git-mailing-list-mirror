From: "Kyle Moffett" <kyle@moffetthome.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 10:33:46 -0500
Message-ID: <f73f7ab80811200733u46ba63f3h11bf13cc476a5f9f@mail.gmail.com>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
	 <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
	 <20081120112708.GC22787@ravenclaw.codelibre.net>
	 <492560C5.5070308@op5.se> <20081120141533.GC6023@codelibre.net>
	 <49257949.4070308@op5.se> <20081120151925.GE6023@codelibre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Christian MICHON" <christian.michon@gmail.com>,
	git@vger.kernel.org
To: "Roger Leigh" <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BYd-0003Ym-4z
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbYKTPds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbYKTPds
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:33:48 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:61586 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbYKTPdr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:33:47 -0500
Received: by an-out-0708.google.com with SMTP id d40so225343and.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 07:33:46 -0800 (PST)
Received: by 10.100.251.8 with SMTP id y8mr1192617anh.119.1227195226183;
        Thu, 20 Nov 2008 07:33:46 -0800 (PST)
Received: by 10.100.38.13 with HTTP; Thu, 20 Nov 2008 07:33:46 -0800 (PST)
In-Reply-To: <20081120151925.GE6023@codelibre.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101454>

On Thu, Nov 20, 2008 at 10:19 AM, Roger Leigh <rleigh@codelibre.net> wrote:
> And yet the fact that it won't propagate makes it totally useless:
> all the other people using the repo won't get the extra metadata
> that will prevent build failures.  Having the extra data locally
> is nice, but not exactly what I'd call a solution.  The whole point
> of what I want is to have it as an integral part of the repo.

Easiest way is typically something like this in the makefile:

docbook_version = $(shell docbook2man --version 2>/dev/null)
ifneq "$docbook_version",""

mymanpage.1:
        ## Real docbook build rules here

else

mymanpage.1:
        if [ -e $@ ]; then \
                echo "No 'docbook' installed, using pregenerated man
pages" >&2 ; \
        else \
                echo "Pregenerated manpages are missing and no docbook
found!" >&2 ; \
                exit 1 ; \
        fi

endif

Such stuff will take an order of magnitude less time than trying to
patch GIT to preserve metadata that most projects don't want
preserved.  You may also find it's easier to just comment out the
documentation build rules if you are always guaranteeing that the docs
have been compiled.

Cheers,
Kyle Moffett
