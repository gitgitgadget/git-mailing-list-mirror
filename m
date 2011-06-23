From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 21:14:47 +0200
Message-ID: <4E0390A7.8040505@web.de>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hler?= <andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 21:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZpN6-0001TK-LC
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 21:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003Ab1FWTPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 15:15:15 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41509 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988Ab1FWTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 15:15:14 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 14B2C1A39A005;
	Thu, 23 Jun 2011 21:14:51 +0200 (CEST)
Received: from [93.246.54.209] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QZpMY-0007BW-00; Thu, 23 Jun 2011 21:14:51 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7v7h8c4nv3.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19oW2bQhp7nBbuMLnd9w4FnPkmbdOXIULYBCSfw
	Apw03xdp6V/knuGPySyqCL5BPJAdSbj5GOAGfN3QWppeAnnGn+
	1WaGNm3IsDsb6uL2QgtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176286>

Am 23.06.2011 16:35, schrieb Junio C Hamano:
> Maarten Billemont <lhunath@gmail.com> writes:
> 
>> When I initialize 2/3 submodules of my git repository and do git
>> submodule update, all is fine: Only the 2 submodules that I need are
>> updated.
>>
>> When I run a git submodule sync to update the URLs that may have been
>> changed in .gitmodules, it ADDS the URL of the submodule that was NOT
>> initialized, thus "initializing" it.
>>
>> Now, when I run git submodule update, it starts checking out the third
>> module and my workflow is broken.
> 
> See 33f072f (submodule sync: Update "submodule.<name>.url" for empty
> directories, 2010-10-08), which introduced this behaviour.
> 
> cmd_update considers anything that has submodule.<name>.url defined as
> "the user is interested", so I suspect "git submodule sync" should not do
> this.
> 
> The situation 33f072f cites as needing this behaviour can easily fixed by
> running 'submodule sync' after switching to the branch to which the
> submodule _matters_, no?
> 
> Jens, what do you think?

I agree that 33f072f introduced a regression. One could argue if it was
a good idea to let "git submodule init" not do the clone itself but defer
it to "git submodule update" by setting the url in .git/config, but that's
the way things are done now (and maybe there was a very good reason to do
it that way I'm not aware of, because I didn't follow the list that closely
back then).

So while I think 33f072f solved a problem for a valid use case, it breaks
other use cases that worked so far. So unless we want to change init to do
the clone itself (which would be a pretty invasive change in behavior),
I'd vote for a revert.
