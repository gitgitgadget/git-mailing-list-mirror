From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: rebase problem
Date: Sat, 17 Mar 2012 14:30:42 +0100
Message-ID: <4F649202.4080102@lyx.org>
References: <OF506B5658.3E449452-ONC12579C4.00460A6E-C12579C4.0047355D@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Mar 17 14:30:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8tif-0006m1-CU
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 14:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031051Ab2CQNaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 09:30:46 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34138 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030660Ab2CQNap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 09:30:45 -0400
Received: by eekc41 with SMTP id c41so2398374eek.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 06:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=NKhnmCW1iQgSs2H7WKX9ir4GeOjWD0n1zhS15pTpBHM=;
        b=ndH55uV7DTh9gsQAhiZgYgZe0UT8rGbsopTJrOvW1wB3VyGDq0CfBP4EwIK3OskYc/
         F+ryEuckllFhfvp6Qfx9L+zs6JlXO/vr70G/Q3RTF1QK2GM8svRoLDGAFtJivsCgIU2y
         88D9/sd6+OFc3ikgwu+bIfXurawtSyOgqco9eVeTieICYzTdrvU3lnrXlxVxjIHvVXHL
         nEpFaL6Vgz69wlPX2EiinnpQezKWkGSOd9CE0/5WzezUXlPcHecMFkdOhs/pto5rxaDT
         HsTkjSEWcLr2IO4XeR4oufRgHfvC0g/GUYZbjJCPeXinDMuvKWLt0EGidofATbPt6xz0
         yxgA==
Received: by 10.213.20.76 with SMTP id e12mr373163ebb.31.1331991044445;
        Sat, 17 Mar 2012 06:30:44 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id q45sm28801243eem.7.2012.03.17.06.30.43
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 06:30:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <OF506B5658.3E449452-ONC12579C4.00460A6E-C12579C4.0047355D@transmode.se>
X-Gm-Message-State: ALoCoQnSlX/s2GLUSpNuY3kGqWdDs+ihX82AaAlRm2SX1YnetKf/hO25vm7elSgPJdUv+VmhUaj0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193323>

Op 17-3-2012 13:57, Joakim Tjernlund schreef:
> A co-worker this on our local u-boot repo:
>    git checkout master
>    git fetch denx/master
>    git merge denx/master
> <resolve conflicts>
>    git commit
>    ...
>    git commit
> Now u-boot is working again
> then update to latest u-boot so:
>    git fetch denx/master
>    git rebase denx/master
> Now it is a mess, that rebase seems to start from way back as a
> staring reference, not from the last merge shown above.
> I guess I forgotten how git works, what did go wrong?
>
>    Jocke
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

The situation is like this:

  master - C - o - o - D - o - o - o - A
                      /
  denx/master- - - - o - o - o - o - B

Now, you ask to rebase master (A) onto denx/master (B). If master would 
have started from D, it would indeed apply the commits D -- A on top of 
B. In your case, however, master already had a lot of commits that were 
not in denx/master: C -- D  (including the merge resolution). So it will 
also apply C -- D on top of  B.

Vincent
