From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] userdiff: funcname and word patterns for sh
Date: Sat, 14 Mar 2015 18:19:27 +0100
Message-ID: <vpqoanvjy3k.fsf@anie.imag.fr>
References: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
	<1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>
X-From: git-owner@vger.kernel.org Sat Mar 14 18:19:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWpiy-0008Pa-Bs
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 18:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbbCNRTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 13:19:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58145 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbbCNRTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 13:19:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2EHJPpc013060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Mar 2015 18:19:25 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2EHJRr6031057;
	Sat, 14 Mar 2015 18:19:27 +0100
In-Reply-To: <1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
	(Adrien Schildknecht's message of "Tue, 10 Mar 2015 00:40:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 14 Mar 2015 18:19:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2EHJPpc013060
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426958371.01443@BiZcSk8QmQVhs1QAFC88Qg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265451>

On overall, the patch looks good. Some suggestions to improve the tests
and a minor nitpick below.

Adrien Schildknecht <adrien+dev@schischi.me> writes:

> +++ b/t/t4034/sh/post
> @@ -0,0 +1,36 @@
> +foo() {ls&echo}

This part is unchanged here and in the pre file. What does it test?

> +$((x++))
> +$((x--))
> +$((--x))
> +$((++x))
> +$((x*y))
> +$((x&y))
> +$((x**y))
> +$((x/y))
> +$((x%y))
> +$((x+y))
> +$((x-y))
> +[ x<=y ]
> +[ x>=y ]
> +[ x==y ]
> +[ x!=y ]

Not sure what the last ones are testing. If it's "[" as "the test
command, spelled as [", then spaces are mandatory around the operators
(and equality should be written =, not == in POSIX).

> +x<<y x>>y x<<-y x<y x>y x>|y x<&y x>&y x<>y
> +x&y
> +x&&y
> +x|y
> +x||y
> +x=y
> +$((x+=y))
> +$((x-=y))
> +$((x*=y))
> +$((x/=y))
> +$((x%=y))
> +$((x<<=y))
> +$((x>>=y))
> +$((x&=y))
> +$((x^=y))
> +$((x|=y))

I think you should test the case of multiple-letters identifiers. One of
the benefit of having a proper word-diff pattern is that e.g.

- pre=foo
+ post=bar

will consider the change "pre" -> "post", and not an unmodified "p" with
the change "re" -> "ost" (otherwise, --color-words=. just works).

> +PATTERNS("sh",
> +	"^([ \t]*(function[ \t]+)?[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\).*)$",
> +	/* -- */
> +	 "[a-zA-Z0-9_]+"

Nitpick: the indentation is not homogeneous. You should add a space
after the tab on the first two lines to get a correct alignment.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
