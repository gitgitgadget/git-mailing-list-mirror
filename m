From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is
 suitable.
Date: Sun, 01 May 2011 16:55:16 -0700
Message-ID: <7vk4eaq8m3.fsf@alter.siamese.dyndns.org>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
 <7vwriq3p0t.fsf@alter.siamese.dyndns.org>
 <BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com>
 <7v7haarsrd.fsf@alter.siamese.dyndns.org>
 <BANLkTikv0YmB-u74sOrQUQZGQvYJNmBx_w@mail.gmail.com>
 <BANLkTimD_S3ik7-0j0gMCiEo3aoRwCy92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Ciaran <ciaranj@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 01:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgU8-0000dV-CI
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 01:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab1EAXz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 19:55:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1EAXz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 19:55:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 570AF56A9;
	Sun,  1 May 2011 19:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=8WbVFzp/tWiMotXF49omFOIrXYo=; b=lU2l4mn12aFVtwnBthk0
	ia36uuW3rle6gybMWWIfTqA1xexyDzOkt+rPCO6eFZseF3lFECRaAvY4iWAN70mo
	prOkDKf2wjOYSOtFcjEPee4U9BzPd4iRRH2rTIle00fhPrggXRtP+EWey5Amie6y
	BF3Cylh/q2Lk9AZv9xy2rA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=KGn2ojnIQ1M5owconGx9C02aci0IdZ3fYVTWpiejc/KY6Q
	9nvFK5xrNfUYr8aAvC1dYpS8TJBnp4wnqXyB7ERMagCkZtRqhvoKnmEj1uMWdkOI
	KhT48D00pO0QThY7z33acNqhUr34aMxaPFBVGZzC4T+u61KOv7FrZvL2LQxC4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2051956A6;
	Sun,  1 May 2011 19:57:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0736056A0; Sun,  1 May 2011
 19:57:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3AF60BE-744E-11E0-A064-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172553>

Ciaran <ciaranj@gmail.com> writes:

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index fb3f52b..4db9212 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -258,12 +258,9 @@ run_merge_tool () {
>  		;;
>  	p4merge)
>  		if merge_mode; then
> -		    touch "$BACKUP"
> -			if $base_present; then
> -				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
> -			else
> -				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
> -			fi
> +			touch "$BACKUP"
> +			$base_present || >"$BASE"
> +			"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>  			check_unchanged

Will queue this version as-is; thanks.


Somebody might want to revisit if that "touch" is still really necessary,
though.  It is outside the scope of this change, as that has been there
before this patch.
