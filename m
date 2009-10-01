From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 1/2] gitweb: check given hash before trying to create snapshot
Date: Thu, 1 Oct 2009 10:13:57 +0200
Message-ID: <200910011013.58899.jnareb@gmail.com>
References: <4ABE5360.8090204@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Oct 01 10:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtGok-0007VC-8v
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 10:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbZJAIOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 04:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbZJAIOG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 04:14:06 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:56518 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbZJAIOB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 04:14:01 -0400
Received: by bwz6 with SMTP id 6so3412730bwz.37
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ulSt2Xjg1k2kKjr6PkmDMWgC7BFXz7Llg4d5j67UUQA=;
        b=eo9GZHGDGqyc0Oe2YXI7Jp9Vkli48ar5IQRekF20HnNo+rgVHSb0hVwvMQbHyiQYus
         FM6jo7lG68wmiAfCyO3wN2mCr+L4SThmvF77GHetIVlCt+ByCabtZZe/T9kkk2XGJ50I
         NvHsqNPLINWEa2MtlSjMDkvyGwBxy/RuLolng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uJmCAmdbTb+5/mTNccrQorPgWKCSID7eyd8X8WM01Z/Q1wosgd0FcmO7hW4RvGP8+0
         AQybUETq7BNs2gOGCO7JPD3RTC48vyKRwmlrFR/n4h2fBb1BTepzFs+9uxwo8QBOVpBK
         WArLhmD11i56KMsR+3pmvnUaGHspfUJ3bixGg=
Received: by 10.204.34.3 with SMTP id j3mr748699bkd.23.1254384844716;
        Thu, 01 Oct 2009 01:14:04 -0700 (PDT)
Received: from ?192.168.1.13? (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id b17sm1005106fka.13.2009.10.01.01.14.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 01:14:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4ABE5360.8090204@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129381>

On Sat, 26 Sep 2009, Mark Rada wrote:

> Makes things nicer in cases when you hand craft the snapshot URL but
> make a typo in defining the hash variable (e.g. netx instead of next);
> you will now get an error message instead of a broken tarball.
> 
> Tests for t9501 are included to demonstrate added functionality.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---

Very nice, and I think robust solution.

Acked-by: Jakub Narebski <jnareb@gmail.com>

[...]
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index d0ff21d..0688a57 100644
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh

BTW. the rest of test scripts are executable, but not this one? Why?
(But correcting this should be done, if needed, in separate commit).

> @@ -75,4 +75,43 @@ test_expect_success \
>  test_debug 'cat gitweb.output'
>  
>  
> +# ----------------------------------------------------------------------
> +# snapshot hash ids
> +
> +test_expect_success 'snapshots: good tree-ish id' '
> +	gitweb_run "p=.git;a=snapshot;h=master;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output
> +'
> +test_debug 'cat gitweb.output'
> +

What *could* be improved (but don't *need to*) is to check also HTTP
status and not only formatted error message:

> +test_expect_success 'snapshots: bad tree-ish id' '
> +	gitweb_run "p=.git;a=snapshot;h=frizzumFrazzum;sf=tgz" &&
  +	grep "Status: 404 Not Found" gitweb.output &&
> +	grep "404 - Object does not exist" gitweb.output
> +'
> +test_debug 'cat gitweb.output'

And similarly in other cases.  But it is not something required.
I think what it is now is good enough.

-- 
Jakub Narebski
Poland
