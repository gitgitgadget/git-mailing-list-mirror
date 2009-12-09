From: Tony Risinger <sweetsinsemilla@gmail.com>
Subject: git init respecting GIT_WORK_DIR
Date: Wed, 9 Dec 2009 12:37:16 -0600
Message-ID: <96aa03fc0912091037o6b253f81u41fb660c1f8bf908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Tony Risinger <sweetsinsemilla@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 19:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIRPj-0001df-5Y
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 19:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZLIShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 13:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbZLIShL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 13:37:11 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:40864 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523AbZLIShK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 13:37:10 -0500
Received: by iwn1 with SMTP id 1so4772866iwn.33
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+V5aGi93IituJj2mSPHgbGj9xL4f3s1A+4zmYlm279c=;
        b=wETL/MGSR9XaIqS6QUMtrdD2PVWpxfLfp3Hv+ZVeBNvMQ/HxBdz1r0TnXCag9v43Nf
         9AvVLvRCedUZb2730nsZYvrABxT1ngWnJe23cB60IF5emJb0VHoH782duA4SRyYll5Cu
         8kNElje3rKWt+Mnx7vai2z5VtCvUofqtFTT9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=isENj1R83GlOxVrBOMfpJviBfI3sDxWObaqtJIrW/LtdoBS/DPuyENGTmtM9Lqf3Kw
         QyVDFLqUZmCTNeOlceNh9qvp66RgmJ4cACf8grjRbptHfRfLMRcYAWnMEkSdAjfmC4lF
         IrPn9zaX9tn/7UwmezNOLb/xcbKtKN9owz69o=
Received: by 10.231.21.157 with SMTP id j29mr759205ibb.28.1260383836428; Wed, 
	09 Dec 2009 10:37:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134991>

should this be expected behavior?

-----DOC

       core.bare
           (snipped)
           This setting is automatically guessed by git-clone(1) or
git-init(1) when the repository was created. By default a repository
that ends in "/.git" is assumed to be not bare (bare = false),
           while all other repositories are assumed to be bare (bare = true).

-----PROBLEM

[cr@extOFme-d0 ~]$ export GIT_DIR=gitdir.git GIT_WORK_DIR=workdir.work

[cr@extOFme-d0 ~]$ git init
Initialized empty Git repository in /home/cr/gitdir.git/

[cr@extOFme-d0 ~]$ git config core.bare
true

[cr@extOFme-d0 ~]$ git config core.worktree
[cr@extOFme-d0 ~]$

-----SUMMARY

i think git should not be so restrictive in what it considers to be a
bare repository.  when you use --work-tree:

[cr@extOFme-d0 ~]$ export GIT_DIR=gitdir.git GIT_WORK_DIR=workdir.work

[cr@extOFme-d0 ~]$ git --work-tree="$GIT_WORK_DIR" init
Initialized empty Git repository in /home/cr/gitdir.git/

[cr@extOFme-d0 ~]$ git config core.bare
false

[cr@extOFme-d0 ~]$ git config core.worktree
/home/cr/workdir.work

everything works as expected.  "git init" should respect GIT_WORK_DIR
env variable and set core.bare and core.worktree appropriately.
