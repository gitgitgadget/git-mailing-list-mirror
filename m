From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git with custom diff for commits
Date: Wed, 19 Dec 2007 10:13:45 +0100
Message-ID: <vpqodcnvygm.fsf@bauges.imag.fr>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
	<7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
	<vpqk5ncz8fn.fsf@bauges.imag.fr>
	<7vodco1him.fsf@gitster.siamese.dyndns.org>
	<000001c841b5$89fcef00$762a14ac@na.acco.com>
	<7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
	<000101c841b7$5f1d1060$762a14ac@na.acco.com>
	<vpqsl1zfz8r.fsf@bauges.imag.fr>
	<000d01c841c5$386f7350$762a14ac@na.acco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "Gerald Gutierrez" <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4v35-00075K-18
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbXLSJQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 04:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbXLSJQn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:16:43 -0500
Received: from imag.imag.fr ([129.88.30.1]:55662 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbXLSJQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:16:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBJ9Dkmh028473
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Dec 2007 10:13:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4uzp-00046Y-SO; Wed, 19 Dec 2007 10:13:45 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4uzp-0000Ub-Pw; Wed, 19 Dec 2007 10:13:45 +0100
In-Reply-To: <000d01c841c5$386f7350$762a14ac@na.acco.com> (Gerald Gutierrez's message of "Tue\, 18 Dec 2007 14\:27\:38 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 19 Dec 2007 10:13:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68870>

"Gerald Gutierrez" <ggmlfs@gmail.com> writes:

> if (user_redefined_changed)
>   if (user_defn_of_changed(work, head)) commit(work);
> else
>   if (builtin_changed(work, head)) commit(work);

That would lead to even less intuitive semantics.

Suppose your working tree has two changes, like

--- a/file
+++ b/file
@@ ... @@
-old ignored line
+new ignored line
@@ ... @@
-this is relevant
+change

What would git be supposed to do if you ignore anything containing
"ignored"?

If git commits, it will commit both changes. People checking-out the
new revision will get "new ignored line" in the file. So, a portion of
the diff that you wanted to ignore has actually gone into the
repository. IOW, whether "new ignored line" would go into the
repository depends on the presence of another unrelated change.

Perhaps you would have expected this, but I wouldn't, and I bet many
other users wouldn't either. And usually, when you can't have people
agree on a common reasonable semantics, the answer is "don't put it in
git, let people script the semantics they want".


Take another example : I use an external diff tool to work with
OpenDocument files. It converts them into text, and calls "git diff"
on them. My diff driver therefore ignores formatting changes. If I
made only content changes, I get no change with this diff driver.
Still, if I commit, I expect git to record my new formatting.

-- 
Matthieu
