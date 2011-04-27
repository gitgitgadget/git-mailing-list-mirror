From: skillzero@gmail.com
Subject: git sparse checkout exclusions not working?
Date: Wed, 27 Apr 2011 09:35:07 -0700
Message-ID: <BANLkTinPg_jaxiF8yFtnf4BrT4fx-BQ=+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF7hs-0000QF-O5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 18:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab1D0QfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 12:35:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37579 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab1D0QfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 12:35:09 -0400
Received: by bwz15 with SMTP id 15so1530729bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=TD2ReKKqJ4fX+aRwdTCYmyfcTRuauNKrVMYGRXHE3vQ=;
        b=MTQyRQUFXYqBwYc0fLXYu5mthyUxkXvxTyxE5g939cj6lMWnz/pZ7llpzz4fxk8q7W
         snZeL3R7xEOQxO86xK/uMhfJ3BKAyb/m5OeHD0aFos1saQcOGVwapMuiupbTCTKhFr/3
         5kWNL2IIOCIqQuuDIfriuKnZ2XwulwDuIuseU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Nk+2ofliwLRy3gxv7mIrhteZE7TuK0fptL9S1r2Cicr12Q//6DtSVm6mcwH+6wQizy
         2lx4b/fijEzJPcKhegpxJ6O7ImCKx4ENO56IZpYenQU0qqvxe4pE6sTwJiKMhYGzRvRZ
         vbbSCcx+Difw529bLZIn9gfsiy4C6kSe8mzNM=
Received: by 10.204.47.103 with SMTP id m39mr1664110bkf.4.1303922107709; Wed,
 27 Apr 2011 09:35:07 -0700 (PDT)
Received: by 10.204.121.79 with HTTP; Wed, 27 Apr 2011 09:35:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172242>

It seems like ! patterns in the sparse-checkout file don't exclude
individual files in a directory. Here's what I did:

git init
mkdir test1
echo "test1" test1/file1.txt
echo "test2" test1/file2.txt
echo "test3" test1/file3.txt
mkdir test2
echo "test2" test2/file1.txt
echo "test2" test2/file2.txt
echo "test2" test2/file3.txt
git add .
git commit -m "test"
git config core.sparseCheckout true

echo 'test1/' > .git/info/sparse-checkout
echo '!test1/file2.txt' >> .git/info/sparse-checkout
git checkout master --

The end result is like this:

test1
test1/file1.txt
test1/file2.txt
test1/file3.txt

The "test1" directory was included, but "test1/file2.txt" wasn't
excluded even though I added a ! pattern for it. The test2 directory
was correctly excluded so that makes me think sparse was working in
general, but just not respecting the ! pattern in this case.

Is this a bug or am I doing something wrong?
