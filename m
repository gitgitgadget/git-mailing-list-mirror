From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git bisect code 125 - "WFT?"
Date: Wed, 16 Mar 2011 21:44:03 +0100
Message-ID: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzxg2-0006VP-6c
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab1CPUui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:50:38 -0400
Received: from mail-vw0-f52.google.com ([209.85.212.52]:47352 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1CPUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:50:37 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Mar 2011 16:50:36 EDT
Received: by vws16 with SMTP id 16so2476585vws.11
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=IEbof3LhmZIQ+4fMoPkoOHH2jXBCF3TW8/tw4JHoAqw=;
        b=tFk1E4gK9KL2tBBE4FjF9S6dp6UySP+Q9X0jS3Nw4AcxLbBe4iOjZ4nLxV+E9Fv61l
         DaGpMGQOdtOXd7KLWITpG6jGL+zdgkMNdzapctVsfRDGOFp2/jiET5UMBZC1CGnaPTD+
         9PnZGBsBaa6PFEaHfKVYPVbC516+c8U8CgAI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=D+ylS+ULrsHM9PY0E6vlFo5HP2+DNqCRymmJdlyYQIixaPGcZBUP4vkAJxNd6uPvKw
         7d4VLNzWYvKWVANgfsi0G/y6uixXIqFDDO3kp3CTt95H0Lfw7syozYstdhWmCVDS079S
         FE7GkhHuMIh+X9+4c2R1eKmlHh+wORzfxyh1E=
Received: by 10.52.178.164 with SMTP id cz4mr699152vdc.42.1300308243356; Wed,
 16 Mar 2011 13:44:03 -0700 (PDT)
Received: by 10.220.202.140 with HTTP; Wed, 16 Mar 2011 13:44:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169194>

Hi,

in git bisect exit code 1-124 and 126-127 means "source is bad"
(0 means "ok", 125 means "can't be tested" and anything other is "stop").

My first reaction was "WTF" - you have a special value in the middle
of a range??

It got a bit clearer after reading the original patch[1] and man bash. It seems
this value is last "free" value for the user to use, at least in bash - values
above 125 may be used by the shell.

Bash uses code 126 if command is not executable, and 127 if command is
not found.

I think it would be better to use 126 and 127 as either "can't be tested" or
"stop" (125 should be left as is):

   * It would not leave a WTF gap in the "bad" range

   * If you get "command not executable" or "command not found" it's more
     probable something is broken than the code is bad, and you should fix
     your script

Opinions? Would it be possible to change the meaning of the codes now
(in 1.8.0)?

[1] http://article.gmane.org/gmane.comp.version-control.git/62390

-- 
Piotr Krukowiecki
