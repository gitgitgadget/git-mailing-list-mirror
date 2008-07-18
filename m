From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Addremove equivalent [was: Re: Considering teaching plumbing to users
 harmful]
Date: Fri, 18 Jul 2008 11:55:35 +0200
Message-ID: <48806897.1080404@fastmail.fm>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <7vmykhpn6z.fsf@gitster.siamese.dyndns.org> <20080717155538.GE11759@fieldses.org> <alpine.DEB.1.00.0807171915420.8986@racer> <7vtzeofjpi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807171940160.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmho-0003aA-KU
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbYGRJzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYGRJzx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:55:53 -0400
Received: from main.gmane.org ([80.91.229.2]:57654 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbYGRJzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:55:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJmgk-0005EN-PS
	for git@vger.kernel.org; Fri, 18 Jul 2008 09:55:46 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:55:46 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:55:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0807171940160.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89023>

Johannes Schindelin venit, vidit, dixit 17.07.2008 20:43:
> Hi,
> 
> On Thu, 17 Jul 2008, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> Is there a way to commit the contents of a tarball without using 
>>>> plumbing?  I occasionally want to track an upstream that I know only 
>>>> as a series of tarballs, so I do something like:
>>>>
>>>> 	cd repo/
>>>> 	git checkout upstream
>>>> 	rm -rf *
>>>> 	tar -xzvf ../new-version.tar.gz
>>> How about "git add -u" and "git add ."?
>> It would work only if new version never removes files.
> 
> You made me doubt for a second there.  But "git add -u" updates the index 
> when a tracked files was deleted.  So after "rm -rf *", "git add -u" would 
> empty the index.

This brings me to a question I never dared to ask so far. In fact, I'm 
happy with git-add and using the index explicitly rather than 
implicitly. Still, sometimes I find my self wanting an "addremove", such 
as in a situation like above. (E.g., tracking a dir which is synced by 
different means.)

Say I have a modified file a, removed file b (rm'ed, not git-rm'ed) and 
a new file c. Then:

git add . would add the changes to a and c
git add -u would add the changes to a and (the removal of) b
git commit -a would commit the changes to a and b (it does add -u + commit)

So, if I want to add and commit all three kinds of changes using 
porcelaine I have to do:

git add .
git commit -a

or
git add .
git add -u
git commit

AFAICT this means that git will scan for modifications to tracked files 
which still exist twice. While this will be noticeable only with large 
dirs on slow FS it's conceptually not so nice. Is there any (porc.) way 
around? I don't know the internals, though; maybe there's no second scan 
(stat...).

Cheers
Michael
