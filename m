From: Joe Einertson <joe@kidblog.org>
Subject: git-rebase + git-mergetool results in broken state
Date: Tue, 23 Feb 2016 16:44:49 -0600
Message-ID: <CA+hqKG8M97SEmejrdr-OC0yQc=ofY4yWej4gG_6B2jsqGq8imw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 23:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYLhS-0008AJ-S8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 23:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbcBWWoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 17:44:54 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34156 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbcBWWou convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 17:44:50 -0500
Received: by mail-io0-f169.google.com with SMTP id 9so5811171iom.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kidblog-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=XS9gRceLQGp69vwV47NGypRtRgOMXYXVaLNrQU4a5OQ=;
        b=KHmI7NsOqnlILRS663w2lCF4rHSCIa2VNHLccsg5HygGLbSR1gy7KihZmpKjcedT+Z
         3ohdyDP1l0rxSRSWqwgbrqjxx0vaS3JE7aZOFenqAR+W2zxFdiSuOH4ejuraHEYHn5wi
         FBBocx9kSV3HD6TT3nqUrbAUfpaLbKGscaojrJImAVV0L/UJ41RtPhz4GpcYsWR/F9ov
         PT/6NodvhywnodREQoldlyyxeDRO19Obt8weQJEfz5dtqyWeNZlk+QqIOpSdw/uI4/pJ
         JW3J+d3BPiEr3Fz5/nMXCdBUEHUmr0Y2ePoRZzVT2yrd58OsNhFQp/JP7WLTZXJrUgDz
         wGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=XS9gRceLQGp69vwV47NGypRtRgOMXYXVaLNrQU4a5OQ=;
        b=ErfmQvEAM9CcEe3PwWXY6L5g9T2IwZC69aqwc/ZlWAQrLxMENzvxPwj+tMIPJVKX9i
         EvOufVikNTHyd3ps4HUTg5YhQvJS+OiA5+z6fmpgELRyYs14otvJWGs39XuT1Q3g44v1
         MBP1JtJPNSz6dExCUK9smK2w3pziz8Xj4rkUZYK+x+q8DWso6WdXdCb4T3u0wk+1KHYy
         /13bDGHitLGWyYT3GCO7BC+Wao8Uz6XuwFoQIxezWMMXM6l6hE+p5A2yI1uC0+Ehbrxy
         BE8SqKrxEwZ57RQMxPKEUEkpeQgjxsBGf6lRqmOCLoukrytk2Qq/DQ3hzNLPLH8BA7oR
         skgw==
X-Gm-Message-State: AG10YORoZeycXsKIBzArqkJCbz1zAWHXdbILHCCeCzlB1I21PlBMRz58Sb/hmoqRD7fMH1C1d0t/h5XdQr5XkQ==
X-Received: by 10.50.60.34 with SMTP id e2mr14970069igr.77.1456267489396; Tue,
 23 Feb 2016 14:44:49 -0800 (PST)
Received: by 10.79.100.7 with HTTP; Tue, 23 Feb 2016 14:44:49 -0800 (PST)
X-Originating-IP: [96.93.247.174]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287135>

I'm experiencing an annoying issue which leaves the repository in a
weird, broken state. I am attempting a rather vanilla rebase, rebasing
the commits from a feature branch on top of the newest commits on
master.

So, I run a typical series of commands:
1. git checkout feature-branch
2. git rebase master (conflicts ensue)
3. git mergetool

The conflicts are expected, but when using mergetool to resolve them,
I encounter many "no such file or directory" errors.

mv: cannot stat
=E2=80=98app/components/mediaManager/kbImageEditor.directive.coffee=E2=80=
=99: No such
file or directory
cp: cannot stat
=E2=80=98./app/components/mediaManager/kbImageEditor.directive_BACKUP_1=
3615.coffee=E2=80=99:
No such file or directory
mv: cannot move =E2=80=98.merge_file_ogGjXX=E2=80=99 to
=E2=80=98./app/components/mediaManager/kbImageEditor.directive_BASE_136=
15.coffee=E2=80=99:
No such file or directory
/usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool:
cannot create ./app/components/mediaManager/kbImageEditor.directive_LOC=
AL_13615.coffee:
Directory nonexistent
/usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool:
cannot create ./app/components/mediaManager/kbImageEditor.directive_REM=
OTE_13615.coffee:
Directory nonexistent

This leaves weird dangling files like '.merge_file_ogGjXX' in the
repo, and I assume I should not proceed with the merge since it
couldn't even create the files to compare.

Is this a known issue? Is there any workaround? Is it safe to proceed
with the merge?

Thanks,
Joe Einertson
