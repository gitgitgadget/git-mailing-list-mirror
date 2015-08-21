From: Kirill Likhodedov <kirill.likhodedov@gmail.com>
Subject: git log date filter behavior with --date-order
Date: Fri, 21 Aug 2015 17:56:18 +0300
Message-ID: <C06C0196-5DEB-4C7B-A714-48D009688342@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julia Beliaeva <julia.beliaeva@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 21 16:56:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSnkF-0002C3-W4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 16:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbbHUO4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 10:56:23 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33819 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbHUO4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 10:56:22 -0400
Received: by lbbtg9 with SMTP id tg9so45483726lbb.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=swT/tm/UMP2RmacPrhaXTjQVeY7wt+L03K1nP13nGJ0=;
        b=a2t6gAmVmFX4siqIlhKcsSZqj76Zw/JIhaMxcIa5f59xwftjacYBTOR3PolUb2s8qt
         GPjMWqVgZ3wlA4+a7kdFQzPsNcM9Wb3CLUtHhPKmm/T74TMEB9xBogLF3O18lrZppQLd
         jEbLCP2HvwoOuj9CXlyisJhKQRqUqGf6fMIIUBCz/OMzUTlwgj1GgTfIlQByTL3IgPp7
         hsMVh6NoA60qeqr/DhFIyouP5pL8AwxK4yvdEF9qrg0RdYa9zz/wSyTPwLv4znxx7NSe
         HZHjkBYKnXI/TqVyrgmdu/BGklTVB3RxRB/+lcdD2ZtXjS7wW5rRwNq6aHbHZFsOY+Ue
         rrVA==
X-Received: by 10.112.147.8 with SMTP id tg8mr8151352lbb.62.1440168981052;
        Fri, 21 Aug 2015 07:56:21 -0700 (PDT)
Received: from loki.labs.intellij.net (lagarm-2.ip.PeterStar.net. [81.3.129.2])
        by smtp.gmail.com with ESMTPSA id au10sm2364193lbc.1.2015.08.21.07.56.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 07:56:20 -0700 (PDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276301>

Hi,

I=E2=80=99ve faced a strange behavior when filtering git log by date.

When used with =E2=80=9C--date-order=E2=80=9D it gives significantly le=
ss results that when used without that option:

#  git log --pretty=3Doneline --remotes "--after=3DWed May 20 23:00:00 =
MSK 2015" "--before=3DFri May 22 00:00:00 MSK 2015" -- | wc -l
      85
#  git log --pretty=3Doneline --remotes "--after=3DWed May 20 23:00:00 =
MSK 2015" "--before=3DFri May 22 00:00:00 MSK 2015" --date-order -- | w=
c -l
      25

My assumption is that git log walks from the specified heads down to th=
e past until it finds a commit which commit date matches the filter. Th=
en it continues until it finds a commit which commit date doesn=E2=80=99=
t match the filter. Is it true?

Commits from =E2=80=9Cmatching=E2=80=9D and =E2=80=9Cunmatching=E2=80=9D=
 parts of the output are located in different branches which are being =
developed in parallel.=20
AFAIU the flag =E2=80=9C--date-order=E2=80=9D is meant to place commits=
 from different branches near each other, if they were performed at the=
 same time.

But when I looked both at the =E2=80=9Cmatching" and the =E2=80=9Cunmat=
ching=E2=80=9D commits in the whole `git log --date-order` view, I=E2=80=
=99ve noticed that they are placed really far away from each other (wit=
h about 4K commits between them).

Could you please give me a hint, why can git log --date-order behave li=
ke that?=20

I=E2=80=99ll be happy to provide more details if needed.=20

Thanks a lot!
Kirill.