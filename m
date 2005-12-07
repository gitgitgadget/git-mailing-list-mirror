From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: Failure in t6021 on Red Hat Enterprise Linux 4
Date: Wed, 7 Dec 2005 10:12:24 -0800 (PST)
Message-ID: <20051207181225.67737.qmail@web34304.mail.mud.yahoo.com>
References: <7vfyp4u7rl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 19:15:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek3ma-0003a2-TP
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 19:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbVLGSM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 13:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbVLGSM3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 13:12:29 -0500
Received: from web34304.mail.mud.yahoo.com ([66.163.178.136]:46495 "HELO
	web34304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751650AbVLGSM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 13:12:28 -0500
Received: (qmail 67739 invoked by uid 60001); 7 Dec 2005 18:12:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AW8XFbsvePaCCgUlE43BVC5Pb2AsqrEpplp6S2j8kF9YGZY0muCKUfv598+UaCYNQckNseu+DK0ydUGXoeRFVoNAVSkqJsLjua6DGI6lhlOc4fIdxsHN76JE9kYDt5W8FyOIDSO2hj7Y68OOLgQqt9rSNmVM9vOFUF+f5JhraRM=  ;
Received: from [65.173.207.2] by web34304.mail.mud.yahoo.com via HTTP; Wed, 07 Dec 2005 10:12:24 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyp4u7rl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13335>

--- Junio C Hamano <junkio@cox.net> wrote:
> Are you using git RPM, or building by hand?
> If the latter, "grep -A2 python INSTALL" may be helpful.

Definitely. Thanks for the pointer -- I rebuilt my git installation with the correct
flag, but there's a bootstrapping problem with the test -- and I'm not a good enough
python programmer to fix it very well.

So, basically the problem is that the subprocess.py module is in the compat directory,
and by default (I think) the git-merge-recursive being tested is only looking in
$HOME/git/git.git where it finds and loads gitMergeCommon.py, but gitMergeCommon.py is
not looking in $HOME/git/git.git/compat which is where subprocess.py lives.

So I hacked in to git-merge-recursive this line at the top of the file

sys.path.append('''/home/mallen/git/git.git/compat''')

at the very top and now the test passes.  

So maybe this points out a problem in the Makefile or in the substitution the Makefile is
using to put in @@GIT_PYTHON_PATH@@

I'm not sure I've clearly explained the issue, and like I said, I'm kind of a Python
baby, so I'm not sure what the best way to fix this problem might be.

Thanks,

--Mark
