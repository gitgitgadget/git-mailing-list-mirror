From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 05/16] t2104: Don't fail for index versions other
 than [23]
Date: Sun, 05 Aug 2012 18:36:50 -0700
Message-ID: <7vwr1c243x.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:37:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCFe-0006jB-GV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab2HFBgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:36:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168Ab2HFBgx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:36:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196608C10;
	Sun,  5 Aug 2012 21:36:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5zn6UZm8U0sS+IDhuFMkG6q8kjk=; b=CJXlWu
	lrU56AeEFhMihHQqsDKLOc9X1KNRR3B0wz8MubKhQKfDDja+myfUd9bql+Y1+/Ns
	5LCbbjA0AummkG3FYJ2CuDne/4+lCPF1Mmk+cSFadmgV8Z8RuPjxW9dTDUFRy5xN
	VRYBz0SOzOZiZF2WEKnQiPF7z7akaVdHBnZLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NaXxPLt3ZxZ16N550DF3d9oRFat0yJUb
	86H69EOix5jnzor+owotyF2MJ8XQCcJ5wOekd6Bs7RBDf4Ok8OgMB82zfIkaf9aK
	cHRIlmx1AP2nZqLs8liawL49c7/w9CvRnki/QEZ7LhsN/14KUnYnNiDkLFIosGsX
	VbHzhaUS30I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 069738C0F;
	Sun,  5 Aug 2012 21:36:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BA4F8C0C; Sun,  5 Aug 2012
 21:36:52 -0400 (EDT)
In-Reply-To: <1344203353-2819-6-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32B52410-DF67-11E1-9123-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202945>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> t2104 currently checks for the exact index version 2 or 3,
> depending if there is a skip-worktree flag or not. Other
> index versions do not use extended flags and thus cannot
> be tested for version changes.
>
> Make this test update the index to version 2 at the beginning
> of the test. Testing the skip-worktree flags for the default
> index format is still covered by t7011 and t7012.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/t2104-update-index-skip-worktree.sh |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
> index 1d0879b..4ef7d99 100755
> --- a/t/t2104-update-index-skip-worktree.sh
> +++ b/t/t2104-update-index-skip-worktree.sh
> @@ -25,7 +25,8 @@ test_expect_success 'setup' '
>  	mkdir sub &&
>  	touch ./1 ./2 sub/1 sub/2 &&
>  	git add 1 2 sub/1 sub/2 &&
> -	git ls-files -t | test_cmp expect.full -
> +	git ls-files -t | test_cmp expect.full - &&
> +	git update-index --index-version=2
>  '

Makes sense, but wouldn't it make even more sense to do this at the
very beginning?  i.e.

        git update-index --index-version 2 &&
	mkdir sub &&
        touch 1 2 sub/1 sub/2 &&
        git add 1 2 sub/1 sub/2 &&
        git ls-files -t | test_cmp expect.full -
