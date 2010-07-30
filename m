From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [msysGit] git rev-parse broken on Git for Windows
Date: Fri, 30 Jul 2010 08:26:45 -0600
Message-ID: <4C52E125.1020004@workspacewhiz.com>
References: <4C526260.6000104@workspacewhiz.com> <alpine.DEB.1.00.1007301022310.2983@bonsai2> <201007301102.15274.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 16:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeqY2-0003lE-NV
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 16:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202Ab0G3O0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 10:26:49 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:60151 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab0G3O0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 10:26:48 -0400
Received: (qmail 958 invoked by uid 399); 30 Jul 2010 08:26:46 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.154.160)
  by hsmail.qwknetllc.com with ESMTPAM; 30 Jul 2010 08:26:46 -0600
X-Originating-IP: 69.98.154.160
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.7) Gecko/20100713 Lightning/1.0b2 Thunderbird/3.1.1
In-Reply-To: <201007301102.15274.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152243>

  ----- Original Message -----
From: Thomas Rast
Date: 7/30/2010 3:02 AM
> Johannes Schindelin wrote:
>> On Thu, 29 Jul 2010, Joshua Jensen wrote:
>>>   9c7304e3e39ed397b3cc6566573333e2698a52b4 (print the usage string on stdout
>>> instead of stderr) and then 47e9cd28f8a404a0d6293935252ddca5fc243931
>>> (parseopt: wrap rev-parse --parseopt usage for eval consumption) break the
>>> following line from the manual and 'git subtree' on msysGit:
>>>
>>> eval $(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)
>> Both commits are from Junio's 'next' branch. I Cc:ed the authors of both
>> commits.
> Can you elaborate on "break"?
>
> Because as you can see in git-sh-setup.sh, the "official" user of
> parseopt does
>
> 	eval "$(
> 		echo "$OPTIONS_SPEC" |
> 			git rev-parse --parseopt $parseopt_extra -- "$@" ||
> 		echo exit $?
> 	)"
>
> So AFAICS they only differ in the quoting.  And the latter works.
Here is the output from Git Bash:

$ git subtree
C:\Program Files (x86)\Git/libexec/git-core/git-subtree: eval: line 31: 
syntax error near unexpected token `<'
C:\Program Files (x86)\Git/libexec/git-core/git-subtree: eval: line 31: 
`cat <<\EOF usage: git subtree add --prefix=<prefix> <commit
 > or: git subtree merge --prefix=<prefix> <commit> or: git subtree pull 
--prefix=<prefix> <repository> <refspec...> or: git subtree
push --prefix=<prefix> <repository> <refspec...> or: git subtree split 
--prefix=<prefix> <commit...> -h, --help show the help -q qui
et -d show debug messages -P, --prefix ... the name of the subdir to 
split out -m, --message ... use the given message as the commit
  message for the merge commit options for 'split' --annotate ... add a 
prefix to commit message of new commits -b, --branch ... crea
te a new branch from the split subtree --ignore-joins ignore prior 
--rejoin commits --onto ... try connecting new tree to an existin
g one --rejoin merge the new branch back into HEAD options for 'add', 
'merge', 'pull' and 'push' --squash merge subtree changes as a
  single commit EOF exit 129'
Usage: git subtree

The example from the git rev-parse documentation fails in the same way:

eval `echo "$OPTS_SPEC" | git rev-parse --parseopt $parseopt_extra -- 
"$@" || echo exit $?`

What does work is the example you gave with the quotes:

eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt $parseopt_extra -- 
"$@" || echo exit $?)"

I can live with modifying 'git subtree' in this manner, but something 
about one or both of those rev-parse commits cause the non-quoted 
version $(echo...) version in git subtree and the `echo...` version to 
break.

Josh
