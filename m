From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Tue, 24 Jul 2012 14:21:03 -0500
Message-ID: <20120724192103.GB5210@burratino>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
 <20120721182049.GL19860@burratino>
 <500EEAAA.8030604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stkff-0004Po-95
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab2GXTVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:21:16 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:57835 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab2GXTVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:21:08 -0400
Received: by ghrr11 with SMTP id r11so7057946ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Au+jxIxnSB2Ulh4G1S1CzBuNpoxEAlCHqLIUfq/Kbms=;
        b=er1B1c6JtQ/JVozNqbuyWybu4XOrVBGE5YoyiEKP3jspLU0rGQZcsWee6NYsyDCJhu
         ZonDlG/EUcvrTk+pHzaRCzb1W/Ljzlo56mzOdmn80GOl6lE4uiF8LesN4ErXp9tJS2gl
         IfU3AU4IE4U0W1GTT3Nf78aF6B0E0/VSZTjtHUjjn6EtHkPmGMhEFw03Nrd4RqoD4de7
         KtLwdUEkkKx8RegUvZwT7DKVcB6+3NfITpt9x7CdSlezRXAI2hVtoExWF99ufZeNE4Bl
         +ZSBRRa+xoj+r7E2li9jDIuMWU7Hs57EXo5xoN5bIXSeymvmHZvmRLrwOj6yA1g1igCN
         NwoQ==
Received: by 10.43.92.67 with SMTP id bp3mr17485021icc.16.1343157667811;
        Tue, 24 Jul 2012 12:21:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id q1sm5450503igj.15.2012.07.24.12.21.06
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:21:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500EEAAA.8030604@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202058>

Hi,

Ramsay Jones wrote:

> The only problematic platforms I test on are "NTFS/bash" on cygwin and MinGW.
> Since commit 2b843732 ("Suppress some bash redirection error messages",
> 26-08-2008), I have not noticed any complaints regarding this problem.

Yeah, that probably took care of squashing the messages.  Maybe my
memory is too long. ;-)

[...]
> No, I don't think this would be a good direction to go in. This may
> not be a good idea either, but if you wanted to add a check here, then
> maybe something like this (totally untested):
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index acda33d..53a2422 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -354,6 +354,9 @@ test_done () {
>  	case "$test_failure" in
>  	0)
>  		# Maybe print SKIP message
> +		if test -n "$skip_all" && test $test_count -gt 0; then
> +			error "Can't use skip_all after running some tests"
> +		fi
>  		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
>  
>  		if test $test_external_has_tap -eq 0; then

I think preventing invalid TAP output like this would be a very good
thing!  As a start, this patchlet looks good to me, and then I guess
we'll have to think more about what happens when a person wants to
skip_all_remaining after a test has already been run.

Care to format it as a "git am"-able patch, or should I?

Thanks again,
Jonathan
