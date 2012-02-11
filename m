From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Sat, 11 Feb 2012 15:43:34 -0800
Message-ID: <7vzkcpkkbd.fsf@alter.siamese.dyndns.org>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <7vpqdln68v.fsf@alter.siamese.dyndns.org>
 <20120211193742.GD4903@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:43:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMbX-0000Lk-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab2BKXnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 18:43:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab2BKXni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 18:43:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B00C9725A;
	Sat, 11 Feb 2012 18:43:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWpNuH+PuPvXYcwogUUOAziYEog=; b=cvPlnS
	cwCJDnNvHnjQ+2a5OtSYN7SiTDn9Q71t3yN5+M+jZXYs8wlUIlnLk0Y6uulalIY6
	drps80OgZkuxKe70a4ZhDcQB4rek0QXi42jOezYK677TBjcJLGBJANfB+MyJNZtW
	1HFT/tEDxHmkv8Zo4/cQtJDPwxHZiC10gy33I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yIj+xci4HW4jcrl7NrEmcWLinYUODi7G
	7achsEVZvLA5XeMTy22adGbesvTp1w2wJRj/L2jXA9A3OjqBqBjFjc1SAK77dkm7
	2uU0cnl9FcDfzF7macToM6OHuaK8CFIpxbiVq6GVebDqXj28o7cvlaBgUqkaPGsC
	ImDyJd29iew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A66AA7259;
	Sat, 11 Feb 2012 18:43:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35A027258; Sat, 11 Feb 2012
 18:43:36 -0500 (EST)
In-Reply-To: <20120211193742.GD4903@tgrennan-laptop> (Tom Grennan's message
 of "Sat, 11 Feb 2012 11:37:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3738955E-550A-11E1-8E8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190544>

Tom Grennan <tmgrennan@gmail.com> writes:

> Yes, I should have stated that this emphasized containment over
> efficiency.  If instead we stipulate that the caller must list exclusion
> patterns before others, this could simply be:

No.

You have to pre-parse and rearrange the pattern[] list *only once* before
matching them against dozens of refs, so instead of forcing the callers do
anything funky, you give a function that gets a pattern[] list and returns
something that can be efficiently used by the match_pattern() function,
and have the caller pass that thing, not the original pattern[] list, to
the match_pattern() function.

That is how pathspec matching side of the logic is arranged.

I keep saying that it is probably not a good idea to directly reuse the
pathspec code, but you would want to study and learn from the overall
structure of it.
