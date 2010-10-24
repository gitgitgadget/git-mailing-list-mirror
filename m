From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add tests to demonstrate update-index bug with core.symlinks/core.filemode
Date: Sun, 24 Oct 2010 16:41:44 -0700 (PDT)
Message-ID: <m37hh7jh17.fsf@localhost.localdomain>
References: <1jqpu2f.1qxnixxtdqhreM%lists@haller-berlin.de>
	<1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Mon Oct 25 01:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAACL-0001aA-QS
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 01:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab0JXXlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 19:41:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50189 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab0JXXlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 19:41:46 -0400
Received: by bwz11 with SMTP id 11so1913255bwz.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=v5/JU5pHPJLxG6DMknV1uRQsiE62Xz09unqUnSaDg64=;
        b=wRkGu1JIWwbE6KCZ/mVo9shI3k7wVvqUtpebMaN0fERhAVXnwNE1XqqBHEdphjUW02
         N3gIoHoUhBvK/rr4CrvIKW8ptrr2vrd2T0pCqEbH8QS1ZgS3Dv0SQ77JHm5LYlV2aw8c
         X/lHgJxfrtRb8mCbkMTCt6rZdGoV2cVyCkklo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=q5QLWGNpsEYb7HmwCGxM609IW0cb/6Urq6oz7HwOzNRDmO1dftzq9ClVMC45C+1mc0
         GcRRULhcl0lZ8jxEr3psoWReYrVBP+LPfFj98jGJgs4KspzLuDPiEJQo+O8p59QV2FEJ
         qvCzmSFidEXTfLKfV8D7v8DR5pMQYLM0DD8rk=
Received: by 10.204.54.68 with SMTP id p4mr4312925bkg.184.1287963705272;
        Sun, 24 Oct 2010 16:41:45 -0700 (PDT)
Received: from localhost.localdomain (abvu207.neoplus.adsl.tpnet.pl [83.8.218.207])
        by mx.google.com with ESMTPS id d27sm4284523bkw.14.2010.10.24.16.41.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 16:41:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9ONf7o0013416;
	Mon, 25 Oct 2010 01:41:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9ONeq51013412;
	Mon, 25 Oct 2010 01:40:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1jqvbx3.1icsj8j1jf26lfM%lists@haller-berlin.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159895>

lists@haller-berlin.de (Stefan Haller) writes:

> This is the first time I write a git test, so please point out anything
> I might have done wrong. Also, I still don't have much of an idea how or
> where to fix the problem, so any guidance towards that is much
> appreciated.
> 
>  t/t2107-update-index-executable-bit-merged.sh |   44 +++++++++++++++++++++++++
>  t/t2108-update-index-symlink-merged.sh        |   43 ++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 0 deletions(-)
>  create mode 100755 t/t2107-update-index-executable-bit-merged.sh
>  create mode 100755 t/t2108-update-index-symlink-merged.sh

I guess that because those two tests are conceptually about the same
thing, namely errors in git-update-index handling permissions which
cannot be represented on filesystem (core.filemode and/or
core.symlinks is false).
 
> diff --git a/t/t2107-update-index-executable-bit-merged.sh b/t/t2107-update-index-executable-bit-merged.sh
> new file mode 100755
> index 0000000..7a8f740
> --- /dev/null
> +++ b/t/t2107-update-index-executable-bit-merged.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Stefan Haller
> +#
> +
> +test_description='git update-index on filesystem w/o symlinks test.
> +
> +This tests that git update-index keeps the executable bit when staging
> +an unmerged file after a merge if core.filemode is false.'

All right.

> +
> +. ./test-lib.sh

All right.

> +
> +test_expect_success \
> +'preparation' '
> +git config core.filemode false &&
> +touch foo &&
> +git add foo &&
> +git update-index --chmod=+x foo &&
> +git commit -m "Create"'

The suggested way of coding in test script looks like the following:

  +test_expect_success 'preparation' '
  +	git config core.filemode false &&
  +	>foo &&
  +	git add foo &&
  +	git update-index --chmod=+x foo &&
  +	git commit -m "Create"
  +'

BTW. does it matter that 'foo' is empty?

[...]
> +test_expect_failure \
> +'check that filemode is still 100755' '
> +case "`git ls-files --stage --cached -- foo`" in
> +"100755 "*foo) echo pass;;
> +*) echo fail; git ls-files --stage --cached -- foo; (exit 1);;
> +esac'

Wouldn't it be better to simply prepare expected output (perhaps with
stubs for hashes), and compare actual with expected output?

Also, weren't you able to use test_tick, test_commit, test_merge
functions from test-lib.sh?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
