From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to determine version of binary
Date: Sat, 5 May 2012 17:13:06 +0530
Message-ID: <20120505114306.GA1498@sita-lt.atc.tcs.com>
References: <jo2jtd$m6c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 13:43:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQdOY-0005eB-Nt
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 13:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab2EELnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 07:43:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38844 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab2EELnV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 07:43:21 -0400
Received: by pbbrp8 with SMTP id rp8so4851730pbb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+b4uajUNEEnr0R5vT4q7QUZKMFnsoWsadILM0APcr6g=;
        b=uFgKuFW4KX+5VZXy2ZeaAmAYrHrXnqSvQvjCJkN30OrSZex0dKyAaMbKgsoAPohV8M
         1VYXlltGUTNPEd+Ngo73TTXrt3MTC4c2GRSQKA1WQ3lfw83yG8iaZd7tm3NI5Ytih7PW
         vmnMO8XSwpObrLOUHT6d8Fnqn0gxyqWgVRLjI9H0H6mMEGxdB9sx9ZPsRbRA0hKzV2g+
         ZImzn3gnZE2nTSS7r1/A7hjZDqpbFZ1XLahAb5qIAwoCqyPMn0Z4MMQ6AN896Lb41yIN
         kEfaSLAuAnoQrkIeupcNckII6Bmqcvujt05Ul0qk6Q1FAN/nwIxTHL+GZxxo6fYFsYKo
         zGWA==
Received: by 10.68.135.226 with SMTP id pv2mr23628268pbb.127.1336218201289;
        Sat, 05 May 2012 04:43:21 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.190.111])
        by mx.google.com with ESMTPS id vl10sm11623382pbc.37.2012.05.05.04.43.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 04:43:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <jo2jtd$m6c$1@dough.gmane.org>
Received: by 10.182.108.67 with HTTP; Sat, 5 May 2012 04:38:26 -0700 (PDT)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197106>


On Sat, May 5, 2012 at 12:42 PM, Neal Kreitzinger <nkreitzinger@gmail.c=
om> wrote:
> Scenario: =A0I detect a binary file that is 'dirty'. =A0I don't know =
how it got
> there. =A0However, I know it came from a git repo. =A0So I calculate =
the sha1 of
> the binary. =A0What is the git command to determine which commit that=
 binary

make sure you are using 'git hash-object' to compute the sha,
not the system supplied 'sha1sum' or eqvt.

> version first appeared in? =A0And the last commit that binary appeare=
d in?

Unless it is a frequent need, I would just use git log's --raw
option to search for the first 7 digits of the SHA you found
above.

=46or example, a very quick one (which does not count odd
situations like the same file appearing multiple times or on
other branches, for instance) is:

    git log --raw | less +/$SHA

You'll want a line where the SHA appears as the second SHA, not
the first one (in case a later commit changed the file it would
also appear as the first sha).  Example, I'm looking for
"14136eb", so I type in

    git log --raw '--format=3D%n%ncommit: %h subject: %s' | egrep commi=
t\|14136eb | grep -B 1 14136eb

The output I get back is:

    commit: 1cf062f subject: ACCESS_CHECK split into ACCESS_1 and ACCES=
S_2; docs updated
    :100755 100755 14136eb... 2a57e2d... M	src/gitolite-shell
    --
    commit: b391000 subject: POST_GIT triggers get 4 more arguments
    :100755 100755 20f4e5d... 14136eb... M	src/gitolite-shell

So the commit that introduced this version of this file is
b391000 (1cf062f is a later one where this file got changed to
something else).
