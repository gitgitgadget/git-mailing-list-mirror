From: Jan Hudec <bulb@ucw.cz>
Subject: Re: exit status 141 from git-svn
Date: Tue, 22 Jul 2008 19:52:40 +0200
Message-ID: <20080722175240.GA3561@efreet.light.src>
References: <loom.20080623T145909-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frederik Hohlfeld <frederik.hohlfeld@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 21:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLNqx-00074P-2q
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 21:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYGVTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYGVTr4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 15:47:56 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58010 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbYGVTrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 15:47:53 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 42788573DB;
	Tue, 22 Jul 2008 19:52:46 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 10d3N5m-yafR; Tue, 22 Jul 2008 19:52:43 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 07B18572DB;
	Tue, 22 Jul 2008 19:52:42 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KLM2S-0001KO-8D; Tue, 22 Jul 2008 19:52:40 +0200
Content-Disposition: inline
In-Reply-To: <loom.20080623T145909-992@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89516>

On Mon, Jun 23, 2008 at 15:00:41 +0000, Frederik Hohlfeld wrote:
> Hi

Sorry for late reply. I just noticed your message after returning from
holiday *and* getting time to try to catch up with the list. Hope a reply
might still be useful.

> I have init'ed a git repository with git svn init.
> 
> Now I'm using git svn fetch, but it stops after just a few files/revisions. The
> exit status is 141.
> 
> What does this 141 want to tell me?

Unix trivia: When process dies from a signal, it's return status (as returned
by wait/waitpid(2) is signal_number * 256. However when bourne/POSIX shell
sees this, it will convert it to 128 + signal_number.

Now 141 - 128 = 13 and signal 13 is SIGPIPE. Process gets a SIGPIPE when it's
writing to a pipe (or socket) and it gets closed on the reading end, so it
sounds like a bad redirection somewhere. Aren't you by chance redirecting the
output to less and than quitting that without first scrolling to the bottom?

(That would be the most situation where process gets SIGPIPE -- and the very
reason why SIGPIPE exists, so that simple commands (like cat) are simply
stopped when nobody is interested in their output anymore).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
