From: "Alexander E Genaud" <alex@genaud.net>
Subject: git-pull sets write bit, git-push does not
Date: Sun, 3 Aug 2008 00:32:41 +0200
Message-ID: <ee521d6f0808021532k66bc5b24ma2eeb51021fb5f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 00:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPPfV-0004PQ-7Y
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 00:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbYHBWco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYHBWco
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 18:32:44 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:10057 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbYHBWcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 18:32:43 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2347761mue.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=rM6P0Pnran/Z4CYw7KKruEuh1H6ajgeUAJBcOWtwN/s=;
        b=CfKyaM2VKAasO+mg7H2hu7pylvuXpCFZ/mSqCisCtgvxQ/gBGqaNvg7HW6ossuACPf
         x0RFDV+7jMH1XGs0nIP2NDdjecNYercdWe5KHxr2olA/UxC10XZ+WveXZRpCHbmrWNW4
         h5LCWwm2UlOqLjBmfnXHORrB5sgSIy+WbFXXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=KRv6tqVZOWQGrj9vrK5yH5ppkjK8nv0Z3EyyYwcAK0DILhqjeTYU6wCoAjNTAJKz6s
         2GCkxaCSKx2jEL315pYUXvMiJPo2X1mSDu9cJ1qTgiKq62zb2zjE4QJDCo12ievUzFNk
         zmeSn6bSXZI4FVTu47vs8spGSLzRaIHh/uimY=
Received: by 10.103.49.7 with SMTP id b7mr4824624muk.104.1217716361662;
        Sat, 02 Aug 2008 15:32:41 -0700 (PDT)
Received: by 10.103.8.1 with HTTP; Sat, 2 Aug 2008 15:32:41 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: e35ac61c5f3393ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91193>

git-pull sets write bit, git-push does not

Hello,

Background: I am using Git locally with ClearCase upstream. I
initialized a Git repository on top of a ClearCase snapshot view,
while my work branches are in a clone. As ClearCase is particular
about the write bit, I have come to depend on an undocumented feature
of Git. Namely, that git-push preserves read only permissions, while
git-pull sets modified files writable.

Can git-push be relied upon to preserve the write bit (readonly)? Why
is git-pull different? Is it a side effect of the plumbing?

Thanks,
Alex

http://genaud.net/2008/08/clearcase-globally-git-locally/


Simplified case:

echo --
echo create a repo r1 with files A and B committed
echo --
mkdir r1
cd r1
echo A > A
echo B > B
git init
git add .
git commit -m init

echo --
echo create an identical repo r2 whose files are readonly
echo --
cp -r ../r1 ../r2
chmod u-w ../r2/[AB]

echo --
echo push a modification of A from r1 to r2
echo --
echo AA > A
git commit -a -m modA
git push ../r2

echo --
echo pull a modification of B from r1 to r2
echo --
echo BB > B
git commit -a -m modB
cd ../r2
git pull ../r1

echo --
echo notice that pushed A remains readonly
echo while pulled B has become writable
echo --
ls -l


-- 
[ alex@genaud.net ][ http://genaud.net ]
[ B068 ED90 F47B 0965 2953 9FC3 EE9C C4D5 3E51 A207 ]
