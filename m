From: "James Pickens" <jepicken@gmail.com>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 20:33:15 -0700
Message-ID: <885649360811131933webae91w134dce4c5c0ccf89@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <20081112173651.GA9127@linode.davidb.org>
	 <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
	 <loom.20081113T174625-994@post.gmane.org>
	 <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 04:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0pS4-0001rV-SF
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 04:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYKNDdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 22:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYKNDdS
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 22:33:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:1481 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbYKNDdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 22:33:17 -0500
Received: by fg-out-1718.google.com with SMTP id 19so983692fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 19:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9dNcf5kB/hJbXTwc8crjSCpEV+dyQld1yr61xYxoYnQ=;
        b=Zf3V/uvLVmU7UYRdEk36hPdHSTc+hWRRakqg7BL4A5C7BKxIkMxPcqv8dfgEW4Yts9
         rX/jv/L/fgX5Twumb1yeUAnuLcZcMRrUjsfGHsTbSWxLVIu1C0OesvcdjTwuJmUUsMLy
         Xh4GaRr93CWNSBHxzqkHcedH+sCXdCRW1J5kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J/G232MkToexhd7Yux5XX1yWh0F0zhekGJr7uO46KrD8R5NDIJnGR29FkMSl8+iLXR
         gGuiTjWgIgBpjURzbn6yTL8J1Nrg7cC18SHcA23QayJblGkokR/WsOpK1S8VtWZhXvQX
         VVqAskZmtF//iYXJX+XwqSd7KGix3ZfhimHDc=
Received: by 10.181.239.8 with SMTP id q8mr123848bkr.109.1226633595110;
        Thu, 13 Nov 2008 19:33:15 -0800 (PST)
Received: by 10.180.229.10 with HTTP; Thu, 13 Nov 2008 19:33:15 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100949>

On Thu, Nov 13, 2008 at 6:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  - maybe there are other users of "read_cache()" that want to do the
>   preloading. I just did "git diff" and "git status" (where the stuff
>   that "git commit" does falls out of the status changes)

I wonder if there are other completely different parts of git that could
benefit from multi threading when the work tree is on nfs?  I'm thinking
specifically of 'git checkout', since while testing this patch I
happened to do a 'git pull' that resulted in several thousand new files
being created, and the "Checking out files" part took *forever* to run.

And FWIW, I timed 50 iterations of 'git diff', and the average runtime
dropped from 11.7s to 2.8s after this patch.  A nice improvement.

James
