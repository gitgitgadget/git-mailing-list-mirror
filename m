From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: 23 Feb 2006 12:41:44 -0800
Message-ID: <86lkw1g647.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
	<86hd6qgit5.fsf@blue.stonehenge.com>
	<7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
	<863bi9hq6u.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 21:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCNHZ-0005a0-W8
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 21:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWBWUlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 15:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBWUlq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 15:41:46 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:28005 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751304AbWBWUlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 15:41:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id BA82C8F2F5;
	Thu, 23 Feb 2006 12:41:45 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19038-02; Thu, 23 Feb 2006 12:41:44 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id ED8B78F31A; Thu, 23 Feb 2006 12:41:44 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
x-mayan-date: Long count = 12.19.13.1.7; tzolkin = 7 Manik; haab = 5 Kayab
In-Reply-To: <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16666>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Now that our local Perl guru joined the discussion, may I ask what
Johannes> is, and what is not quoted when put inside qx{}?

Nothing is quoted.  Your string acts as if it was XXX in:

        sh -c 'XXX'

so any quoting is entirely on your own.  Thus, without the multi-arg exec in
my proposed replacement, you can get shell-ish interactions that can ruin your
day pretty bad.

Johannes>  I had the
Johannes> impression that all arguments are quoted, except that variables are
Johannes> resolved first. Was that wrong? IOW does

Johannes> 	qx{bash $variable}

Johannes> quote the value of $variable, or not?

The Perl $variable is expanded to its current contents.  But suppose the
contents are `date` (including the backquotes).  That would mean that a shell
would execute a date command, and *its* output would then contribute further
to the command invocation.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
