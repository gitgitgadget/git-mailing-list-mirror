From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v6 2/3] compat: add a basename() compatibility function
Date: Sat, 30 May 2009 21:42:47 -0700
Message-ID: <20090531044246.GA23995@gmail.com>
References: <1243744675-24160-1-git-send-email-davvid@gmail.com> <1243744675-24160-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 31 06:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAct2-0000ik-CT
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 06:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbZEaEmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 00:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZEaEmw
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 00:42:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:56947 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZEaEmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 00:42:51 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2095847rvb.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ac4gwXKSZ7Y45dijow0PLa2usHksRejGEg/V1Ognp1U=;
        b=WgjQqpS6a+CEJWIG77Q4LRu5QE9BzcqQcFhOgbOcFje85ixXAnH40scviha3tmnVQJ
         VDWbJ9Z9Fe1F7rVASXxWBuQtYuiMCwuFTZPnREagxc8MCmqjD0nl5LFDROl7SyEkiWiT
         3NIQSZS3TVcYkockG0djwEKjmuRRICBL6MIlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MRpqiT+IcxSlo+Irmfb8hET3L1jOJXZyItFi/Rdm7C7o8N4QUp0Tee8xG6fbMi6kcD
         C0XU59zOL/Up/B+ecnDx1FrwRgJj9j8qA0/WleELF8pCh1LEZcwQuRy5rBz0ycpiPpM9
         H/jaeBfZ2a/Q4M1f/0T/dVryjIz+/GU44aCVY=
Received: by 10.140.139.3 with SMTP id m3mr4018440rvd.77.1243744973327;
        Sat, 30 May 2009 21:42:53 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j31sm4233450waf.26.2009.05.30.21.42.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 21:42:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1243744675-24160-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120378>

On Sat, May 30, 2009 at 09:37:54PM -0700, David Aguilar wrote:
> Some systems such as Windows lack libgen.h so provide a
> basename() implementation for cross-platform use.
> [...]
> diff --git a/compat/basename.c b/compat/basename.c
> new file mode 100644
> index 0000000..c45716a
> --- /dev/null
> +++ b/compat/basename.c
> @@ -0,0 +1,19 @@
> +#include "../git-compat-util.h"
> +
> +/* Adapted from libiberty's basename.c.  */
> +char *gitbasename (char *path)
> +{
> +	const char *base;
> +
> +#ifdef USE_WIN32_FS
> +	/* Skip over the disk name in MSDOS pathnames. */
> +	if (isalpha(path[0]) && path[1] == ':')
> +		path += 2;
> +#endif


Thanks for bearing through this series everyone.. ;)

Can someone with better win32 knowledge let me know if the
USE_WIN32_FS stuff is needed for msysgit?

I would really like it if there was a way to do without the
#define.



> +	for (base = path; *path; path++) {
> +		if (is_dir_sep(*path)) {
> +			base = path + 1;
> +		}
> +	}
> +	return (char *)base;
> +}

-- 
		David
