From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 09:52:50 +0200
Message-ID: <48D8A052.6000101@viscovery.net>
References: <20080922155749.c8070681.stephen@exigencecorp.com>	<20080922231927.ef18f420.stephen@exigencecorp.com>	<48D88813.9060400@viscovery.net> <2008-09-23-09-30-47+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2ik-0002Od-JF
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 09:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYIWHw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 03:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYIWHw6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 03:52:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47459 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYIWHw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 03:52:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ki2hX-0003gr-1N; Tue, 23 Sep 2008 09:52:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B768EAFCC; Tue, 23 Sep 2008 09:52:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <2008-09-23-09-30-47+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96533>

Samuel Tardieu schrieb:
>>>>>> "Johannes" == Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> Johannes> i.e. linearized history without merges.
> 
> A few days ago, I had a question in my team quite similar to Stephen
> concern. A developer had performed a merge of a complex feature and
> was ready to commit it
> 
>   --o--o--o--o--X        <-- origin
>      \           \
>       A--B--C--D--E      <-- master
> 
> when he realized that someone just pushed another change on origin
> while he was doing the complicating merge (with lots of conflicts to
> resolve). The configuration was then:
> 
>   --o--o--o--o--X--Y     <-- origin
>      \           \
>       A--B--C--D--E      <-- master
> 
> He would have wanted to have the merge rebased on E and Y instead of E
> and X before pushing, without going through all the conflicts
> resolution again (he didn't have "rerere" enabled).

If you mean "merge", and you are willing to keep E, then you do another
merge to get this history:

  --o--o--o--o--X--Y     <-- origin
     \           \  \
      A--B--C--D--E--F   <-- master

and the previous conflicts will not show up again. But if you do not want
E to show up in the history, like this:

  --o--o--o--o--X--Y     <-- origin
     \              \
      A--B--C--D-----F   <-- master

then you will have to resolve all conflicts again. Of course, you can keep
 E in a temporary branch, and you can selectively check out files from
that tree to safe some work, but whether this is possible depends on the
changes that Y introduces.

If you mean "rebase", then you get this after the first rebase:

  --o--o--o--o--X--Y               <-- origin
                 \
                  A'--B'--C'--D'   <-- master

Then you can rebase again to get this:

  --o--o--o--o--X--Y                  <-- origin
                    \
                     A"--B"--C"--D'   <-- master

at which time you don't see the old conflicts again.

-- Hannes
