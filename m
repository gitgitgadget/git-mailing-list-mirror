From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Restricting access to a branch
Date: Thu, 22 May 2008 01:16:50 -0700 (PDT)
Message-ID: <m3d4ne4uts.fsf@localhost.localdomain>
References: <20080521163616.31fad56f@extreme>
	<7vhccrxkdm.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.10.0805211732520.3081@woody.linux-foundation.org>
	<7v63t7xgdg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Stephen Hemminger <shemminger@vyatta.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 10:18:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz5zw-0004RT-Us
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 10:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765905AbYEVIQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 04:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764557AbYEVIQz
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 04:16:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19103 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764685AbYEVIQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 04:16:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1313578nfc.21
        for <git@vger.kernel.org>; Thu, 22 May 2008 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=8T6xXalKTOZaOwZHTTjl1kvhI+p4UAmeneFkIUJ+IK8=;
        b=nokT6ybKutkEDUPjTlDMSUUKazDEMsYOtt1935IqHK53+NCkbhf7wXCJKbjnpoy87pkS0IyvhsF1AXyRS0pNN0EQogciIyg6+1yqXPuXOTbFkfgvdoyfjDF+MeggEk0zTz3mgfCr7LwNp8agBrMIuPB9nC4tx19sYHemm93CbHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=aO1GLY0yp5PtPqxYb2Wsg/RJLy+hTKV9IPREWcUzJY5m6864ZW1KnxIjcpjoPXlOEAIwxkHLouw2ZrS8nAa2WabqFdTR8h542bkPwPmmIVfKtYxYuC9LmT1HUCH1W6kXymkpRWUmpQzXjlgeKfCxqF8gQACMvIl30WBmU2FOXuE=
Received: by 10.210.133.2 with SMTP id g2mr10206519ebd.47.1211444211563;
        Thu, 22 May 2008 01:16:51 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.143])
        by mx.google.com with ESMTPS id d23sm21344492nfh.11.2008.05.22.01.16.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 May 2008 01:16:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4M8Gp5l022702;
	Thu, 22 May 2008 10:16:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4M8Gmp5022699;
	Thu, 22 May 2008 10:16:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v63t7xgdg.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82604>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > What you *can* do is:
> >
> >  - rename the branch to something that includes a slash (aka 
> >    subdirectory). Let's call it "frozen/mybranch" as an example.
> >
> >  - do a 'git gc' to make sure that branch is in the packed refs file.
> >
> >  - make the subdirectory of that branch is unwritable (ie just do 
> >    something like "chmod -w refs/heads/frozen")
> >
> > and now the filesystem permissions should mean that you can't actually 
> > update that branch any more, even though you can read it.
> 
> Hmmmmm... and deleting of the branch would take the same lock used for
> updating, which is under frozen/ directory, so that is also safe.
> 
> That's sneaky.
> 
> I'd however throw that into "happens to work, unsure if we would want to
> promise supporting it as a _feature_ forever" category.

Another solution would be to make it lightweight tag, i.e. change if
from refs/heads/somebranch to refs/tags/somebranch (by tagging, for
example).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
