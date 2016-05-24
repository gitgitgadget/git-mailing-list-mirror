From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t7800 test failure
Date: Tue, 24 May 2016 17:53:25 +0200
Message-ID: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 17:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5EeB-00042n-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 17:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbcEXPx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 11:53:27 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34094 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbcEXPx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 11:53:26 -0400
Received: by mail-yw0-f194.google.com with SMTP id j74so2850145ywg.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=AXdBdx47cGJObs04zdJMGTJZt+XEV1hz4UC2kjf9bgI=;
        b=RNt27J2gr+kMZruYPKWLgVgan5/GmtVRafi/HguwwJjO9JcoL2FZKYFKo5a/S1qY8H
         xJEFwXyjny6sZzH2NY+Y5z1TCs6/iJykk2yiVQEMN7/MbPNuoj/dTUV2MkmssF3jRcwx
         c6g0ceG5MYveQUCj+jbEZKU9lXEGwxMDj7EyihDfIj7fKbyKXRHXYMRGczzI+0gQCRZ6
         XNT1G2/woWqysGa/d0EPnLh4R64T9wfW4p11LMvbBPp+QKuR4J38RQ134gX1pqvPUREU
         h9GupmvOK7qm0cSrQC62+fy9wrnjJLOwj0/1fDQfAl8JvEHzAZuHYGgRfQVeSGBqhkyk
         E2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AXdBdx47cGJObs04zdJMGTJZt+XEV1hz4UC2kjf9bgI=;
        b=VndIEVAvVJldFRtgmqLIKO0C3LQ5T5EiOYD6nSxuFSXdA2+b/SGt/cSptci2bERHQt
         Ylc0EFDIGsrWOZbsv7bTHdOaskap7zrdm+B3ByFkGYRwL+uRW/Q2JTlwkc5Sbf+aLt7A
         VBsXyneObVrDFXLT1guoTw/NXg0192myupCSQvQuMUTHPYmfKu2Zk5COLw1ItrQxQ97b
         D9wrbyD9Tx2SH3Yg+s6QWROi/r23m7/IJ4sS45llNOAMmGyK0ciBXD4XzW/9B4dyAoBU
         82leHiVFOnEtKAP8OHjIqqJE0M/p5HdPzBU27oh14ALs8pHP8eht8C3mWUojTiuDc1Lx
         qmcg==
X-Gm-Message-State: ALyK8tKApFkbfbJLTia5SUYjNbMn5ioDGr4ZK3vRmB2vc4PH76Gpl8WsBoDkZgFgc5/MVV8co3tEfckm8MJemQ==
X-Received: by 10.13.204.86 with SMTP id o83mr2708464ywd.168.1464105205586;
 Tue, 24 May 2016 08:53:25 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 24 May 2016 08:53:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295496>

t7800 fails on systems where readlink (GNUism?) is not available.
An easy workaround for the very basic readlink usage of this test
would be to use a shell function like this:

---
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ff7a9e9..be3d19f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -420,6 +420,7 @@ run_dir_diff_test 'difftool --dir-diff when
worktree file is missing' '
 '

 write_script .git/CHECK_SYMLINKS <<\EOF
+readlink() { ls -ld "$1" | sed 's/.* -> //'; }
 for f in file file2 sub/sub
 do
        echo "$f"
