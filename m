From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting
 GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri, 9 Oct 2009 15:01:03 -0500
Message-ID: <20091009200103.GB3610@progeny.tock>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
 <20091009192812.GA4122@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, drizzd@aon.at, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 09 22:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwLdq-0006Hl-EW
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 22:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934045AbZJITxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 15:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbZJITxa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 15:53:30 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:45145 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZJITx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 15:53:29 -0400
Received: by fxm27 with SMTP id 27so6713215fxm.17
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bTj+QISg9YicuqGF25PQaax10sfFXEA4Vgqqf21Di74=;
        b=w53sUkW6AXkvx+XNIKBrMbXnm7t5pOFFr1i09fq1lfgcjkEWlfqnBcfAlB+5wgISMA
         YL1EsRx5tH7dkbP/EupvxRx3TVISzHhefQ9AKuqwz22dgYBr0bTNbqO3T+IfBFa1mMfk
         PwNRGt774ipuDYOxq45yB2VKu9EzIGFQurI3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IrH6mWmijuABn1GPJasIC+SeeHhe5FkvodoRr6DJh4RhLXe2nF8qYJL02EIjRy6Fw1
         LlzrO/fRNs1ctTP6WZxuMCl6nClTLbncuiW9/UT6qfzGyaZiylA44jAHIQLB95RimLSD
         O6aQcvy6VYatYt0cPuPudwROwQbhF6C3FSIQI=
Received: by 10.86.229.18 with SMTP id b18mr2790350fgh.34.1255117972409;
        Fri, 09 Oct 2009 12:52:52 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id l19sm765539fgb.22.2009.10.09.12.52.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 12:52:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091009192812.GA4122@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129837>

Sorry to reply to self, just want to correct something I missed.

Jonathan Nieder wrote:
> Brandon Casey wrote:

>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index f2ca536..64e793a 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
> [...]
>> @@ -183,16 +183,16 @@ test_success=0
>>  
>>  die () {
>>  	code=$?
>> -	if test -n "$GIT_EXIT_OK"
>> +	if test -n "$GIT_EXIT_CODE"
>>  	then
>> -		exit $code
>> +		exit $GIT_EXIT_CODE
>>  	else
>>  		echo >&5 "FATAL: Unexpected exit with code $code"
>>  		exit 1
>>  	fi
>>  }
>
> $code can be removed now, right?

Sloppy reading on my part here: $code is still used in the error
message on unexpected exits.  The $code will be inaccurate on Suns
in some cases, but this is only a cosmetic problem and the wrong
value should be better than nothing for debugging.

> lib-httpd.sh:96:        trap 'code=$?; stop_httpd; (exit $code); die' EXIT
>
> It is probably worth changing that, too, unless GIT_TEST_HTTPD would not
> work on these platforms for some other reason.

This is used to support that error message, so it should not be
changed, either.

Your patch looks good.  Maybe the commit message could explain this,
though?

Apologies for the noise,
Jonathan
