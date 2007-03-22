From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Rename handling
Date: Thu, 22 Mar 2007 12:10:06 +1200
Message-ID: <46a038f90703211710q168a691cpa282f8e2afc5c8a6@mail.gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
	 <45FED31B.8070307@midwinter.com>
	 <200703191903.20005.andyparkins@gmail.com>
	 <45FEE2B2.6050904@midwinter.com> <etpson$qih$1@sea.gmane.org>
	 <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <4601B199.9060300@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 01:10:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUAt5-0004la-Cr
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 01:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965536AbXCVAKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 20:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965549AbXCVAKK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 20:10:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:3814 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965539AbXCVAKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 20:10:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so575648wxd
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 17:10:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBctcADrGt0mcTIvHUIGYmFBl1jVpO6SCyLJC+0f6M9u+rwTI95kSsFXeTfKic7KYe2Pp6Tr+beD1xTTQNI/4d6Li4o5nB8dL3gNm+fitxmr3IdTR7QuRnU2b7+g9RB+Q5G/oI0J9zZCvwD52iq950rHwhNoD4OQBerdYuQ+Kug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FQoKIJ4mPxzyVY2ZDYZJj4aV2myH54xuOvp9zrli0RmnmGlJkaqKZ+xwpqFa/c9rImYmNHL2ZKoOkPUptFFPbRHqy+gWxsH2Rhbw4/zXC7oNeH5JfutwB+Z9fNPdiIm7SaTWgqOAQXfygIXER92H90cTOjc6UpgDJD2sr3J+dEA=
Received: by 10.90.72.10 with SMTP id u10mr2943553aga.1174522206257;
        Wed, 21 Mar 2007 17:10:06 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 21 Mar 2007 17:10:06 -0700 (PDT)
In-Reply-To: <4601B199.9060300@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42828>

On 3/22/07, Steven Grimm <koreth@midwinter.com> wrote:
> Say you're tracking a directory full of video files. Even a slight tweak
> to one of them (to put a logo in the corner, say, while moving it into
> an "accessible by the public" directory) will result in a file that has
> no content in common at all if you look at it as purely a stream of

In that case, tracking the rename is not useful at all from the POV of
your SCM. The  reason the SCM needs to understand content-movement (of
which renames are a special type), it to help you as much as possible
at merge time.

So - git as an SCM focusses on tracking your content, and helping you
merge. It does _that_ probably better than any other SCM. So git
internat data structures care strictly about the stuff that is needed
for git's operation as an SCM.

And in the context of helping you merge, explicit rename tracking is a
red-herring. This point is arguable - Linus said earlier "you can do
better by tracking content and ignoring explicit renames" and we are
now getting there in terms of having code that does better.

Of course in your case the fact that there was a rename is important
-- for users. This kind of information is not metadata for the SCM but
for users. So that goes into the commit message, which is freeform. So
- working with your scenario, if this happens often, I would suggest
having a pre-commit hook that prepares a nice commit text message
listing likely renames if they can be sussed out automatically.

Or having a custom git-mv that collects mv operations and then your
pre-commit-hook preps your commit message with that manifest of moved
files.

Does it make sense? It is data-for-the-user, so it goes in the commit
msg. If it's data-for-the-SCM machinery, then it goes into the
tracking data git handles internally.

cheers,


martin
