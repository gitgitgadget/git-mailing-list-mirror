From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: core.autocrlf considered half-assed
Date: Sun, 7 Mar 2010 12:27:01 +0300
Message-ID: <20100307092701.GC31105@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 07 10:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoClX-00011l-EE
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 10:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab0CGJ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 04:27:09 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:51189 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0CGJ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 04:27:06 -0500
Received: by fxm19 with SMTP id 19so5450047fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 01:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dv8BuF1iuU43GsETqz3otELQXckLtIgtyDI4xq1/KG0=;
        b=GSvMn4yaNTjX5ak/iiWq2qMmnz1xp22L1Mlh1PryW57GFQc0rkDr6ysXiROSTTDulh
         yghqNUlOnu75k9n591RSPQDI2TzQlJqiFzma0PIG3N+3CIPS8FRp75XB/R28/zsDO5hR
         jCmNDn9TmIfzph7lu2WtJuhTURpMIVb2gRslc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kgUL0CjwpkVHJZo9TK5Y1qCJxAQAp6YqLDVme8SO+1rlCwtAlewt4d4o2o1BMtG1OU
         Mc2ak8lsF3soR/LvcNG0uhj231NDW2TbsaForPHEJH5r74Zk9+qCqq9bt1si4H0L4wo+
         Vd4MVWdUiaTDJ4vtV+gqoU+ivIE5PRY2aNGGw=
Received: by 10.87.16.39 with SMTP id t39mr3724070fgi.46.1267954023597;
        Sun, 07 Mar 2010 01:27:03 -0800 (PST)
Received: from localhost (ppp91-77-225-63.pppoe.mtu-net.ru [91.77.225.63])
        by mx.google.com with ESMTPS id 14sm2276166fxm.9.2010.03.07.01.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 01:27:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141616>

On Sat, Mar 06, 2010 at 12:23:33AM +0100, Johannes Schindelin wrote:
> 
> back then, I was not a fan of the core.autocrlf support. But I have to 
> admit that in the meantime, I turned into an outright un-fan of the 
> feature. Not because its intent is wrong, but because its implementation 
> is lousy.

Well, I agree there are some issues with it. In particularly, when
someone changes core.autocrlf in his/her repository, and then git
behavior is outright confusing. IMHO, the nuts of the problem is that
does not store in the index how files were checkout. Instead it uses
core.autocrlf, which specifies how the user _wants_ files to be check-
out. So, when the autocrlf option changes, things get very confusing.
However:

> Just try to "git reset --hard" or "git stash" when there are files with 
> DOS line endings and when core.autocrlf is not false.

I did, and I have not noticed any problem with that.

git init
git config core.autocrlf true
echo foo^ | tr ^ '\r' > foo
git add foo
git commit -m 'add foo'
echo more^ | tr ^ '\r' >> foo
echo "Before reset:"
tr '\r' ^ < foo
git reset --hard
echo "After reset:"
git diff
tr '\r' ^ < foo


Dmitry
