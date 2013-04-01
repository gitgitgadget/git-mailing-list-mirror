From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: give better message when no names specified for 
 rename
Date: Sun, 31 Mar 2013 19:51:53 -0700
Message-ID: <7vfvzbm08m.fsf@alter.siamese.dyndns.org>
References: <00E97900-F00D-455F-A3EB-52D0A3CF5CF6@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 04:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMUrB-0000MI-4X
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 04:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347Ab3DACv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 22:51:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755742Ab3DACv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 22:51:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5E6E8AA;
	Mon,  1 Apr 2013 02:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YYxzaFQFYRewJh9PeXhWBryQSYA=; b=UEsWc9
	iBPH1bFUfTWqFIfQ8U6TokYMy4yFjENn9/ENXHe6ivvtfEQ9Rt4knfhUBMx5i1tY
	axEk/e1v3gRSfFu18BctAGLYZbpsDTPYF2U8ZLExeHOnZB2iu42ge+TgwwiZHBzu
	Em1Pgf/5EMzvp4zdgZgmY9Wmh6WbEMfwNXIa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tM3O19du/KAhoClJb0dg/Z+KP+kOFhE8
	FZzmbNITT0Mzb11w3/ZB0SPiL8pJOwFcVtDvxl9O3Mt+m6a8f9uVc1CbXUsnxPk6
	dA6m6xr3Dy8ovC1DqX+AsSP3p2RhiWP0PVvx/SLyJ/eiWAlT5KP04dbo+NPh5tFv
	aqC90DpObUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24755E8A9;
	Mon,  1 Apr 2013 02:51:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7241FE8A8; Mon,  1 Apr 2013
 02:51:55 +0000 (UTC)
In-Reply-To: <00E97900-F00D-455F-A3EB-52D0A3CF5CF6@JonathonMah.com> (Jonathon
 Mah's message of "Sat, 30 Mar 2013 18:27:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D1CDF6E-9A77-11E2-9E5A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219662>

Jonathon Mah <me@JonathonMah.com> writes:

> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---
>
> The previous message was incorrect when not enough arguments were
> specified:
>     
>     $ git branch -m 
>     fatal: too many branches for a rename operation
>
> I changed to "branch name required" instead of "new branch name required" in the hope that existing translations can be used.
>
>  builtin/branch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 00d17d2..580107f 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -880,7 +880,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		if (edit_branch_description(branch_name))
>  			return 1;
>  	} else if (rename) {
> -		if (argc == 1)
> +		if (!argc)
> +			die(_("branch name required"));
> +		else if (argc == 1)
>  			rename_branch(head, argv[0], rename > 1);
>  		else if (argc == 2)
>  			rename_branch(argv[0], argv[1], rename > 1);

Obviously a good thing to do; thanks.
