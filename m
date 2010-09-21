From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 13:49:17 +0200
Message-ID: <4C989BBD.80106@drmicha.warpmail.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com> <4C987C2E.3060001@drmicha.warpmail.net> <4C98830A.70203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 13:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy1Ld-0002Ap-3a
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 13:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797Ab0IULtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 07:49:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41667 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796Ab0IULtL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 07:49:11 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 36BAB5EA;
	Tue, 21 Sep 2010 07:49:10 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 21 Sep 2010 07:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ymOhZfbzSXQMwcy0Lpkn9SZv/go=; b=ZvPv4ew58abTbQq0JbTcx4Qx/z/udpz22JHoo+NCx1VUoThn2Y64T9FqBaM7rjWmmB2SVZtixfs6N0vEUqPQP9vhROqr5AYkHWQroY5vT/FHr39p3coiFXIaqfF/2wuq2KrBzNEI0dtyLv2RkSq5dpaJTChJpbwe6FsYZEAKNuE=
X-Sasl-enc: MD1V2rrETfHEhtoaoC2yKbq7wN5h7XUnodeXn+vqTBgD 1285069749
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 75762407E17;
	Tue, 21 Sep 2010 07:49:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <4C98830A.70203@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156714>

Johannes Sixt venit, vidit, dixit 21.09.2010 12:03:
> Am 9/21/2010 11:34, schrieb Michael J Gruber:
>> The earlier tag (in terms of depth) wins, yes.
> 
> Does it? Then explain this result:
> 
> git describe e5498e8a^2 e5498e8a^1~24 e5498e8a
> v1.7.0.7
> v1.7.1.1
> v1.7.1.1-38-ge5498e8
> 
> v1.7.1.1 is 25 commits away, while v1.7.0.7 is a parent (the second).
> 
> AFAICS, git-describe does The Right Thing (--first-parent).

I'm not saying it does the wrong thing. I'm saying it does not do
--first-parent but depth priority (where depth is a bit complicated),
which may or may not be the same as first-parent transversal/priority.
You picked one case where they coincide:

git describe --debug e5498e8a^2 e5498e8a^2~24 e5498e8a
v1.7.0.7
v1.7.0.5
searching to describe e5498e8a
 annotated         38 v1.7.1.1
 annotated        252 v1.7.1
 annotated        268 v1.7.1-rc2
 annotated        318 v1.7.1-rc1
 annotated        355 v1.7.1-rc0
 annotated        478 v1.7.0.7
 annotated        492 v1.7.0.6
 annotated        512 v1.7.0.5
 annotated        539 v1.7.0.4
 annotated        564 v1.7.0.3
traversed 1267 commits
more than 10 tags found; listed 10 most recent
gave up search at 97222d9634b5518cd3d328aa86b52746a16334a7
v1.7.1.1-38-ge5498e8

v1.7.1.1 clearly wins by depth priority.


In an example like Joshua's, it is obviously not the first parent which
wins by default:

* 771c6c7 (HEAD, master) more_development
*   88b63bd Merge branch 'maint'
|\
| * d99fb44 (tag: v1.1-stable, maint) v1.1-stable
* | c2f7480 development
* | 9480bca (tag: v2.0-base) v2.0-base
|/
* 31e78ef (tag: v1.0-stable) v1.0-stable

git describe --debug --tags  HEAD
searching to describe HEAD
 lightweight        4 v1.1-stable
 lightweight        4 v2.0-base
 lightweight        5 v1.0-stable
traversed 6 commits
v1.1-stable-4-g771c6c7

git describe --debug --tags --match v2\* HEAD
searching to describe HEAD
 lightweight        4 v2.0-base
traversed 6 commits
v2.0-base-4-g771c6c7

git describe --debug --tags --first-parent HEAD
searching to describe HEAD
 lightweight        3 v2.0-base
 lightweight        4 v1.0-stable
traversed 5 commits
v2.0-base-3-g771c6c7

The latter is with my RFC PATCH, of course.

Note that without the commit "development", v2.0-base wins even in the
first case, even though this does not change the first-parent relationships.

Cheers
Michael
