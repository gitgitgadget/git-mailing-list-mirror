From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 15:58:35 -0500
Message-ID: <866D073C-57B9-457E-80BA-0C87B6D14E23@silverinsanity.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <200811102117.30372.jnareb@gmail.com> <200811102124.59973.fg@one2team.com> <200811102132.05472.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fg@one2team.com>,
	Michal Nazarewicz <mina86@tlen.pl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdsB-0002Ep-5f
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbYKJU6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbYKJU6t
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:58:49 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:56483 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbYKJU6s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 15:58:48 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 70A951FFC17B; Mon, 10 Nov 2008 20:58:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id C92AB1FFC02E;
	Mon, 10 Nov 2008 20:58:31 +0000 (UTC)
In-Reply-To: <200811102132.05472.jnareb@gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100573>


On Nov 10, 2008, at 3:32 PM, Jakub Narebski wrote:

> Dnia poniedzia=C5=82ek 10. listopada 2008 21:24, Francis Galiegue =20
> napisa=C5=82:
>> Le Monday 10 November 2008 21:17:29 Jakub Narebski, vous avez =20
>> =C3=A9crit :
>
>>> Well, _some_ command has to be invoked to expand keywords. "git add=
"
>>> doesn't do that (perhaps it should?), so you need to use checkout.
>>>
>>
>> If "git add" aims to do that, you'd have to be very, VERY careful, =20
>> not to
>> substitute in the wrong place to start with, not to attempt =20
>> substitution in
>> binary files...
>>
>> And this would have a sizeable cost, imho. If you really want to do =
=20
>> this,
>> isn't there a hook somewhere that can do that for you, instead of =20
>> modifying
>> git add directly?
>
> If I remember correctly there was idea to add 'pre-add' or 'post-add'
> hook...

Without adding any additional hooks, you could use the post-commit =20
hook to look for any added/changed files containing $Id$ lines and =20
force a checkout of them.

Perhaps something as simple as the following in your .git/hooks/post-=20
commit (untested, caveat emptor, YMMV):

git diff --name-only --diff-filter=3DAM HEAD^ HEAD | \
while read file; do
   rm "$file" && git checkout -- "$file"
end

~~ Brian