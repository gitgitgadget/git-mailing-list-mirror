From: Nick Muerdter <stuff@nickm.org>
Subject: Permission denied on home dir results in fatal error as of 1.8.1.1
Date: Fri, 8 Feb 2013 17:40:19 -0700
Message-ID: <CAECnihxpvtE1XejzHDCRBF=GkyBHmb53WDLa16Suiq=4SeYzvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 01:40:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yUk-000734-G4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab3BIAkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:40:21 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58145 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab3BIAkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:40:20 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so1617796qcs.20
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 16:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type:x-gm-message-state;
        bh=NnMZqYs8GKlVvlqCgnaELV8GCTvweST9KVazXe5fBfs=;
        b=Zt26Xu+vedPDRmA8Z4scVE1Ol+LasOefsnX1dod1fnpIXDcq39vfg0amoiUDu8T6Hf
         UhPk5P6t5prG70qPsXCJYKQtsuiWcDTX9S+4HWmPQ6R5UOxrumtpnwnDMBU5phvBCUlD
         iCIegWOx4OrQJlWKnnOKtedHD9PiTm3DnNuv38EvojZCH1172j9+UZlk79MaYjYUCJGU
         qYYCLscILWO+IJqgBs4aQYlMUk/PT1al2g5gcWxr4ptlvt5Zmxq1RrO2VCwR95Sau0sW
         UwLNqbgb3wAhMmv+tQdKIu4JNvFmVwm9HwNQ/cRAyIL88pZV/LSJSSNjvGo0buU5hQ1P
         ahog==
X-Received: by 10.229.206.89 with SMTP id ft25mr624950qcb.27.1360370419703;
 Fri, 08 Feb 2013 16:40:19 -0800 (PST)
Received: by 10.49.39.37 with HTTP; Fri, 8 Feb 2013 16:40:19 -0800 (PST)
X-Google-Sender-Auth: 3kmf1ebPOT-weW6j7JcWXuCbY6Y
X-Gm-Message-State: ALoCoQnbYItMy6raXPzHjnlRLBrmrZKnRhSr5FmTZ5i8WsqgdzijSbJf8S32eWWtpnRedm83UFls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215835>

As of git 1.8.1.1 and above (tested up to 1.8.1.3), if the home
directory can't be accessed, it results in a fatal error. In git 1.8.1
and below this same setup just resulted in warnings. Was this an
intentional change?

I ran into this in a situation where sudo is being used to execute a
script as root and then git ends up getting executed as a different
user. In this case HOME ends up being /root when git is called as this
different user. This home value is obviously incorrect, so there's an
issue there, but it would be perhaps be nice if this still just
resulted in warnings.

Here's a simple way to reproduce if run as a non-root user:

git 1.8.1.1 (fatal error, doesn't work):

$ env HOME=/root git ls-remote http://github.com/sstephenson/rbenv.git v0.4.0
fatal: unable to access '/root/.config/git/config': Permission denied

git 1.8.1 (warnings, but still works):

$ env HOME=/root git ls-remote http://github.com/sstephenson/rbenv.git v0.4.0
warning: unable to access '/root/.config/git/config': Permission denied
warning: unable to access '/root/.gitconfig': Permission denied
warning: unable to access '/root/.config/git/config': Permission denied
warning: unable to access '/root/.gitconfig': Permission denied
warning: unable to access '/root/.config/git/config': Permission denied
warning: unable to access '/root/.gitconfig': Permission denied
warning: unable to access '/root/.config/git/config': Permission denied
warning: unable to access '/root/.gitconfig': Permission denied
9375e99f921f428849f19efe2a2e500b3295d1a7 refs/tags/v0.4.0

Thanks,
Nick
