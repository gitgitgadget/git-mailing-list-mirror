From: Christian Holtje <docwhat@gmail.com>
Subject: [RFE] git rebase doesn't say it failed
Date: Sun, 9 Mar 2008 23:20:48 -0400
Message-ID: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 04:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYYZx-0003wZ-Ij
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 04:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYCJDUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 23:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbYCJDUz
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 23:20:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:27151 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYCJDUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 23:20:54 -0400
Received: by wr-out-0506.google.com with SMTP id 50so682264wra.13
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 20:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=FijL0eO2UrEuoZe42LnK9qBZdbJc+puw0bqFK2Ongdc=;
        b=E/2JMcj3uG3EcJlIuPpE0QZ13ErfXiDT69ysHVD41ZaDs+8RIwl1O7l5MobBylxPEjw3J1hFMqAE8BnoMHOByvO2iXiDm4rQit9ocbHM7yqIw+Jftg8lOMxgw+ukSqCMU17cEExFZtCBthlJsKzxB/Ed0cs6IwuAKr0AxdX9E+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=oD/ptsrPSeaWWzLts8oC/D6brynJiIMCMux/hUk7IiS/C3YLxT7w4x9NJpqnYsFo0ipYjEI4ZYH0O5+18Q7GyStTRdJGRmJnbAcLYnE36MaI9RakQsmgIiTKskHQVdG7baycOc51GyQRdFoX2+IzXOKJtSKl6WiExXJccvz6dOc=
Received: by 10.150.49.15 with SMTP id w15mr2401522ybw.32.1205119251571;
        Sun, 09 Mar 2008 20:20:51 -0700 (PDT)
Received: from quicksilver.holtje.home ( [69.17.59.126])
        by mx.google.com with ESMTPS id l43sm9966330wrl.17.2008.03.09.20.20.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 20:20:51 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76694>

Hello!

What happened:
  I tried to do a rebase and got a message about files "needs  
update".  However, it didn't say it did a rebase nor did it say that  
it failed.
Example:
+ git rebase origin/master
f1: needs update


What I expected:
  It should have said that it was unable to rebase because of these  
files.
Example:
+ git rebase origin/master
f1: needs update
Git was unable to rebase due to the files above.  Please commit them  
or move them out of the way.
Hint: See "git reset --help" for a suggestion about saving work in  
progress.


Notes:
I have had several users at the company that I work think that these  
messages meant that it worked fine.  There are some commands (like  
reset, co, etc.) that show these kind of messages and it isn't an  
error; they were conditioned to think they were acceptable messages.

version: 1.5.4.3

Shell script to recreate the problem:
#!/bin/sh

set -eux

rm -rf a b
mkdir a
cd a
git init
echo 1 > f1
echo 1 > f2
git add f?
git commit -m "init"

cd ..
git clone a b

cd b
echo 1.5 > f1

cd ../a
echo 2 > f2
git commit -m "2" f2

cd ../b
git fetch
git rebase origin/master

#EOF
