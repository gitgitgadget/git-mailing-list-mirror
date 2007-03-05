From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Mon, 5 Mar 2007 18:15:43 +1300
Message-ID: <46a038f90703042115r3ce1498cmdddc0dc11c9d4b2a@mail.gmail.com>
References: <200702131438.30291.andyparkins@gmail.com>
	 <200702131605.29088.andyparkins@gmail.com>
	 <Pine.LNX.4.63.0702131910020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200702131821.37284.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 06:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO5Y5-00043O-18
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 06:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbXCEFPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 00:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbXCEFPp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 00:15:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:12883 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbXCEFPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 00:15:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1143364uga
        for <git@vger.kernel.org>; Sun, 04 Mar 2007 21:15:43 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afoaTAoWWLyWq7Re/VBIEGuniGtffA/3JYaG+3sCu/au+OrM2BdtQ0+93RLYrsqpvpbS0GtpxLiH13dgbo21ivCYoJwnX5vR1PoqsvDQf/HaQ1cL3R6CyIn0r+j7bH0p2q+crnTLrnGG1zTqJax9/3nJYB+7zQMwaIvBMWYN6oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=asoJG6bVJ12bJpNi9+B/NhnVsNJ6Pm9Hy79YcMxDxL25tuijRO7pIxwZ2QiFMFm+JDBEooVaNER/DWQyyGVFzbZLE/3KyC3drhIJ+jqiC9V3e9kxciW8YqmaPvVs/x6FYRxIv2SgsF5VC7SjZ0HZFUXl16QfeLgbL5ngX99TO2g=
Received: by 10.67.40.12 with SMTP id s12mr9711290ugj.1173071743523;
        Sun, 04 Mar 2007 21:15:43 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Sun, 4 Mar 2007 21:15:43 -0800 (PST)
In-Reply-To: <200702131821.37284.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41401>

On 2/14/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007, February 13, Johannes Schindelin wrote:
>
> > Ummm. What I tried to say is that this is intended behaviour, not bad
> > behaviour. The file does not have to have write permissions for the
> > group. The _directory_ has to have them.
>
> It's not just write permissions.  The default umask could also prevent
> read access by the group - the new ref needs to be readable by the
> group.

I agree. cvsserver depends on the user's umask just like an oldstyle
cvs server. This is probably wrong, and you are right - we should
respect core.sharedrepository.

The recent change to use git-update-ref should have fixed part of the
problem. The other part of the problem is the handling of the sqlite
files. All the other operations that leave permanent files in the repo
are using git plumbing so we are safe.

To fix the sqlite files handling, the fix is to change the umask early
on if core.sharedrepository is true.

cheers,


martin
