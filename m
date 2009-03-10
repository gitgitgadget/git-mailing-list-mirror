From: Jiri Olsa <olsajiri@gmail.com>
Subject: [BUG] - git-read-tree segfaults
Date: Tue, 10 Mar 2009 20:34:28 +0100
Message-ID: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 20:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh7kA-0002Ul-8A
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 20:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZCJTed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbZCJTec
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 15:34:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:48904 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbZCJTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 15:34:31 -0400
Received: by ey-out-2122.google.com with SMTP id 25so440878eya.37
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=g9oH5Y6XAVx7c9ZqyIRvbvOFvgLNX7eTGiyeCAXslcc=;
        b=sl1ZQ5ZcDBZ2RB4JYu9Y6cDdDy7MsZSMIngYWrUFS7pyma2wN8GQy3mQ7dWBE09RgX
         tJGwyPFzE6zHqy/TswCYNHdSnMoviGa4kgKwhooTlRqp8bQAoTQdd0CX1/fv6AUPzKbc
         QXQYXBWBzZkdTL5t0nnZO4DaMjGzpLYF28Z84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=woS88ex78mQU+ZaPm9apZYElCnBDvB884RUcuDB1rOUaHPewcjy8biljnG3SgGRqyd
         t66Oh9Js4vALSq2tQDcwcRdNZYRsErzzsfI1OsMOoJ4XB6ElPtP7Xjbc2pYSFcjWaTIh
         ItveHoEi3sl+akG/eB6SbtxGdvThc5OWpvqgU=
Received: by 10.210.88.3 with SMTP id l3mr4840813ebb.11.1236713668761; Tue, 10 
	Mar 2009 12:34:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112841>

Hi,

I was following the git core tutorial and git-read-tree got me segfault.
I accidentaly executed the git-read-tree without "-m -u" options and
got segfault.

I can reproduce with the latest git using following script.

-----------------------------------------------
#!/bin/sh

GIT=$1

rm -rf crash; mkdir -p crash; cd crash
$GIT init
echo "xxx" > xxx
$GIT add xxx
$GIT commit -m "xxx"
$GIT checkout -b yyy
echo "yyy" > yyy
$GIT add yyy
$GIT commit -m "yyy"
echo "yyy1" >> yyy
$GIT commit -a -m "yyy1"
$GIT checkout master
echo "xxx1" >> xxx
$GIT commit -a -m "xxx1"
mb=$($GIT merge-base HEAD yyy)
$GIT read-tree $mb HEAD yyy
-----------------------------------------------

regards,
jirka
