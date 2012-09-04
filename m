From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes extra slashes
Date: Tue, 04 Sep 2012 11:19:24 -0700
Message-ID: <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 04 20:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8xip-0008Hw-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab2IDST2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:19:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab2IDST1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:19:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02E948FED;
	Tue,  4 Sep 2012 14:19:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eTm/TI8xMfeVGnTWBy3b++xkldQ=; b=Bncv5M
	Uys3lrl+0qjkx9CTGzba8UO9EOp/0bgFuXqmNXNQ6qIoOk7UMJ4qi8CrMoDkS+Ww
	1xEaoQG3LRRicyxjfAbBFgvvstWSl0Yowm+mzr6BvF2X2K3U8BYlyL8UYpP+hDhC
	Yt5W/B85kCAyGSDQhZjneKTyZuYNyOe2o8ju8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T6r6CDg0ATFf2DmEBYhFTZUJb9UVmsX/
	tA61uu9dtMHl6w5grDOAIPpGgKvj7VcTYCbSs5Uqthe6n3ovTVcDMNssGVcgnzT7
	zOF9WMLu2FuOuWe2HClof8KI3ZJzq55HVI2O7uWqYHtnDc0NesEbhLyCWPE8k39I
	hhAmxlMTycU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2CE88FEC;
	Tue,  4 Sep 2012 14:19:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 325E08FE3; Tue,  4 Sep 2012
 14:19:26 -0400 (EDT)
In-Reply-To: <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Tue, 4 Sep 2012 10:14:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F3908AE-F6BD-11E1-B515-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204760>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> These tests already pass, but make sure they don't break in the
> future.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> It would be great if somebody would check whether these tests pass on
> Windows, and if not, give me a tip about how to fix them.

I think this (perhaps unwarranted) removal of the double leading
slashes is the root cause of

    http://thread.gmane.org/gmane.comp.version-control.git/204469

(people involved in that thread Cc'ed).

>  t/t0000-basic.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index d929578..3c75e97 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -468,6 +468,17 @@ test_expect_success 'real path works on absolute paths' '
>  	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
>  '
>  
> +test_expect_success 'real path removes extra slashes' '
> +	nopath="hopefully-absent-path" &&
> +	test "/" = "$(test-path-utils real_path "///")" &&
> +	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&
> +	# We need an existing top-level directory to use in the
> +	# remaining tests.  Use the top-level ancestor of $(pwd):
> +	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&
> +	test "$d" = "$(test-path-utils real_path "//$d///")" &&
> +	test "$d/$nopath" = "$(test-path-utils real_path "//$d///$nopath")"
> +'
> +
>  test_expect_success SYMLINKS 'real path works on symlinks' '
>  	mkdir first &&
>  	ln -s ../.git first/.git &&
