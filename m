From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-gui.sh: support Tcl 8.4
Date: Tue, 6 Jan 2015 14:47:32 -0800
Message-ID: <82A625FF-768E-4D7E-8248-B14005464EAE@gmail.com>
References: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c> <xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8cua-0006fK-8B
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 23:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbbAFWrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 17:47:36 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45357 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbAFWrf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 17:47:35 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so630165pab.6
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 14:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=sVRAXSa31efoLS6I3WPr8cRB/BT73y1S4vDlFQoq6QA=;
        b=EpZpfjna5pLjp29B7XrX9ACtvSSMxvXDahcNPrCULOktRu7zKw19Y5P42lvu956NYF
         Iw119m1M3czc3yya9bCeb+cWRID0uSrbi2g0To5Dty7NYVJWZez0v8U3Gpyl8MAK6cTY
         TCj1vN1Olh6oShtEndcGqIS/6dn7LTdqq6j3oY8O6PqevR4+0cqnIoXND9TKGvtMYWRr
         vZ6SfXyyem3vIO0bSXuF7Siy//6Les4GohkYEhEiz0OpwyM4KzOJMmwjua8f73DIxrMI
         TUjP7sKVU82UAwFpvtFJaJUD/bam2HKWxf6El2t6+DgBc8Pmv3WNS97oBDoslHAuPYKg
         dqdg==
X-Received: by 10.68.129.6 with SMTP id ns6mr158131140pbb.137.1420584454964;
        Tue, 06 Jan 2015 14:47:34 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kb16sm57863504pbb.34.2015.01.06.14.47.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 14:47:34 -0800 (PST)
In-Reply-To: <xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262105>

On Jan 6, 2015, at 11:42, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> Tcl 8.5 introduced an extended vsatisfies syntax that is not
>> supported by Tcl 8.4.
>
> Interesting.  We discussed this exact thing just before 2.0 in
>
>    http://thread.gmane.org/gmane.comp.version-control.git/247511/focus=248858
>
> and nobody seems to have noticed that giving the new range notation
> to vsatisfies is too new back then.
>
>> Since only Tcl 8.4 is required this presents a problem.
>
> Indeed.
>
>> However, what we really want is just a basic version compare,
>> so use vcompare instead to restore compatibility with Tcl 8.4.
>
> My Tcl is not just rusty but corroded, so help me out here.

My Tcl is barely operational, but I'll give it a shot.  :)

> * Your version that compares the sign of the result looks more
>   correct than $gmane/248858; was the patch proposed back then but
>   did not get applied wrong?  This question is out of mere
>   curiosity.

Thanks for the reference.  That patch proposed this type of change:

-	if {[package vsatisfies $::_git_version 1.6.3]} {
+	if {[package vcompare $::_git_version 1.6.3]} {

But that's wrong because vsatisfies returns a boolean but vcompare  
returns an integer (think strcmp result) so the proposed change is  
testing whether the version is not 1.6.3 rather than being 1.6.3 or  
greater.  But Jens mentions this in $gmane/249491 (that the original  
patch was missing the ">= 0" part).

I can't find anything in that thread about why vsatisfies was  
preferred over vcompare other than the obvious that the vsatisfies  
version is only a 1-character change.  And that would be more than  
enough except that Tcl 8.4 doesn't support the trailing '-' vsatisfies  
syntax.  There are complaints about this problem with git-gui [1] by  
folks who have Tcl 8.4 on their system and have upgraded to Git 2.0 or  
later.

> * Would it be a good idea to update the places $gmane/248895 points
>   out?  It is clearly outside the scope of this fix, but we may
>   want to do so while our mind is on the "how do we check required
>   version?" in a separate patch.

Makes sense to me, but my Tcl knowledge isn't up to making those  
changes as the code's a bit different.  I have to paraphrase Chris's  
message here by saying that I guess those checks are correct if not  
consistent with the others.

[1] http://stackoverflow.com/questions/24315854/git-gui-cannot-start-because-of-bad-version-number

-Kyle
