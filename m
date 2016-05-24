From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t7610-mergetool.sh test failure
Date: Tue, 24 May 2016 18:44:02 +0200
Message-ID: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:44:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5FRC-00065u-6r
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbcEXQoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:44:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36287 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbcEXQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:44:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id l126so3034008ywe.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=YRlgZDK+mTz/OHZJ5iG4nNHAuG8hGSTW5H1mGn3h2/Q=;
        b=G7i8cZTc2fSJeRaVEl+/rrkwp4RneGUauwD1yvZzT7wI14Es7q4hmxETRkewtEv4Rd
         9qjel38Y834/EI4pieA+5tFrXEVgXt1Ve+gRydL42++tfunNuldbdHV+vlg2ye6Mf9Gu
         9DhiUiqNhqKuIXjIcHBYlgkz+DarSN6fn60y8jipnnrKJ1IbVgaaeY3+9TneG2kG8bN0
         4tKZJKvwtDEcEJ3H/Wh47V8NGygkY75Dvw1vGoETaFScS/otU7h281Vf1ZHIXeC8Wgya
         u9GzxIy/kZ8zY3L82S3hl8CnewHYd7G+F3HWAfePMOv0+FsF8Yus2Ya1RnGwIWvZN6vi
         g+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YRlgZDK+mTz/OHZJ5iG4nNHAuG8hGSTW5H1mGn3h2/Q=;
        b=VRAK3qziXPHY4c7B9+0KPusyziVi6eYz6xPDSPCd6xsfmAgFw23Nipk1DhSdNP/qbL
         j/fmJstkTX/f+PagqAm/uZ3Vhg5QZwXHnP+2PUVQrcgESYVb3u+Yu4+nCn1l1b9pHwuU
         vsI5Q7t3+r7GvZUiprrU0VrMcZm8cjEGwlpOIFtBMoAXOJupnsbVf0Ol/YK+4cuZOWbF
         ++88uz94/XK5sAmmMQBRkKsgaGd5ckg3MEKiJHDxNah2yjFWM1go0Gcqsqo99AdugUzH
         k4Sd4pTYQhyoMU8idPZG0Gwe5h7YAXXR3kprt7dqq0kSGvQM7cyoxl40z7jXwNbmMVvD
         M6yg==
X-Gm-Message-State: ALyK8tLVMl8s0eMdV5gQxA9c2ba3jk9tNNNqANr4qsX5igsHE1vJsV7kF/9kkbBd1sNn5GhhkNA8m2wLqyv7Vw==
X-Received: by 10.129.92.4 with SMTP id q4mr3124467ywb.156.1464108242056; Tue,
 24 May 2016 09:44:02 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 24 May 2016 09:44:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295501>

t7610-mergetool.sh fails on systems without mktemp.

mktemp is used in git-mergetool.sh and throws an error when it's not available.
error: mktemp is needed when 'mergetool.writeToTemp' is true

I see 2 options:
1. code around it, write an own mktemp, maybe use the test-mktemp as a basis.
2. disable the test when mktemp is not available

>From my point of view option 2 would be enough.
Any opinions about that?

Peff suggested something like this... works for me.
This patch is probably whitespace damaged... I could not yet figure out a way
to use and preserve tabs with Google mail.

---
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 76306cf..9279bf5 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -589,7 +589,12 @@ test_expect_success 'filenames seen by tools
start with ./' '
        git reset --hard master >/dev/null 2>&1
 '

-test_expect_success 'temporary filenames are used with mergetool.writeToTemp' '
+test_lazy_prereq MKTEMP '
+       tempdir=$(mktemp -d -t foo.XXX) &&
+       test -d "$tempdir"
+'
+
+test_expect_success MKTEMP 'temporary filenames are used with
mergetool.writeToTemp' '
        git checkout -b test16 branch1 &&
        test_config mergetool.writeToTemp true &&
        test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
