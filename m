From: Delcypher <delcypher@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 21:36:19 +0100
Message-ID: <CANNJ_zi=qrhmWjd0_QR5-LLjuf2yM8g88xhiwmwdqansvaYy3A@mail.gmail.com>
References: <53076DFC.1000602@gmail.com>
	<53499bb02c140_285f9032ec58@nysa.notmuch>
	<CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
	<53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
	<CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
	<535425d891e41_6b186d130cc5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 22:36:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbyTQ-0000cn-FD
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 22:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaDTUgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 16:36:21 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:54524 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaDTUgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 16:36:20 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so6582976veb.15
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SxDPLSES87lVnbvBWfnOUocdtG9mQQt7CWFZLiVnL5A=;
        b=g6tr+xHwpTdHFIIOPapFhnvlrX7oc9d9Ihz0y/5w6EY/tw5EIcNZZdp4XyJhE5uw6E
         49opL+KeEFRsmoZ7xfEZQeUGhx4nobNbZpzoLoSg1nz2FFr0OehGPs8bOm646KMml8F4
         BOHHZWzL3k1akQC6RYzsRG82SBnag7WfvRgGKAP1uuMax4cEnoDimO1PBhXhqMdEj2GB
         Qsj3DklIvLWINTykR8A9o1hn/AAh7lvo6emG8ouZibjubsQx1LDck/8DZCZazTij3Wy/
         DjNs+28F0K/TuNEngUPettR3OXwB+romEuQTjGaTtkeB6eunbyie4lUQ0acWYQGvjDiu
         ks9w==
X-Received: by 10.58.38.166 with SMTP id h6mr171449vek.22.1398026179143; Sun,
 20 Apr 2014 13:36:19 -0700 (PDT)
Received: by 10.220.88.70 with HTTP; Sun, 20 Apr 2014 13:36:19 -0700 (PDT)
In-Reply-To: <535425d891e41_6b186d130cc5@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246580>

> Same as me. And which version of git-remote-hg are you using?

I'm using the version that ships with git 1.9.2

I've taken a look and it seems I made a mistake, sorry. It seems that

[ui]
quiet = True

is being respected when placed in ``.git/hg/origin/clone/.hg/hgrc``

with the un patched version of git-remote-hg.

But it is still the case that authentication details are being ignored
when present in  ``.git/hg/origin/clone/.hg/hgrc``

i.e. something like the following is ignored.

[auth]
cc.prefix = hg.codeplex.com
cc.username = USERNAME
# Eurgh fixme this shouldn't live here.
cc.password = PWD
cc.schemes = https

and pushing fails. An easy way of duplicating this is forking a
project on codeplex (e.g. [1]), cloning that respository, making a
trivial commit and then trying to push that commit to your fork.

When I try this pushing fails because the authentication details are
being ignored in  ``.git/hg/origin/clone/.hg/hgrc``. Applying my patch
(or your improved version using repo.ui instead of
repo._unfilteredrepo.ui) fixes this for me.

[1] https://boogie.codeplex.com/SourceControl/latest
