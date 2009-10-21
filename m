From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] new --dirty option for git describe
Date: Wed, 21 Oct 2009 15:07:27 -0700
Message-ID: <7v63a81jvk.fsf@alter.siamese.dyndns.org>
References: <1256132122-12509-1-git-send-email-jean@pryen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jLV-0005rJ-TB
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbZJUWHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbZJUWHi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:07:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587AbZJUWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:07:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B7F614EE;
	Wed, 21 Oct 2009 18:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xbU4qBDTQFueAsyqpr0EXH6G0Nc=; b=EqLAsV
	PpDKlW2vyOY+gaEFYxJMk9QteZHm+oYJhJgtt0LOSN/ZayQdqN85RqCIJSakn7YQ
	LmMLf95+dBmcIVvKQS0mcLe2vZ3lShJnrjOTaXtLYwxZmNXCeIl1uDt8oFT4Ts6c
	dlMtzoHYMADi/Igs17bqcLWqvSk9bQ6BEcihs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ur7AgL93RFLoz0X0Jbp+B3DnKsyoKbXk
	whbwPikXqHP7z172bDfp/5/kaiTVi5NZCJPQMwkmIJ22960lAnecqH5Ai/uiQ7TZ
	hwmmkVG794CAyQFFYno1thx3mFWe/JNcXa/IGG5heUo5980uxLmgVaezjYdOJG2Z
	Oyz1EPjqo08=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 398AF614ED;
	Wed, 21 Oct 2009 18:07:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34FF9614EC; Wed, 21 Oct
 2009 18:07:29 -0400 (EDT)
In-Reply-To: <1256132122-12509-1-git-send-email-jean@pryen.org> (Jean
 Privat's message of "Wed\, 21 Oct 2009 09\:35\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2326A99E-BE8E-11DE-886B-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130975>

Thanks.  I'll queue it to 'pu' after minor reformatting and typofixes to
the log message.

> 3 Use --dirty as in this patch
> ...
> Pro: has an easy fallback to alternative 1 if the world become suddenly
>      ideal, or at least allows some kind of future transition plan if
>      people *really* bother:
>      1- ask that scripts use either "git describe HEAD" or
>         "git describe --dirty" (no more "git describe")
>      2- change default
>      Once the transition is done, the role of the --dirty option will
>      just be the way to specify an alternative mark (and a noop if alone)

Also I'd drop this as a Pro specific to #3.  It is clear that the first
one is incompatible from the beginning and there is no "smooth migration
path" possible; also I think the second one can be migrated equally well
in exactly the same way, so this is not an advantage specific to #3.

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 8c7e081..e061177 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -123,6 +123,20 @@ test_expect_success 'rename tag Q back to A' '
>  test_expect_success 'pack tag refs' 'git pack-refs'
>  check_describe A-* HEAD
>  
> +check_describe "A-*[0-9a-f]" --dirty
> +
> +test_expect_success 'set-up dirty working tree' '
> +	echo >>file
> +'
> +
> +check_describe "A-*[0-9a-f]-dirty" --dirty
> +
> +check_describe "A-*[0-9a-f].mod" --dirty=.mod
> +
> +test_expect_success 'describe --dirty HEAD' '
> +	test_must_fail git describe --dirty HEAD
> +'

"clean work tree gets no marks; dirty work tree gets expected marks with
or without the mark string; the option is incompatible with an explicit
rev".  Nicely covers all cases.  Good job.
