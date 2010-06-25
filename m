From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-cat-file.txt: Document --textconv
Date: Fri, 25 Jun 2010 11:04:10 +0200
Message-ID: <4C24710A.7000506@drmicha.warpmail.net>
References: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net> <vpqmxukir3e.fsf@bauges.imag.fr> <4C2355EF.7030604@drmicha.warpmail.net> <7vocf0chwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 11:05:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS4qK-0001FM-DV
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 11:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab0FYJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 05:04:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35643 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501Ab0FYJEx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 05:04:53 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1B25C105B8B;
	Fri, 25 Jun 2010 05:04:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 25 Jun 2010 05:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AKcpXEVWQz/p6IAMgd4yGnrsqBo=; b=mzjacsoEUNhnUhsK6MWuaXWS2mt+oDmVYrM7K2+HzhfmONFrVyF/++KtQL62YJlndbc6W7IAtQHCDxqOEFwTl0MjkeLFVuErjgqtm1K384akxIzo6X1JRQ0j/cYQtBq1HY561kDGrdF8IS3+1lHWL09y7rvCDWMswMOwMjA3gKU=
X-Sasl-enc: G63Z2uMFS7WaDLaq30+enepKRlkVWjsFaqFFfHyj23uH 1277456692
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DBC284B2620;
	Fri, 25 Jun 2010 05:04:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vocf0chwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149674>

Junio C Hamano venit, vidit, dixit 24.06.2010 22:09:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Wait a minute:
>>
>> git show HEAD:path >a
>> git show :path >b
>> diff a b
>>
>> Oh no! We've been having this all along. This is bad but probably
>> unchangeable.
> 
> There is nothing "bad" about this, unless you forgot about the index.

I'll object to the "unless"...

> The comparision target of "git diff" defaults to the index, not HEAD, if
> you want other precedents.

...but agree here. Do we have a logic/principle which determines whether
"empty ref" means HEAD or INDEX (which doesn't exist, of course)?

> 
> If you kept telling others that "everything defaults to HEAD", it is
> indeed bad, but that can be fixed ;-).

I'll promise to be more careful ;-)

But I still think the situation is unfortunate:

rm -Rf tt && mkdir tt && cd tt && git init
echo a >f && git add f && git commit -m a
echo b >f && git add f && git commit -m b
echo c >f && git add f && echo d >f
for c in "show --oneline f" "show --oneline :f" "diff f"; do
  echo "#git $c"
  git $c
done

produces

#git show --oneline f
3b977dc b
diff --git a/f b/f
index 7898192..6178079 100644
--- a/f
+++ b/f
@@ -1 +1 @@
-a
+b
#git show --oneline :f
c
#git diff f
diff --git i/f w/f
index f2ad6c7..4bcfe98 100644
--- i/f
+++ w/f
@@ -1 +1 @@
-c
+d

[I don't need "f" with "show" or "diff" nor "--oneline" with ":f", of
course.]

I know why it does that, but I think it's confusing that "show :f" does
not show the version of f which is the endpoint of the comparison for
the diff shown by "git show", which is the only parameter to show.

diff is different in that it really has two parameters for the two
points of comparison (which default to INDEX and WORKTREE), and by
giving one you specify the startpoint.

> 
>> I was going with the usage line, but you are right: <a>:<b> makes more
>> sense semantically and is clearer.
>>>
>>> What about this:
>>>
>>> --textconv:: 
>>> 	Show the content as transformed by a textco+nv filter. In this
>>> 	case, <object> has be of the form <treeish>:<path>, or :<path>
>>> 	to run the filter on the file <path> stored in the index.
>>
>> I'll be more mathematically stubborn about "file", see v2;)
> 
> If you want to be mathematically stubborn, then I think you should prefer
> <path> in a context like this, since <treeish>:<path> is the notation to
> reach to a <blob> inside the treeish.  <file> is merely one of the two
> possible manifestations of <blob> when it is accessed through the tree
> that immediately contains it (other being <symlink>).
> 
> Most importantly, "cat-file blob <blob>" codepath has nothing to do with
> that "should this <blob> materialize as a <file> or a <symlink>?" logic,
> so saying <file> is doubly wrong in this context.

Yes. Maybe my remark was ambiguous, but from my v2 you can see what I
meant: not "on the file <path> stored in the index", but "content
recorded in the index at <path>".

Michael
