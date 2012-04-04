From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output of 'diff' and 'diff --raw' not the same for modified
 submodule
Date: Wed, 04 Apr 2012 11:02:46 -0700
Message-ID: <7v1uo39xyx.fsf@alter.siamese.dyndns.org>
References: <CAFouetg6rB7oyYGBuMMSgWzaKFwUWTdp4OUo3czvJro4iHa_kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:02:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUXl-0002DY-A7
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 20:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab2DDSCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 14:02:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34580 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300Ab2DDSCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 14:02:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D31636DB8;
	Wed,  4 Apr 2012 14:02:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x2bNwqTjLjJlU34pd9PO2R0zrFo=; b=IS/IhR
	zPBq3Y5mlOoR76HTPpXassS5uNKfvypOgtqSgaRT+FOI7/HJeTdumbA6s81QekhD
	eunK6Zmj/buVUxp/bVCo2ki1UPFl2X1jAY4RoUl7y95FwHbhkgg13QX3+5M/PqEh
	2W7pblP1EkhlPUAiQ+zUmxUsWUvehziS+u1kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MUWd5Kx/qCPYOjYxoUkhben1R1uBeU2G
	X7E6eG+Jm2oYR06WGNDMng83+eSbOGMQJgmgVjxxmA1vK62BkVEdjNqFm3fEntMa
	fYYVybmHlYJmD5BRY4Gcxp3xoGNR5ToPLO/iM1PpfY/YRYoadx1rvAM9pWxGaB6A
	ZzG6xBVuPIY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB1656DB7;
	Wed,  4 Apr 2012 14:02:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558196DB4; Wed,  4 Apr 2012
 14:02:47 -0400 (EDT)
In-Reply-To: <CAFouetg6rB7oyYGBuMMSgWzaKFwUWTdp4OUo3czvJro4iHa_kg@mail.gmail.com> (Tim
 Henigan's message of "Wed, 4 Apr 2012 09:03:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62A33E98-7E80-11E1-997C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194715>

Tim Henigan <tim.henigan@gmail.com> writes:

> If a submodule has new commits, then 'git diff' and 'git diff --raw'
> report different outputs.

There is nothing different except for the inherent difference between a
patch and the row information.

> $ git version
> git version 1.7.10.rc4
>
> $ git diff
> diff --git a/lib/tst-mergetool b/lib/tst-mergetool
> index 9917ea0..5bc1908 160000
> --- a/lib/tst-mergetool
> +++ b/lib/tst-mergetool
> @@ -1 +1 @@
> -Subproject commit 9917ea0c228a0c24153da38df954f8a9d78cafac
> +Subproject commit 5bc19083c436aaa85762cdc309e62ed98f5cc276
>
> $ git diff --raw --no-abbrev
> :160000 160000 9917ea0c228a0c24153da38df954f8a9d78cafac
> 0000000000000000000000000000000000000000 M  lib/tst-mergetool
>
>
> 'git diff' shows the new SHA1 for the submodule, but 'git diff --raw'
> shows the NULL ID.  From the diff man page, I understand that the NULL
> ID indicates "creation, unmerged or 'look at the work tree'", but I
> expected the output of two commands to match.

You are fooled by the textual patch output.

Consider "Subproject commit <blah>" a textconv-ed version of what is on
that path.  Repeat the above but with a regular file at tst-mergetool in
both preimage and postimage.  You will see exactly the same output.  Lines
that begin with "-" show the information for the preimage, while those
that begin with "+" show the information for the postimage.

The --raw output always uses 0{40} to tell you that you need to look at
the working tree for the information you seek for the right hand side (for
"U" entries, 0{40} merely means that we do not have any information to
show on the unmerged side in the first place), and also to mark that the
side that has 0{40} on an "M" entry talks about the working tree.
