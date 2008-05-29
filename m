From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] rollback index if git-commit is interrupted by a signal
Date: Thu, 29 May 2008 16:35:11 +0200
Message-ID: <483EBF1F.9000809@gnu.org>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org> <alpine.DEB.1.00.0805291341290.13507@racer.site.net> <483EAD69.9090001@gnu.org> <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 16:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jEn-0002qB-37
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 16:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYE2OfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 10:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYE2OfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:35:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:22525 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbYE2OfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 10:35:14 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2652309mue.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=trV7rjYiWdGEFJBve832v0LH0cgH1/9RwQ7Z20kgYvs=;
        b=Jj7gXtn2Llw0/XZVsHQK+IaoTBDAIV8UFVid5jXVFf3uKrh2SYW0W/yt8iNzO5r9bGQbl5/np2sy0ArneKMw+Snpmh3ygh4TofcdVvfC2RD/ZFqxQfyydDYGFtnIHwUmXwEg+wT+JeOxYbl0y5hmvYdKkq3JX6yJrRxTsLXoSAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=wbDYuR+Ov01vPuFFJALGd+czLNg2RfAydmpcHnhZCDtq9Os59QnTMTJkrPVQ7xMeCc06p2IEgj6q6zght9OHul29bY4APeREp1zhKyXSX0dvtneos/Ia2SD0RoLKeDVeWHtKD3JNy+iPp/K40cG3SakxxFIfbA3CN/z8EFgNY3A=
Received: by 10.103.22.11 with SMTP id z11mr2777554mui.83.1212071711129;
        Thu, 29 May 2008 07:35:11 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j9sm4459315mue.5.2008.05.29.07.35.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 07:35:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83205>


>> Without this change, there could be races between the time the lock file 
>> is created and the time the commit_style variable is set, leading to the 
>> rollback not being performed.
> 
> IMO it would make much more sense to _guarantee_ that the commity_style 
> variable is set before the index is locked.  It is feasible, and there is 
> no good reason not to do that.

No, it's not possible because the COMMIT_PARTIAL case first creates the 
index_lock and then the false_lock.  It would be curious at least to set 
the commit_style to COMMIT_NORMAL after creating the index_lock, and 
upgrade it to COMMIT_PARTIAL later on.  I contemplated that, and my 
patch is the simplest code that's needed and works.

Paolo
