From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: add --word-diff option that generalizes
 --color-words
Date: Sun, 04 Apr 2010 19:06:12 -0700
Message-ID: <7v39zay7or.fsf@alter.siamese.dyndns.org>
References: <cover.1270388195.git.trast@student.ethz.ch>
 <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 05 04:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nybi3-0001KM-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 04:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab0DECGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 22:06:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab0DECGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 22:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A096A76C8;
	Sun,  4 Apr 2010 22:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G159XqS9+sF4/mNMlWaOmMbvmGk=; b=vdrPSr
	/0spBesyB/lOwVV6Z699TI3Nnpdb+LDdj1thpF/sdRSD6a87IFJkrEONyn5P3B3B
	1lqoetFqnf8JaD5V2i9gMhO36CmIFKDFS1u2Ojyu/+FJFdzq+yoaKDnYWcB7VWBp
	1um65xHj43HEra8/wEQh/Ud6HOOQB7rF+Nlcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoN2hggIRfXly58j+eivBxxK/MCZMNBl
	cvmrh87o2pYSdtI5fg0eVOv5fgEaML/YJlnDYRr/vqF8mTSntxUeeSY/YBXIDeTv
	YU3wfnoXKzYZPpkzY1aJHqeyWBbM5G61ngajgojYVYRdQO4c/JR51osrf6MM3+xo
	N/rz2BFtTHY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ACF5A76C7;
	Sun,  4 Apr 2010 22:06:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F250FA76C0; Sun,  4 Apr
 2010 22:06:18 -0400 (EDT)
In-Reply-To: <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun\, 4 Apr 2010 15\:46\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D722B2DA-4057-11DF-9669-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143964>

Thomas Rast <trast@student.ethz.ch> writes:

> This teaches the --color-words engine a more general interface that
> supports two new modes:
>
> * --word-diff=plain, inspired by the 'wdiff' utility (most similar to
>   'wdiff -n <old> <new>'): uses delimiters [-removed-] and {+added+}
>
> * --word-diff=porcelain, which generates an ad-hoc machine readable
>   format:
>   - each diff unit is prefixed by [-+ ] and terminated by newline as
>     in unified diff
>   - newlines in the input are output as a line consisting only of a
>     tilde '~'

Thanks.  This was a fun feature to look at.

I think it is a bug that "git show --word-diff" gives the colored format
output when I have "color.ui" configuration.

Even though I may have "color.ui = auto" in the configuration, I am
telling the command to do a --word-diff, not --color-words, from the
command line, and that should override color.ui settings.

So I think a request for --word-diff that is not --word-diff=color should
never use the --color-words _unless_ there is --color on the command line:

	git show --word-diff
	git show --word-diff=plain
	git show --word-diff=porcelain

All of the above may paint hunk headers and metainfo the usual way when I
have "color.ui" set, but I do not want them to be painting the diff part
like --color-words does.  I am fine if "porcelain" did not to paint the
metainfo, but I see this feature as three different output types of how
word diff is presented, so in that sense, it probably is better to force
scripts to explicitly ask for no-color, i.e.

	git show --no-color --word-diff=porcelain

if they want to read and interpret metainfo.

When the command line asks for color explicitly, then we should see the
good old --color-words:

	git show --color-words
	git show --word-diff=color

I am not sure what the following two should do.  One could argue that
these default to --color-words; or --color should apply only to the
coloring of metainfo but not the diff part:

        git show --color --word-diff
        git show --word-diff --color

I am slightly in favor of doing the same as --color-words, but people may
have different opinions.

The following of course should show the plain word diff but the metainfo
and friends colored:

        git show --word-diff=plain --color
        git show --color --word-diff=plain

It might be just the matter of defaulting --word-diff without "=<type>"
not to "auto" but to "plain".  I haven't looked at the code closely yet.
