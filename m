From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2 5/5] Use kwset in grep
Date: Mon, 22 Aug 2011 08:39:20 +0200
Message-ID: <4E51F998.50801@gnu.org>
References: <20110820223032.12380.72469.stgit@localhost6.localdomain6> <20110820224218.GF2199@fredrik-Q430-Q530>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 08:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvOAU-0007y8-1e
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 08:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab1HVGjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 02:39:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61160 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868Ab1HVGjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 02:39:24 -0400
Received: by wwf5 with SMTP id 5so4884778wwf.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rgFlKNMtb4SJu0OAQgKHDp8K8BERStpJ/UNJSSiSPlo=;
        b=D8BHKWYX1O1+NL9FADdNhh8uOnEBSUjvVS08fj/QsMCI/pcwA/9XiQDZJE3XgicsY8
         x+NM2p8psp1QdhxxAHCG5YBUk++I4KuI/5IJPdciZC9XNcYtreXTGsVeN7RL1AiHz1IR
         gixurtMf34WMms0s6PGrqZQSj/cLFUCiqdrh4=
Received: by 10.216.69.77 with SMTP id m55mr1641052wed.11.1313995162729;
        Sun, 21 Aug 2011 23:39:22 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-199-31.ip51.fastwebnet.it [93.34.199.31])
        by mx.google.com with ESMTPS id y61sm3716177wec.30.2011.08.21.23.39.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Aug 2011 23:39:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <20110820224218.GF2199@fredrik-Q430-Q530>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179843>

On 08/21/2011 12:42 AM, Fredrik Kuivinen wrote:
> +		if (opt->regflags&  REG_ICASE || p->ignore_case) {
> +			static char trans[256];
> +			int i;
> +			for (i = 0; i<  256; i++)
> +				trans[i] = tolower(i);
> +			p->kws = kwsalloc(trans);
> +		} else {
> +			p->kws = kwsalloc(NULL);
> +		}

Of course, this makes absolutely no sense for MB_CUR_MAX > 1.  It's 
worth mentioning that grep instead uses a loop with 
mbrtowc/towlower/wcrtomb.  This in turn will remove the need for the 
complex kwset code. :)

The "mbtolower" code" dates to after the license change, but I wrote it 
and I give permission to use it under GPLv2.  See commits 70e23616 and 
30af8050 in the GNU grep repository.

Should still be good enough for most uses, so I'll give my

Acked-by: Paolo Bonzini <bonzini@gnu.org>

Paolo
