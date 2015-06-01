From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 1 Jun 2015 23:37:39 +0200 (CEST)
Message-ID: <864699446.258590.1433194659960.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr> <xmqqiob773iy.fsf@gitster.dls.corp.google.com> <vpqa8wj48c1.fsf@anie.imag.fr> <xmqqpp5f5l7v.fsf@gitster.dls.corp.google.com> <vpqiob7z2n7.fsf@anie.imag.fr> <xmqqeglv5kg1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 23:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzXWt-0002Li-B8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 23:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbbFAVpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 17:45:47 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:55579 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754052AbbFAVpi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 17:45:38 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2015 17:45:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BE2254882A;
	Mon,  1 Jun 2015 23:37:07 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3egBfEiXtmbD; Mon,  1 Jun 2015 23:37:07 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9F61148813;
	Mon,  1 Jun 2015 23:37:07 +0200 (CEST)
In-Reply-To: <xmqqeglv5kg1.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: solving a bug with hunks starting at line 1 in git apply
Thread-Index: QYxAPOyQ/Z6J6vrIye7ElVva+Aj33Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270473>

Ok, Thanks for all the informations

> Notice that the pre-context lines in this second example is only one
> line.  Is it giving the same degree of safety if we rejected an
> attempt to apply this patch only when the original does not have 10,
> 20, 30 and 40 in this order?
> 
> No.  Because we are doing two-line context patch, the patch is not
> just saying "this change applies to a place where the first line is
> 10".  It also is saying "there is no line before that line".

Yes, It's obvious that "patch" has not the same degree of safety as the
git apply command. But I thought that any patch working with
git apply should work with the "patch" command and give the same output,
It seems that this is not true, regarding

file:

10
10
10
10
20

diff:

@@ -1,2 +1,3 @@
+10
 10
 10
@@ -1,4 +2,5 @@
 10
 10
+cc
 10
 10

(I changed it to have 2 line context).  Of course these are
hand-written patches, which can't be obtained with a diff (except with
the non coalescing git add -p as you said yourself). Wouldn't it 
be a problem?

> In other words, isn't the right fix to coalesce that input, so that
> the second hunk does *not* require fuzzy application in the first
> place?

Yes, you're right, that will be fixed if we restore coalescing, I
didn't thought of this possibility. This will cause fewer split but
we have the edit option anyway.


Thanks
