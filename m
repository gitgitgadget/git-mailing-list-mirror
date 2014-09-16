From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 10/35] cache.h: define constants LOCK_SUFFIX and
 LOCK_SUFFIX_LEN
Date: Tue, 16 Sep 2014 14:05:38 -0700
Message-ID: <20140916210538.GK29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:05:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzwY-0004HX-G8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbaIPVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 17:05:42 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39953 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaIPVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 17:05:41 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so575831pdj.16
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PucWKjO7srE99UISrbZIwhmpta3K2Lx3VQ+PgRJHAEc=;
        b=SJ4M7Nm5fJisgPXg1bVVofVGzTNBsAdc9utNNXSlBRu4xYBu99Lq4Cdz3hd1In6rBT
         8fU9Ol81P6gXa8aBl2qdUNVOwYS0O1jx8RGw65lUxumOiNiqgoNDxqQTHkQQwvXRIxjU
         l/szqzwxA1Me2Q9NuSbfxp3rvjGXM5uOSL/zrSrb2BH5RA3V31pN2oczzsMQ6E7KdzWu
         xgoKj+D1cN2iZbUXIaKgiuDwjjvUYFMmHXI4liJYtlFWVgC/Vh3IOZCsniK/us7kGxF/
         Zykerhz90KxS1lzuAOssWGl5CV2HwTEOkJNvUhgJWCBEvwVv8p12CNWtmqkvTI22+eFk
         Dy1g==
X-Received: by 10.68.134.71 with SMTP id pi7mr54214900pbb.86.1410901541556;
        Tue, 16 Sep 2014 14:05:41 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id d9sm14977356pdp.44.2014.09.16.14.05.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 14:05:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-11-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257194>

Michael Haggerty wrote:

> There are a few places that use these values, so define constants for
> them.

Seems like a symptom of the API leaving out a useful helper (e.g.,
something that strips off the lock suffix and returns a memdupz'd
filename).

[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -570,6 +570,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
>  #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
>  extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
>  
> +/* String appended to a filename to derive the lockfile name: */
> +#define LOCK_SUFFIX ".lock"
> +#define LOCK_SUFFIX_LEN 5

My suspicion is that error handling would be better if fewer callers
outside of lockfile.c did the '- LOCK_SUFFIX_LEN' dance, so this seems
like a step in the wrong direction.

Adding constants in lockfile.c would make sense, though.

Thanks,
Jonathan
