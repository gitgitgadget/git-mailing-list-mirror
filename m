From: Alexander Gladysh <agladysh@gmail.com>
Subject: Bug: git add with absolute path fails if repo root dir is a symlink
Date: Mon, 27 Dec 2010 09:25:58 +0300
Message-ID: <AANLkTi=Mj3AdinC87Ys35fv9DpZqefiZXhPbHMLdmyPh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 07:26:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX6XK-0004S9-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 07:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0L0G0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 01:26:20 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53446 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0L0G0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 01:26:20 -0500
Received: by qyk12 with SMTP id 12so9154289qyk.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 22:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=OHgCdOXWpg0ov/IKDuv72SOpBpFmEcIYvJ+JeqHKOdY=;
        b=aSTK5/aervvz9hn0aa/oYPdfwxCm6yjFgBZkamKV2j9aaoK7u6zBU4ylru3gf+/Kyn
         F4Hoi0gcJMpfzKJXYv8DoVHaYiQ8AaPLOUVHX0ElzbKfUEat0shEju83hipU1usoBCTT
         CC+TcooNszZSkIGL/fwP/CdObLFUNc8HOMlO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=L9n1o4U8HpgYxXZ9miEk0QKPR0N5Eb5FIEsnPSj/+cFGbKNNcKZibYywfmbknS/WmH
         Uf9RvT84Ao71NI4TfBf9kctBuDq+aJbR76EyXGOP2OFTq7eOjFagiMjN9MUqcnfg/Mzg
         IxAQct6nKyMLvqXA/5LU2m+gif+UeBHpCJudE=
Received: by 10.229.182.11 with SMTP id ca11mr2994848qcb.15.1293431178350;
 Sun, 26 Dec 2010 22:26:18 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Sun, 26 Dec 2010 22:25:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164212>

Hi, list.

Yet another issue with Git symlink handling.

I can't run git add with absolute path if the repository's root
directory is a symlink.

Please see the transcript below for details.

Alexander.

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 10.10
Release:	10.10
Codename:	maverick

$ uname -a
Linux ubuntu 2.6.35-24-generic #42-Ubuntu SMP Thu Dec 2 01:41:57 UTC
2010 i686 GNU/Linux

$ git --version
git version 1.7.3.4

$ mkdir myrepo && cd myrepo
$ git init
$ touch alpha
$ git add alpha
$ git commit -m "initial commit"

$ cd ../
$ ln -s myrepo mysymlink
$ cd mysymlink
$ git status
$ touch beta

$ git add ~/tmp/git-test/mysymlink/beta
fatal: '/home/agladysh/tmp/git-test/mysymlink/beta' is outside repository

$ cd ../myrepo/
$ git add ~/tmp/git-test/myrepo/beta
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   beta
#
