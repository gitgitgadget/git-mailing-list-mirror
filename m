From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT_SSH alternate ssh name or helper
Date: Wed, 03 Aug 2005 10:12:53 -0700
Message-ID: <7viryndjvu.fsf@assigned-by-dhcp.cox.net>
References: <20050803151542.GA6655@medusa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 19:14:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Mnf-0005oq-T7
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVHCRM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVHCRM4
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:12:56 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39124 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262350AbVHCRMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:12:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803171254.SCGH1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 13:12:54 -0400
To: Martin Sivak <mars@nomi.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Sivak <mars@nomi.cz> writes:

> This patch make possible to use alternate ssh binary or ssh helper
> script. The script can be used to give additional parameters to ssh
> binary (like private key, protocol version, ...).
>
> Example script could look like this:
>
> #!/bin/sh
> ssh -1 -i myprivatekey.key "$@"
>
> The patch itself is realy very simple:

I understand why you would want this if your ssh binary is
called something other than ssh [*1*], but I doubt the example
you gave needs this patch.  Could you explain why having
something like this in your .ssh/config file is not enough?

    Host foo.bar.xz
      Protocol 1
      IdentityFile ~/.ssh/privatekey.key

Even if you wish to use different settings between git and
interactive, I presume you could do something like this:

    # for interactive
    Host foo.bar.xz
      Protocol 2

    # real repo is foo.bar.xz:/pub/scm/git/git.git/ but pull with
    # git-foo.bar.xz:/pub/scm/git/git.git/
    Host git-foo.bar.xz
      Hostname foo.bar.xz
      Protocol 1
      IdentityFile ~/.ssh/privatekey.key


[Footnote]
*1* and even in that case you can trivially fix it by having
a small wrapper in $HOME/bin/ssh:

    #!/bin/sh
    exec ssh-installed-under-nonstandard-name "$@"
