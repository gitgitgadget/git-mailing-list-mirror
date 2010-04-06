From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5] Documentation/remote-helpers: Add invocation section
Date: Tue, 6 Apr 2010 16:34:35 +0530
Message-ID: <t2sf3271551004060404xe41ff754i9d16a265a4222a28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:05:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz6ac-0001l2-Cn
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab0DFLE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 07:04:57 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62981 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab0DFLE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 07:04:56 -0400
Received: by gxk9 with SMTP id 9so3582203gxk.8
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=rEto87KmisV6J2iMI9KlXT9YedUeUebQttg1uz32fdY=;
        b=YS2IHZFu9mZ9caai9Wg052CmnLkM7Oqi5qFXOyOrl/yXsJfV9YsmnhIP0XYFbuGCLn
         hPT+LLJphAN4HFOYr0jKreizl+BdRD+xuIlBsBNEecR2RSPdrYLM3SSb7LLE6gX7rsaG
         GhUMFqQAfmH6fkyVG0NRQVVsHpi8MDWcUK73w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=LidL8F+mMKCgiM3gRT0KzVbRJ+ZAjkhrCu/6YWwopIJhLDDQFbrnz2T+1SNS+s9SyV
         ziaTtHdgtNFtnWqXzo9lVfbBcX17PfxNmdHwyG2Vc14VyMDKGs7FPu+9hGxHvugmqZkP
         GcpPEKzI6KViM+fEFH48Jz43iiaXAF5TpdPHA=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 04:04:35 -0700 (PDT)
Received: by 10.91.58.11 with SMTP id l11mr2139005agk.0.1270551895097; Tue, 06 
	Apr 2010 04:04:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144126>

Add an 'Invocation' section to specify what the command line arguments
mean. Also include a link to git-remote in the 'See Also' section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 What changed: After Junio's review, invocation section is more detailed.

 Documentation/git-remote-helpers.txt |   48 +++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 2382fb4..b3b42ff 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -7,7 +7,7 @@ git-remote-helpers - Helper programs to interact with
remote repositories

 SYNOPSIS
 --------
-'git remote-<transport>' <remote>
+'git remote-<transport>' <repository> [<URL>]

 DESCRIPTION
 -----------
@@ -38,6 +38,48 @@ Git comes with a "curl" family of remote helpers,
specifically
 'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
 and 'push'.

+INVOCATION
+----------
+
+Remote helper programs are invoked with one or (optionally) two
+command line arguments. The first argument specifies a remote
+repository as in git; typically, it is either the name of a configured
+remote or just a URL. The second argument specifies a URL; it may
+either be a URL recognized by git, or an arbitrary URL-like string
+recognized by the specific helper being invoked. When the remote
+specified in the first argument has more than one configured URL, it
+serves to resolve the ambiguity and pick one of the URLs. Depending on
+the helper, supplying the second argument can make the first argument
+redundant.
+
+When git encounters a URL of the form '<transport>://<address>', where
+<transport> is a protocol that it cannot handle natively, it
+implicitly invokes 'git remote-<transport>' with
+the full URL as the second argument. The first argument
+is either the same as the second, when called from directly from
+command line, or <name> corresponding to the configured remote's name.
+
+A URL of the form '<transport>::<address>' explicitly instructs git to
+invoke the corresponding helper with '<address>' as the second
+argument. '<transport>::<string>' is the first argument when the
+helper is invoked directly from the command line, or '<name>'
+corresponding to the configured remote's name.
+
+Another explicit invocation case arises when a configured remote
+includes the remote.<name>.vcs is set to <transport>, in which case
+the 'git remote-<transport>' is invoked with a single argument,
+<name>.
+
+
+<nickname> with vcs set
+~~~~~~~~~~~~~~~~~~~~~~~
+
+A remote can be configured to use the
+'git remote-<transport>' helper by setting the vcs variable to
+<transport> in the [remote "<nickname>"] section of a configuration file.
+The url variable in such a section is optional and can be set to an
+arbitrary string <address>.
+
 COMMANDS
 --------

@@ -206,6 +248,10 @@ OPTIONS
 	must not rely on this option being set before
 	connect request occurs.

+SEE ALSO
+--------
+linkgit:git-remote[1]
+
 Documentation
 -------------
 Documentation by Daniel Barkalow and Ilari Liusvaara
-- 
1.7.0.3
