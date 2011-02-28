From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: copying git repositories ...
Date: Mon, 28 Feb 2011 10:10:39 -0500
Message-ID: <43737C0D-E1B7-4036-BE39-8DF09751E22D@silverinsanity.com>
References: <1298388877.32648.171.camel@lenovo-w500> <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com> <1298565560.32648.258.camel@lenovo-w500> <201102252155.13466.andres@anarazel.de> <1298903102.14697.127.camel@lenovo-w500>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Andres Freund <andres@anarazel.de>, git@vger.kernel.org,
	kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Mon Feb 28 16:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu4kK-000459-8Q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 16:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab1B1PKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 10:10:43 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:44109 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab1B1PKn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 10:10:43 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C26F81FFC151; Mon, 28 Feb 2011 15:10:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.7] (cpe-74-78-177-55.twcny.res.rr.com [74.78.177.55])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id AB0D61FFC057;
	Mon, 28 Feb 2011 15:10:37 +0000 (UTC)
In-Reply-To: <1298903102.14697.127.camel@lenovo-w500>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168114>


On Feb 28, 2011, at 9:25 AM, Michael Meeks wrote:

> 	I'm really looking for an equivalent of 'cp -lR foo baa' that:
> 
> 	* uses hard links to save space
> 	* produces precisely-a-duplicate repository

I mostly handle this sort of thing by branch switching in the same checkout, which I assume you're trying not to do because of recompilation time.  Your way, eventually the repositories in question would start to diverge and you'd have to keep them in sync manually, which sounds far less than ideal.  Eventual repacks would break the hard links and you'd even lose the space savings.

What you might be interested in is the git-new-workdir script in git.git/contrib/workdir.  It uses symbolic links to create a new working directory backed by the exact same object store and config as the original.


This is not a situation git is well designed for, honestly.  The more "git-like" work flow would be to maintain a single central, probably bare, repository on your machine that pulls from everything that all your local repositories need.  Then set up the other repositories to get all the references from the central repo.  Then there's only one that needs to be updated from the remotes.  If you use the --reference option to git-clone, you're not even duplicating the object store and each clone only has the objects it needs.

~~ Brian
