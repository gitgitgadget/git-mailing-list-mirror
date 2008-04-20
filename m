From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH v2 02/13] Don't append default merge message to -m message
Date: Sun, 20 Apr 2008 09:52:32 -0700
Message-ID: <7v7iescvu7.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:53:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JncnY-0004ln-OL
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbYDTQwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 12:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYDTQwv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:52:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYDTQwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 12:52:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFDAC6138;
	Sun, 20 Apr 2008 12:52:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 242BC6135; Sun, 20 Apr 2008 12:52:44 -0400 (EDT)
In-Reply-To: <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 (=?utf-8?Q?J=C3=B6rg?= Sommer's message of "Mon, 14 Apr 2008 02:20:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79966>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> From: gitster@pobox.com (Junio C Hamano)
> Date: Sun, 23 Mar 2008 22:17:09 -0700
>
> Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>

I'd admit that this was taken from my "You could do this" patch, and I =
am
inclined to think that the users would probably want this behaviour of
dropping the default merge summary when giving their own message with -=
m,
but I am not absolutely convinced that doing this unconditionally is th=
e
right thing to do (iow, some people might have relied on the current
behaviour).

List, any objections?

> ---
>  git-merge.sh |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/git-merge.sh b/git-merge.sh
> index 7dbbb1d..bd9699d 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -250,17 +250,19 @@ else
>  	# We are invoked directly as the first-class UI.
>  	head_arg=3DHEAD
> =20
> -	# All the rest are the commits being merged; prepare
> -	# the standard merge summary message to be appended to
> -	# the given message.  If remote is invalid we will die
> -	# later in the common codepath so we discard the error
> -	# in this loop.
> -	merge_name=3D$(for remote
> -		do
> -			merge_name "$remote"
> -		done | git fmt-merge-msg
> -	)
> -	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
> +	if test -z "$merge_msg"
> +	then
> +		# All the rest are the commits being merged; prepare
> +		# the standard merge summary message to be appended to
> +		# the given message.  If remote is invalid we will die
> +		# later in the common codepath so we discard the error
> +		# in this loop.
> +		merge_msg=3D$(for remote
> +			do
> +				merge_name "$remote"
> +			done | git fmt-merge-msg
> +		)
> +	fi
>  fi
>  head=3D$(git rev-parse --verify "$head_arg"^0) || usage
> =20
> --=20
> 1.5.5
