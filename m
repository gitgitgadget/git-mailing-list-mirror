From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Nesting a submodule inside of another...
Date: Wed, 13 Jul 2011 23:20:39 +0200
Message-ID: <4E1E0C27.60903@web.de>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com> <4E1C9F21.6070300@web.de> <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:20:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6rO-0005nF-OR
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 23:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab1GMVUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 17:20:42 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:49858 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1GMVUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 17:20:41 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id A4110193C9DC3;
	Wed, 13 Jul 2011 23:20:39 +0200 (CEST)
Received: from [93.246.47.236] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qh6rH-0002EA-00; Wed, 13 Jul 2011 23:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/UZ3ItpGIDASsSyJPFQx0P/HOhxN+xtQD2gWs6
	odVL/RXTiUvyVIQmWp92lys7+dNqIZt3P9TaxzILdXSYP6qjTb
	DJIG588O88hOxunEq92Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177085>

Am 13.07.2011 03:21, schrieb John Szakmeister:
> On Tue, Jul 12, 2011 at 3:23 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Submodules are repositories of their own, so their work tree is outside
>> the superproject's work tree. You're attempting to have a submodule of
>> the superproject inside another submodule of the superproject, but this
>> won't work because it does not live in the superproject's work tree (as
>> that doesn't include submodules and their subdirectories).
> 
> I guess I still don't see how that's a problem.  It seems to me that
> for the superproject the ignore rule needs to be:
>   ignore framework1, except framework1/module

But that would mean the superproject would have to scan framework1's
work tree for changes too, which is conflicting with the idea that each
submodule is a repo of it's own, so that won't fly.

> And then it could check its status.  Of course, framework1 would
> somehow need to know to ignore it... and I'm not sure how that can be
> communicated.

It can't be communicated, as submodules are unaware of their superproject.
And adding module manually to framework1's .gitignore is just a problem
waiting to happen. Having a file or submodule in the work tree of one
git repository being referenced by another is just asking for trouble ...

>> But at least since 1.6.2 git should issue a meaningful error message.
>> With current master I get:
>>
>> $ git add sub/file
>> fatal: Path 'sub/file' is in submodule 'sub'
> 
> Sorry, I wasn't trying to do a 'git add'.  I was trying to do a 'git
> submodule add'.

Ok.

>> What version are you using?
> 
> I'm using 1.7.6rc3.  I updated to the latest trunk and still get the same error:
> 
> :: git submodule add $PWD/../c b/c
> The following path is ignored by one of your .gitignore files:
> b/c
> Use -f if you really want to add it.

You're right, the error message of "git submodule add" should be better
here.
