From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 00:50:30 +0200
Message-ID: <4F7395B6.1020506@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com> <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr> <4F737027.5020503@ira.uka.de> <7vvclotpp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1hY-0007Oq-QW
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043Ab2C1Wun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:50:43 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37996 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932900Ab2C1Wun (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 18:50:43 -0400
Received: from dslb-088-066-020-130.pools.arcor-ip.net ([88.66.20.130] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1SD1hK-0003I9-QZ; Thu, 29 Mar 2012 00:50:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120215 Thunderbird/10.0.2
In-Reply-To: <7vvclotpp7.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1332975040.226066000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194214>

Am 28.03.2012 22:50, schrieb Junio C Hamano:
> I think Matthieu is not thinking about the "resolve conflicted merge (or
> rebase, am) and make a single commit" use case, for which your "pick one
> of the sides" makes sense.  His is more about "I like some change in that
> unrelated commit---while I have no intention to replay that change as a
> whole, I want to use "cherry-pick --no-commit" and pick only the bits out
> of the change that are useful for what I am doing" use case.
>
> In such a context, after resolving conflicts in the working tree, "add -p"
> would be a good tool to pick hunks in the diff between the HEAD and the
> working tree.

Ok. Something like this (which is not really that different from Eriks 
example, so I might still be missing something) ?

git init .
echo "foo" > bar.txt
git add bar.txt
git commit -m.
git checkout -b new
echo "bar" >> bar.txt
git commit -am.
git checkout master
git reset --hard
echo "baz" >> bar.txt
git commit -am.
git cherry-pick --no-commit new
git add -p bar.txt

So he would be interested in keeping his previous working tree version 
(identical to HEAD commit, otherwise cherry-pick fails) for conflicting 
chunks as they (in most cases) don't have anything to do with the chunks 
he is interested in. In this case that is "baz"

Which would always be the "ours" side in any conflicting junks.

That suggests that he could just type '<' respective 'o' whenever a 
conflicting junk comes up as it would be the previous working tree version
