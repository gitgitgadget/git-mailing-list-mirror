From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] fast-import: clarify documentation of "feature" command
Date: Sun, 28 Nov 2010 13:43:57 -0600
Message-ID: <20101128194357.GC19998@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 20:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMnAo-0003FM-H5
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0K1ToF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:44:05 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39667 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab0K1ToD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:44:03 -0500
Received: by ywl5 with SMTP id 5so1671829ywl.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=y9sfMth6ckzvP8mxkW4uin3iexyq4DdA/5QRnSD4mK4=;
        b=B2jPjCvRQNrlVPVSB3/nht6qcmZVEh5LrQ+rjcLB/cLyKwbMpZMkD83aVWmQWlK6uH
         syq1RnrLxWg7i/cRJFxo1p+vCidMyoEyKmOat988pfd5PW9OSrAreg5dLtbEpgmFSIMq
         VM0r/Y9UOWVxF2o9ElcTfJjCX0KNuVwm+n1VI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oQRlqpY0p2XIlQEfor8tGIWfOugYy9xE3QwhlUQdgpHiDLKrXmK1xtogIXzG6T1U1V
         aPIBw+L0XwvLeBvS0HAOF/7/lEYEBKjpDkHGJsF6tmrXxRY38Zr70jsysxoxvygZv1+E
         RPQJYtWSrxaZo0gs6JD0CgghZqhfC5EUZQO7A=
Received: by 10.150.196.2 with SMTP id t2mr8987832ybf.205.1290973442683;
        Sun, 28 Nov 2010 11:44:02 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id k16sm2756721ybe.12.2010.11.28.11.44.00
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:44:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128194131.GA19998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162356>

The "feature" command allows streams to specify options for the import
that must not be ignored.  Logically, they are part of the stream,
even though technically most supported features are synonyms to
command-line options.

Make this more obvious by being more explicit about how the analogy
between most "feature" commands and command-line options works.  Treat
the feature (import-marks) that does not fit this analogy separately.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---
Side note: I am thinking of introducing a syntax

	'feature' SP 'command' SP <command name> LF

which would just check if <command name> is a recognized command.
This way, when a feature introduces a new command, it would get
a feature name to go along with that with no extra effort.

In particular, it is not obvious to me whether cat-blob, ls-tree,
and so on ought to be considered a single feature but with the
feature command syntax, we could dodge the issue. :)  Sane?

 Documentation/git-fast-import.txt |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 19082b0..3bf04e3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -878,28 +878,25 @@ Require that fast-import supports the specified feature, or abort if
 it does not.
 
 ....
-	'feature' SP <feature> LF
+	'feature' SP <feature> ('=' <argument>)? LF
 ....
 
-The <feature> part of the command may be any string matching
-^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
+The <feature> part of the command may be any one of the following:
 
-Feature work identical as their option counterparts with the
-exception of the import-marks feature, see below.
+date-format::
+export-marks::
+relative-marks::
+no-relative-marks::
+force::
+	Act as though the corresponding command-line option with
+	a leading '--' was passed on the command line
+	(see OPTIONS, above).
 
-The following features are currently supported:
-
-* date-format
-* import-marks
-* export-marks
-* relative-marks
-* no-relative-marks
-* force
-
-The import-marks behaves differently from when it is specified as
-commandline option in that only one "feature import-marks" is allowed
-per stream. Also, any --import-marks= specified on the commandline
-will override those from the stream (if any).
+import-marks::
+	Like --import-marks except in two respects: first, only one
+	"feature import-marks" command is allowed per stream;
+	second, an --import-marks= command-line option overrides
+	any "feature import-marks" command in the stream.
 
 `option`
 ~~~~~~~~
