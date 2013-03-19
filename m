From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG?] rebase -i: edit versus unmerged changes
Date: Tue, 19 Mar 2013 15:07:54 +0530
Message-ID: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 19 10:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHt0G-000386-JC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 10:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab3CSJiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 05:38:17 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65516 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439Ab3CSJiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 05:38:16 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so217174iac.19
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=VphVo1xOTa05rMr6vYLKtah7i2FIC8c3hB3rICBn1fQ=;
        b=xrM3oo75gIWphh1w0GAgeFGFC1D1tHPfAj/08VDn8EiOeq3gL9i9TQZSvNKQmbKva0
         limT81IvpcKWvrbWpQ/4R2nti+sk5gwNGqL9gNq4+Q5XLpgu3ioj7Y9IIlOgHCyd2BWG
         Dt0t12LS2FmsfA9P4wMUi7CMm14jnmsbslgBe02sj9atVjsM3q3EvBNuCMHuiDKiDpsr
         15JVg3oVIJ6zHZpm5QPoOpCNYIL/wI/QxWEr690GDbtWZ0JRSQwB1Ilnah1sUpa3jdgA
         84UEoWpC+YBPidFkGxxTEXWB+Pm2w5Q3zIF52SKeP4n1cy5vtco80O2f/n9vjWG4L3iK
         ydMw==
X-Received: by 10.50.17.71 with SMTP id m7mr852344igd.14.1363685896057; Tue,
 19 Mar 2013 02:38:16 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 19 Mar 2013 02:37:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218490>

Hi,

I have the following instruction sheet:

  pick 2f7c86e remote.c: simplify a bit of code using git_config_string()
  pick c7f7ae4 remote.c: introduce a way to have different remotes for
fetch/push
  edit 7038841 remote.c: introduce remote.pushdefault
  edit 73413b0 remote.c: introduce branch.<name>.pushremote
  pick 7f47687 WIP: fetch-push: write a test

When I get to 7038841, I edit config.txt, stage the changes and commit
--amend, before executing rebase --continue.  When I get to 73413b0
(the next commit), I get a conflict which is auto-resolved by rerere.
So, I just make further changes to config.txt, and commit --amend
before executing rebase --continue as before.  Unfortunately, this
squashes 73413b0 into 7038841, because the merge conflict requires a
commit to resolve the merge and pick the commit; this is different
from commit --amend, which worked in the previous case, because the
commit was already picked.

I know that this is expected behavior, but is there an easy way to get
rid of this inconsistency?  I'd ideally like everything to use the
sequencer, and have uniform --continue/ --abort/ --skip semantics, but
that would require re-implementing all the shell commands in C unless
we can think of exposing a generic API using stdin or something.  Does
anyone have ideas in this direction?

Thanks.

Ram
