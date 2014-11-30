From: Pol Online <info@pol-online.net>
Subject: git status / git diff -C not detecting file copy
Date: Sun, 30 Nov 2014 09:35:51 +0900
Message-ID: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 01:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XusUZ-00076i-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 01:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbaK3Afx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 19:35:53 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:48356 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaK3Afw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2014 19:35:52 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so6055139qgf.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2014 16:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pol-online.net; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZhN6mLEjEaW+f1YIJsQCP/z56tN8/EUGzddIdFuQxyE=;
        b=dRTEHq3DLAN+mWP8F854B/A7VAIFf78ltshaZh5dyaiondyTUmwHDNafyocaE7bLSQ
         Jy/8DsPC55VTviQL0Hnor4tCMRw3Q9yJXAJbSddYk1/W+9V+fgP19bnrkjSNZoRoCHXY
         SvS24UcRNcyBZcH9W5ZhHs50JpG4hqeY8nYfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ZhN6mLEjEaW+f1YIJsQCP/z56tN8/EUGzddIdFuQxyE=;
        b=ks4fERJ/yZF3WZihIp5/rJ5k3JaCKFWNBNbGQIePvLLrkgxmNqND9zizNwJC9qmdZj
         1T1r4fHyD2JmcnCBom/2CmUwU7v7LbmHde/zy7GNFNRv8p8ol4RcyDz43z3iTTE65XEX
         rLuN+GbtjRTH8hR7LNj837D25rYXvoPzuSBXecg76P0sXdqx+J24b5XSLvEpEN0KRYpQ
         rrDnJidM9HYShd2qrM1iqiLAwa3fIs4cqW013jRpNrwUULgbnotH7ZmMF/pqWpflAJyZ
         NJVobtztyAgF+Kg7w0k2n82gg3zHANRTxmx5eKE+HjSN5sJNYWcx3e/xZEHSc1o6Nz1u
         JK9g==
X-Gm-Message-State: ALoCoQm+VeijAgWKBD7SD5Osg6GsXjYexqmlHQZPkLQrTcQqqyNjh1dqydq5hGkYTVzctTqtwNbJ
X-Received: by 10.229.50.135 with SMTP id z7mr21029465qcf.21.1417307751752;
 Sat, 29 Nov 2014 16:35:51 -0800 (PST)
Received: by 10.140.97.5 with HTTP; Sat, 29 Nov 2014 16:35:51 -0800 (PST)
X-Originating-IP: [221.186.131.72]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260381>

Hi,

The documentation for git status at http://git-scm.com/docs/git-status
implies that it should be able to detect both renames and copies (with
the R and C states). The command git diff -C should do it as well.

However I can't get either to detect copies in this simple test case -
what is happening?


mkdir test
cd test/
git init
echo 'Hello World!' > hello.txt
echo 'Goodbye World!' > goodbye.txt
git add -A
git commit -m "Initial commit"

cp hello.txt copied.txt
mv goodbye.txt moved.txt
git add -A

$ git status --short
A  copied.txt  <------------ NO COPY DETECTED
R  goodbye.txt -> moved.txt

$ git diff -M -C --summary --cached
 create mode 100644 copied.txt  <------------ NO COPY DETECTED
 rename goodbye.txt => moved.txt (100%)

$ git commit -m Test
$ git diff -M -C --summary HEAD~
  create mode 100644 copied.txt  <------------ NO COPY DETECTED
  rename goodbye.txt => moved.txt (100%)


-Pol
