From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Tue, 24 Jan 2012 17:24:21 -0600
Message-ID: <20120124232421.GH8222@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 00:24:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RppjE-0006JM-0n
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 00:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab2AXXYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 18:24:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41405 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab2AXXYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 18:24:34 -0500
Received: by iacb35 with SMTP id b35so6003710iac.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qumb//3RCIvTHIeMaPvwrszc/Ln1JXI2C9yUJbEv6LQ=;
        b=O1FD8ZA/cbMwDp+hd1XS5yfym7sdVkkafIcfd36h+TvpEgLWbtFGgqxy6PwRvJLqWh
         K7Gul5dhKV2T21OSNI2Ij7xj1o9lc5c66xuXZm6T3xs6mgF3n74s/A8xnCzagRUrz3+0
         Ev6T8wn1Bc3k62Mo3m2ky9x+U2fmIihQKaL6k=
Received: by 10.43.133.199 with SMTP id hz7mr13463507icc.35.1327447474512;
        Tue, 24 Jan 2012 15:24:34 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id mr24sm6666100ibb.1.2012.01.24.15.24.33
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jan 2012 15:24:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327444346-6243-6-git-send-email-fransklaver@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189086>

Frans Klaver wrote:

> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -76,12 +76,12 @@ test_expect_success POSIXPERM 'run_command reports EACCES, interpreter fails' '
>  	grep "bad interpreter" err
>  '
>  
> -test_expect_failure POSIXPERM 'run_command reports ENOENT, interpreter' '
> +test_expect_success POSIXPERM 'run_command reports ENOENT, interpreter' '
>  	cat non-existing-interpreter >hello.sh &&
>  	chmod +x hello.sh &&
>  	test_must_fail test-run-command start-command-ENOENT ./hello.sh 2>err &&
>  
> -	grep "error: cannot exec.*hello.sh" err &&
> +	grep "fatal: cannot exec.*hello.sh" err &&

Thanks.  I'd suggest using "test_expect_code" rather than the detailed
wording of the message, since that is what scripts might want to rely
on.

What happens on Windows?
