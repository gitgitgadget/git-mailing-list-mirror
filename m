From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 16:04:06 +0200
Message-ID: <4FD89DD6.1070705@in.waw.pl>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeoBH-0006yX-0w
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 16:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2FMOEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 10:04:15 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38437 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600Ab2FMOEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 10:04:14 -0400
Received: from zopt1.fuw.edu.pl ([193.0.81.24] helo=[10.33.8.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SeoBB-0007hD-J6; Wed, 13 Jun 2012 16:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199892>

On 06/12/2012 04:46 PM, Junio C Hamano wrote:
> I do not think it is worth another round of resend at this point, so
> please eyeball the version I fixed up and queued in 'pu' when it is
> pushed out.  I also moved the '-x <cmd>::' option description to
> where it belongs (iow, not at the very beginning).

Hi,
I think some small changes are still in order. Please consider
squashing this in:

-----8<------
Subject: [PATCH] squash! rebase -i: teach "--exec <cmd>"

In the commit message: s/each runs/each run/

Fixup to the documentation part:
- Use the phrase "after each commit in the final history" from Junio's
  commit message to replace "each commit application". The latter is
  awkward and not really true.
- Reorder paragraphs and reword the one about --interactive.
  Make the part about two forms of exec less verbose.
- Replace ';' with '&&' in the example. This (a) makes the two
  examples equivalent, and (b) encourages good practice that we try
  to follow in git tests to never fail silently. People are likely
  to copy the example verbatim.
---
 Documentation/git-rebase.txt | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 048da64..179ab77 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -346,22 +346,23 @@ idea unless you know what you are doing (see BUGS
below).

 -x <cmd>::
 --exec <cmd>::
-	Append "exec <cmd>" after each commit application line. <cmd>
-	will be interpreted as one or more shell commands (see
-	INTERACTIVE MODE below).
+	Append "exec <cmd>" after each line creating a commit in the
+	final history. <cmd> will be interpreted as one or more shell
+	commands.
 +
-This option has to be used along with the `--interactive` option
-explicitly.  You may execute several commands after each commit
-application.  For this, you can use one instance of `--exec`:
+This option can only be used with the `--interactive` option
+(see INTERACTIVE MODE below).
 +
-	git rebase -i --exec "cmd1; cmd2; ...".
+You may execute several commands by either using one instance of `--exec`
+with several commands:
 +
-You can also insert several instances of `--exec`, if you wish to only
-have one command per line. For example:
+	git rebase -i --exec "cmd1 && cmd2 && ..."
 +
-	git rebase -i --exec "cmd1" --exec "cmd2" ...
+or equivalently by giving more than one `--exec`:
 +
-If `--autosquash` is used, the "exec" lines will not be appended for
+	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
++
+If `--autosquash` is used, "exec" lines will not be appended for
 the intermediate commits, and will only appear at the end of each
 squash/fixup series.

-- 
1.7.11.rc3.129.ga90bc7a.dirty
-----8<------

Zbyszek
