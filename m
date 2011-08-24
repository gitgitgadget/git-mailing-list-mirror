From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Wed, 24 Aug 2011 11:25:07 +0200
Message-ID: <4E54C373.1070702@drmicha.warpmail.net>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com> <7vei0brdiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 11:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw9i1-0002zR-R6
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 11:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab1HXJZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 05:25:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41466 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1HXJZK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 05:25:10 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CA81E20E17;
	Wed, 24 Aug 2011 05:25:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 24 Aug 2011 05:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=GNbk9S32aWGsXxMpJh9Ufw
	7034s=; b=eaXVtvcZC1PU+iQZAlMAH+1Bq1lFAm2vkF32Ug7DMtEMp3DSCK6Wg9
	Nk526HqOQhBR5QY0Ir69LQyAokf01jIm6zyrmXuD3ydB85JtctQGZFzyCqto1dYD
	0drEMB9p24ySaZJVny7HHUeNlKQfcg7azHSNT3Rt+Py2533QIGwwI=
X-Sasl-enc: xUlcfI9iSN7vCMBI6ux9AyiAJj3oZX8oXThZvU4rv5zG 1314177909
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 387559E06FF;
	Wed, 24 Aug 2011 05:25:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vei0brdiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179991>

Junio C Hamano venit, vidit, dixit 24.08.2011 00:03:
> "Nathan W. Panike" <nathan.panike@gmail.com> writes:
> 
>>        1.          If $GIT_DIR/<name> exists, that is what you mean
>> (this is usually useful only for HEAD, FETCH_HEAD, ORIG_HEAD,
>> MERGE_HEAD and CHERRY_PICK_HEAD);
>>        2.          otherwise, refs/<name> if it exists;
>>        3.          otherwise, refs/tags/<refname> if it exists;
>>        4.          otherwise, refs/heads/<name> if it exists;
>>        5.          otherwise, refs/remotes/<name> if it exists;
>>        6.          otherwise, refs/remotes/<name>/HEAD if it exists.
>> ...
>>
>> Is there any way to change this behavior, e.g., so that rule 6 becomes
>> an error?
> 
> You will force people to say "git log origin/master..master" to measure
> their progress if you did so, when "git log origin..master" has been the
> way described in many git books and documentation pages floating on the
> web.

I haven't come across advice like that. In our own documentation, we
don't explain it, and in our user-manual "origin" is used as the name of
a branch.

I consider that advice very bad indeed:

If "origin..master" is resolved to "master ^origin/master", then
obviously "origin..next" is resolved to "next ^origin/next" - but it is
not, of course, and the fact that "origin" is resolved to
"origin/master" depends on the content of "origin/HEAD", which the
upstream repo owner controls (in the sense that upstream's HEAD
determines it), not downstream.

Thus, teaching "origin..master" as a way of measuring your progress is
grossly misleading. "@{u}.." does that when you're on the branch in
question, and we have no notation for "@{u(master)}..master".

Side note:

In fact, who groks symbolic refs anyway? I mean, git-reset sets HEAD and
git-checkout does so, right? ;)
(I'm afraid I need to clean up after myself in git-reset(1)...)

> I think it is _very_ unlikely that such a change is going to happen.

If messing with the origin..master notation is the only fall-out I'm all
for it.

But note that the OP only asked for a way to turn off disambiguation,
not for a change of defaults..

Michael
