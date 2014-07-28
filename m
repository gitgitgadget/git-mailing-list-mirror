From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 11:19:46 -0700
Message-ID: <xmqqppgp4a7x.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
	<20140728103504.GB10737@peff.net>
	<xmqqtx614cea.fsf@gitster.dls.corp.google.com>
	<20140728173734.GA10309@peff.net> <20140728180157.GA11265@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:20:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpWr-0008V3-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaG1SUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:20:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50908 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbaG1ST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0557A2DDF7;
	Mon, 28 Jul 2014 14:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKeYeKvqfwrjQOQGUh1Y2gh1p6Q=; b=TdmsKJ
	zFb8u3Bs3CaTLnu9NjZYgOgkh13EVx26SPnviVFsQlN5eXdazOYm0QFgnzLSWde6
	/5gqy7+yy0/1NuPuwOgB4D4vGGUvsEnLuoHI8WAiLKjgLXF5O7cYIGJu5zOVp86B
	4K6BLVTAoXki9uRpF0VtxDt2Bt7to74/VMohA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HyYJYQ7j4mwpiTm7SwZ3CD0H5KMehYfk
	VBFaMsNjnGE9jRVpyvi1lkA09X+PKsYuhBc8+YmU7GEaEEofhBnXtC+TdR6dB8RD
	VTWM8zI4rVH9jSRfEKzRkrSOiz3pMwWDQZM/YfYuI9C7ROxBjHU9962/L65NQGH6
	Owmzo4MRdD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E91EC2DDF6;
	Mon, 28 Jul 2014 14:19:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 998552DDED;
	Mon, 28 Jul 2014 14:19:48 -0400 (EDT)
In-Reply-To: <20140728180157.GA11265@peff.net> (Jeff King's message of "Mon,
	28 Jul 2014 14:01:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C26D7F26-1683-11E4-9723-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254332>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 28, 2014 at 01:37:34PM -0400, Jeff King wrote:
>
>> On Mon, Jul 28, 2014 at 10:32:45AM -0700, Junio C Hamano wrote:
>> 
>> > > Junio, we should consider a v2.0.4 with that series, I think. This is a
>> > > pretty serious regression in diff-tree (I didn't even realize that the
>> > > buffer-slab work went into the maint series; that may have been a little
>> > > ambitious).
>> > 
>> > Or v2.0.4 without that series, which is how we usually do things,
>> > but let me see if jk/alloc-commit-id is easily applicable there
>> > first.
>> 
>> Yeah, I'm fine with a straight revert, too (I think it is fine to keep
>> in master, though). I think jk/alloc-commit-id is built right on top of
>> the original commit-slab topic, so it should be easy to do either way.
>> 
>> Thanks for dealing with it.
>
> Whatever we do, perhaps it is worth applying the test below on top?

Yeah, thanks.  I think that is a good idea.  I was preparing a patch
to tuck your minimum reproduction at the end of 4202, but your version
and placement makes good sense.

> -- >8 --
> Subject: t4013: test diff-tree's --stdin commit formatting
>
> Once upon a time, git-log was just "rev-list | diff-tree",
> and we did not bother to test it separately. These days git-log
> is implemented internally, but we want to make sure that the
> rev-list to diff-tree pipeline continues to function. Let's
> add a basic sanity test.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t4013-diff-various.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 805b055..6ec6072 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -324,4 +324,14 @@ test_expect_success 'diff --cached -- file on unborn branch' '
>  	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
>  '
>  
> +test_expect_success 'diff-tree --stdin with log formatting' '
> +	cat >expect <<-\EOF &&
> +	Side
> +	Third
> +	Second
> +	EOF
> +	git rev-list master | git diff-tree --stdin --format=%s -s >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
