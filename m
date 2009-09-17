From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Wed, 16 Sep 2009 22:15:39 -0700
Message-ID: <7vk4zykv7o.fsf@alter.siamese.dyndns.org>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
 <20090917041440.4048.16353.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 07:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo9Ll-0006LT-8l
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 07:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZIQFP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 01:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbZIQFP6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 01:15:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbZIQFP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 01:15:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 994E1358FA;
	Thu, 17 Sep 2009 01:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IuBxaHrd5/EznwMKShdHZDpVBDc=; b=oBiCbl
	XyNY12owu3du4/ZNjxGB1vElE/PsSX6sMEtx45oJkRqQfUPq63muOPBRJgKFK7he
	/Es3kTYm1/Uza7gwPI3/4i2kl8rIjT7eZg+A6BMRs1Sq5VRtFjod78hEdysOf3z7
	L9N0oWUDH/fJXMcAB1xLYTgPvD7+tvZkrpd80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jeuhUXx/Y2qP+OGW/9RixzFXdrTLd0oX
	7ULRAkn0/qZ8KaCJRqEV868EI18jhTpHXCDrv0VbhJjG+RQhS+gGW5qTo6XFFFau
	zxbXUgsy70bH4wcX4w9JioT8oSwqVmG9f2baIYJZIejTwcwmnKBMJS+PRAx8/zKC
	KeUxRezdDjg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E59B358F9;
	Thu, 17 Sep 2009 01:15:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E28C6358F7; Thu, 17 Sep
 2009 01:15:42 -0400 (EDT)
In-Reply-To: <20090917041440.4048.16353.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu\, 17 Sep 2009 06\:14\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B500B2A-A349-11DE-B93F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128711>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This option is nearly like "--merge" except that it is
> safer.

Do you still want to have this description after the last round?

> The table below shows what happens when running
> "git reset --option target" to reset the HEAD to another
> commit (as a special case "target" could be the same as
> HEAD) in the cases where "--merge" and "--merge-safe"
> (abreviated --m-s) behave differently.
>
> working index HEAD target         working index HEAD
>   B      B     A     A   --m-s      B      A     A
>                          --merge    A      A     A
>   B      B     A     C   --m-s       (disallowed)
>                          --merge    C      C     C

I'd like to see at least the following rows filled as well.

    X      U     A     A   --m-s      ???    ???   ???
                           --merge    ???    ???   ???
    X      U     B     A   --m-s      ???    ???   ???
                           --merge    ???    ???   ???

> In this table, A, B and C are some different states of a file.

... and X is "don't care", and U is "unmerged index".

> The code comes from the sequencer GSoC project:
>
> git://repo.or.cz/git/sbeyer.git
>
> (at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)
>
> But in the sequencer project the "reset" flag was set in the "struct
> unpack_trees_options" passed to "unpack_trees()". With this flag the
> changes in the working tree were discarded if the file was different
> between HEAD and the reset target.

If you need to have four lines worth of description here, is this still
Stephan's patch, or would it be more appropriate to say "This is based on
an earlier GSoC work by Stephan in git://repo.or.cz/git/sbeyer.git
repository." and you take all the credit and blame?

>  static const char * const git_reset_usage[] = {
> -	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
> +	"git reset [--mixed | --soft | --hard | --merge | --merge-safe] [-q] [<commit>]",
>  	"git reset [--mixed] <commit> [--] <paths>...",
>  	NULL
>  };

As we established in the previous round, this is _different_ from --merge,
but *not* in the sense that --merge is more dangerous and users should be
using this new option instead, but in the sense that --merge perfectly
works well for its intended use case, and this new option triggers a mode
of operation that is meant to be used in a completely different use case,
which is unspecified in this series without documentation.

In that light, is --merge-safe still a good name for the option, or merely
a misleading one?

As I said in the previous round, --merge discards the modified index state
when switching, and it is absolutely _the right thing to do_ in the use
case it was intended for.  It is _not_ dangerous, and using --merge-safe
in that scenario is not being _safe_ but is actively a _wrong_ thing to do.

> @@ -95,6 +98,16 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
>  
>  	read_cache_unmerged();
>  
> +	if (reset_type == MERGE_SAFE) {
> +		unsigned char *head_sha1;
> +		if (get_sha1("HEAD", head_sha1))
> +			return error("You do not have a valid HEAD.");
> +		if (parse_and_init_tree_desc(head_sha1, desc))
> +			return error("Failed to find tree of HEAD.");
> +		nr++;
> +		opts.fn = twoway_merge;
> +	}

get_sha1() takes an allocated buffer, does not allocate space on its own.
I think you meant "unsigned char head_sha1[20];" here.
