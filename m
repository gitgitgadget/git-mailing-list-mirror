From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Mon, 09 May 2005 21:30:08 -0700
Message-ID: <428038D0.5000706@zytor.com>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 06:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVMGw-0008KG-Eb
	for gcvg-git@gmane.org; Tue, 10 May 2005 06:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEJEaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 00:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEJEaT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 00:30:19 -0400
Received: from terminus.zytor.com ([209.128.68.124]:41934 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261540AbVEJEaN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 00:30:13 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4A4U8jk007591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 21:30:10 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mark Allen wrote:

>  
> Index: local-pull.c
> ===================================================================
> --- 972d8624458936868e6f392b40858b7c362af8cd/local-pull.c  (mode:100644)
> +++ uncommitted/local-pull.c  (mode:100644)
> @@ -71,7 +71,7 @@
>                 close(ofd);
>                 if (status)
>                         fprintf(stderr, "cannot write %s (%ld bytes)\n",
> -                               dest_filename, st.st_size);
> +                               dest_filename, (long) st.st_size);
>                 else
>                         pull_say("copy %s\n", hex);
>                 return status;

This is just plain WRONG.  st.st_size is longer than long on many 
architectures, including Linux/i386.

The easiest way to deal with it is to #include <inttypes.h>, use %jd and 
cast it to (intmax_t).  That is, however, a C99-ism.

	-hpa
