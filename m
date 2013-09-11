From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 21:59:53 +0200
Message-ID: <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 22:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJqa0-0001DM-VW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 22:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab3IKT74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:59:56 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:44919 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3IKT7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:59:54 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so8031348lab.27
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tJhONc3QnzsvDQlnKo8uG1l6ZIWoR3ZR7XW+59KNnrg=;
        b=kZsL5nVJaLnlT+YtCzOLGCUC1plW9kSZhGFsCY69nluyMwKBwFHYDWuJv2cI8Mp0xa
         Ywuw8CliMQ6ebgWln9En1qCN+/wDEVUNGlGK0lcyAYRgF6I0Ho4N48W0rnI1Wgz3J304
         jel6cthEkO7d5+J9qC9AQ3dlvKK0vf/mj6l+7OWzKR7N7bfup70erlQRp0k2JwqlI2UW
         taMc4DwUltzpvXC/qfJz8zWzVzdCvxCzzIFe+mPMSYIJQicq9DZV9C1GL4r2xkIuS2+V
         vQmxRqJOVmrnUeWS4T6gTjxxLC+TxUWjWTXege9w5apKWIbQR5tEpwBhTBHKvi4BH5J8
         6Y/A==
X-Received: by 10.112.172.137 with SMTP id bc9mr4037196lbc.21.1378929593456;
 Wed, 11 Sep 2013 12:59:53 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Wed, 11 Sep 2013 12:59:53 -0700 (PDT)
In-Reply-To: <20130911182921.GE4326@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234605>

On Wed, Sep 11, 2013 at 8:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> This is necessary so that read_mailmap() can obtain a pointer to the
>> function.
>
> Hm, what platform has strcasecmp() as an inline function?  Is this
> allowed by POSIX?  Even if it isn't, should we perhaps just work
> around it by providing our own thin static function wrapper in
> mailmap.c?

I'm on Windows using MSYS / MinGW. Since MinGW runtime version 4.0,
string.h contains the following code (see [1]):

#ifndef __NO_INLINE__
__CRT_INLINE int __cdecl __MINGW_NOTHROW
strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
{return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}
#else
#define strncasecmp _strnicmp
#endif

[1] http://sourceforge.net/p/mingw/mingw-org-wsl/ci/master/tree/include/string.h#l107

-- 
Sebastian Schuberth
