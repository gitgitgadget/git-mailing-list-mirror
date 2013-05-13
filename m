From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 07:40:34 -0700
Message-ID: <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubtve-0006UM-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab3EMOki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:40:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab3EMOkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:40:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FCC91D3D0;
	Mon, 13 May 2013 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOG/VaJcEGYIj+UcwD5OPotyAfs=; b=M3U6Vg
	3yYUDPwbgf9H3XjXBsLHC5/vpu9D1hgh/h4z/o2I1KsAVbd8p8DwhAcl2kxki7c+
	ylq0RFZ+GaEkgjttuve2EFvEv7/d5B//rdDnjejeQfjqcuJ4pPW+cidqoXb1OL6U
	ORONKjrZa7kw9bXAuJLzlmJCuqsQRec8AN3A4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/2EYnFmeU648U2R2t2An+vHExtw1fiu
	xzZkYmCXU/eNggxwkHg9kEDBZcFfeW/LraugI+VdLVUHMmE16ij0rdqaj/MF71Nk
	YnYF4fcYlsbtV6E8jpaJ0ITBBzzdXHxfN/nIo64l7ByupTmC9fmNMW2SWY5DkibP
	zETYYz86TR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31B111D3CF;
	Mon, 13 May 2013 14:40:37 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8813E1D3CE;
	Mon, 13 May 2013 14:40:36 +0000 (UTC)
In-Reply-To: <1368449154-21882-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 13 May 2013 18:15:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1301DB80-BBDB-11E2-9124-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224154>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 05e462b..e58ab74 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>  	     [-u|--include-untracked] [-a|--all] [<message>]]
>  'git stash' clear
>  'git stash' create [<message> [<include-untracked-p>]]
> +'git stash' store <commit> <message>

Two points:

 - We should not advertise "store" (and "create" for that matter) in
   the end-user facing documentation.  IIRC, "git stash -h"
   deliberately omits 'create'; having it in the documentation is
   unavoidable, but it was a mistake that it was not marked with
   "this is most likely not what you want to use; see 'save'".

   It may even be better with a leading underscore or two in the
   name that clearly marks it as "not meant for direct end-user
   consumption".

 - The error message store_stash() gives should not be hardcoded in
   that function.

   Save-stash may want to keep saying 'the current status' as it
   said before, but a caller like your rebase-autostash will not be
   saving the "current" status and would want to have a different
   message.

Other than that, the overfall structure of the patch looks OK to me.
