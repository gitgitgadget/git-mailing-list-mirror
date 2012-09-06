From: Jeffrey Middleton <jefromi@gmail.com>
Subject: approxidate parsing for bad time units
Date: Thu, 6 Sep 2012 09:24:02 -0700
Message-ID: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 18:24:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9esZ-00060R-GF
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 18:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab2IFQYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 12:24:23 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56756 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab2IFQYX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 12:24:23 -0400
Received: by vbbff1 with SMTP id ff1so1657044vbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jw+QOVTieO2D2m1Jaqje9vjdkqkh2omoU+XRdgzlGrk=;
        b=vWfvozhNgn0Zo0DNom3UzTSqvb7StuH0YRaOgFTLDVYtEJXuwxBS0cZir6+7YATxuN
         GdCRD94d4MPYa1oXw6hAXqCKqMnq4HMr5JoqoK/dS8o1E17gmTNuv41QwtM1yilTfZ4o
         dd0FCpWzfj6UsegvQz45jVVpSH28IhPqb7yD9vE07dVWzZ3Cq9UVBQP4D0Z3loqKdtEH
         lHMH4xKA+9Ik8ZEYO/3JhJUbAgXzMkwTADEzL0kMGfKBzs32/c/CIUqJY+WDommkQAy9
         gkV8p4kHGAA8XV4AIZrb71M4jYqZ690YGPd4QD07v1vpgpuUWvEmWWaLAgIUDdILAbOI
         jBMQ==
Received: by 10.58.151.197 with SMTP id us5mr3296781veb.14.1346948662397; Thu,
 06 Sep 2012 09:24:22 -0700 (PDT)
Received: by 10.220.26.3 with HTTP; Thu, 6 Sep 2012 09:24:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204901>

In telling someone what date formats git accepts, and how to verify it
understands, I noticed this weirdness:

$ export TEST_DATE_NOW=`date -u +%s --date='September 10'`;
./test-date approxidate now; for i in `seq 1 10`; do ./test-date
approxidate "$i frobbles ago"; done
now -> 2012-09-10 00:00:00 +0000
1 frobbles ago -> 2012-09-02 00:00:00 +0000
2 frobbles ago -> 2012-09-03 00:00:00 +0000
3 frobbles ago -> 2012-09-04 00:00:00 +0000
4 frobbles ago -> 2012-09-05 00:00:00 +0000
5 frobbles ago -> 2012-09-06 00:00:00 +0000
6 frobbles ago -> 2012-09-07 00:00:00 +0000
7 frobbles ago -> 2012-09-08 00:00:00 +0000
8 frobbles ago -> 2012-09-09 00:00:00 +0000
9 frobbles ago -> 2012-09-10 00:00:00 +0000
10 frobbles ago -> 2012-09-11 00:00:00 +0000

Which gets more concerning once you realize the same thing happens no
matter what fake unit of time you use... including things like "yaers"
and "moths". Perhaps approxidate could be a little stricter?

Thanks,
Jeffrey
