From: Christoph Bartoschek <ponto@pontohonk.de>
Subject: Re: Prevent switching branches when local modifications exist
Date: Thu, 14 Jun 2012 09:17:30 +0200
Message-ID: <apfoa9-qkr.ln1@homer.bruehl.pontohonk.de>
References: <h5ina9-g9n.ln1@homer.bruehl.pontohonk.de> <7vfw9yg4z1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 09:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf4JX-0003cG-5k
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 09:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab2FNHRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 03:17:51 -0400
Received: from plane.gmane.org ([80.91.229.3]:54635 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab2FNHRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 03:17:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Sf4JO-0003LW-Gn
	for git@vger.kernel.org; Thu, 14 Jun 2012 09:17:46 +0200
Received: from p3e9bbe88.dip.t-dialin.net ([62.155.190.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 09:17:46 +0200
Received: from ponto by p3e9bbe88.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 09:17:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p3e9bbe88.dip.t-dialin.net
User-Agent: KNode/4.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199973>

Junio C Hamano wrote:

> Christoph Bartoschek <ponto@pontohonk.de> writes:
> 
>> Hi,
>>
>> how can I prevent that git allows me to switch branches when there are
>> uncommited local modifications?
>>
>> [14.1 (steiner_topo)]$ git checkout -b ergo
>> Switched to a new branch 'ergo'
>> [14.1 (ergo)]$ echo blub >> src/invtree.C
>> [14.1 (ergo)]$ git checkout steiner_topo
>> M       src/invtree.C
>> Switched to branch 'steiner_topo'
>> [14.1 (steiner_topo)]$
>>
>> How can the last checkout be prevented?
> 
> The question sounds similar to asking "How can I prevent 'rm -r'
> from removing anything when I type it in my home directory."  It is
> useful for 'rm -r' to remove everything recursively, but sometimes
> you would want to prevent you from running it by mistake in a wrong
> place. In general, there is no good direct solution for that.
> 
> A few usual ways people deal with this kind of issue are (1) to make
> it easier to notice that they are "in a wrong place" (e.g. by having
> the current directory in their prompt to avoid 'rm -r' in $HOME) and
> training themselves to be careful, (2) to make it possible to
> recover if that happens by mistake (e.g. by having .snapshot on the
> filer).
> 
> For "checkout", an approach that corresponds to (1) is to have
> branches and status in the prompt (available from git-completion).
> Fortunately for (2) there isn't anything special necessary, as
> checking out a different branch with "git checkout" does not lose
> information, after creating and checking out the steiner_topo
> branch, you can use checkout again to come back to ergo branch.


So I assume there is no option for this currently.

Git checkout already behaves different from 'rm -r' by preventing me from 
overwritting modified files with changes in the target branch. I just would 
like to expand this to all files. A branch change is only possible if 
everything is clean. (I see that this does not carry over to untracked 
files).

Maybe I have to go with a wrapper for checkout like:

if [[ $(git status --porcelain) =~ "M " ]]; then echo "NO"; exit 0; else git 
checkout "$@"; fi

A little background: We currently evaluate adoption of git instead of svn 
and some users are scared of any code change by a tool. They even do not 
trust any merge at all. Before they run 'svn update' they copy all their 
changes away, carefully merge manually and then go on. 

Thanks
Christoph
