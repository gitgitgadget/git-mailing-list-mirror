From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 18:39:58 +0400
Message-ID: <20131227183958.b8e55d7e3c8c38b46137ea9c@domain007.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
	<vpqwqiqpe80.fsf@anie.imag.fr>
	<CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYaN-0004a1-7E
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3L0OkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:40:15 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:41966 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab3L0OkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:40:13 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rBREdwUo019822;
	Fri, 27 Dec 2013 18:39:59 +0400
In-Reply-To: <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239739>

On Fri, 27 Dec 2013 20:25:16 +0600
Sergey Sharybin <sergey.vfx@gmail.com> wrote:

> Security in this case is about being sure everyone gets exactly the
> same repository as stored on the server, without any modifications to
> the sources cased by MITM.
> 
> As for "smart" http, this seems pretty much cool.However, we're
> currently using lighthttpd, so it might be an issue. We'll check on
> whether "smart" http is used there, and if not guess it wouldn't be a
> big deal to switch to apache.

The web server software has nothing to do with HTTP[S] used by Git being
"smart", I think, it just has to be set up properly.

As discussed in an earlier thread here, a good indication of the
dumb version of the protocol being in use is no display of the
fetching progress on the client while doing `git clone` because this
information (like "compressing objects ..." etc) is sent by the
server-side Git process which is only there if HTTP[S] "was smart".
Otherwise the client just GETs packs of objects, traverses them, GETs
more and so on, so batches of HTTP GET requests correlating to clone
sessions in the web server logs should also be indicative of the
problem.
