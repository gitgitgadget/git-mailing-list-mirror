From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 11:40:50 -0600
Message-ID: <20101123174050.GB12113@burratino>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:41:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwrc-0000uW-0F
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab0KWRk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:40:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62765 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab0KWRk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:40:57 -0500
Received: by fxm13 with SMTP id 13so4099307fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=929MnVS7zGzeOxmXKpcAJXsiX9IjSeFUpxnY8tyawFc=;
        b=GlKcu5poBrWiUgwlThJjTkup6Tlk6DSjOt3nzS0xz+hKqO7zJO7zNQhz6gFwrnc5Oq
         D8ZLHC1yeekyqQm05FU4ct1CLTPNELl9DiDga+X2Q5tckggJGNXX3c5l5Oj9lkgjIQ6V
         p6DrjK1Uux2b/92VgfmdO/p17M2EccRoRnbrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H2UTClzLPmAgqfbl8CcUBd0VQekaPD44wZFO4YvkD4VaQoD5OEJlrykIyqLmdiGaoD
         oYU49f4XUsGJGrlnNQGKgSzlCFbiVws9ssHFPWhuBhvcJm8kgRCU+W5XRPUvsAbYAVyH
         pxSeNVDT3NsT5/dmnP0UT4+RdQDynGBT6s5BE=
Received: by 10.223.70.138 with SMTP id d10mr5970865faj.2.1290534055959;
        Tue, 23 Nov 2010 09:40:55 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n1sm717611fam.40.2010.11.23.09.40.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:40:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290533444-3404-2-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161991>

Erik Faye-Lund wrote:

> --- a/compat/msvc.c
> +++ b/compat/msvc.c
> @@ -7,16 +7,13 @@ DIR *opendir(const char *name)
>  {
>  	int len;
>  	DIR *p;
> -	p = (DIR*)malloc(sizeof(DIR));
> +	p = xmalloc(sizeof(DIR));
>  	memset(p, 0, sizeof(DIR));
>  	strncpy(p->dd_name, name, PATH_MAX);
>  	len = strlen(p->dd_name);
>  	p->dd_name[len] = '/';
>  	p->dd_name[len+1] = '*';
>  
> -	if (p == NULL)
> -		return NULL;

A behavior change but maybe a good one.  For example, the
prune_packed_objects() loop currently skips object dirs it can't open,
even if that is due to memory exhaustion, but this changes it to error
out.

What is the motivation?
