From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] report which $PATH entry had trouble running execvp(3)
Date: Wed, 20 Apr 2011 09:37:34 +0200
Message-ID: <4DAE8D3E.8000705@viscovery.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org> <7vipub6r3s.fsf@alter.siamese.dyndns.org> <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:37:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCRyr-0005g8-69
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1DTHhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:37:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14164 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1DTHhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:37:40 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QCRyh-0000LD-6k; Wed, 20 Apr 2011 09:37:35 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id ECA6B1660F;
	Wed, 20 Apr 2011 09:37:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171848>

Am 4/20/2011 6:01, schrieb Junio C Hamano:
> Add an internal function sane_execvp() that emulates execvp(3), skipping
> ENOENT and EACCES while remembering a path that resulted in EACCES while
> trying later directories on $PATH.  When failing the request at the end,
> report the path that we had trouble with, and use it when reporting the
> error.

I don't think this is worth the trouble. In which way is git different
from other tools that execvp other programs?

And how do you help when the script is executable, but the interpreter is not:

$ chmod -x git	# use git itself just for exposition
$ echo '#!'"$(pwd)/git" > git-frotz
$ chmod +x git-frotz
$ git --exec-path=. frotz
fatal: cannot exec 'git-frotz': Permission denied
$ # WTF, git-frotz *is* executable and readable!?!?

IOW, when you get strange behavior, you still have to dig around to know
what went wrong.

-- Hannes
