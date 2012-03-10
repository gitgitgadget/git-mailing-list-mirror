From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 00:47:41 +0100
Message-ID: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 00:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6W1B-0008T7-II
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 00:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab2CJXsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 18:48:05 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50237 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2CJXsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 18:48:01 -0500
Received: by yhmm54 with SMTP id m54so1700552yhm.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=G5HBuQq7VYyjvqF7In+E+/y4qm6llBxEXvql0MPgigA=;
        b=aRl1SFykTwWjYkva/jv6IEivggNyXOQgeu9Fu3OdH3fBfbZJoN4cib53KqDJyIYiPi
         b0MVAWqmSLDQQ5O20mUOFEp/15R04Vjf+bAqHHxzT4K9aq6+mQ70mGiaqldA5smEAUbt
         fnB3Aqr7v/8BWHP+foTUf3M6QRVOI9h/iKqQXD+oVBhcRgLyjurt8BZ67DGkYEISRPFP
         NuVfiyy6PpJXPgripcz97vha427jvZaU48niCyCGYtq5jfK7ZcnfnOntEKmr90dUckk+
         0HFuJEO43ueSpjLnOStqt4CZKdmpr3V0ofjcXJVK0b2Ke9oRr7UAvDG1uEIYtBZpoJzB
         zjMg==
Received: by 10.60.3.138 with SMTP id c10mr2907348oec.72.1331423281156; Sat,
 10 Mar 2012 15:48:01 -0800 (PST)
Received: by 10.60.20.104 with HTTP; Sat, 10 Mar 2012 15:47:41 -0800 (PST)
X-Google-Sender-Auth: Bcg_nEJ9RmkoyoOrzljVv7F_HUY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192795>

Hi git devs,

I have a repo with two branches where some files are absent in one of
the branches. Say the two branches are <allfiles> and <somefiles>. Until now
I was using

$ git merge -s ours <allfiles> # with <somefiles> checked out

to merge commits which touches the absent files. But this clutters up
history and is very inconvenient to do sometimes. So when I came across
the possibility of using .gitattributes for file specific merge
strategies, I tried the following:

pattern merge=ours

However I get the following conflict message:

CONFLICT (rename/delete): org-mode-config.el deleted in HEAD and
renamed in 74288bb. Version 74288bb of org-mode-config.el left in
tree.

This file was deleted from <somefiles> in the past[1] and was renamed in
<allfiles> since the last merge. I was expecting this file to be ignored
(or in other words, merged with ours) since the .gitattributes file has
entries like these:

org-mode-config.el	   merge=ours  # new name in allfiles branch
lisp/org-mode-settings.el  merge=ours  # old name deleted in somefiles

I also see other new files in <allfiles> which are mentioned in
.gitattributes being merged in <somefiles>.

$ git status -sb
## somefiles
M  abbrev_defs
A  cpp-config.el
A  email-config.el                 # <-- this should be ignored
A  gui-config.el                   # <-- this should be ignored
UU init.el
A  keybindings.el
M  lisp/skeletons.el
D  lisp/text-mode-like-settings.el
UA org-mode-config.el              # <-- this should be ignored
A  text-mode-config.el

What am I doing wrong here? My git version is 1.7.7.6.

Thanks in advance,


Footnotes:

[1] There has been several successful merges since then.

-- 
Suvayu

Open source is the future. It sets us free.
