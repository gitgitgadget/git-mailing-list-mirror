From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Fri, 15 Jan 2010 09:30:48 +0100
Message-ID: <4B5027B8.2090507@viscovery.net>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org> <1263537842-5792-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 09:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVha7-00020g-6k
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 09:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab0AOIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 03:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081Ab0AOIaz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 03:30:55 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24619 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab0AOIay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 03:30:54 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NVhZx-0001SE-G1; Fri, 15 Jan 2010 09:30:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 25C3E1660F;
	Fri, 15 Jan 2010 09:30:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1263537842-5792-1-git-send-email-tarmigan+git@gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137059>

Tarmigan Casebolt schrieb:
>         REQUEST_METHOD="GET" some_shell_function

> I can't tell from my reading of the POSIX spec whether my usage was
> wrong or if dash is wrong,

According to POSIX, variables set as shown above for shell functions are
not exported and retain their value after the function returns. I would
not be surprised if dash got this right, and the tests fail because they
were written for bash, which gets it wrong.

In particular,

f() { sh -c 'echo +$v+'; }
v=x f
echo +$v+
sh -c 'echo +$v+'"

Should print

++
+x+
++

I can test only ash, bash, zsh, and ksh, of which only ksh gets it right.

-- Hannes
