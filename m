From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] shell doc: emphasize purpose and security model
Date: Sat, 9 Mar 2013 13:55:37 -0800
Message-ID: <20130309215537.GB24777@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 22:56:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UERkP-0004yb-LG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 22:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3CIVzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 16:55:44 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:58293 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3CIVzn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 16:55:43 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so2419314pbb.34
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jLJEbDvbIOsznJDA4bG8yhdEp/jNOcg4kDSCayTFhms=;
        b=JITGWx2BlzPkK14eqohpoeINr3ZVlinkZc8aoRa8J+aWpVZeYQ70PuGoXrfzZ10I4x
         nalZiqay2wfoOJ1ack5iEiQTw3HgLzAoBBtj5VKdfZU3vJDzfwf67xjL54KJvyAEnw1g
         ZnGhnM8BXTEFt/e0qME+lMhbKDYZsQEvOiqFuHY1vKDTWMrWiJMYdJ5MdCwAmccHHLIl
         AkqUdtBWptUe5jvzMqof8C7DOOCYdRtUzy3eZfFoqirqM5BVDeXkZi+XWj1y2NQ916Vc
         xcO8AbNfmi1Rm9zLmkeLQanb+k1w1XOJTekAvPwxKow4QVroKc/ljqGDeEg6GzuG5kpE
         G0NA==
X-Received: by 10.68.134.233 with SMTP id pn9mr14736937pbb.90.1362866142709;
        Sat, 09 Mar 2013 13:55:42 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id xr3sm12020066pbc.46.2013.03.09.13.55.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 13:55:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130309215237.GA24777@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217767>

The original git-shell(1) manpage emphasized that the shell supports
only git transport commands.  As the shell gained features, that
emphasis and focus in the manual has been lost.  Bring it back by
splitting the manpage into a few short sections and fleshing out each:

 - SYNOPSIS, describing how the shell gets used in practice
 - DESCRIPTION, which gives an overview of the purpose and guarantees
   provided by this restricted shell
 - COMMANDS, listing supported commands and restrictions on the
   arguments they accept
 - INTERACTIVE USE, describing the interactive mode

Also add a "see also" section with related reading.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v2:

 - use "command -v" instead of "which" in synopsis to subtly reinforce
   good habits
 - use <user> instead of hardcoding "git" username in synopsis
 - give up on typesetting "git> " in monospace, since the toolchain
   doesn't seem to like lonely backticks :/
 - clarify change description

The actual text is pretty much the same.

 Documentation/git-shell.txt | 66 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 9b925060..544b21aa 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -9,25 +9,61 @@ git-shell - Restricted login shell for Git-only SSH access
 SYNOPSIS
 --------
 [verse]
-'git shell' [-c <command> <argument>]
+'chsh' -s $(command -v git-shell) <user>
+'git clone' <user>`@localhost:/path/to/repo.git`
+'ssh' <user>`@localhost`
 
 DESCRIPTION
 -----------
 
-A login shell for SSH accounts to provide restricted Git access. When
-'-c' is given, the program executes <command> non-interactively;
-<command> can be one of 'git receive-pack', 'git upload-pack', 'git
-upload-archive', 'cvs server', or a command in COMMAND_DIR. The shell
-is started in interactive mode when no arguments are given; in this
-case, COMMAND_DIR must exist, and any of the executables in it can be
-invoked.
-
-'cvs server' is a special command which executes git-cvsserver.
-
-COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
-read and execute permissions to the directory in order to execute the
-programs in it. The programs are executed with a cwd of $HOME, and
-<argument> is parsed as a command-line string.
+This is a login shell for SSH accounts to provide restricted Git access.
+It permits execution only of server-side Git commands implementing the
+pull/push functionality, plus custom commands present in a subdirectory
+named `git-shell-commands` in the user's home directory.
+
+COMMANDS
+--------
+
+'git shell' accepts the following commands after the '-c' option:
+
+'git receive-pack <argument>'::
+'git upload-pack <argument>'::
+'git upload-archive <argument>'::
+	Call the corresponding server-side command to support
+	the client's 'git push', 'git fetch', or 'git archive --remote'
+	request.
+'cvs server'::
+	Imitate a CVS server.  See linkgit:git-cvsserver[1].
+
+If a `~/git-shell-commands` directory is present, 'git shell' will
+also handle other, custom commands by running
+"`git-shell-commands/<command> <arguments>`" from the user's home
+directory.
+
+INTERACTIVE USE
+---------------
+
+By default, the commands above can be executed only with the '-c'
+option; the shell is not interactive.
+
+If a `~/git-shell-commands` directory is present, 'git shell'
+can also be run interactively (with no arguments).  If a `help`
+command is present in the `git-shell-commands` directory, it is
+run to provide the user with an overview of allowed actions.  Then a
+"git> " prompt is presented at which one can enter any of the
+commands from the `git-shell-commands` directory, or `exit` to close
+the connection.
+
+Generally this mode is used as an administrative interface to allow
+users to list repositories they have access to, create, delete, or
+rename repositories, or change repository descriptions and
+permissions.
+
+SEE ALSO
+--------
+ssh(1),
+linkgit:git-daemon[1],
+contrib/git-shell-commands/README
 
 GIT
 ---
-- 
1.8.2.rc3
