From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] git-p4: remove bash-ism in t9800
Date: Sun, 26 Feb 2012 18:48:07 +0100
Message-ID: <4F4A7057.2020309@kdbg.org>
References: <1330270647-8817-1-git-send-email-pw@padd.com> <1330270647-8817-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 18:48:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1iCw-000433-LV
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 18:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab2BZRsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 12:48:21 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59945 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752337Ab2BZRsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 12:48:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5F2342C4008;
	Sun, 26 Feb 2012 18:48:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 53A6919F604;
	Sun, 26 Feb 2012 18:48:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <1330270647-8817-3-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191569>

Am 26.02.2012 16:37, schrieb Pete Wyckoff:
> -		P4EDITOR=touch P4USER=bob P4PASSWD=secret test_must_fail "$GITP4" commit --preserve-user &&
> -		test_must_fail git diff --exit-code HEAD..p4/master
> +		# dashism: test_must_fail does not propagate variables
> +		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
> +		export P4EDITOR P4USER P4PASSWD &&
> +		test_must_fail "$GITP4" commit --preserve-user &&
> +		! git diff --exit-code HEAD..p4/master

It is a bashism that variables assigned in front of a shell function are
exported. But it is not a dashism that they are not exported; that
(surprising?) behavior is actually conforming to POSIX.

With the new code, be aware that the variables remain exported, which
might affect subsequent tests in general, though not this one, because
the assignments are in a sub-shell:

>  	)
>  '

-- Hannes
