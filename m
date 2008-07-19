From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Sat, 19 Jul 2008 10:52:19 +0200
Message-ID: <200807191052.20057.johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <1216366485-12201-5-git-send-email-johannes.sixt@telecom.at> <7vej5q67dq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 19 10:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK8Bw-0005sZ-LA
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 10:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYGSIwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 04:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYGSIwZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 04:52:25 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:41420 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYGSIwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 04:52:24 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 1625797323;
	Sat, 19 Jul 2008 10:52:21 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 80CD71D3B4;
	Sat, 19 Jul 2008 10:52:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vej5q67dq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89104>

On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> Sorry, I am not sure if I understand what you are trying to solve.  If you
> have ../libexec/git-core/ in GIT_EXEC_PATH (or have builtin_exec_path()
> use it), then your installation would look like this:
>
> 	[[some random place]]
>         	bin/git
>                 libexec/git-core/git-add
>                 libexec/git-core/git-del
>                 libexec/git-core/git-dir
>                 ...
>
> and if "git" can figure out it is "[[some random place]]/bin/git",
> it can find its subcommands from neighbouring directory, that is still
> inside the random place the user told the installer to use, can't it?

Yes, but...

Take as an example 'git pull'.

- The first call to git will derive the exec-path 
$prefix/bin/../libexec/git-core and prepend it to $PATH.

- Calls to builtin git commands from inside 'git pull' will then derive the 
exec-path $prefix/bin/../libexec/git-core/../libexec/git-core, that is 
$prefix/libexec/libexec/git-core, and prepend it to $PATH as well. That 
directory does not exist - usually - and it does not hurt. But it feels dirty 
and potentially dangerous.

> > This counteracts the aims of the "dash-less" change on Windows, but
> > better this way than having no working git at all.
>
> I'd agree to the extent that anything is better than having no working
> git, but this somewhat feels backwards.

It certainly does.

I'm hoping that the msysgit crew has an opinion on this. CMD users like me do 
not care how cluttered $PATH is because there is no command completion that 
would reveal the 100+ git commands. But msysgit users who are working from a 
bash may want to have them hidden outside $PATH. Or maybe they do not care.

-- Hannes
