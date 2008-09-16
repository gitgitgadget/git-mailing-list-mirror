From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Tue, 16 Sep 2008 08:17:14 +0200
Message-ID: <48CF4F6A.6080604@viscovery.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net> <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org> <48CEC3FB.5070101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 08:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfTvx-0000zX-Ej
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 08:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYIPGRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 02:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYIPGRU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 02:17:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41803 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYIPGRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 02:17:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfTsB-0007Q9-9X; Tue, 16 Sep 2008 08:17:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E632D6EF; Tue, 16 Sep 2008 08:17:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48CEC3FB.5070101@drmicha.warpmail.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95975>

Michael J Gruber schrieb:
> I was actually surprised that setup_path() uses argv0_path without
> setting it, same as with argv_exec_path. I assumed this is for a good
> reason, I'm lacking the code base overview to judge this myself.

It argv_exec_path comes from git --exec-path=..., hence, git (via git.c)
is the only caller of setup_path() that is able to set it. We can leave
that one out of the equation.

> In any case, git.c sets argv0_path early, messes a bit with argv[0] and
> calls setup_path afterwards anyways. So adding the path in setup_path()
> should not hurt any "git foo" command.
> 
> One could construe situations where even that wouldn't help, because
> git-upload-pack can't pass --exec-dir to git and they can be in
> different locations - but I think that's crazy.
> 
> git.c, upload-pack.c, receive.pack.c and shell.c are the only callers.
> setup_path() needs to get a parameter. If shell.c should profit from the
> change then it needs to be taught how to pass an absolute path to
> do_{generic,cvs}_cmd().
> 
> So, I guess the general approach (change setup() path and have every
> caller profit) is OK. OK with you?

Have you studied the commit message of e1464ca7bb0d (Record the command
invocation path early) and the context in which this commit occurs? It's
about relocatable git installations and how system_path() derives various
other paths from argv[0].

Please show how you think you could change setup_path(), but keep in mind
that in git.c you neither can do the equivalent of git_set_argv0_path()
later nor setup_path() earlier.

-- Hannes
