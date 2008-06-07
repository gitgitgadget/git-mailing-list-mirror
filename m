From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-archive and unwanted .gitattributes
Date: Sat, 7 Jun 2008 22:21:48 +0700
Message-ID: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50Fj-0001QM-B4
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbYFGPVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbYFGPVu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:21:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:60989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156AbYFGPVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:21:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so985068fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Uln2cC0SxbO3sBZQsvcb5WxOIItMFqtnltYF1m+bjVw=;
        b=W9VUZYZ3KoQ1pkSlKnPbH/wO1mt/RG7V+ASO+DdNgYjLJGqbT9Wc7+o9ZV+jnJ+dxj
         XAx6MhGrqXBj/swI7uzdcdlbDKX0x2fqIoeqrMLYLHe8oDmnQxwukpCAMF9NBGka0Glr
         mqafCOTOjeM3dxb7105j5cg2vC10c/NqjlUOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=w8y2O5dkROgcIf6SvUjXyH0Y8IY8NtZPDSqGWqYkUmA7fW6sT07KUZsbEmWgIL6tV6
         t37VFOQkZzW9S6niqbFtm8nVenq6u01QoyHUD6P1oFc4CXdDTCrSox1eWgqKDaDNXC0F
         Q0HTyPECRmKjbih+6mkS5dlNlB3BxjyN2/Gkk=
Received: by 10.86.70.8 with SMTP id s8mr1948932fga.31.1212852108297;
        Sat, 07 Jun 2008 08:21:48 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Sat, 7 Jun 2008 08:21:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84206>

Hi,

Currently attr.c will read .gitattributes on disk no matter there is a
real worktree or not. This can lead to strange behavior. For example
when I do

mkdir a && cd a
git init
echo '$Format:%s$' > a
git add a && git commit -m initial
cd ..
echo 'a export-subst' > .gitattributes # let's assume this is an accident.
git --git-dir=a/.git archive --format=tar HEAD|tar xO a

I expect it to show '$Format:%s$', not "initial". git-archive should
not bother reading that .gitattributes. I thought an
is_inside_work_tree() check would be enough. Unfortunately, setting
--git-dir will automatically set worktree too. Any ideas?
-- 
Duy
