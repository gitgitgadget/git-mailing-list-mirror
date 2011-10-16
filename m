From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 1/6] git-p4 tests: refactor and cleanup
Date: Sun, 16 Oct 2011 11:38:57 +0200
Message-ID: <201110161138.58396.stefano.lattarini@gmail.com>
References: <20111015155358.GA29436@arf.padd.com> <20111015155517.GB29436@arf.padd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 11:39:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNBe-0005Uh-Nm
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 11:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab1JPJjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 05:39:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44977 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab1JPJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 05:39:12 -0400
Received: by wyg36 with SMTP id 36so1304532wyg.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=Oi6c/sGOOG8XRdsiB6wbU3m2A4Z16UN9mfm4I6TCJAQ=;
        b=e64E8+FPW4zcihXbGlIK2J5tdAy9aVJZ9o95SHltLl80hr0eefNFK+TsQd4GXZqvn1
         ycCigxx+NJ/9pYQolKrd2SsZs/3iXgxB6vET01W1EfJJ4pVj5g22/hv3NNlTpOpDTcY/
         cbOTq+Zi4Fl4uJvxOQqjxog2xDPzcbwSnd3ww=
Received: by 10.227.38.66 with SMTP id a2mr5395975wbe.81.1318757951353;
        Sun, 16 Oct 2011 02:39:11 -0700 (PDT)
Received: from bigio.localnet (host72-38-dynamic.56-82-r.retail.telecomitalia.it. [82.56.38.72])
        by mx.google.com with ESMTPS id n21sm24428556wbp.2.2011.10.16.02.39.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 02:39:10 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/2.6.30-2-686; KDE/4.6.5; i686; ; )
In-Reply-To: <20111015155517.GB29436@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183696>

Hi Pete, hope you don't mind a couple of minor nits from an outsider ...

> +# Try to pick a unique port: guess a large number, then hope
> +# no more than one of each test is running.
> +#
> +# This does not handle the case where somebody else is running the
> +# same tests and has chosen the same ports.
> +testid=${this_test#t}
> +git_p4_test_start=9800
> +P4DPORT=$((10669 + (testid - git_p4_test_start)))
> +
This won't work with older versions of the Almquist shell (without
prepending `testid' and `git_p4_test_start' with a `$', that is):

  $ ash-0.5.2 -c 'a=4; b=2; echo $(( 1 + (a - b) ))'
  ash-0.5.2: arith: syntax error: " 1 + (a - b) "

Still, it works with all the other POSIX-ish shells that I've tried,
including dash 0.5.5.1 on GNU/Linux, NetBSD 5.1 /bin/sh and /bin/ksh,
and Solaris 10 /bin/ksh and /usr/xpg4/bin/sh, so it might not be worth
worrying about.

Same goes for other similar usages in the rest of the patch, such as
"git config git-p4.detectCopies $((level + 2))"

Regards,
  Stefano
