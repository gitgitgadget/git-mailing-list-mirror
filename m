From: Bostjan Skufca <bostjan@a2o.si>
Subject: Configurable filename for what is now .gitignore
Date: Sat, 30 Aug 2014 05:33:01 +0200
Message-ID: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 05:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNZPZ-0006hd-AO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 05:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbaH3DdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 23:33:05 -0400
Received: from portkey.s.itsis.si ([78.47.12.76]:34446 "EHLO
	portkey.s.itsis.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaH3DdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 23:33:04 -0400
Received: from undisclosed (undisclosed [127.0.0.254]) (Authenticated sender: undisclosed) by portkey.s.itsis.si (Postfix) with ESMTPSA id 3187B80053
	for <git@vger.kernel.org>; Sat, 30 Aug 2014 03:33:02 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.4 at portkey
Received: by mail-ig0-f172.google.com with SMTP id h15so10556852igd.17
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 20:33:01 -0700 (PDT)
X-Received: by 10.50.164.202 with SMTP id ys10mr8540920igb.6.1409369581054;
 Fri, 29 Aug 2014 20:33:01 -0700 (PDT)
Received: by 10.50.218.174 with HTTP; Fri, 29 Aug 2014 20:33:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256207>

Hi there,

I created a patch which makes ".gitignore" filename configurabe.
Preliminary diff is pasted below.

My question is:
Would something like this be acceptable for inclusion?
(providing documentation and test cases will be done too, of course)

See "Motivation" part below for additional explanation.

Possible downsides:
- default filename .gitignore is kept, so there is no issue here, if
this new config option is not changed
- increased support questions, but I think generally people would not
change this setting without having a good reason


Motivation:
Git is great for tracking code development, but when deploying
mentioned code by using git itself, various configuration files must
be created additionally, which are normally .gitignored, for various
reasons (code portability, sensitive data, etc). There is currently no
simple way of tracking changes to those critical configuration files
(at least none that I am aware of).

One way to approach this would be tracking those changes in separate
git repository. It is possible to create this second repo outside of
code repository. But this gets messy very fast (you still need to
create symlinks in code repository, or sth).

It would be splendid if this configuration tracking repository could
be created inside code repository, but in a "separate namespace".
(I've just found out that "namespaces" word is already used for
different concept in git 2.1.x, so let's call it "dirspace" in this
discussion).

Separate dirspace is currently possible for ".git" directory via
GIT_DIR environment variable. Adding possibility of using
differently-named .gitignore files is first step for dirspaces,
.gitmodules and .gitattributes are another two filenames that would
need to be made configurable.

I can imagine a tiny tool, let's call it "gitsth". When called, sets
GIT_DIR from .git to .gitsth, and in .gitsth/config configures
alternate filenames for .gitignore, .gitmodules and .gitattributes to
.gitignoreSTH, .gitmodulesSTH and .gitattrSTH (for example). This
.gitignoreSTH could then be used to ignore all files except
configuration files that need to be tracked.

That is just my imaginative usecase. Think of it as sort of
overlay-git. Git would only need to provide tools for it, so that on
top of those tools new solutions could be created. Other usecases
would probably pop up sooner or later.


Thank you for your opinion,
b.


Readable diff format: http://pastiebin.com/53ff8747b97f1
Actual patch:
(redacted, as vger swallowed two sending tries with a "250 2.7.1 Looks
like Linux source DIFF email.." response)
