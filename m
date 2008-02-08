From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use the config file to set repository owner's name.
Date: Fri, 8 Feb 2008 16:33:54 +0100
Message-ID: <200802081633.55934.jnareb@gmail.com>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <20080208135327.GC30264@c3sl.ufpr.br> <20080208143027.GA707@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Feb 08 16:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNVFU-0008DX-2q
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 16:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970AbYBHPeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757855AbYBHPeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 10:34:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:30373 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbYBHPeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 10:34:06 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3595620wra.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=ISXnu4jKWD7GsaIOo3sdeYQirK1lvPVMlSc1UW+wIpI=;
        b=UxIxP6DF8WDaZyoHCEw/nTpONr6v1BMB1JGKHswZ9Xa/nbE3670m/XPv7b0grxp15taS8m0VSl5P3xjdxYMMXtF41w7hnqF01x1s83qw7aeADfgc3bV6p4oacQndlWLpTqli/UeoVRSu433jw5PRIR37q+9FX0fim5Wgxu7vY1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=vxSk0qsgVj5MTTR8zFIO1UDzl1BioYTWsCAIvIJU/rPE+UGRZ4t6z8tVZI2u7ANJvLsEyrUmzNUokswXcHl2NRSaxacDCoOQTZDxn6ynkvVjSXbiW4lNXHarPLFSV17cyWy0ssDZnyEoDXhX6zT3lIZXSxzsJk4kXhgLwB71sns=
Received: by 10.115.77.1 with SMTP id e1mr3681975wal.103.1202484842318;
        Fri, 08 Feb 2008 07:34:02 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.242.186])
        by mx.google.com with ESMTPS id i4sm1112535nfh.26.2008.02.08.07.33.59
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 07:34:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080208143027.GA707@c3sl.ufpr.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73099>

I have joined the two emails to reply only once.

On Fri, 8 Feb 2008, Bruno Cesar Ribas wrote:
> On Fri, Feb 08, 2008 at 02:55:33AM -0800, Jakub Narebski wrote:
>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
>>> 
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 8ef2735..e8a43b7 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -1767,7 +1767,12 @@ sub git_get_project_owner {
>>>       if (exists $gitweb_project_owner->{$project}) {
>>>               $owner = $gitweb_project_owner->{$project};
>>>       }
>>> -     if (!defined $owner) {
>>> +
>>> +     if (!defined $owner){
>>> +             $owner = git_get_project_config('owner');
>>> +     }
>>> +
>>> +     if (!$owner) {
>>>               $owner = get_file_owner("$projectroot/$project");
>>>       }

Another comment: why did you change from checking of "!defined $owner"
to checking "!$owner"? git_get_project_config('owner') returns undef
if gitweb.owner is not defined. With checking for defined we can avoid
false positives of owner being "0" (in practice I think this does not
matter) or "" (this could happen if somebody doesn't want for project
to have owner shown).

>> First, I think the empty lines added are not needed.
> 
> I made those empty lines because original code had same empty lines
> above, I just let it to have same pattern, but I can remove. Should I
> remove?!

The idea was for empty lines to separate blocks of code: variables 
declaration, initialization, finding an owner, and return value.
So I think that empty lines are not needed here. There were no empty 
lines between check for owner in the structure populated by 
git_get_project_list_from_file() and checking filesystem stat for 
project directory owner.

By the way, the git_get_project_list_from_file() interface is a bit 
strange...

> I that last 3lines should be inside the block that we call
> git_get_project_config, don't you think?

No. I think using "if (!defined $foo) { maybe define foo }..."
sequence is a good flow.

> I'll resend [...] with $git_dir set.

And with signoff corrected, I assume?

Please try to check if the code works with and without gitweb.owner set 
before sending new version of the patch...
-- 
Jakub Narebski
Poland
