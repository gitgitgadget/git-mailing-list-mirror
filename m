From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 11:58:18 +0200
Message-ID: <20081022095818.GA27711@elte.hu>
References: <20081022061730.GA5749@elte.hu> <48FEE5B3.9060202@op5.se> <20081022090010.GC4369@elte.hu> <48FEF868.2010802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 22 11:59:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsaVG-0003bo-2J
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 11:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYJVJ6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 05:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbYJVJ6d
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 05:58:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33266 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbYJVJ6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 05:58:32 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KsaTt-0000Zq-2q
	from <mingo@elte.hu>; Wed, 22 Oct 2008 11:58:30 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 3C5303E21A3; Wed, 22 Oct 2008 11:58:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FEF868.2010802@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98855>


* Andreas Ericsson <ae@op5.se> wrote:

> Ingo Molnar wrote:
>> * Andreas Ericsson <ae@op5.se> wrote:
>>
>>> I imagine you'd want to use it to find out which branches you can (=
or=20
>>> can't) merge, and in that case you need to know about all the topic=
s =20
>>> which have the commit. Assuming you don't go crazy cherry-picking a=
nd=20
>>> criss-cross merging, it should only list a few. The output is not a=
s =20
>>> fancy as below, but it should be faster than the appended script (b=
y =20
>>> several orders of magnitude).
>>
>> i solved that particular problem quite well, based on suggestions in=
 a =20
>> thread earlier on the git-list. I'm using git branch --no-merged:
>>
>>  earth4:~/tip> time todo-merge-all
>>  merging the following updated branches:
>>  merging linus ... ... merge done.
>>
>>  real    0m2.865s
>>  user    0m2.580s
>>  sys     0m0.228s
>>
>> that work step used to be over a minute! There are 233 topic branche=
s=20
>> at the moment and 18 integration branches. Kudos for making this go=20
>> really fast in 1.6.0.
>>
>> the thing i'm after is to see the originator branch of changes. "git=
 =20
>> name-rev" was suggested by Santi B=E9jar in this thread and that is =
=20
>> exactly what i need - i'll try to integrate it into some git-log-ish=
 =20
>> output tool.
>>
>> One thing i noticed is that 'git name-rev' can be quite slow for=20
>> certain commits:
>>
>>  earth4:~/tip> time git name-rev 948f984
>>  948f984 tags/tip-safe-poison-pointers-2008-05-26_08_52_Mon~1
>>
>>  real    0m2.181s
>>  user    0m2.068s
>>  sys     0m0.092s
>>
>> Which seems natural since it might have to dive back into history an=
d =20
>> cross-reference it to all names. (there's 400 branches and 450 tags =
in =20
>> this tree, so i'm certainly pushing things!)
>>
>> But if i use that in my git-log-line summary tool it might become =20
>> quadratic overhead (or worse) very quickly, with minutes of runtime.
>>
>
> What's the timing for "git branch --contains 948f984" ?
>
> "git name-rev" parses a lot more just to be able to print a pretty
> short-name (the reversed "git describe") for you to use.

it takes much longer:

 earth4:~/tip> time git branch --contains 948f984
 [... 44 branches ...]
 real    0m9.596s
 user    0m9.151s
 sys     0m0.218s

	Ingo
