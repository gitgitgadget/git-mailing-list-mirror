From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/37] t3030: Add a testcase for resolvable rename/add conflict with symlinks
Date: Mon, 20 Sep 2010 02:34:57 -0700 (PDT)
Message-ID: <m3wrqgkbch.fsf@localhost.localdomain>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
	<1284971350-30590-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Schalk, Ken" <ken.schalk@intel.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 11:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxcmC-0008G1-SS
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 11:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab0ITJfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 05:35:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51857 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab0ITJe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 05:34:59 -0400
Received: by fxm3 with SMTP id 3so503601fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kYpLoQtXkOvGBf1NA80yt0UaLBlDQtPcoHdBofOBcsA=;
        b=Oi7KtswJsuvmO0/PRknaHKHKculH1eWc/m7hm3kizpChy8AieMHtbDSYLlRvfdo2bJ
         Z2EbJWKUOOZi/10H+yszYucj2z6V5VdFFdOCrR5FvYCX2aBNNyrFeIGzDg146g3MN46p
         kiBLU1y6XY9QlZODvZERzbrhOZKkOIebC2lBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=c0gb88RLbDplMopG37zGihYLDJ5haidle3pHCU5VvUf0c5wq7OUo75ers0WpJz12oO
         NbY/w1KimmG2cbi8coQsVuNW7SJywamcZZuZvQxFjrfwkdh6ZvYviYmLLkf7Tz/7SPeN
         5HmigSjKT2mUuwqyJb6zh//f5VB2IJ6NWVeJs=
Received: by 10.223.125.148 with SMTP id y20mr861459far.94.1284975297925;
        Mon, 20 Sep 2010 02:34:57 -0700 (PDT)
Received: from localhost.localdomain (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id a7sm2818376faa.45.2010.09.20.02.34.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 02:34:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8K9YNTI007334;
	Mon, 20 Sep 2010 11:34:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8K9Y7h4007330;
	Mon, 20 Sep 2010 11:34:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1284971350-30590-2-git-send-email-newren@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156606>

Elijah Newren <newren@gmail.com> writes:

Just an addition to what Johannes Sixt wrote.

> @@ -255,7 +259,16 @@ test_expect_success 'setup 8' '
>  	git mv a e &&
>  	git add e &&
>  	test_tick &&
> -	git commit -m "rename a->e"
> +	git commit -m "rename a->e" &&
> +	if test_have_prereq SYMLINKS
> +	then
> +		git checkout rename-ln &&
> +		git mv a e &&
> +		ln -s e a &&
> +		git add a e &&
> +		test_tick &&
> +		git commit -m "rename a->e, symlink a->e"
> +	fi

Wouldn't it be better to move it to separate test_expect_success
entry... if SYMLINK prerequisite would be really needed (Johannes says
it isn't).

> +if test_have_prereq SYMLINKS
> +then
> +	test_expect_success 'merge-recursive rename vs. rename/symlink' '
[...]
> +fi

It is better to use

  +test_expect_success SYMLINKS 'merge-recursive rename vs. rename/symlink' '

form, see t/README about three-argument form of test_expect_success.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
