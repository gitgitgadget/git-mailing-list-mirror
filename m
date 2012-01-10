From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-send-email: bug with sendemail.multiedit
Date: Tue, 10 Jan 2012 10:56:58 +0100
Message-ID: <87sjjnlw2d.fsf@thomas.inf.ethz.ch>
References: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Pierre Habouzit <madcoder@debian.org>, <pierre.habouzit@m4x.org>,
	<git@vger.kernel.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 10:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYS5-0004os-OR
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab2AJJ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 04:57:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:17132 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab2AJJ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:57:01 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 10:56:59 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 10:56:58 +0100
In-Reply-To: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com> (Jean-Francois
	Dagenais's message of "Mon, 9 Jan 2012 14:09:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188231>

Jean-Francois Dagenais <jeff.dagenais@gmail.com> writes:

> Bonjour Pierre! ... and all git developers!
>
> I think there is a bug with git-send-email.perl's evaluation of the sendemail.multiedit config variable.
>
> I was only able to make the "do_edit()" function detect it as false by setting the variable to "0" instead
> of "false", like so:
>
> git config --global sendemail.multiedit 0
>
> otherwise do_edit evaluates it as true and invokes the editor with all files as argument.

The patch below looks like the obvious fix.  Perhaps you can test it?

diff --git i/git-send-email.perl w/git-send-email.perl
index d491db9..7ac0a7d 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -210,6 +210,7 @@ sub do_edit {
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
+    "multiedit" => [\$multiedit, undef],
 );
 
 my %config_settings = (
@@ -227,7 +228,6 @@ sub do_edit {
     "bcc" => \@bcclist,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
-    "multiedit" => \$multiedit,
     "confirm"   => \$confirm,
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
