From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Sat, 12 Jun 2010 02:18:50 -0500
Message-ID: <20100612071850.GA2765@burratino>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
 <20100612062812.GA12685@coredump.intra.peff.net>
 <4C132C7E.5090606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Bobby Powers <bobbypowers@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 09:19:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONL05-0003Fz-Ew
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab0FLHTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 03:19:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55246 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab0FLHTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 03:19:01 -0400
Received: by iwn9 with SMTP id 9so1230995iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hwNHLDIy+NwQrdkHqVMskS2t/07I+rreEIYJoJLCnw8=;
        b=QbfVkq7paqguLX91b97MpgmiSGgIUZImx3NVhsCsf4eFa7g/fUYdBj9pfpgN8NfWUr
         uU4AvwmyRZz1ZTWntlcm0/WYiBcQJw8bnk7Nax2vHf3d616voY/HkkolEczTbUVpUoRZ
         PLUGOwmU/6F8JfJXHXZrLqvBD+HjMFhI03JP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I8IJS6oMrZdjHS3TYg7YXx5OBPg5B6h7AM8EEUyoU6INh3LZNqtLz6oDWORMjSYStI
         WDhoTfjm85ljevrUk50rAR/rDYgIsFugxSJi3z/FkdIg/USPkj/vGsgsJt1X4IppsvHZ
         Y72DMKegUNTkIqCpSDzZ0BatSbcPP/+R81eK4=
Received: by 10.231.124.73 with SMTP id t9mr2916327ibr.170.1276327140682;
        Sat, 12 Jun 2010 00:19:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm9145799ibi.11.2010.06.12.00.18.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 00:19:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C132C7E.5090606@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148994>

Bobby Powers wrote:
> On 06/11/2010 11:28 PM, Jeff King wrote:

>> FWIW, we can already do this kind of stuff with:
>>
>>   GIT_EDITOR="sed -i 1i$prefix" git cherry-pick -e $ref
>>
>> or
>>
>>   git cherry-pick -n $ref&&
>>   sed -i 1i$prefix .git/MERGE_MSG
>>   GIT_EDITOR=true git commit
>>
>> I'll admit the first one is not very intuitive. But it is easy to script
>> around the second form. For one of my examples, I would probably do:
>>
>>   git cherry-pick -n $ref&&
>>   git log -1 --format='%s%n%ncontent between subject and body%n%b' |
>>   git commit -F -
>
> I like this; it clearly hadn't occurred to me.  I can just use this
> format instead.

Sorry to misunderstand.  Maybe something like this could help.  Patch
applies on top of cc/cherry-pick-series.

-- %< --
Subject: Documentation: explain use of cherry-pick -n in scripts

Add an example to indicate how to munge a commit while cherry-picking it.

The formatting is ugly because I do not know how to ask asciidoc to
use a multiline heading in a definition list.

Based-on-work-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index bcb4c75..4769ca5 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -113,6 +113,17 @@ git cherry-pick --ff ..next::
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
+------------
+git checkout maint &&
+git cherry-pick -n bugfix &&
+git add new_file.txt &&
+git show -s bugfix --format='%s%n%n%b%n%nAlso add a new file.' |
+git commit -F -
+------------
+
+	Apply a bugfix on top of the maint branch and tweak it before
+	creating a new commit to record it.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
-- 
