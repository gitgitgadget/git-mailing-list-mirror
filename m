From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase -i: Add tests for "--edit-todo"
Date: Sat, 15 Sep 2012 23:58:06 -0700
Message-ID: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
References: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
 <1347739709-15289-1-git-send-email-andrew.kw.w@gmail.com>
 <1347739709-15289-4-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD8o6-0001ry-KC
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547Ab2IPG6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 02:58:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2IPG6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 02:58:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF506744;
	Sun, 16 Sep 2012 02:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yRWkbgkirHXknjDraRL4ZTH9y3c=; b=cwdQuk
	oXFR8XKhiI9PlFXg51qDKw1l4i5xUjPNaEzfY6bPR3ip5CqqnVG1ePRlvyeolvtv
	5dAVlNy3lf0f/xssa8WRNsr54ItdVgkYQDyOy6T1fByqJryJ8263/64/3Cdp3u0j
	nt+KzevfbAB3U7oS4mdsLVuXUA2OHWFfk0ncE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uLxMOGU0qKSzeG5M+Jp0yAVTi2G8ssLj
	pVyoIBeTapYX6AhoFJ1cOLMxb7mD5WTfufw9aQ6ZZnt0+qyjP5SpS6Yi7FSf1VrA
	5mxFfJSrrsU9cktzXB8f7a9uCHTGPshNTvCZ9XoU27hEUCyayfPSP4PwoRSOg/f5
	Rwq8wwbcwQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAA416743;
	Sun, 16 Sep 2012 02:58:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 434A96741; Sun, 16 Sep 2012
 02:58:08 -0400 (EDT)
In-Reply-To: <1347739709-15289-4-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Sat, 15 Sep 2012 16:08:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF039E16-FFCB-11E1-8B48-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205598>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 7304b66..a194c97 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -911,4 +911,20 @@ test_expect_success 'rebase -i --root fixup root commit' '
>  	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
>  '
>  
> +test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
> +	git checkout conflict-branch &&
> +	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
> +	test_must_fail git rebase --edit-todo &&
> +	git rebase --abort
> +'

It _might_ be that you simply inherited sloppiness from surrounding
existing tests, but what happens when a test _before_ this test
failed?  Is "git checkout conflict-branch" sufficient to bring you
to a sensible state where this test would succeed?  I'd prefer to
see a defensive "git reset --hard &&" before the first "checkout".

The same for the next one.

> +test_expect_success 'rebase --edit-todo can be used to modify todo' '
> +	git checkout no-conflict-branch^0 &&
> +	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
> +	FAKE_LINES="2 1" git rebase --edit-todo &&
> +	git rebase --continue
> +	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
> +	test L = $(git cat-file commit HEAD | sed -ne \$p)
> +'
> +
>  test_done
