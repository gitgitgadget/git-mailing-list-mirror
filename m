From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-web--browse: don't add start as candidate on
 Ubuntu
Date: Sat, 03 Jan 2009 23:53:56 -0800
Message-ID: <7vljtr33sb.fsf@gitster.siamese.dyndns.org>
References: <495D3964.6040006@ramsay1.demon.co.uk>
 <200901040833.25849.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 08:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJNqQ-0005v9-9j
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 08:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbZADHyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 02:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbZADHyL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 02:54:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZADHyK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 02:54:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CBBE61BBD8;
	Sun,  4 Jan 2009 02:54:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DE7BC1BBD7; Sun, 
 4 Jan 2009 02:54:00 -0500 (EST)
In-Reply-To: <200901040833.25849.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sun, 4 Jan 2009 08:33:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DCC7D47A-DA34-11DD-AFA8-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104497>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le jeudi 1 janvier 2009, Ramsay Jones a =C3=A9crit :
> ...
>> Does anybody else see this issue and can someone test the patch?
>
> Petr, as you added support for using /bin/start on MinGW, could you t=
est?
>
> Thanks,
> Christian.

> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index 78d236b..7ed0fad 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -115,7 +115,7 @@ if test -z "$browser" ; then
>  	browser_candidates=3D"open $browser_candidates"
>      fi
>      # /bin/start indicates MinGW
> -    if test -n /bin/start; then
> +    if test -x /bin/start; then
>  	browser_candidates=3D"start $browser_candidates"
>      fi

In any case, the original test is simply bogus.  'test -n "$foo"' is to
see if $foo is an empty string, and giving a constant /bin/start always
yields true.

As an old timer, I tend to prefer "test -f" in this context, as anybody
sane can expect that the directory /bin will contain executables and
nothing else.  Another reason is purely stylistic.  Historically "-f" h=
as
been much more portable than "-x" (which came from SVID), even though i=
t
wouldn't make much difference in practice in the real world these days.
