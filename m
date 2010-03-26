From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 16:50:00 -0700
Message-ID: <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
References: <20100326215600.GA10910@spearce.org>
 <20100326222659.GA18369@progeny.tock> <20100326222950.GB10910@spearce.org>
 <4BAD3C6E.4090604@gmail.com> <20100326230537.GC10910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJIK-0004fU-FV
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab0CZXuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:50:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab0CZXuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 19:50:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DED1A5AA5;
	Fri, 26 Mar 2010 19:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XIbycu7CzeOaO6pLebTPLtwJWn4=; b=g7MSM7
	yWM9H66/U+ydN2hUtw+XSPL+whD5ar1Bh3zW5AoRVEUMEilb1zoIY2ouurdyedRj
	wt+QBfmNUKy5j+pnvifk+vcKl9GIoij5b7JMnCAzgyBJNnj0atMhSnwqpAP4yDQ3
	JIoO8dKy79P8JstgC1tY8AxrSnsL8qSeep2hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXr91Fg3sjyM8laGZWS2nPlPHA/HWcRT
	6osRkDo9yxIm1GFbqGSl4/SU279hEnN53sw0oWxgG5uL4yp5yDst1MsuZLu3a2hD
	cMteB0JM8U5OUz4g0HmugnL5gJQGACW9tXSREuKYs3UtwJzolkjVY8Q5TtjtgGTO
	c8eICdA1dW4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A30AA5A9A;
	Fri, 26 Mar 2010 19:50:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2992A5A96; Fri, 26 Mar
 2010 19:50:02 -0400 (EDT)
In-Reply-To: <20100326230537.GC10910@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 26 Mar 2010 16\:05\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53C9D3C2-3932-11DF-A276-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143302>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Scott, please fix that library on GitHub.  JGit's fsck has a hard
> failure on these malformed trees, because the leading '0' mode
> causes the tree to come up with the wrong SHA-1 hash given its
> logical content.  They shouldn't be created like this.

What is curious is that even though 6407180 (git-fsck-cache: be stricter
about "tree" objects, 2005-07-27) does talk about zero-padding, it appears
that we never had a version of git that padded mode in '0' in the entire
history of write-tree (except that "notes tree" one, but even that didn't
escape the laboratory).

But now we know there is a tool in the wild creating broken objects left
and right, jgit's fsck routine might need to be more lenient (while
warning loudly) in what it accepts.

Scott, does your tool have outside users (i.e. being freely distributed
and you have no control over the continued use of existing copies that
create broken objects)?  If not, then there won't be further damage once
you fix it at Github, and we may not have to worry about changing jgit
after all.
