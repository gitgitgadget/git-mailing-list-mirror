From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 20:20:09 +0200
Message-ID: <vpq382b47fq.fsf@anie.imag.fr>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:20:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUJu-00052P-7X
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbbFASUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:20:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59870 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbbFASUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:20:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t51IK72M031646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 20:20:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t51IK90C025106;
	Mon, 1 Jun 2015 20:20:09 +0200
In-Reply-To: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr> (Remi LESPINET's message
	of "Mon, 01 Jun 2015 19:07:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jun 2015 20:20:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t51IK72M031646
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433787608.76091@dfX7uxmKQ8pYb2UTSMS6+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270451>

Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> ======================================================================
> = 2. Correction
> ======================================================================
>
> I see mainly two ways to fix the bug:
>
> ********************************************************************
> * 2.1 first method (the most basic)
> ********************************************************************
>
> The most basic is to change the code so that the special behavior
> only affects the hunks of the form
>
> @@ -1,k +1,m @@

I do not think that this would work in all cases. It seems git apply has
issues with overlapping contexts, not just with hunks starting at line
1. See:

$ cat pre.txt
-1
0
10
20
30
40
$ cat p2.diff 
--- pre.txt
+++ pre.txt
@@ -2,2 +2,3 @@
 0
+5
 10
@@ -3,3 +4,3 @@
 10
+15
-20
 30
$ git apply p2.diff
error: patch failed: pre.txt:3
error: pre.txt: patch does not apply
$ patch < p2.diff 
patching file pre.txt
$ cat pre.txt
-1
0
5
10
15
30
40

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
