From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 10 Feb 2012 10:42:22 +0100
Message-ID: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 10:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmzt-0001VI-18
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab2BJJmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 04:42:24 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48536 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752948Ab2BJJmX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 04:42:23 -0500
Received: by obcva7 with SMTP id va7so3538887obc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PyED9NExNUpylBtVn1nwK7RE98qsc3iAemnXB0Pa8xA=;
        b=T7K8zKOMiqy5K3dwfwK1K/nL8EtNvY/bHAy6f4EWHdTy1IafJJucTPNoH2GnEUDc+Y
         21WjeYKPr2wFwuUr3iHLhEbM+WrtSK1zneeGluSMMhdX5vylIxzUVWo92W73T5m8ubpK
         gcGjW/sL/ZxfEcHayvjWWZSQDYDui9wPViQ5E=
Received: by 10.50.45.195 with SMTP id p3mr1975843igm.2.1328866942715; Fri, 10
 Feb 2012 01:42:22 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Fri, 10 Feb 2012 01:42:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190397>

Hi,

I compared stating whole tree vs one small subdirectory, and I
expected that for the subdirectory status will be very very fast.
After all, it has only few files to stat. But it's not fast. Why?


With cold cache (echo 3 | sudo tee /proc/sys/vm/drop_caches):

$ time git status    > /dev/null
real	0m41.670s
user	0m0.980s
sys	0m2.908s

$ time git status -- src/.../somedir   > /dev/null
real	0m17.380s
user	0m0.748s
sys	0m0.328s


With warm cache:

$ time git status    > /dev/null
real	0m0.792s
user	0m0.404s
sys	0m0.384s

$ time git status -- src/.../somedir   > /dev/null
real	0m0.335s
user	0m0.288s
sys	0m0.048s


Repository/dir stats:

$ find * -type f | wc -l
127189
$ du -shc * | grep total
2.2G	total

$ find src/.../somedir -type f | wc -l
55
$ du -shc src/.../somedir | grep total
224K	total


$ git --version
git version 1.7.9.rc0.10.gbeecc

-- 
Piotr Krukowiecki
