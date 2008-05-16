From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Fri, 16 May 2008 12:50:04 +0200
Message-ID: <482D66DC.30602@viscovery.net>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com> <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net> <alpine.DEB.1.00.0805161118160.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 12:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwxX6-00033P-B5
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYEPKuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbYEPKuL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:50:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21722 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYEPKuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:50:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JwxVl-0008En-5d; Fri, 16 May 2008 12:50:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D4F716C4; Fri, 16 May 2008 12:50:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0805161118160.30431@racer>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82271>

Johannes Schindelin schrieb:
> Hi,
> 
> On Fri, 16 May 2008, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>> +'GIT_CEILING_DIRECTORIES'::
>>> +	If set (to a colon delimited list of absolute directories), Git
>>> +	will refuse to look for the .git/ directory further when hitting
>>> +	one of those directories (otherwise it would traverse the parent
>>> +	directories until hitting the root directory).
>> Hmm.
>>
>> Looking at the current implementation, this should be written as:
>>
>> 	If set to a colon delimited list of absolute directories,
>> 	and the current directory is in or below one of them, then
>> 	these are the top-most directories in which Git will look for
>> 	a .git/ directory (otherwise it would traverse the parent
>> 	directories until hitting the root directory).
> 
> According to the test case
> 
>         GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
>         export GIT_CEILING_DIRECTORIES &&
>         (cd subdir && test_must_fail git rev-parse --git-dir)
> 
> this is not the case.  If you have something like /bla/subdir and you are 
> in /bla/subdir, it will not look for .git/.

No, the test just shows that it does not *find* a subdir/.git/, but it
does not show that it doesn't even *look* for it.

Let's first clarify the semantics of GIT_CEILING_DIRECTORIES before we
start fixing something: Can a directory that is named in
GIT_CEILING_DIRECTORIES be a git repository or not?

David's original motivation was that it cannot; in your implementation it can.

-- Hannes
