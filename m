From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 4/4] t/t8006: test textconv support for blame
Date: Thu, 3 Jun 2010 17:44:07 +0200
Message-ID: <201006031744.07569.j6t@kdbg.org>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr> <1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?iso-8859-1?q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:47:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCdW-00083d-F4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab0FCPrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:47:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:32523 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756581Ab0FCPrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 11:47:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4BF64CDF82;
	Thu,  3 Jun 2010 17:47:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A812819F5EC;
	Thu,  3 Jun 2010 17:44:07 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1275562038-7468-5-git-send-email-axel.bonnet@ensimag.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148337>

On Donnerstag, 3. Juni 2010, Axel Bonnet wrote:
> +cat >helper <<'EOF'
> +#!/bin/sh
> +sed 's/^/converted: /' "$@" >helper.out
> +cat helper.out
> +EOF

You don't need an intermediate file here, do you? Without it, this textconv 
script is a one-liner; now, isn't it possible to configure a shell command as 
textconv command, i.e., without this helper script?

> +test_expect_success 'setup ' '
> +	echo test 1 >one.bin &&
> +	echo test number 2 >two.bin &&
> +	ln one.bin link.bin &&

Do you need a hard link? Can't you just copy the file at the right time?

> +test_expect_success 'blame with --no-textconv' '
> +	git blame --no-textconv one.bin | grep Number2 >blame
> +	find_blame <blame >result

It would be nice if you could write this like, e.g.,

	git blame --no-textconv one.bin >blame &&
	find_blame Number2 <blame >result

so that the git command is not part of a pipeline (otherwise, unexpected exit 
codes would go undetected).

Please look for missing '&&', you forgot it in many places.

-- Hannes
