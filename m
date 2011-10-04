From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log --children
Date: Tue, 04 Oct 2011 22:27:59 +0200
Message-ID: <4E8B6C4F.1090507@drmicha.warpmail.net>
References: <1317736923-20539-1-git-send-email-jaysoffian@gmail.com> <4E8B68AC.7020009@drmicha.warpmail.net> <7vpqicbj8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBaz-00070E-Jw
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686Ab1JDU2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:28:04 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42358 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933567Ab1JDU2D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 16:28:03 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 32008242E7;
	Tue,  4 Oct 2011 16:28:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 04 Oct 2011 16:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=J8kZGJaezxTkchac1Vdtww
	o3ZTs=; b=dVA5eU+ERJgHcHRJn1h1f9ygivH7zerojK7LdF3FR9rQmzY9sDQFMY
	kVLayWk0H0xvK3+uwv0uT6qFDHR6bYMqiooUpjoZrqOUIdqrn+b/ZFk1U3dCoeKg
	mikNWbUg2EkHLI5ia4RimPA0N98OmBmVAbY5TrJ5qNY7pa2kP7/tk=
X-Sasl-enc: XGHkabuVIh1bx9sIKft5tbHbCJ/XPbIH0ZYe/RrLj88N 1317760081
Received: from localhost.localdomain (p5485928F.dip0.t-ipconnect.de [84.133.146.143])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4FB1B4C0DAD;
	Tue,  4 Oct 2011 16:28:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vpqicbj8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182801>

Junio C Hamano venit, vidit, dixit 04.10.2011 22:21:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> @@ -414,6 +422,8 @@ void show_log(struct rev_info *opt)
>>>  		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
>>>  		if (opt->print_parents)
>>>  			show_parents(commit, abbrev_commit);
>>> +		if (opt->children.name)
>>> +			show_children(opt, commit, abbrev_commit);
>>
>> That means that "log --children --parents" will print out the parents'
>> sha1s, then the children's. Is that a good default format, or should we
>> somehow deal with the case when both are specified?
> 
> I think these two options are muturally exclusive, not because of the
> "mixed output getting confusing" reasons but because of traversal reasons.
> IIRC, when parent rewriting is in effect, you cannot just say "a commit
> that has these commits on its parents list is a child of these commits",
> as you have to orphan and adopt it as a child of ancestor commits, which
> the code introduced in f35f5603 does not do.
> 

I didn't think --parents would switch on rewriting, but I guess all is good:

git rev-list -5  --parents --children origin/next
fatal: cannot combine --parents and --children

Should be the same for log.

Michael
