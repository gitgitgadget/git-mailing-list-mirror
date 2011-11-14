From: Erik Carstensen <mandolaerik@gmail.com>
Subject: mergetool's test for rerere seems to be incorrect
Date: Mon, 14 Nov 2011 21:26:18 +0100
Message-ID: <CALeBojRuZP3dbEs=rPX1E5p=oD43_yJO_Ec=Pe2SRpjG-rH2Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 21:26:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ36n-0005tn-L8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab1KNU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:26:19 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38992 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab1KNU0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:26:19 -0500
Received: by ggnb2 with SMTP id b2so6580790ggn.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=anJltGZW+GUCW6m7ieQtn+BAebrizaN1FMpPHIRpbs0=;
        b=HZ6WNkbwRBXeAP3sol43cTPf3sDUt0B3pz4DhnXDGhvLGqYlB6zy7V23FkWqmmDAju
         +R8EJZAgBd+jKjQR9hMruqDCtg6NgzYoeSAvNByaeKu8+WSFUcYZgYlYOOwZ3LZzXNNo
         kxbDJYwCbBL+ktbzaO1PEENGf6fc//L3yNep0=
Received: by 10.101.177.9 with SMTP id e9mr2339019anp.152.1321302378401; Mon,
 14 Nov 2011 12:26:18 -0800 (PST)
Received: by 10.100.143.19 with HTTP; Mon, 14 Nov 2011 12:26:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185398>

Hi,

Occasionally when I use mergetool in a conflicted state ('git status'
says it's a conflict), nothing happens.

By bisection I found that bb0a484e985ef8d9bbbbeb172b1fcf4982634bef is
the offending commit.

I have rerere.enabled unset, but I did find an empty file MERGE_RR in
.git/, which explains my problem: mergetool chooses to use rerere
because it finds the MERGE_RR file, but rerere just exits silently
because it's not enabled.

Wouldn't it make sense to restrict mergetool's use of rerere to the
case when rerere.enabled is set?

I'm also a little confused about why the MERGE_RR file appeared there
in the first place. I can see that empty MERGE_RR files, with
different timestamps, have ended up in various other of my git
repositories as well. I never used rerere in these repos, and the only
non-git tools I have used for version control are stgit and kdiff3.

Erik
