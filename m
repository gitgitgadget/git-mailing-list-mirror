From: "Marco Costalba" <mcostalba@gmail.com>
Subject: git-log: --topo-order speed-ups the thing !?
Date: Tue, 17 Jul 2007 21:13:17 +0200
Message-ID: <e5bfff550707171213m5969e436yf4db83c44a1c8c42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 21:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAsU6-0001lS-Vf
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 21:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbXGQTNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbXGQTNU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 15:13:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:3140 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbXGQTNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 15:13:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2103026wah
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 12:13:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PmE+S2pKdmtff7TcLv/PoBGOCztTvoKQNR0hzslaHo6n9KUAypknPRSqDl0gpDCXcBPixTSsUSy7IMIgGUgB0gFDPAaOCUGIZd8Bde5X8J98UDZrG0KCIMz4WPGsUQeXNU3NwOVUIS+eE2Ej6L+6yIexUCEutqnrcfMXEaSuqBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gwAzAL7u9VVmFLftLcCgxB9TZftuaERPwiRt2FvpjP7Bkvn2/qNDzTrRZjhmm8a46xfZLx1dAJ+JEkyCwjqUBgRF1Lnbo4MD5J9g7MkKX1mtknqj1Gkfa0JnvzA0/ByBXGy0grJT39LH395uLvhb6NlWKrfH7xcGup0Oxs0X00A=
Received: by 10.114.95.1 with SMTP id s1mr701044wab.1184699597237;
        Tue, 17 Jul 2007 12:13:17 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Tue, 17 Jul 2007 12:13:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52792>

Testing with git log performance on Linux tree I found this
interesting and unexpected result:

$ time git log --parents --boundary --pretty=raw -z --log-size
--topo-order HEAD > /dev/null
6.85user 0.20system 0:07.05elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+21142minor)pagefaults 0swaps

$ time git log --parents --boundary --pretty=raw -z --log-size HEAD > /dev/null
7.01user 0.09system 0:07.10elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+11128minor)pagefaults 0swaps

Although page faults are more or less the half, execution time is
faster _with_ --topo-order option.

Someone could explain why?

Thanks
Marco
