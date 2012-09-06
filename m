From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] pre-merge-hook
Date: Thu, 06 Sep 2012 10:16:11 +0200
Message-ID: <50485BCB.20607@drmicha.warpmail.net>
References: <cover.1346851863.git.git@drmicha.warpmail.net> <7v8vcn68o9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9XGI-0002tH-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab2IFIQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 04:16:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34425 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753055Ab2IFIQN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 04:16:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E13DA208F2;
	Thu,  6 Sep 2012 04:16:12 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 06 Sep 2012 04:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KWoaHLtSBOTiTm0SiOMYcx
	wmDII=; b=m+hV/jbHkRA7NMEoiOthZnI0P06G4CBBKw0tkVCCPxgwbl/8MYnMe+
	9Zb6SyN+uR2xdI6kfONnTS+JCqEJiJodExy0hxbojQk0mD3Tn842rdTH2+/uNMXt
	icmlSm6895t9WXlPHeSLchu6pEordhOLX0s25GpaTXVSY7VCSskVY=
X-Sasl-enc: RG6x4lDgOX6GtEfZw5Z7j3gcMCSHr3tOAXirryHuO8Ux 1346919372
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 636398E0217;
	Thu,  6 Sep 2012 04:16:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v8vcn68o9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204869>

Junio C Hamano venit, vidit, dixit 06.09.2012 07:07:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The pre-commit hook is often used to ensure certain properties of each
>> comitted tree like formatting or coding standards, validity (lint/make)
>> or code quality (make test). But merges introduce new commits unless
>> they are fast forwards, and therefore they can break these properties
>> because the pre-commit hook is not run by "git merge".
>>
>> Introduce a pre-merge hook which works for (non ff, automatic) merges
>> like pre-commit does for commits. Typically this will just call the
>> pre-commit hook (like in the sample hook), but it does not need to.
> 
> When your merge asks for a help from you to resolve conflict, you
> conclude with "git commit", and at that point, pre-commit hook will
> have a chance to reject it, presumably.  That means for any project
> that wants to audit a merge via hook, their pre-commit hook MUST be
> prepared to look at and judge a merge.  Given that, is a separate
> hook that "can just call the pre-commit but does not need to" really
> needed and useful?
> 
> I admit that I haven't thought things through, but adding a boolean
> "merge.usePreCommitHook" smells like a more appropriate approach to
> me.
> 
> I dunno.

That would be an option ;)

Seriously, that would make the case where both hooks are the same even
simpler, obviously. On the other hand it would make the other case more
difficult. But, really, since non-automatic merges call pre-commit now,
and that is probably to stay, catching those with a different (part of
the pre-commit) hook will stay difficult anyways. So the question is
really more whether we prefer to bloat the config space or the name
space by this.

Either works for me, and if we don't change the current behaviour
(pre-commit-hook resp. no hook for non-automatic merges resp. automatic
merges) the config option is probably less confusing.

Michael
