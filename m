From: Timur Tabi <timur@freescale.com>
Subject: Treating similar blank lines between hunks as part of the hunks
Date: Thu, 26 Aug 2010 15:19:59 -0500
Message-ID: <AANLkTikZFYSSNMENC5SmKSVt49a+WxXdO0mP=V7Mbi-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 26 22:20:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooive-0007YX-Se
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 22:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab0HZUUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 16:20:01 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41071 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab0HZUUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 16:20:00 -0400
Received: by gxk23 with SMTP id 23so817030gxk.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=WncJugESyiQUJPlcvBz9hd8Ikk05J7HHbtSSZCCyNmw=;
        b=H/aw6XzUpvKXtQCBEfcA8t2wQeE0I7WlHXQlUvHAwno4n0pcGz+MhYUCyTlAC8Wn7t
         QIA7iLgDtSx+LdK3HYLDp4SqRgFfkIwZ7x1bkm1oHH+NKhdoFbrk5zzwq+/VPpGlH+ef
         59DLWfrPWguCEYH1cooxZOrCNI05k2zTTmykw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=wYOU8+lrCyRjYk9JmWs0SInAhAQYtQdFT/aOUQ0+271udb8eSRJyNXxEoObSEcaS4s
         5UGfnq0VX+LX6HeDP6y2QpcGD4VY5ST1JjVuJ/wO25PmaNzOliv6AXmVgpnNI92hnIqK
         lHBWtAQ/8DH2NM/uSVNxcTDv0rkmt8biENwMY=
Received: by 10.151.21.18 with SMTP id y18mr739671ybi.296.1282853999170; Thu,
 26 Aug 2010 13:19:59 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Thu, 26 Aug 2010 13:19:59 -0700 (PDT)
X-Google-Sender-Auth: K3iUqyoU8rAuPy5cdbzQNG11T8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154559>

Is there any way to convince git-diff to treat blank lines between two
hunks as part of the hunks for diffing?  That is, if I have these two
files:

-----
A
B
C

D
E
-----

and

-----
A
F
G

H
E
-----

git-diff will do this:

 A
-B
-C
+F
+G

-D
+H
 E

Instead, I would prefer it did this:

 A
-B
-C
-
-D
+F
+G
+
+H
E

This second diff is easier to read, especially when the number of
hunks is large, but the size of each hunk is small.  This can happen
in source code when one function is replaced with a completely
different function.  Git sees the blanks in each function as being
common, but everything else is completely different, so the diff is
unreabable.

-- 
Timur Tabi
Linux kernel developer at Freescale
