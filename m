From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Fix git rebase --continue to work with touched files
Date: Tue, 27 Jul 2010 21:53:36 +0200
Message-ID: <201007272153.36646.j6t@kdbg.org>
References: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdqEQ-00058g-SM
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab0G0Ty0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 15:54:26 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:16694 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751801Ab0G0TyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 15:54:25 -0400
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 2AE94CE6B1
	for <git@vger.kernel.org>; Tue, 27 Jul 2010 21:54:20 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5F5C9A7EC1;
	Tue, 27 Jul 2010 21:53:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B91BF19F5C6;
	Tue, 27 Jul 2010 21:53:36 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151979>

On Dienstag, 27. Juli 2010, David D. Kilzer wrote:
> +test_expect_success 'rebase --continue works with touched file' '
> +	count=1
> +	while test "$count" -le 4
> +	do
> +		git branch topic$count topic &&
> +		test_must_fail git rebase --onto master master topic$count &&
> +		echo "Resolved" >F2 &&
> +		git add F2 &&
> +		touch F1 &&
> +		git rebase --continue || exit 1

exit from a test is a big no-no. But I think you can reproduce the issue 
reliably and get rid of the entire loop if you use test-chmtime instead of 
touch:

		test-chmtime =-60 F1 &&

i.e. set the modification time back one minute.

> +		count=$(($count + 1))
> +	done
> +'
> +
> +test_done

-- Hannes
