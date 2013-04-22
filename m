From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] Silent data loss on merge with uncommited changes + renames
Date: Mon, 22 Apr 2013 16:43:34 +0200
Message-ID: <vpqtxmy7hih.fsf@grenoble-inp.fr>
References: <vpqobd6q5nm.fsf@grenoble-inp.fr> <517547F8.3040004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 16:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUHyI-0001Ba-L0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 16:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab3DVOnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 10:43:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59657 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932120Ab3DVOnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 10:43:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3MEhWM0010976
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 16:43:32 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UUHxu-0005ly-BS; Mon, 22 Apr 2013 16:43:34 +0200
In-Reply-To: <517547F8.3040004@viscovery.net> (Johannes Sixt's message of
	"Mon, 22 Apr 2013 16:23:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Apr 2013 16:43:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3MEhWM0010976
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367246614.27534@srxgUH+NfpwZlBrcron/jA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222019>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/22/2013 11:24, schrieb Matthieu Moy:
>> Following the discussion on "merge with uncommited changes" inside the
>> "git pull --autostash" thread, I did a bit of testing, and encountered a
>> case with silent data loss. In short: merge a branch introducing changes
>> to a file. If the file has been renamed in the current branch, then "git
>> merge" follows the rename and brings changes to the renamed file, but
>> uncommited changes in this file are overriden silently.
>
> Can you check whether your case is already covered by one of:
>
>   git grep expect_failure t/*merge*

Indeed, it's already here:

test_expect_failure 'will not overwrite unstaged changes in renamed file' '
	git reset --hard c1 &&
	git mv c1.c other.c &&
	git commit -m rename &&
	cp important other.c &&
	git merge c1a &&
	test_cmp important other.c
'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
