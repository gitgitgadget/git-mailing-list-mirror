From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: What about allowing multiple hooks?
Date: Fri, 21 Nov 2008 16:56:03 +0200
Message-ID: <4926CC03.4000009@dawes.za.net>
References: <20081121133828.GB5912@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 15:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3XTu-0004FP-L5
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 15:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYKUO6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 09:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYKUO6R
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 09:58:17 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:35776 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbYKUO6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 09:58:17 -0500
Received: from spunkymail-a17.g.dreamhost.com (sd-green-bigip-202.dreamhost.com [208.97.132.202])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7BB62196BFA
	for <git@vger.kernel.org>; Fri, 21 Nov 2008 06:58:16 -0800 (PST)
Received: from [192.168.201.100] (dsl-243-208-159.telkomadsl.co.za [41.243.208.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id A8B59733DC;
	Fri, 21 Nov 2008 06:56:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081121133828.GB5912@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101532>

Marc Weber wrote:
> Use case:
> 
> I've been reading parts of the topGit code. And it does make for it to
> add its own checks. However having to change the existing scripts
> insterting a call to the tg hooks isn't the best way.
> Why? one is using #/bin/sh the next is using #/bin/ruby maybe..
> 
> So what about allowing (or even enforcing) ths directory layout?
> 
> .git/hooks/pre-commit/hook1.sh
> .git/hooks/pre-commit/hook2.sh
> .git/hooks/pre-commit/topGitcheck.sh

I second Martin's suggestion, that you implement:

.git/hooks/pre-commit
.git/hooks/pre-commit.d/hook1.sh

where hooks/pre-commit is e.g. a shell script much like the init scripts 
that iterate over the executables in the corresponding .d/ directory, 
and execute them one at a time. Basing your script on initscripts will 
likely save you some time, since they have already considered things 
like script ordering, backups, etc.

I'm also inclined to think that this is likely to be a local 
customisation, because you need to decide what makes sense in your 
context, aborting if a script exits with a non-zero result, or 
continuing to see if the next script manages to exit with a zero result.

e.g. in the pre-commit case, it *probably* makes sense to allow any 
script to abort the commit, but your site-specific requirements might be 
that all hooks must fail to abort the commit.

Regards,

Rogan
