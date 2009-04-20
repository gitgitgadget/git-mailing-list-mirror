From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 
	write_entry()
Date: Mon, 20 Apr 2009 14:58:49 +0200
Message-ID: <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
References: <49EC2F7C.8070209@viscovery.net>
	 <20090420110302.GB25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvt6n-00068H-Fv
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055AbZDTM6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 08:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbZDTM6v
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 08:58:51 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:64760 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbZDTM6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 08:58:50 -0400
Received: by yx-out-2324.google.com with SMTP id 3so758713yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KvaJjTvAj6TgJMenFHK+iOXIjaMizR9x3D62+z3zz/s=;
        b=cfu2XB28iJ1WV7KAUcJAMp7yv2Nf9yjHhGuf/oJzyi0v2sBkhMRtK0fS1QA+CbCMVU
         DUbXY7lok/2CkXd/aFSfWWqeKx/P2q5QYtp5A649ONX9RaEWbxbyxO/tUEsyqmIYc1pS
         v6QLqJWBQ9GvnhHliI7Ik2mPC9xT6e9QI1n9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=boOViXY8T5IDHXtQ5DLKpHA+6Y+9WSrrdcEic6BP0MvAanTsBer/rk6KtlBw2j0E6W
         aMycwLormKSXY4BX1wo+7aKem/+afT41i6xNPxvUWw1p+pKpA/uPVCyD5YGXAbnz3bQ2
         tm9ECgw9LRhC4yNmPx+TPWRAWDFU+m4hXJd84=
Received: by 10.150.139.8 with SMTP id m8mr1223705ybd.178.1240232329323; Mon, 
	20 Apr 2009 05:58:49 -0700 (PDT)
In-Reply-To: <20090420110302.GB25059@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116979>

2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
> The cygwin version has the same problem. (In fact, it is even worse,
> because we have an optimized version for lstat/stat but not for fstat,
> and they return different values for some fields like i_no). But even
> if we used the only Cygwin functions, we would still face the problem,
> because Windows returns the wrong values for timestamps (and maybe
> even size on FAT?). So I think the following patch should be squashed
> on top.

I just sent a patch with an "optimized" fstat. I see no problems (at least none
like these) with that patch. Timestamps match. Windows XP, yes. But since
that MSDN article mentions that it is not guaranteed, I guess I just been lucky.
