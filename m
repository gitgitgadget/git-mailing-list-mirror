From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 10:15:34 -0700
Message-ID: <20060819171534.GA64962@gaz.sfgoth.com>
References: <1155990772.6591@hammerfest> <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com> <20060819132922.GA6644@code-monkey.de> <e5bfff550608190819i3cade548g28b2c95fab172a49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 19:06:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEUHh-0000jh-OV
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 19:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWHSRGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWHSRGx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 13:06:53 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:10947 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1422717AbWHSRGw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 13:06:52 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id k7JHFYtV065613;
	Sat, 19 Aug 2006 10:15:35 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id k7JHFYxV065612;
	Sat, 19 Aug 2006 10:15:34 -0700 (PDT)
	(envelope-from mitch)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550608190819i3cade548g28b2c95fab172a49@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 19 Aug 2006 10:15:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25729>

Marco Costalba wrote:
> >> >+       if (!user ^ !group)
> >> >+               die("either set both user and group or none of them");
> 
> BTW the following (very ugly) works.
> 
>         if ((int)user ^ (int)group)

No it doesn't.  Besides being a dangerous cast (no guarantee that a pointer
will fit in an "int") your code is basically just a fancy way of saying

	if (user != group)

Which is definitely NOT what is intended.  "user" and "group" are pointers --
unless they're both NULL we expect them to have different values.  The
original code is equivalent to:

	if ((user == NULL) != (group == NULL))

which is what is actually intended.

-Mitch
