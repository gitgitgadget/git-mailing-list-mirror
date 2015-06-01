From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFCv2 0/2] rebase -i : drop command and removed commits
Date: Mon,  1 Jun 2015 11:57:21 +0200
Message-ID: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stephen Kelly <steveire@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 11:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMTe-0003JC-JP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbbFAJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 05:57:37 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:54066 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932129AbbFAJ5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 05:57:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 05B764884A;
	Mon,  1 Jun 2015 11:57:26 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWt6ZGJiHdcA; Mon,  1 Jun 2015 11:57:25 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DCC6648841;
	Mon,  1 Jun 2015 11:57:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id CFEC320E4;
	Mon,  1 Jun 2015 11:57:25 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSIaM3wb59mC; Mon,  1 Jun 2015 11:57:25 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.grenet.fr (eduroam-032176.grenet.fr [130.190.32.176])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id A299720D6;
	Mon,  1 Jun 2015 11:57:25 +0200 (CEST)
X-Mailer: git-send-email 2.4.1.363.g9535a9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270388>

 - [PATCH 1/2] git-rebase -i: add command "drop" to remove a commit
The 'drop' command is added as a way to explicitely remove commits in
git rebase -i.
This patch does not prevent users from commenting the line, removing
the line or using the 'noop' command if they want to.
While the 'noop' command has the same effect, it doesn't seem to be
the right use for it since 'noop' merely ignores everything that
follows, in particular writing 'noop <SHA-1> <text>' can be confusing.
Commenting a line also has the same effect but the 2/2 part of the
patch is not made for working correctly with comments (though it still
works with 'noop').
This command is inspired by the command 'drop' in histedit of
Mercurial (though in the idea, it is not made to make migrants from
Mercurial feel better but rather because it seems like a good idea).
For the 'drop' command, maybe instead of just doing the same thing as
noop, checking if the SHA-1 that supposedly follow does exist could be
a good idea.

 - [PATCH 2/2] git rebase -i: warn about removed commits 
Since the default behaviour is 'ignore', meaning that no checking is
done and no warning is displayed, users that are used to remove the
lines to remove a commit can still do so without changing their
configuration.
However this patch gives the user the possibility to avoid silent loss
of information if he wants.
Regarding the comments of v1 : The dupplicated commits are not checked
anymore ((about the review by Eric Sunshine) thus the error case stays
within the warning test, now that we only have one test for warnings).
The list of removed commits is now shown in the format '<short SHA-1>
<commit-message>' instead of '<full SHA-1>', this was done following
an idea given by Matthieu Moy outside of the mailing list. 
Because of this some code have been added and modified and thus need
reviewing.
A test has been added to check the correct behaviour of the error
configuration.
