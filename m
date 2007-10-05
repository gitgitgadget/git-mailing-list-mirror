From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Correction for post-receive-email
Date: Fri, 5 Oct 2007 15:29:43 +0100
Message-ID: <200710051529.45440.andyparkins@gmail.com>
References: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com> <200710050913.58835.andyparkins@gmail.com> <18182.12163.311826.242309@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, "Eric Mertens" <emertens@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 16:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoBm-0003jH-Vk
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbXJEO3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbXJEO3y
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:29:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37779 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbXJEO3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:29:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so506112ugc
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XB5uU5Gjk06z9zYZiTyfqr1aLbmDryo4fcfcawMfx3M=;
        b=ZDvnLKqcvMGMTIYN2UStk1/P2cEgwN+22Et/PosDal5OjD+/QrRq/Ge1tpEuz04krZWDSjDnOwWftxfmJjhmt8Zv1NlzZpGNqx47/KBKA2uqoDHw0uaymJ4V5bxup3dbGyu5Y/Q5UxMSHyyrmmb9nCvxmSCWcJaoADnwrnCs+Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jgdyUejv0jBIAHBVLl+CwNoNCd5XBAa3XGo+gopuXp5ENXQzQUnavQ/xeab6IWoHillN83gsYS0gCqwSE/Yr7rNr5jaVTQB7J/UihKPkUGM+HyeEvqiUJTQuc9mmEUBU6t7AxNuOvlyJsFoDIQ8iyVdCNzMFWgVZzu/z+8Hj52I=
Received: by 10.66.239.2 with SMTP id m2mr3358689ugh.1191594590994;
        Fri, 05 Oct 2007 07:29:50 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z34sm3415726ikz.2007.10.05.07.29.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2007 07:29:49 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <18182.12163.311826.242309@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60085>

On Friday 2007 October 05, Bill Lear wrote:

> I have a few changes I would like to see in this script, ones that I think
> would make it generally more useful.  I don't have a clean patch, though,
> so should I just submit suggestions to you directly, Andy?

Me; or the list. Or both.

I'm happy to try to accommodate any suggestions.  I'm happy if it is useful to 
anyone other than just me :-)


--- SNIP THIS BIT IF YOU'RE NOT INTERESTED IN ITS BUGS ---
The big fault in it as it stands is that it doesn't try to reorder the refs 
being updated to the most logical form.  For example:

 O --- * --- A (ref2)
              \
               B (ref1)

Let's say that both ref1 and ref2 were originally at O and this push has moved 
them to these new locations.  The email hook gets sent this information like 
this:

 refs/heads/ref1 O B
 refs/heads/ref2 O A

The hook iterates through this list, for each ref update it shows only the 
commits introduced by the change that aren't already included in an existing 
ref.  This is the problem, ref2 introduced "*" and "A" and ref1 
introduced "B",  ideally then the two emails would show

 ref2 updated from O to A
   new revs: *, A
 ref1 updated from O to B
   new revs: B

But because ref1 is alphabetically before ref1, what you get is:

 ref1 updated from O to B
   new revs: *, A, B
 ref2 updated from O to A
   new revs: <none>

I can't say I know what the answer is; nor even what the correct output should 
be.  If anyone has opinions on this, I'll be glad to hear them.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
