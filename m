From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing list argument to for loop
Date: Sat, 03 Jul 2010 11:51:35 +0530
Message-ID: <87d3v56q6o.fsf@hariville.hurrynot.org>
References: <80typu1ozt.fsf@tiny.isode.net>
	<8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 09:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUwzT-0001u2-Hp
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 09:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab0GCHSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 03:18:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:34185 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab0GCHSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 03:18:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OUwz9-0001kn-NH
	for git@vger.kernel.org; Sat, 03 Jul 2010 09:17:59 +0200
Received: from 117.192.133.127 ([117.192.133.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 09:17:59 +0200
Received: from harinath by 117.192.133.127 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 09:17:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.133.127
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:wvUisikZGli5V+82QGa1mPr4peg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150178>

Hi,

Brandon Casey <casey@nrlssc.navy.mil> writes:

> ksh does not like it when the list argument is missing in a for loop.  This
> can happen when NO_CURL is set which causes REMOTE_CURL_ALIASES to be unset.
> In this case, the for loop in the Makefile expands to look like this:
>
>    for p in ; do
>
> and ksh complains like this:
>
>    /bin/ksh: syntax error at line 15 : `;' unexpected
[snip]
> -	{ test x"$(REMOTE_CURL_ALIASES)" = x || \
> -		for p in $(REMOTE_CURL_ALIASES); do \
> +	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
> +	for p in $$remote_curl_aliases; do \

I believe the idiom

  test x'$(foo)' = x || for p in ''$(foo); do

works equally well in this case, and is less invasive.

- Hari
