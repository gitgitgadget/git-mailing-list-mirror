From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: git worktree fails to recreate existing branch even with -B
Date: Tue, 9 Feb 2016 17:54:01 +0300
Message-ID: <344AE670-BF9A-4779-AFB0-50B870E1D488@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 15:54:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT9gI-0003PA-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 15:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbcBIOyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 09:54:08 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34557 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbcBIOyH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 09:54:07 -0500
Received: by mail-lf0-f48.google.com with SMTP id j78so116952490lfb.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=CyplzirmWwOhG4BnwX13+lNXShJZX9FDvZwNhox6Ppg=;
        b=nanMYn6q0HQc7oiOsrXMdVb98Rx0YUYWF0rhZ+g7Oryw++lCAN1pihF8XK8OUHXk0f
         2CCwqNlLXRH1B39zpwyteoJsuD6WqR4cOJFWsWU20eHV22xXXEyuaIE0qJxgYtxColhE
         IodJx3WVY2HgsDcYqVatptn5zpa/6ukvtPX+O1NIZtjmqHd+6alVuLyEBvTiqxRXqX9z
         LiUXygssvZhi8Iuo84bYcfRfxiFIxKVhoBkO0NuQjCYr3ykKf/6RPdlBS3nEHBCHUe7L
         LgLueCFYfuayyHNX7mSeNf4xqAbVier4wh3trdNmbjdZjHAgj9dRKSNs+KBM0Qruobam
         Gyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=CyplzirmWwOhG4BnwX13+lNXShJZX9FDvZwNhox6Ppg=;
        b=CUexoUxfpOWp976qR8oMhnd6ZkmLs+wnFIMOlmNGfoxPMH3YkwTfFhQQGvT6qIitXT
         pAYs382iwPmt8rJbWSLszCTUtuU8RmzF4vrap/6BNGZRXK78VCMh7kmExPEg7pDBoYTN
         pHgc97Id1adfsiN4ZMn5ufPrCvbnuBO6pv0SZuGrOCAdogLtkpWGS1IJh0SEE1FQddqH
         tSvUh4rtGt1RrWCjwRjoq0WCC/2TRGJqXsJnWAFUYxnODIZJhNy1RIUgzee44wpyXDwS
         EnLpL3ZTN62m5BNz3ucQb/YVXSCz7oMEy0SO/1JYUigEGWcXEsR7qL26kMBY2YHcoDQL
         uT3w==
X-Gm-Message-State: AG10YOSsFYTpo+LLWmVxoeneoI5RPBPn1CLqQ5yi3ZGXAxsWOKwOQRxltNhv1ept1nuXKh79
X-Received: by 10.25.218.137 with SMTP id r131mr11489800lfg.63.1455029644368;
        Tue, 09 Feb 2016 06:54:04 -0800 (PST)
Received: from loki.times.labs.intellij.net ([217.148.215.18])
        by smtp.gmail.com with ESMTPSA id v140sm451260lfd.24.2016.02.09.06.54.02
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 06:54:02 -0800 (PST)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285838>

Git doesn=E2=80=99t allow me to execute=20
    git worktree add -B <branch> <path> <start-point>
where <branch> already exists in the repository.

The command prints the following:
    Preparing <path> (identifier <branch>)
    fatal: Refusing to point HEAD outside of refs/

I=E2=80=99m trying to create a worktree on an existing branch <branch>,=
 which should point to <start-point>. This obviously should fail with =E2=
=80=9C-b=E2=80=9D, but I use =E2=80=9C-B=E2=80=9D and expect it to be r=
eset to <start-point> as mentioned in the docs:

    By default, -b refuses to create a new branch if it already exists.=
 =20
    -B overrides this safeguard, resetting <new-branch> to <branch>.

Do I miss something or there is a bug?

Steps to reproduce:

git init wt
cd wt
echo 'asd' > a.txt ; git add a.txt ; git commit -m initial
git branch br1
git worktree add -B br1 ~/temp/br1 master

Error message:
Preparing /Users/loki/temp/br1 (identifier br1)
fatal: Refusing to point HEAD outside of refs/

Thanks a lot!
-- Kirill