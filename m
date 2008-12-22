From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Move-delete merge conflict is not displayed using git ls-files --unmerged
Date: Mon, 22 Dec 2008 17:29:02 +0300
Message-ID: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 15:30:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LElnt-0004qx-TM
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 15:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbYLVO3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 09:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbYLVO3H
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 09:29:07 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:50347 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYLVO3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 09:29:04 -0500
Received: by bwz14 with SMTP id 14so8093603bwz.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=TH8Fc+PHK6lPbNh5xfgpkTQi91HpwGy+GdHV2D9gEik=;
        b=iFtM8SAxVXXtyFiitFI3TC0LuwEJgQ1rA8Sexax2E7cstRy+NlFwDeeEJi3sqYmLZc
         EATJPsLADTTmWVoisDggxc8yfXT+d2asyQzyQJkCnz5ou/ssn7QAP+hIY1tOtyI1xj/j
         ndClb6hJfSyQ4lJFfW2gYSExhF/Y8ev0QefvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SxowXrdUdaxiwMCvjq8wbmioLeStLjAPH/GFvn+IYgjYSCsW8sc4hS8aOl68+X4nLG
         wbqLEjWVu8BUMKbReyxaDAMOMXnGJ2WT5Gf0cznPwJ3IUMyRkzyX2ZuGCVngTPgcGo49
         ++AEK8S8rYLUln2z8h7JBsqUKVQhkreo44HSo=
Received: by 10.180.241.8 with SMTP id o8mr2342403bkh.102.1229956142716;
        Mon, 22 Dec 2008 06:29:02 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Mon, 22 Dec 2008 06:29:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103756>

Lets consider repository state created with the following script (git
version 1.6.0.4).

mkdir test-move-delete
cd test-move-delete
git init
echo test1 >file.txt
echo test2 >>file.txt
echo test3 >>file.txt
echo test4 >>file.txt
git add file.txt
git commit -m "start"
git checkout -b moved master
git mv file.txt copy.txt
git commit -m "moved"
git checkout -b deleted master
git rm file.txt
git commit -m "deleted"
git merge moved

The last merge command fails with move-delete conflict.

CONFLICT (rename/delete): Renamed file.txt->copy.txt in moved and
deleted in HEAD
Automatic merge failed; fix conflicts and then commit the result.

However git ls-files --unmerged does not list any conflict in that
case and it is possible to execute git commit command right away
without doing anything with the repository.

I think that if git merge reports the conflicts, such conflicts should
be discoverable using git ls-files and prevent commit with resolving
the conflict like it is done with modify-delete conflicts.

Regards,
Constantine
