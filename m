From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Tue, 10 Apr 2007 23:21:30 +0400
Message-ID: <20070410192130.GE4946@moonlight.home>
References: <20070409112422.GE11593@moonlight.home> <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbLuf-00086L-GY
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbXDJTVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXDJTVj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:21:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:51173 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbXDJTVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:21:36 -0400
Received: by ug-out-1314.google.com with SMTP id 44so135640uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 12:21:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pGwREFjKA9c6zhMb0F58OOvfx7V7W5bfBEQKLj9ePDQRtwoMo0FBqdL2WhiG9UDcg9c5ORaXJNF8eujk/t5BNb6Fr3sPb4En2qE2jc5TKgVQX1iLlNOPxLtSy7epQJvBJPGdFA2YHpr9B/AsYy0XB9AepaZwQehNcj7hbSiODBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LwFaUDJl5C5D37PlEBqmGQWBRO1KUw1xZqW4Us6JDCHDDlHWuIT4DzWue57Drwzf3eJ4Fd/i64XFNAOAxBOzMjQLgf9pWEnpbm8oI7Lel+ftgXi3DSktb5I98BdI1bKDHes3oiwsC4OanLy98pywUd//9YYnL+y6RcV0QysErRQ=
Received: by 10.67.27.15 with SMTP id e15mr475115ugj.1176232895028;
        Tue, 10 Apr 2007 12:21:35 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id e23sm1104498ugd.2007.04.10.12.21.33;
        Tue, 10 Apr 2007 12:21:34 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 79A353A7C2;
	Tue, 10 Apr 2007 23:21:31 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l3AJLU29000543;
	Tue, 10 Apr 2007 23:21:30 +0400
Mail-Followup-To: git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44171>

On Tue, Apr 10, 2007 at 17:48:29 +0100, Catalin Marinas wrote:
> >Fix in apply_diff() relaxes the restriction in 'push --merged' and
> >'rebase --merged' for detection of upstream merges, fix in
> >apply_patch() does relaxation 'import', 'fold' and 'sync' commands.
> 
> Thanks for the patch. I'm OK with -C1 in apply_patch() but I'm a bit
> concerned with the 'push/rebase --merged' logic being relaxed. There
> is also the reporting of patches being modified during 'push', i.e.
> the push succeeded only after a three-way merge.
> 
> I think I could add separate config options for both apply_diff and
> apply_patch, only that it might confuse users not knowing the StGIT
> internals.

Aha, I've made a mistake, I wanted to say 'pull --merged and rebase
--merged', not 'push'.  The idea was that StGIT should be liberal when
it decides if the patch was applied upsteam, it should not force the
user to merge her own patch back because of different context
upstream.  Of course we can imagine the situation when during such
merge the user will realize that her patch was applied upstream
incorrectly, but such cases will be rare, so better not to enforce the
merge.

But I see your point, and back then I didn't realize how it will
affect the 'push' command.

So, I think the best would be to have 'pull'-like commands (pull,
rebase, import, fold, sync) to be liberal by default (accept pathes
with -C1), while 'push'-like commands (push, any other?) to be
conservative (require full context match).  And both classes should
provide the way to explicitly control acceptance level.


-- 
   Tomash Brechko
