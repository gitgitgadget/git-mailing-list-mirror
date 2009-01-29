From: Moriyoshi Koizumi <mozo@mozo.jp>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 22:59:27 +0900
Message-ID: <4981B63F.4040100@mozo.jp>
References: <1233221532.21518.1.camel@lena.gsc.riken.jp> <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXKX-0000ib-3h
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZA2Nvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZA2Nvw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:51:52 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:47435 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZA2Nvv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 08:51:51 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8695096wfd.4
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=WWCVip/COrcGEycKknHEi7QCN86PaMAk6U/yJkvnnZM=;
        b=dZiCLldTiQTclBEzzuD+3m5Ec7fHjbgOfrlblySA5PH/cz4i8l4PGIT9j/kB/DhGqs
         sDAu8p3Rz9/EXh0q9wxTmNq/yS2/to7sh1S9KC49uAVk/tbpIYZi+cetKta2UJzjIlgU
         /aFs4AyclYQXYlv+1B1TB9TtKN0oiMSCK6ozc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=IBvLIABfnwSjbvnUp+EMhsDnmezEZhwbmW34VuHZjFJEoiMLWqPxbw7RcXCKIMs7ca
         F0zP1u/f3tQaZDlqFVO7LISDphu19uMf78xGQfZlLAwheIGJLxTpfKKnpQMLEAJiUOcW
         AlU//mKk7+7gxGE+eCkbFeWvdvWw94LjoGACg=
Received: by 10.143.3.4 with SMTP id f4mr24966wfi.299.1233237109822;
        Thu, 29 Jan 2009 05:51:49 -0800 (PST)
Received: from ?192.168.0.131? (i58-89-25-149.s04.a014.ap.plala.or.jp [58.89.25.149])
        by mx.google.com with ESMTPS id 28sm3270023wfg.48.2009.01.29.05.51.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 05:51:48 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107675>

First thank you for the advice. I am not familiar to the code base and
definitely doing something wrong.

Junio C Hamano wrote:
> Moriyoshi Koizumi <mozo@mozo.jp> writes:
>> This patch enables it if supported by CURL, adding a couple of new
> 
> "it" in "enables it" is a bit unclear...

I was a bit in a rush and I thought I got to get this done before I went
home.  This patch dnables various HTTP authentication methods namely
basic, digest, GSS and NTLM that are supported by cURL.  cURL tries to
use basic authentication if the option is not explicitly provided.

> Linewrapped and whitespace damaged patch that would not apply.

Sorry for the crap. I'll try to send the correct one next week.

> I am not a cURL expert, so I'd take your word for these version
> dependencies.
> 
> We do not initialize static scope pointers to "= NULL" nor variables to 0,
> instead we let BSS take care of that for us.  ftp_no_epsv we can see in
> the context is doing unnecessary initialization that should be fixed.

Right.

>> +#if LIBCURL_VERSION_NUM >= 0x070a06
>> +	if (!strcmp("http.auth", var)) {
>> +		if (curl_http_auth == NULL)
> 
> We tend to say "if (!pointer)".

I'll fix this too.

> I see you implemented "the first one wins" rule with this test, but I do
> not think you want that.  We first read $HOME/.gitconfig and then
> repository specific $GIT_DIR/config, so it is often more useful to use
> "the last one wins" rule.

The environment variables win over gitconfigs. I thought that's what I
implemented and what we want.

> Our isspace() is a sane_isspace(), so you do not have to play casting
> games between signed vs unsigned char.
> 
>> +	for (;;) {
>> +		char *q = buf;
>> +		while (*p && isspace(*p))
>> +			++p;
>> +
>> +		while (*p && *p != ',')
>> +			*q++ = tolower(*p++);
>> +
>> +		while (--q >= buf && isspace(*(unsigned char *)q));
>> +		++q;
>> +
>> +		*q = '\0';
>> +
>> +		if (strcmp(buf, "basic") == 0)
> 
> Say !strcmp(buf, "literal") like you did in the configuration parsing part
> earlier.

I tend to like this way, and the reason for the inconsistency between
them is that the earlier one is pasted from the nearby code.  I'm
willing to fix this as well if I should.

> 
>> +			mask |= CURLAUTH_BASIC;
>> +		else if (strcmp(buf, "digest") == 0)
>> +			mask |= CURLAUTH_DIGEST;
>> +		else if (strcmp(buf, "gss") == 0)
>> +			mask |= CURLAUTH_GSSNEGOTIATE;
>> +		else if (strcmp(buf, "ntlm") == 0)
>> +			mask |= CURLAUTH_NTLM;
>> +		else if (strcmp(buf, "any") == 0)
>> +			mask |= CURLAUTH_ANY;
>> +		else if (strcmp(buf, "anysafe") == 0)
>> +			mask |= CURLAUTH_ANYSAFE;
>> +
>> +		if (!*p)
>> +			break;
>> +		++p;
>> +	}
> 
> You leak "buf" here you forgot to free.  The string you can possibly
> accept is a known set with some maximum length, so you can use a on-stack
> buf[] and reject any token longer than that maximum, right?

That one is really silly and shameful :-( I first thought I could go
with the on-stack buffer, but I eventually did this because the input
might contain an indefinite set of tokens, and thought safer to alloc it.

>> +	if (curl_http_proxy) {
>> +		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> +
>> +		if (curl_http_proxy_auth) {
>> +			long n = get_curl_auth_bitmask(curl_http_proxy_auth);
>> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, n);
>> +		}
>> +	}
>> +
> 
> This part does not have to be protected with the LIBCURL_VERSION_NUM
> conditional?  I somehow find it unlikely...

The block that starts with if (curl_http_proxy_auth) {} should've been
enclosed by the conditinals. The leading part had been there in the
first place.

> Instead of parsing the string every time a curl handle is asked for, how
> about parsing them once and store the masks in two file scope static longs
> in http_init() and use that value to easy_setopt() call here?

That has to be the way to go, but the question is where I am supposed to
parse the strings and store them to the globals?

>
> That way you can free the two strings much early without waiting for
> http_cleanup(), too, right?

Regards,
Moriyoshi
