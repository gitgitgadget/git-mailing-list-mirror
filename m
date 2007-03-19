From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 19:03:17 +0000
Message-ID: <200703191903.20005.andyparkins@gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>,
	John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 20:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNBN-0000La-BT
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXCSTGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXCSTGM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:06:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37733 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbXCSTGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:06:11 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1374674uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 12:06:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pxeurL/YCGqymeXdIFFM9bXO+n+0/oW+5vY/vvv968MNZG2czV3YmiR1inbjMe43x8d1aqAVXC8htLnx1XGMzl5sNCmClgtqn0U3BqS2tk057De1ZQaAdEdIqCIu3IzlNtGPfEWp0JkC2tq+vCLVh+14nzJR6vOm73GiHQPxubY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L7uD43ihTf6uGmugs06EK2zU+gAHkvP1V50QmjBU6ZwSoKK5y0DzcT06Q3cxteJWLPuR6c6DevEoNzkxNR2wSh9bYjeOXVdHZxfgS4GK5ec0xzALVQvUubnLGWogaQfTSBHAUurKwrCpgSXQI/qEdVs4ggiGjZn/9GRhhdEJoAg=
Received: by 10.67.119.9 with SMTP id w9mr10270804ugm.1174331169727;
        Mon, 19 Mar 2007 12:06:09 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 53sm7558221ugn.2007.03.19.12.06.08;
        Mon, 19 Mar 2007 12:06:09 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <45FED31B.8070307@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42653>

On Monday 2007, March 19, Steven Grimm wrote:

> On the other hand, I agree with your general point; I really don't
> like being uncertain about whether renames are going to come out
> correctly or not ("it has always worked before" and "it is by design

I agree with you, but I think that git does exactly what you want.  In 
fact I think git is better.

The beauty of git figuring out renames for itself is that git can figure 
it out later. 

 $ mv file1 file2
 $ git update-index --remove file1
 $ git add file2

The important thing here is that git wasn't used to do the move.  This 
is great when you're lost in a development haze and do the move without 
thinking.

> So to answer your question, in my opinion if 100% guaranteed renames
> are high on your priority list, then Mercurial might be the better
> option for now. In practice, I've found that git's 99+% rename
> detection has yet to fail on me aside from the above directory
> renaming case, but at the end of the day it *is* guessing at your
> renames after the fact.

It's not really a guess; through the magic of sha-1, and provided you 
are disciplined enough to commit the rename without any changes to the 
content you can be sure that the rename is tracked.  The sha-1 /must/ 
be the same before and after.  For this 100% case, git doesn't even 
need the "-M", git-blame, git-diff and git-merge will find it anyway.

Even better is that because the rename isn't recorded explicitly when 
you upgrade git and the detection gets better, all your history 
instantly gets interpreted correctly.

The only command I've found that doesn't do the "right thing" by default 
is git-log and I think that once the following works, all the "why 
doesn't git track renames" people will go quietly away:

 $ git init
 $ date > file1
 $ git add file1
 $ git commit -m ""
 $ git mv file1 file2
 $ git commit -m ""
 $ git mv file2 file3
 $ git commit -m ""
 $ git log -- file3




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
