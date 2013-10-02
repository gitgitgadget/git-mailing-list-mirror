From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug? Files are losing history after subtree merge
Date: Wed, 02 Oct 2013 21:42:42 +0200
Message-ID: <vpqsiwjlarx.fsf@anie.imag.fr>
References: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 02 21:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRSJv-0006xD-Hh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab3JBTmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 15:42:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55744 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3JBTmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 15:42:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r92Jgeag003421
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Oct 2013 21:42:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VRSJm-0005EO-Uv; Wed, 02 Oct 2013 21:42:43 +0200
In-Reply-To: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 2 Oct 2013 21:20:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Oct 2013 21:42:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r92Jgeag003421
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1381347761.05201@AGRj31zXpKrR0Zzt/+w8lA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235671>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Hi,
>
> recently I did a merge where a complete repo shall be
> merged into a specific directory of another repo. I
> tried both the "subtree" merge strategy and the option
> "-Xsubtree=<dir>" of "recursive". I noticed that in both
> cases somehow the history of single files were lost
> during these merges (with history I mean 'git log <file>'
> and 'git log --follow <file>').

This is a known bug of "git log --follow": it does not follow accross
subtree merge. But your history is still there (try gitk on your project
for example).

Technically, a subtree merge is a merge commit in which files are
renamed compared to the second parent. --follow does not manage this
case.

> diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
> index 73fc240..e9a97d7 100755
> --- a/t/t6029-merge-subtree.sh
> +++ b/t/t6029-merge-subtree.sh
> @@ -61,6 +61,14 @@ test_expect_success 'initial merge' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_failure 'file keeps history after subtree merge' '
> +	cd ../git-gui &&
> +	git log --follow git-gui.sh >../git/expected &&
> +	cd ../git &&
> +	git log --follow git-gui/git-gui.sh >actual &&
> +	test_cmp expected actual
> +'
> +

That would actually be good to add a failing test to "document" the
failure.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
