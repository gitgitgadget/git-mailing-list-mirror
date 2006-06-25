From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] git --trace: trace command execution
Date: Sun, 25 Jun 2006 14:51:46 +0200
Message-ID: <E1FuU5a-0000u3-Bc@moooo.ath.cx>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx> <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 14:52:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuU5n-0007MB-TQ
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 14:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWFYMvw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFYMvw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 08:51:52 -0400
Received: from moooo.ath.cx ([85.116.203.178]:43239 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751239AbWFYMvw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 08:51:52 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22621>

> Interesting.  Debugging one's alias entries would be helped with
> this I would imagine, and for that you would want something like
> this:
> 
> > Example:
> > % git showtag v1.4.1-rc1 > /dev/null
> > trace: exec: /home/matled/local/stow/git/bin/git-showtag v1.4.1-rc1
> > trace: exec failed: No such file or directory
> * trace: expanded alias "showtag" => "cat-file tag"
That's a good idea, I'll integrate that.

> By the way "git cat-file -p" or "git verify-tag -v" might be
> more pleasant to view a tag since they make the tagger timestamp
> human readable.
Ok, yesterday I was searching for something to see the annotation of a
tag. verify-tag -v looks quite much like that, is there any other way
to read this? Or in general: how do I work with tags? I want to build
a version tagged as v1.2 so currently I'll do
> git checkout -b 1.2 v1.2
and built it. But then I've to type the version number twice (typing
it once is annoying enough :)) and I've to type it once more to get
the tag annotation.

> Might be worth reusing quote.c::sq_quote(), perhaps?
Oh, sure, did not know about this. This would result in a loop of
malloc'ing memory for the buffer. Is this ok? Or should I add a
function like sq_quote which takes a stream and writes to it?

So for the --trace part I think an environment variable GIT_TRACE is
more suitable for this because children inherit this. So running git
status will show what internal commands the shell script uses.
Otherwise I see no way to pass the --trace option down because an
extern program like git-status, git-annotate etc will not accept
parameters which can be passed to `git'.
