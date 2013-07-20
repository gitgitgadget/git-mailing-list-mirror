From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Fix compilation on OS X.
Date: Sat, 20 Jul 2013 14:06:48 +0200
Message-ID: <51EA7D58.3050800@web.de>
References: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 14:07:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0VwX-0000ea-Hy
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 14:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab3GTMGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 08:06:53 -0400
Received: from mout.web.de ([212.227.17.12]:63685 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab3GTMGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 08:06:52 -0400
Received: from [10.0.0.74] ([107.0.115.51]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0MW6Ib-1UcSbj0aSX-00XGwV for <git@vger.kernel.org>; Sat,
 20 Jul 2013 14:06:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1374306567-16640-1-git-send-email-tsunanet@gmail.com>
X-Provags-ID: V03:K0:rkycuQg3dA0bH33rAP5/aN74QFfBrm5uep0z+e6Ql+3UH1dJNzj
 tQ7U3PjK2PgNJmROSFEId6dQVQTyq142sA1GzeBjoRNhHY8WWUDW11LH8M8prGy5JY10VVx
 Qc07c2EfoDxcv2/Qbk8tWX8K+KIWBbEdbeSPlrzN0NO+n35sO/LaK3GWi5oZ+eLi00FDITp
 fFdbxbx8Hd4agc1lFQr0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230895>

On 2013-07-20 09.49, Benoit Sigoure wrote:
> +#ifdef __APPLE__
> +// On OS X libc headers don't define this symbol.
> +extern char **environ;
> +#endif
> +
A more generic approach could be:

In the file "config.mak.uname": Define a variable in the Darwin section like this
NO_EXT_ENVIRON = UnfortunatelyYes

In "Makefile", pick it up, and convert it into a compiler option:
ifdef NO_EXT_ENVIRON
	BASIC_CFLAGS += -DNO_EXT_ENVIRON
endif

And in "git-compat-util.h", add these lines "at a good place":
#ifdef NO_EXT_ENVIRON
extern char **environ;
#endif

This will allow other OS to use the NO_EXT_ENVIRON when needed,.

Thanks for working on this.
/Torsten
