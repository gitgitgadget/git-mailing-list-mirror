From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] commit: Fix a memory leak in determine_author_info
Date: Mon, 15 Jul 2013 16:46:38 +0200
Message-ID: <51E40B4E.7040309@googlemail.com>
References: <1373810463-7144-1-git-send-email-stefanbeller@googlemail.com> <7vehazevf3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 16:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyk2o-0002uw-Tg
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 16:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab3GOOq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 10:46:27 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:60163 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab3GOOq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 10:46:26 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so4675240bkc.16
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=3PgRRLvvIWmwyIWLx1Kk/mkluGcYjP8af+gcZoCgRfM=;
        b=WJoQxVLbyvNqp3p9WgCH0PGzg8CVXpiGvvBUyPqWk+js3z6rZobPRAqfP/yl7VxFuB
         +MqTwZ0j+imQ6WGXlmA5S6ulY07t3Xdq9HJALIqeEzSC0HaVHxWgUHCOGs/nW+gcJ+Qv
         cGe5FmCbId9dD3GvEn3x6CuJGZjvU09X9CUzRaSBfPzhEYfKmSBPkDlPtI0976PoTyW8
         1/R0HcqeTZEeEPtUP4JSDiMiOsEe5NDD+8ZwnJVrM9KlOuHFiwG2PS6rahC80qHfLXvA
         rSrkn+1GoRmFRiUlvtl/4X4Grb1nVJ+P1OWayh9KIiU0cWlUeM2Wri4PyWQYWA8uCwCW
         0H4g==
X-Received: by 10.204.175.141 with SMTP id ba13mr7808553bkb.115.1373899584968;
        Mon, 15 Jul 2013 07:46:24 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id kz11sm12440215bkb.11.2013.07.15.07.46.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 07:46:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vehazevf3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230472>

On 07/15/2013 04:42 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
>> The date variable is assigned new memory via xmemdupz and 2 lines later
>> it is assigned new memory again via xmalloc, but the first assignment
>> is never freed nor used.
>> ---
>>  builtin/commit.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 790e5ab..00da83c 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -534,7 +534,6 @@ static void determine_author_info(struct strbuf *author_ident)
>>  					(lb - strlen(" ") -
>>  					 (a + strlen("\nauthor "))));
>>  		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
>> -		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
>>  		len = eol - (rb + strlen("> "));
>>  		date = xmalloc(len + 2);
>>  		*date = '@';
> 
> Makes sense. I'd assume this is signed-off?
> 

As I realised I did not sign it,
I resend it with some other findings a few hours later,
so you'll find it there as well.

See Message-ID
<1373837749-14402-2-git-send-email-stefanbeller@googlemail.com>
[PATCH 2/4] commit: Fix a memory leak in determine_author_info
