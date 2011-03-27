From: Junio C Hamano <gitster@pobox.com>
Subject: Re: start of git2 (based on libgit2)
Date: Sun, 27 Mar 2011 01:34:34 -0700
Message-ID: <7v62r52c85.fsf@alter.siamese.dyndns.org>
References: <20110325231203.GA7961@jakstys.lt> <4D8D2B31.4040908@lyx.org>
 <20110326132915.GA2859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 27 10:35:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3lRE-0002qd-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 10:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab1C0Iev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 04:34:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab1C0Iet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 04:34:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7672E3889;
	Sun, 27 Mar 2011 04:36:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uxxDTgo+TmQYIaUCH7hLbQofbU=; b=x68uVL
	i4Fv0ZaASE4YLVENWV5AoOo5fw7uqcecWrV5eNY8R2wLdZAA6fEO2bUYKfxUp/Qa
	xDdeFZr8LRCF041p6erWhIqUSQV8PdcjXkhllXUsXey96osey0DgEAr2Mungm5dD
	zXdnaiqIdY55orJsrsZRGeCPm1TRPk2tsMp4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uT+9Dq6/YoXWcewD0M9VsAGprbqfnm3o
	IMdGoYLobgZ0oqqwrVtyOJA1BYmJYLa2Sc7/m2LYe7F36vxFNVf6A4wx8L9su7MM
	MnME6UyqlSKb0D1KTOYQhUBY9jiGeBiqtZ347DHW+BTp9rH6t4UThmiBCx2PIrBD
	bwq2sPcBccg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3308F3887;
	Sun, 27 Mar 2011 04:36:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9861F3886; Sun, 27 Mar 2011
 04:36:20 -0400 (EDT)
In-Reply-To: <20110326132915.GA2859@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Mar 2011 09:29:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC02AA4-584D-11E0-BCC5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170076>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 26, 2011 at 12:54:25AM +0100, Vincent van Ravesteijn wrote:
>> 
>> I guess a lot can be copied from Git itself. Actually
>> builtin/rev-list.c consists mostly of command line arguments parsing
>> methods, and outputting functions. The key is to parse what you want
>> to know and ask libgit2 to provide the info. If libgit2 has
>> implemented the basic functionality that is needed, the rest would be
>> relatively simple.
>
> I wouldn't worry about having _every_ argument. Some arguments are much
> less frequently used than others. For example, start with basic stuff,
> like including and excluding commits (e.g., "branch1 ^branch2"),
> --max-count, --{min,max}-age, --grep, and others. Do common things like
> path limiting. And then once all that is done and tested, start worrying
> about things like --cherry-pick (or maybe not, and focus on the basics
> of other simple commands).

I agree that for a summer student project, aiming at basic stuff makes
more sense than trying to chew a large bite that cannot be managed within
the timeframe and not achieving anything.

"A..B" requires you to walk the ancestry chain. Limiting history with
pathspec while simplifying merges needs to use the tree-diff machinery;
and filtering commits by looking at the message with "--grep" needs to
call into the grep machinery.  Depending on how much libgit2 has already
covered the basic blocks, even the above list might be too much, I am
afraid.

A good news is that among the larger and more important basic building
blocks in C git, there is only one part that was designed from day one to
disregard the reusability and instead aimed for speed and simplicity, and
that is the history and object walking. The way the in-core object pool is
managed and especially the way per-object flags are designed to be used
clearly show that the revision walker machinery can take it granted that
the calling programs are run-once-and-clean-via-exit.

But other major parts are designed to be reusable and I would imagine that
it shouldn't be hard to link with them (or better yet, find counterparts
in libgit2). "diff" machinery below the diffcore layer (i.e. the entry
points "diff-lib.c" calls into, e.g. starting at diff_addremove(), then
running the diffcore machinery with diffcore_std() and finally getting the
result from diff_flush() callchain) and "grep" machinery below the
"grep.c" (but not "builtin/grep.c") are designed not to depend on the
process level global variables.
