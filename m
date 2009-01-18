From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sat, 17 Jan 2009 21:42:23 -0800
Message-ID: <7vhc3x1874.fsf@gitster.siamese.dyndns.org>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
 <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de>
 <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?Jonas_Flod=C3=A9n?= <jonas@floden.nu>
X-From: git-owner@vger.kernel.org Sun Jan 18 06:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOQS2-0000tp-Hh
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 06:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZARFmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 00:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZARFmf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 00:42:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZARFmf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 00:42:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 05E641CC1A;
	Sun, 18 Jan 2009 00:42:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 847841CC19; Sun,
 18 Jan 2009 00:42:27 -0500 (EST)
In-Reply-To: <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
 (Jonas =?utf-8?Q?Flod=C3=A9n's?= message of "Fri, 16 Jan 2009 15:34:47
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CCE3C57A-E522-11DD-862B-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106141>

"Jonas Flod=C3=A9n" <jonas@floden.nu> writes:

> When git-am fails it's not always easy to see which patch failed,
> since it's often hidden by a lot of error messages.
> Add an extra line which prints the name of the failed patch just
> before the resolve message to make it easier to find.
>
> Signed-off-by: Jonas Flod=C3=A9n <jonas@floden.nu>
> ---
> Johannes Schindelin wrote:
>> Maybe
>>
>> -               echo Patch failed at $msgnum.
>> +               echo Patch failed at $msgnum($FIRSTLINE).
>
> How about this instead. Though the line could get very long.
> This makes the line stand out a little more.
>
>  git-am.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 4b157fe..09c2f9c 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -501,7 +501,7 @@ do
>  	fi
>  	if test $apply_status !=3D 0
>  	then
> -		echo Patch failed at $msgnum.
> +		printf '\nPatch failed at %s (%s)\n' "$msgnum" "$FIRSTLINE"
>  		stop_here_user_resolve $this
>  	fi

Looks sane except that I do not think you need printf nor the leading
blank line, i.e.

	echo "Patch failed at $msgnum ($FIRSTLINE)"
