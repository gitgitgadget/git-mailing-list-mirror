From: Lea Wiemann <lewiemann@gmail.com>
Subject: name-rev --stdin is slow
Date: Thu, 19 Jun 2008 23:10:12 +0200
Message-ID: <485ACB34.2020901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ROy-0002h2-3F
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbYFSVJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYFSVJp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:09:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:39477 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYFSVJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:09:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so491191fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=hLItAEFYE4sHBdsb+5qzed5xVhwMYv87xyoiCW7hF8w=;
        b=vBnBtRVnqxGuOrctm07lDUZvSP4eorE+HJHvRH8t9L4aVMJJVPBuhbe5GeJVNtrmvX
         ttgvlZBOHTX2gaxNK6MFrVRfGWkGU69CUEFCCmNVF+PjLQOx7zdePmoB5hYTExNkQs8R
         VuG3sfUGGByeX87w5SsRXC6fs2/cQWntMv5WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=v0vzIu4dMeMtni9C7fMkCD5xgzoiRZTxylC6q/ODMUjLpyhfVZgyjLhfbCQe6/oe4Y
         EBd8VXKHAftyKBctLMsooFKAr6/Afj30whu3cU2d5vvpxtGcpQzhFM1SqqbkmeHLubiQ
         iGoQyp0xUZvLKOo7y+4b2Bd+WYjWWQlSZeISQ=
Received: by 10.86.65.11 with SMTP id n11mr2703903fga.64.1213909779635;
        Thu, 19 Jun 2008 14:09:39 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.94])
        by mx.google.com with ESMTPS id e20sm1894105fga.1.2008.06.19.14.09.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 14:09:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85531>

name-rev --stdin has some really high start-up time.  The example below 
is on my git.git branch.  Is this unavoidable to make name-rev fast for 
naming high numbers of revisions -- i.e. is it about amortization? 
Still, 0.7 seconds seems pretty excessive, and on linux-2.6 it even 
takes 6 seconds.

Anyone care to look into it?

$ time echo HEAD | git name-rev --stdin
HEAD

real	0m0.748s
user	0m0.588s
sys	0m0.080s
$ time git name-rev HEAD
HEAD master

real	0m0.041s
user	0m0.016s
sys	0m0.028s
