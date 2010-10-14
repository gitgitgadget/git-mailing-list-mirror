From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
 with TAP
Date: Thu, 14 Oct 2010 11:27:57 -0500
Message-ID: <20101014162757.GC16500@burratino>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 18:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6QiK-0003o3-I6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 18:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab0JNQb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 12:31:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52492 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0JNQb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 12:31:26 -0400
Received: by ewy20 with SMTP id 20so3583898ewy.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AvpmMwlsha7bq6geaegl2FNxQYIVV6mlH3+J45vxAtU=;
        b=QnLP9xAvmjQ1mHqY8dXEMvK6IEomYshmh9QFE0sDEXhVOr7PvHzrVOMKMwxtA2LiK9
         p0PmIP7kp8Tnghm9eMJPxi1QD5HgNpVWzKqZHjy+ARE1HkTm3qvXc6OsNltkOTe/5Xeh
         le0SJJ3KT81Dympc/j4FnWAiqibzxQBw4IcG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pd5Tjnsa+Puvg4b1zA13zncdwPdv+SWcyqSoQLfJEkLhPie8/6t6AmqLBwuCqFlSu+
         v4XL8EEG5DbRLn+vJWHe24tQu+vretvDoNZY9hWYPE5c0z5CjGjLnhRupd50XqEBUoMB
         yenAX+5SI04R5iWanqJIcH8bxG+6MAr38CrrY=
Received: by 10.213.30.4 with SMTP id s4mr235338ebc.99.1287073884861;
        Thu, 14 Oct 2010 09:31:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v56sm1332133eeh.2.2010.10.14.09.31.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 09:31:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159055>

Michael J Gruber wrote:

> Introduce a new make target "prove" which runs the tests via "prove"

I like it. :)

I've been using

	prove -j2 --shuffle t[0-9]*.sh

and would be happier to be able to dump GIT_PROVE_OPTS="-j2 --shuffle"
in my config.mak and just run "make prove" instead of that unwieldly
glob.

> RFC also because of lack of doc, and:
> 
> Currently, one can do
> 
> make -C t t6010-merge-base.sh
> 
> or even
> 
> make -C t t601*
> 
> which is cool but undocumented. If we want this with prove it requires more
> effort

Doesn't "prove t601*" work well for that use case already?

> --- a/t/Makefile
> +++ b/t/Makefile
[...]
> +prove: pre-clean
> +	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> +	$(MAKE) clean
> +
>  $(T):
>  	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)

Not about this patch, but is that GIT_CONFIG setting needed?  I would have
guessed rather that test-lib.sh would unset GIT_CONFIG as soon as possible.
