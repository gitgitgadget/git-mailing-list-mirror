From: Gert Palok <gert@planc.ee>
Subject: pulling the root commit overwrites untracked files without warning (1.7.2.3)
Date: Thu, 21 Oct 2010 16:18:19 +0300
Message-ID: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 15:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8v2y-00087S-La
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 15:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab0JUNTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 09:19:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54615 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757955Ab0JUNTC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 09:19:02 -0400
Received: by wyb28 with SMTP id 28so5102116wyb.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=E1DuSGawAv0Xo5Su4WO0gNgVFDOwjKOoXHoPeZlwBeU=;
        b=XulCl0MtBodE6zXZgP0+81YhZauu2xasJQesBGe/HK9uzH6Bj2X4uRg8A+Bx1sI+S2
         Un+jbAYIYU/ezeIJ9n+zH5ih88dUhKCynpmPTx0Nl48Lfms2AW98S16zMaPo6p5rtOZw
         ZLEhQ49SchTK+7mXYtxDkaI/bj99teH7K+Y1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=aLrrDmY4Acbc1A+HKSurR6MlM0bzDZ5ejQZd/Ds0pdF00Q17/KkcaQM5Yje+k934po
         53fGdo0olQZcMnA4wHhSkJTIPWv0YlrQ6BclPwdLIkWA/HY+aIab5QCjv4NgHRp0dUMd
         OsIy3RADIamwvCC47FOb568lpj69NIDwj2MTc=
Received: by 10.227.146.198 with SMTP id i6mr1139473wbv.65.1287667140111; Thu,
 21 Oct 2010 06:19:00 -0700 (PDT)
Received: by 10.216.52.4 with HTTP; Thu, 21 Oct 2010 06:18:19 -0700 (PDT)
X-Google-Sender-Auth: JTrbIVcFaQ6hPEtTvVjY7wwhSvo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159503>

Hi

On 1.7.2.3, pulling the root commit overwrites untracked files

Minimal working example:
$ git init wc1
$ cd wc1
$ echo a > a
$ git add a
$ git commit -m "added a"
$ mkdir ../wc2
$ cd ../wc2
$ echo b > a
$ git init
$ git remote add origin ../wc1
$ git pull origin master
$ # expected: error: Untracked working tree file 'a' would be
overwritten by merge.  Aborting
$ # actual: no error
$ cat a
$ # expected: b
$ # actual: a

An excerpt from the session:
gert@planc ~/test/wc2 git[master?]
768$ git pull origin master
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From ../wc1
 * branch            master     -> FETCH_HEAD
gert@planc ~/test/wc2 git[master]
769$ cat a
a

-- 
Gert Palok
