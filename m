From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 13:20:02 +0100
Message-ID: <20130525122002.GI27005@serenity.lan>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <1369405177-7855-2-git-send-email-artagnon@gmail.com>
 <CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
 <CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 14:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgDSN-0006kE-Fe
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 14:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab3EYMUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 08:20:15 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:43199 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab3EYMUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 08:20:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id A08D722BA0;
	Sat, 25 May 2013 13:20:13 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nx84+UVo1E8I; Sat, 25 May 2013 13:20:13 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 68E7F22B4B;
	Sat, 25 May 2013 13:20:04 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225525>

On Sat, May 25, 2013 at 05:20:29PM +0530, Ramkumar Ramachandra wrote:
> Antoine Pelisse wrote:
> > Is it not possible for "color" to be used uninitialized here ?
> 
> My compiler didn't complain; what am I missing?  Doesn't the
> declaration char color[COLOR_MAXLEN]; initialize an empty string?

Why would it?  The variable's begin allocated on the stack and the C
standard only zero-initializes variables with static storage duration;
Section 6.7.9 of the C11 standard says:

    If an object that has automatic storage duration is not initialized
    explicitly, its value is indeterminate.


I suspect the compiler doesn't complain because there is a path through
the function that initializes color before reading it (if we hit the
"if" branch in the loop before the "else" branch) and the compile
assumes that there is something in the function's contract that
guarantees that we follow this path.  But I don't think that's correct
so you do need to initialize color to the empty string.

> More importantly, aren't there numerous instances of this in the
> codebase?

Care to point at one?  I had a quick look and all places I inspected are
either static or write to the array before reading it.
