From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 23:59:07 +0100
Message-ID: <200702072359.08043.jnareb@gmail.com>
References: <17866.20355.744025.133326@lisa.zopyra.com> <eqdjt3$jo5$1@sea.gmane.org> <17866.21770.762672.84327@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:59:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvl7-0001lc-Pb
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbXBGW7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbXBGW7V
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:59:21 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:50822 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422815AbXBGW7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:59:20 -0500
Received: by wx-out-0506.google.com with SMTP id h31so323744wxd
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 14:59:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RTAx+urlm6S4c1ODieFB/x9Ccmw57ygHoPDAQCAKEkU65lPQKYt2IMeRoHs3fQunxY5ME291xbbWeZ8uIb8+v0VoYQrkcbO1xg7l5FmZOHOXm2rVppF81not9tF43D/wtQRTM7OZpamVGIrnSRkxAE0oBBVYFyZFXtqgjOkv0t4=
Received: by 10.100.189.17 with SMTP id m17mr3356048anf.1170889159813;
        Wed, 07 Feb 2007 14:59:19 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id o24sm2048878ugd.2007.02.07.14.59.08;
        Wed, 07 Feb 2007 14:59:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <17866.21770.762672.84327@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38992>

Bill Lear wrote:
> On Wednesday, February 7, 2007 at 23:29:56 (+0100) Jakub Narebski writes:
>>...
>> Is history of shell commands too short? Reflogs doesn't help
>> (concatenate all reflogs, perhaps preceding them with file name,
>> and sort by date) either?
> 
> Well, I thought of shell history also, but the problem is, that we often
> have multiple repos on a machine (we may be executing a long-running
> experiment in one, for example, and not want to disturb it).
> 
> Shell history in that case doesn't help.  Also, not having the branch
> information is a minus (each of us puts the current git branch in our
> prompt).

Fact. Although in worst case, if shell history is deep enough, you could
do forensic on it... unless you use multiple shells, freely interspersing
commands in them...
 
> I didn't know about reflogs.  What did you have in mind?  Could you
> show an example, please?

Unfortunately till some time ago reflogs were not enabled by default.
If they are enabled, for each branch you should have 
$GIT_DIR/logs/refs/heads/<branch> file, which contains information about
operations on given branch. It has pre- and post-operation commit ids,
and timestamp of a change, together with short description. You could
concatenate reflogs, and sort them by timestamp.

Reflogs are purely local matter, they represent local view of history.

See git-update-ref(1), "Logging Updates" section, git-repo-config(1)
(or git-config(1)), description of core.logAllRefUpdates variable,
and Git User's Manual.


Examples (sha1 are shortened, and lines are broken for easier reading):

 * .git/logs/refs/heads/origin
 798123... e68989... Jakub Narebski <jnareb@gmail.com> 1170836783 +0100 \
    pull origin git://git.kernel.org/pub/scm/git/git.git: fast-forward
 e68989... 6506e1... Jakub Narebski <jnareb@gmail.com> 1170873620 +0100 \
   fetch origin git://git.kernel.org/pub/scm/git/git.git: fast-forward

 * git/logs/refs/heads/master
 93342d... 39daf6... Jakub Narebski <jnareb@gmail.com> 1169555797 +0100 \
   commit: t/t1300-repo-config.sh: value continued on next line
 39daf6... b62502... Jakub Narebski <jnareb@gmail.com> 1169809125 +0100 \
   commit (merge): Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
 b62502... 7ab704... Jakub Narebski <jnareb@gmail.com> 1170150241 +0100 \
   pull origin: Merge made by recursive.
 7ab704... bb77c5... Jakub Narebski <jnareb@gmail.com> 1170238531 +0100 \
   pull origin: In-index merge

 * git/logs/refs/heads/gitweb/web
 ceae8a... a29878... Jakub Narebski <jnareb@gmail.com> 1169973601 +0100 \
   commit: Git config file reader in Perl (WIP 5)
 a29878... 1b600e... Jakub Narebski <jnareb@gmail.com> 1170034498 +0100 \
   reset --hard 1b600e659abc7e409c9d830e332d3cef010
 62c1c1... 05b936... Jakub Narebski <jnareb@gmail.com> 1170034499 +0100 \
   rebase: Git config file reader in Perl (WIP 1)
-- 
Jakub Narebski
Poland
