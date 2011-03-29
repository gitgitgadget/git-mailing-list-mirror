From: Michael J Gruber <drmicha@warpmail.net>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 20:36:36 +0200
Message-ID: <4D9226B4.20806@warpmail.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net> <7vbp0tss6t.fsf@alter.siamese.dyndns.org> <7v7hbhss0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dvx-00083s-Ui
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1C2SqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:46:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34617 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab1C2SqY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 14:46:24 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Mar 2011 14:46:24 EDT
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B7EC320444;
	Tue, 29 Mar 2011 14:36:33 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 29 Mar 2011 14:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mA9GNB665dEIL7V1QPTN0W/W6g0=; b=G+BBpgzRDKE0JTpFHlt5t3UpPRazV07I3KzLZsq3pe+IJqsJiTMbFasagskdO6V0veYYTFN1dEFMxe+whlUDv30epzQQ9B8vAGFfVFdIMr70tZt7RExGKVSaHf7uWaAgS8FRsMQzIGOzbdJT4EM5pch2jzBXxl3+frvVMHsaAr0=
X-Sasl-enc: nVY8mAw4YvHy990dTwgcWNJwUN3UIWddAgzv9uZe1HcE 1301423793
Received: from localhost.localdomain (p54858F1A.dip0.t-ipconnect.de [84.133.143.26])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E42D5403D57;
	Tue, 29 Mar 2011 14:36:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v7hbhss0g.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170303>

Junio C Hamano venit, vidit, dixit 29.03.2011 20:25:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> The current description of '-C' together with the analogy to 'git commit
>>> -C' can lead to the wrong conclusion that '-C' copies notes between
>>> objects. Make this clearer by rewording and pointing to 'copy'.
>>>
>>> The example for attaching binary notes with 'git hash-object' followed
>>> by 'git notes add -C' immediately raises the question: "Why not use 'git
>>> notes add -F'?". Answer it (the latter is not binary-safe).
>>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>> In fact, the long name '--reuse-message' is really misleading, but I've been
>>> around long enough to refrain from trying to change it ;)
>>
>> Yeah, it utterly is broken.  Why not fix it before people start making
>> serious use of notes?

You seriously ask why? Because I've banged my head way to often by
suggesting behavior changes!

> 
> Actually I take it back and throw it again after doubling it.  Not just
> the long name, but using -C/-c is already utterly broken.  These are meant
> to reuse (meta)data associated with an existing object, not using some
> data that happens to be stored in a random loose blob.  I don't think of
> any similar option anywhere in git.
> 
> Instead of mucking with the documentation, why not fix the behaviour to
> match what -C/-c/--reuse usually means, which is what the documentation
> describes?

Because it's not what the doc describes. The current version is easy to
misunderstand, but in connection with the example it is clear how it is
meant, and that's how it is implemented. If I were to reimplement it I
would:

- make "notes add -C/-c" really analogous to "commit -c/-C", i.e. do
"notes copy"

- make -F binary safe

and while at it rename "add" to "edit", because I've been bitten too
often by trying to add to a note using the "add" command. But all these
are behavior changes/incompatibilities, i.e. a no-go.

I don't mean to criticize the initial implementation of "notes", it just
shows that we detect rough ui edges only after using a feature. I'm all
for changes, I just rarely can get myself to making a hopeless feature
change patch any more.

Michael
