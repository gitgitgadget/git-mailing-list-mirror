From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to coax hooks into working
Date: Tue, 27 Apr 2010 10:52:12 +0200
Message-ID: <4BD6A5BC.3010708@drmicha.warpmail.net>
References: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com> <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com> <FAF218B9-D2DB-4081-88CB-BEBA08DF1229@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 10:52:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6gWj-0004yD-NB
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 10:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0D0IwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 04:52:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48705 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752642Ab0D0IwP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 04:52:15 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 85A4BF05E4;
	Tue, 27 Apr 2010 04:52:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 27 Apr 2010 04:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bMJLcp1QcYivjjiTlqY1rUczmfw=; b=KuvK9Nutnkgfch9o72B8flowWt1ibiAOtyK4Ga/ccJP4pHhYEschBWaSaZ2M0G9j4LiHBkRqcGwrD7IfEQLonJetldPEVWcbZJg2ns/rYzFpv5cW/MYgDvtN0NlQA3sKS/oeXqzQ+6a5dONPVl073XkF5eZzvL4VWpa6l3Gqi2Y=
X-Sasl-enc: unrwYoX/o0/xLirYroZ5CfQ+WZIRpUJIcIj0dKOt2R4m 1272358334
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3A6C3713C;
	Tue, 27 Apr 2010 04:52:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <FAF218B9-D2DB-4081-88CB-BEBA08DF1229@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145885>

Jeremiah Foster venit, vidit, dixit 27.04.2010 10:33:
> 
> On Apr 26, 2010, at 8:11 PM, Jacob Helwig wrote:
> 
>> On Mon, Apr 26, 2010 at 11:04, Jeremiah Foster
>>> 
>>> 
>>> Can I confirm that hooks work with this type of transport?
>> 
>> The real problem is that you're using a post-commit hook (or at
>> least everything you said in your original email implies you are). 
>> post-commit hooks are only triggered in your _local_ repository,
>> since this is the only place you actually commit.  Doesn't matter
>> which transport you're using, post-commit will never be triggered
>> by a push.
>> 
>> You want one of the receive, or update hooks, if you're putting
>> this in a central place, where it needs to be triggered by someone
>> doing a push in to the repo.
> 
> Thanks Jacob. I'd just like to confirm that I am, in fact, using the
> update hook. I logged into the server holding the git repo, cd'd to

That used to be different ;) update hook on the server is good.

> the .git/hooks/ directory. Moved the update.sample to update. Changed
> the code to something trivial that would echo back to the client for
> testing. I checked permissions, checked ownership, ran the code as
> the git repo owner. I logged out, did a trivial change in the client
> repo, ran git commit -a -m "foo" and expected that the trivial update
> script to run on the server would produce output to the client. This

But this is the same problem backwards. Again: Please try to understand
what commit does, and what push does, in terms of where (local repo vs.
server) a change happens:

As long as you only commit in your local repo nothing changes on the
server (remote repo), so no hook is triggered there.

> never occurred. I further tested the client hooks which also did not
> run.

Which ones?

committing locally triggers post-commit on your local repo.
pushing to remote triggers post-update (and others) on the remote
server's repo.

Michael
