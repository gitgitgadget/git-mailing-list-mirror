From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Tue, 03 Jan 2012 09:35:56 +0100
Message-ID: <4F02BDEC.9060407@kdbg.org>
References: <20120103011352.GA13825@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Brian Harring <ferringb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 09:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhzqm-0000kC-Bn
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 09:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab2ACIgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 03:36:00 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:38229 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751462Ab2ACIf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 03:35:59 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CAC7D10021;
	Tue,  3 Jan 2012 09:34:10 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 04B9319F43C;
	Tue,  3 Jan 2012 09:35:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20120103011352.GA13825@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187855>

Am 03.01.2012 02:13, schrieb Brian Harring:
> git-repo if interupted at the exact wrong time will generate zero
> length bundles- literal empty files.  git-repo is wrong here, but
> git fetch shouldn't effectively spin loop if pointed at a zero
> length bundle.

Adding a test case is very much appreciated.

> +test_expect_success 'die if bundle file is empty' '

How about 'empty bundle file is rejected'?

> +
> +   echo -n > empty-bundle

'echo -n' is not portable; use simply

	>empty-bundle &&

(note the style: no blank after >). Also chain commands using &&.

> +   timeout 5 git fetch empty-bundle

Yes, there was an infinite loop. But we do not specifically protect our
git invocations in the test suite against this sort of failure. Just write

	test_must_fail git fetch empty-bundle

and end the test case here.

> +   ret=$?
> +   [ $ret == 128 ] && return 0
> +   return $ret
> +
> +'

Furthermore, indentation should be one tabstop, not blanks.

-- Hannes
