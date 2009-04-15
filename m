From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 16:14:42 +0200
Message-ID: <49E5EBD2.1070704@op5.se>
References: <1239797816-24582-1-git-send-email-ae@op5.se> <49E5DE98.1080600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 16:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu5uY-00014m-9H
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 16:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbZDOOOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbZDOOOq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 10:14:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43206 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZDOOOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 10:14:45 -0400
Received: by fg-out-1718.google.com with SMTP id e12so938953fga.17
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 07:14:43 -0700 (PDT)
Received: by 10.86.36.17 with SMTP id j17mr206508fgj.38.1239804883524;
        Wed, 15 Apr 2009 07:14:43 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e20sm11135135fga.14.2009.04.15.07.14.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 07:14:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49E5DE98.1080600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116612>

Johannes Sixt wrote:
> Andreas Ericsson schrieb:
>> +/*
>> + * strip username information from the url
>> + * This will allocate a new string, or return its argument
>> + * if no stripping is necessary.
>> + *
>> + * The url's we want to catch are the following:
>> + *   ssh://[user@]host.xz[:port]/path/to/repo.git/
>> + *   [user@]host.xz:/path/to/repo.git/
>> + *   http[s]://[user[:password]@]host.xz/path/to/repo.git
>> + *
>> + * Although git doesn't currently support giving the password
>> + * to http url's on the command-line, it's easier to catch
>> + * that case too than it is to cater for it specially.
>> + */
>> +static char *anonymize_url(const char *url)
>> +{
>> +	char *anon_url;
>> +	const char *at_sign = strchr(url, '@');
>> +	size_t prefix_len = 0;
>> +
>> +	if (!at_sign)
> 
> 	if (!at_sign || has_dos_drive_prefix(url))
> 
> or even better move this function to transport.c and use is_local().

Good idea, even though it really shouldn't matter in practice due
to the last if() below. Then again, there's no telling what some
silly IDE might take into its head to name paths ;-)

I also see now I botched the job and sent the un-amended patch.
v2 incoming.

> 
>> +		return strdup(url);
>> +
>> +	if (!prefixcmp(url, "ssh://"))
>> +		prefix_len = strlen("ssh://");
>> +	else if (!prefixcmp(url, "http://"))
>> +		prefix_len = strlen("http://");
>> +	else if (!prefixcmp(url, "https://"))
>> +		prefix_len = strlen("https://");
>> +	else if (!strchr(at_sign + 1, ':'))
>> +		return strdup(url);
>> +

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
