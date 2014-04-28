From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 12:37:42 -0500
Message-ID: <535e91e6c69eb_4565148331047@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerTV-0005CL-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489AbaD1ToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:44:21 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40270 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbaD1ToU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:44:20 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so7722362obc.25
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=LmmFMRVymIFbUFYJn2jM+zvASD4cRDu0C6/yXWfIlmU=;
        b=sq99XdWPp7dezgR6C1pIEGMU6c1UKcTHJmd35JE5C074EQF0V48jiGKqbbtbf9AmMU
         /n207THt6ZJeYxlboI7GGxjysrz+2JYNF6xHUF2dEh4BwmFBI/1U58X2AX6ES82u3kuW
         5DmEgL77GGPAjJMGQ/KCxRkVXg57ci1CcrrYzWqlSERD0oAuS47+HnxfduXvfeJEAwz8
         UvfxMZWrDCl3uqnrWq9mAr+6SzJl6crNPZ7q2ZakIaLT58S5MLkCHtDDRqxayzwuSsrQ
         DxQQoB9JAAd0AX0OfyqTWgu7CMwCtfvBb7/Z7fV+q9hAQHC3PzukgPQwUV4cUZh7lJH6
         X1YQ==
X-Received: by 10.60.93.168 with SMTP id cv8mr23597717oeb.21.1398707296383;
        Mon, 28 Apr 2014 10:48:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm38100748obr.15.2014.04.28.10.48.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 10:48:15 -0700 (PDT)
In-Reply-To: <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247419>

Marat Radchenko wrote:

> diff --git a/Makefile b/Makefile
> index 74a929b..24befc2 100644
> --- a/Makefile
> +++ b/Makefile

> @@ -401,8 +404,11 @@ htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
>  
>  export prefix bindir sharedir sysconfdir gitwebdir localedir
>  
> -CC = cc
> -AR = ar
> +AR = $(CROSS_COMPILE)ar
> +CC = $(CROSS_COMPILE)cc
> +GCOV = $(CROSS_COMPILE)gcov
> +STRIP = $(CROSS_COMPILE)strip

Nice.

> diff --git a/config.mak.uname b/config.mak.uname
> index 5d301da..6c2e6df 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -511,7 +511,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	EXTLIBS += -lws2_32
>  	GITLIBS += git.res
>  	PTHREAD_LIBS =
> -	RC = windres -O coff
> +	RC = $(CROSS_COMPILE)windres -O coff

I don't think this is the best.

We should probably have this in the Makefile:

  RC = $(CROSS_COMPILE)windres

And then config.mak.uname should have

  RCFLAGS += -O coff

>  	NATIVE_CRLF = YesPlease
>  	X = .exe
>  	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield

-- 
Felipe Contreras
