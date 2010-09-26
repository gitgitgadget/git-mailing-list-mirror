From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] sh-setup: Write a new require_clean_work_tree function
Date: Sun, 26 Sep 2010 18:28:56 +0200
Message-ID: <vpqmxr4piyf.fsf@bauges.imag.fr>
References: <4C9E07B1.50600@workspacewhiz.com>
	<1285514516-5112-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 18:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozu6B-0000hq-0y
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 18:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab0IZQ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 12:29:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54046 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757424Ab0IZQ3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 12:29:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8QGO5xi017704
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 26 Sep 2010 18:24:05 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ozu5w-0003U9-HM; Sun, 26 Sep 2010 18:28:56 +0200
In-Reply-To: <1285514516-5112-2-git-send-email-artagnon@gmail.com> (Ramkumar Ramachandra's message of "Sun\, 26 Sep 2010 20\:51\:55 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 26 Sep 2010 18:24:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8QGO5xi017704
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286123048.22379@I4fT7R7qTZJ0kYLAINKnmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157238>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +	then
> +		echo >&2 "cannot $1: you have unstaged changes."
> +		echo >&2 "Please commit or stash them."
> +		git diff-files --name-status -r --ignore-submodules -- >&2

I totally agree on the idea, and the implementation is OK. On the
format of the message, you can try to make it more consistent with
other error messages, like:

$ git merge branch
error: The following untracked working tree files would be overwritten by merge:
        one
	two
Please move or remove them before you can merge.

That would give stg like:

echo >&2 "error: The following files have unstaged changes:"
git diff-files --name-status -r --ignore-submodules -- >&2
echo >&2 "Please commit or stash them to proceed."

(same for the second case)

Also, you probably want to give all the error before you "exit 1",
hence stg like:

error=f
...
if
then
	...
	error=t
fi

if
then
	...
	error=t
fi

if [ "$error" = "t" ]; then
	exit 1
fi

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
