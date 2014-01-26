From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 0/4] submodule: Local branch creation in module_clone
Date: Sun, 26 Jan 2014 12:45:12 -0800
Message-ID: <cover.1390768736.git.wking@tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 21:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Way-0002Yc-3d
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 21:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbaAZUqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jan 2014 15:46:12 -0500
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:40904
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215AbaAZUqK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 15:46:10 -0500
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id Jjm81n0011YDfWL5Fkm9ca; Sun, 26 Jan 2014 20:46:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta20.westchester.pa.mail.comcast.net with comcast
	id Jkm61n00k152l3L3gkm7TN; Sun, 26 Jan 2014 20:46:09 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id C8F89F1C335;
	Sun, 26 Jan 2014 12:46:05 -0800 (PST)
Received: (nullmailer pid 2836 invoked by uid 1000);
	Sun, 26 Jan 2014 20:45:23 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140117023746.GJ7078@odin.tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390769169;
	bh=wezSCohjI1tmA7hm/ay4HJsf3VuJg0avCaAiPHrJ5Oo=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id:MIME-Version:Content-Type;
	b=R648dhWhV6zkSqrrhA2/2noC7qCCZs2qy55kO8wVZwkHJc4sQ7/7oEjkIgtyA8J68
	 FEbUpVuuCY+9VIHUlPUeWym3ktBFwba1y5k32c+kGyeqyj1E8/T9c3pVI5KAbISwy0
	 Gn9hSagpSJ2xZEusYqzAang2+q8KbJJCwkcFgZMk+3Jx3lb8v5nt4OdsMficqH4tIp
	 JLyKu6aEgYuGhTHGHsmVT8KXsymfWRdhjmSwivzMVJzdV+p0S5QENDMOviG/qqZ7UV
	 hHxTWHs465YbKizFXlV34RvhhJUyDeo3xxhWChCkWAo7Pq5pWD0D+zwNg91XpAN3lN
	 Cd0QqXvYwxhHw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241112>

Changes since v4:

In git-submodule.sh:

* Explicitly set an empty $local_branch in cmd_add if $branch is empty
  [1].
* Restore die-early checking for invalid $update_module [2].  This
  check is now outside the load-from-config branch, ensuring we have a
  valid update_module, regardless of how it was set.

In Documentation/git-submodule.txt:

* Fix =E2=80=9Cbut be=E2=80=9D =E2=86=92 =E2=80=9Cbut can be=E2=80=9D [=
3].
* Fix =E2=80=9Ccheckout=E2=80=9D =E2=86=92 =E2=80=9C--checkout=E2=80=9D=
 [4].
* New text on why you'd use --remote [5] (new commit #4).

In Documentation/git-submodule.txt and Documentation/gitmodules.txt:

* Use backticks (instead of single quotes) for command line options
  [6].

I also squashed the implementation, testing fixes, new tests, and
documentation for the new local_branch stuff (v4's #3, #4, #5, and #6)
into a single commit (v5's #3) [7].

[1]: http://article.gmane.org/gmane.comp.version-control.git/240524
[2]: http://article.gmane.org/gmane.comp.version-control.git/240522
[3]: http://article.gmane.org/gmane.comp.version-control.git/240543
[4]: http://article.gmane.org/gmane.comp.version-control.git/240531
[5]: http://article.gmane.org/gmane.comp.version-control.git/240529
[6]: http://article.gmane.org/gmane.comp.version-control.git/240536
[7]: http://article.gmane.org/gmane.comp.version-control.git/240530

W. Trevor King (4):
  submodule: Make 'checkout' update_module explicit
  submodule: Document module_clone arguments in comments
  submodule: Explicit local branch creation in module_clone
  Documentation: Describe 'submodule update --remote' use case

 Documentation/git-submodule.txt | 46 ++++++++++++++++-----
 Documentation/gitmodules.txt    |  4 ++
 git-submodule.sh                | 89 ++++++++++++++++++++++++++-------=
--------
 t/t7406-submodule-update.sh     | 39 +++++++++++++++++-
 4 files changed, 136 insertions(+), 42 deletions(-)

--=20
1.8.5.2.8.g0f6c0d1
