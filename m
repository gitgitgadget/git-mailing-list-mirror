From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] git-mergetool--lib: Make vimdiff retain the current
 directory
Date: Mon, 23 May 2011 08:36:25 +0200
Message-ID: <4DDA0069.9010500@drmicha.warpmail.net>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org> <1306058229-93800-1-git-send-email-davvid@gmail.com> <1306058229-93800-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1h?= =?UTF-8?B?bm4=?= 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 08:36:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOOkl-000684-77
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 08:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab1EWGga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 02:36:30 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:42635 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384Ab1EWGg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 02:36:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D32742086C;
	Mon, 23 May 2011 02:36:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 23 May 2011 02:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+im59Efw//jaY8Qs5Hhj7jBb3+E=; b=V0iaY6SmfMmQXmDC1eAo2aLEKWrH7e0CTrVqLlomt1Oc09XZp40DEVSkHgW3nFBL3IEMUNV8gc8FelkNNMhmVPUnvqsj8WDiM3ThQqLfwBNJG+aWUf7JPBGE6Qo7A6IMamNS5zwv56g/7gi5uqa02L5Q6QXdNLMj4wNSVTp+b9I=
X-Sasl-enc: wv3fhSfPHdxlJkbgpAy+Nej/+v880eeXCidgndXO++4X 1306132587
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 180B0440EBE;
	Mon, 23 May 2011 02:36:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1306058229-93800-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174225>

David Aguilar venit, vidit, dixit 22.05.2011 11:57:
> When using difftool with vimdiff it can be unexpected that
> the current directory changes to the root of the project.
> Tell vim to chdir to the value of $GIT_PREFIX to fix this.
>=20
> Care is taken to quote the variable so that vim expands it.
> This avoids problems when directory names contain spaces.
>=20
> Signed-off-by: David Aguilar <davvid@gmail.com>
> Reported-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
> ---
>  git-mergetool--lib.sh |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>=20
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 4db9212..ece6a08 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -187,7 +187,9 @@ run_merge_tool () {
>  			fi
>  			check_unchanged
>  		else
> +			resolve_git_prefix
>  			"$merge_tool_path" -R -f -d -c "wincmd l" \
> +				-c 'cd $GIT_PREFIX' \
>  				"$LOCAL" "$REMOTE"
>  		fi
>  		;;
> @@ -198,7 +200,9 @@ run_merge_tool () {
>  				"$LOCAL" "$MERGED" "$REMOTE"
>  			check_unchanged
>  		else
> +			resolve_git_prefix
>  			"$merge_tool_path" -R -f -d -c "wincmd l" \
> +				-c 'cd $GIT_PREFIX' \
>  				"$LOCAL" "$REMOTE"
>  		fi
>  		;;
> @@ -437,3 +441,12 @@ get_merge_tool () {
>  	fi
>  	echo "$merge_tool"
>  }
> +
> +resolve_git_prefix() {
> +	# If GIT_PREFIX is empty then we cannot use it in tools
> +	# that expect to be able to chdir() to its value.
> +	if test -z "$GIT_PREFIX"; then
> +		GIT_PREFIX=3D.
> +		export GIT_PREFIX
> +	fi
> +}

Hmmm. Maybe we should export "." when there is no prefix? Maybe it's no=
t
too late to change that aspect of GIT_PREFIX. We went through some
iteration back then for !alias.

Michael
