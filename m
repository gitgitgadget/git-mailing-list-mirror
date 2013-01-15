From: Phil Hord <phil.hord@gmail.com>
Subject: --simplify-merges returns too many references
Date: Tue, 15 Jan 2013 18:12:59 -0500
Message-ID: <CABURp0q0nhka+ivrs3+m+3C1N+FfTq2zJ=1rWp34tfGNQ3b30g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvFhT-0004Bq-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934184Ab3AOXNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 18:13:24 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:62839 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144Ab3AOXNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 18:13:22 -0500
Received: by mail-vc0-f175.google.com with SMTP id fy7so725444vcb.34
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=47xYO0HxAjqot5jv3CE2o29V6B+05W7EqsUl5LaYPzY=;
        b=rBFPxFUljbVU8dJq2E4BP72TJJjw4wcqnU1Oe5me/vZE6ranmzdjs9QFQGBA9CIh7x
         Dit7xetooyQdE9ZKvC4p6lmehRuGmkrUzzg2eH/ZqMGCERd/Ptt6W/xeDrRNNoNB0RmG
         kWfNFx8lUUo2xvELy6ypXT+lBijKAQEreTQ9vzdDOf1gSgf0F7Gd9qeTuuAK783ADEjW
         OsOe+31UM129CQNQnlK/swjbzoG+BJllfuYYzc+g1XgqzeIyoaKJVC/T5M1o62VxuVsN
         m4of8oYLqx3++UqgGnE9VLZg2QHkpvmvB9FHqEyYs4+AZupQwOSNtq6QlfVRYahiGsgT
         XeaQ==
Received: by 10.52.71.174 with SMTP id w14mr93170704vdu.122.1358291599724;
 Tue, 15 Jan 2013 15:13:19 -0800 (PST)
Received: by 10.58.241.203 with HTTP; Tue, 15 Jan 2013 15:12:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213689>

I thought I understood the intent of the various history
simplification switches, but maybe I am still confused.

In git.git, I see three commits which touch stripspace.c:

$ git log  --oneline -- builtin/stripspace.c
497215d Update documentation for stripspace
c2857fb stripspace: fix outdated comment
81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory


With --full-history and also with --dense, I see the same three commits:

$ git log  --full-history --oneline -- builtin/stripspace.c
497215d Update documentation for stripspace
c2857fb stripspace: fix outdated comment
81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory

$ git log  --dense --oneline -- builtin/stripspace.c
497215d Update documentation for stripspace
c2857fb stripspace: fix outdated comment
81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory


But with --simplify-merges, I see _more_ commits.

$ git log  --simplify-merges --oneline -- builtin/stripspace.c
634392b Add 'contrib/subtree/' from commit ...
497215d Update documentation for stripspace
c2857fb stripspace: fix outdated comment
81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
610f043 Import branch 'git-p4' of git://repo.or.cz/fast-export
b4d2b04 Merge git-gui
0a8f4f0 Merge git://git.kernel.org/pub/scm/git/gitweb
98e031f Merge git-tools repository under "tools" subdirectory
5569bf9 Do a cross-project merge of Paul Mackerras' gitk visualizer


None of the "new" commits touches this file.  The man page suggests
that simplify-merges should result in fewer commits than full-history.

"       --simplify-merges
       Additional option to --full-history to remove some needless merges from
       the resulting history, as there are no selected commits contributing to
       this merge."


Am I confused or is git?

Phil
