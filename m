From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Bad git status performance
Date: Fri, 21 Nov 2008 21:07:16 +0100
Message-ID: <492714F4.1090807@gmx.ch>
References: <4926009E.4040203@gmx.ch> <c9e534200811201711y887ddd2t33013ec4a7db3c9a@mail.gmail.com> <4926ADB8.5000307@gmx.ch> <4926D196.3000301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Glenn Griffin <ggriffin.kernel@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 21:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3cIu-0005XM-GA
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 21:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYKUUHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 15:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753855AbYKUUHV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 15:07:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:58116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753786AbYKUUHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 15:07:20 -0500
Received: (qmail invoked by alias); 21 Nov 2008 20:07:17 -0000
Received: from 74-186.0-85.cust.bluewin.ch (EHLO [192.168.123.204]) [85.0.186.74]
  by mail.gmx.net (mp006) with SMTP; 21 Nov 2008 21:07:17 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+qJkIIGOWqzg7Mu6JlgCYgJL+5/uk80hY+YZiMmJ
	jG8nleAjsxV1E8
User-Agent: Thunderbird 2.0.0.17 (X11/20080928)
In-Reply-To: <4926D196.3000301@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101539>

Michael J Gruber wrote:
> Experimenting further: Using 10 files with 10MB each (rather than 100
> times 1MB) brings down the time by a factor 10 roughly - and so does
> using 100 files with 100k each. Huh? Latter may be expected (10MB
> total), but former (100MB total)?

100 files at each 100k gives me 1.73s, so about 10x speed up.  So
it seems git indeed looks at the content of the files and having a
tenth of the content means it's ten times as fast.

Interestingly, using only a single file of 100MB gives me 0.6s.
Which is still very slow for the job of telling that a 100MB file
is not equal to a 1 byte file.  And certainly there's no renaming
going on with a single file.

> Now it's getting funny: Changing your "echo >" to "echo ">>" (in your
> 100 files 1MB case) makes things "almost fast" again (1.3s).

Same here and that's pretty interesting, because in this situation
I can understand the slow down: Comparing two 1MB files that
differ only at their ends is expected to take some time, as you
have to go through the entire file until you notice they're not
the same.

jlh
