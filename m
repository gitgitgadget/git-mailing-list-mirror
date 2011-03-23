From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Wed, 23 Mar 2011 13:51:18 +0100
Message-ID: <4D89ECC6.7040903@drmicha.warpmail.net>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com> <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org> <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com> <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com> <4D871E51.8090106@drmicha.warpmail.net> <7v7hbqk8ox.fsf@alter.siamese.dyndns.org> <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Nai-000738-OV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab1CWMzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 08:55:03 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58361 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932649Ab1CWMzB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 08:55:01 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DD1D120A46;
	Wed, 23 Mar 2011 08:54:50 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 08:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=EteR1IEWdscz9vfpQj1KGGsG6RQ=; b=ID8ioP9ylhUTJ6CR6ICWXXrB1sXQGoizBDm7Q2hoLlLU9nrAPJozwfyrXIoqXOoIdq1xpcOXL31n48ovH6Paut9yVeIlw7vgJXf9Oc+rh0wsGcF6DBB+DlWLUz2DS2z8Jmq98PK3JxO0yUFAIqGwkgJ82AI+NcmAY2pzz6zsYzs=
X-Sasl-enc: 6goQFFQm1NmTHjJBenXmFF6Zbp9z7jgWEwDw720/tbgv 1300884890
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 241C740946D;
	Wed, 23 Mar 2011 08:54:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTimeEWOvmNXQV9fJKe23Qe3sipT7q=qHVB2fLq0n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169826>

Nguyen Thai Ngoc Duy venit, vidit, dixit 23.03.2011 13:10:
> On Wed, Mar 23, 2011 at 6:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Let's clarify by dumping my understanding of what we aim to achieve.
>>
>> ...
>>
>> Both the ":/<path>" proposal (or your ":<path>" proposal) changes only a
>> very small part of the above, namely, "each prefixed with '<prefix>'" is
>> changed to if the element in original pathspec has the magic colon prefix,
>> the magic is stripped away, and the remainder becomes the element in the
>> resulting pathspec array without additional <prefix> in front.
> 
> Correct.
> 
>> If Nguyen's proposal is to also match ":/<path>" (or ":<path>") literally,
>> that part should be scrapped.  If somebody wants to match such an unusual
>> path component, it can always be expressed by quoting it as a glob,
>> i.e. "[:]/<path>" (or "[:]<path").
> 
> OK.
> 
>> I am slightly in favor of ":<path>" syntax (than ":/<path>"), but I do not
>> care too deeply.  Either has the same problem that it will be confusing
>> with existing and well-established syntax (the former would conflict with
>> "name of the blob in the index", the latter with "name of the commit that
>> match the regexp).
> 
> How about ":<path>" for root pathspecs, but reserve ':[^0-9A-Za-z]*'
> for future use?
> 
> (on top of Michael's patch)
> 
> -- 8< --
> diff --git a/setup.c b/setup.c
> index ef55e5d..1ebe1d2 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -146,8 +146,13 @@ const char **get_pathspec(const char *prefix,
> const char **pathspec)
>  	while (*src) {
>  		const char *p;
> 
> -		if ((*src)[0] == ':')
> +		if ((*src)[0] == ':') {
> +			const char *reserved = "~`!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?";
> +			if (strchr(reserved, (*src)[1]))
> +				die("':%c' syntax is not supported. "
> +				    "Quote it to match literally.", (*src)[1]);
>  			p = prefix_path(NULL, 0, (*src)+1);
> +		}
>  		else
>  			p = prefix_path(prefix, prefixlen, *src);
>  		*(dst++) = p;
> -- 8< --

Sounds good to me so far.

Note that there is also possible notational overlap with the WIP "attr:
make attributes depend on file type" at

http://permalink.gmane.org/gmane.comp.version-control.git/168116

which suggested something like

:symlink:* diff=symlinkdiffdriverofyourchoice

as a notation for attributes which depend on the file type. Is that a
problem, should I do something different there? (Also, I still need help
with that...)

Michael
