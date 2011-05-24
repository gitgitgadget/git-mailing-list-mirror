From: Junio C Hamano <gitster@pobox.com>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 21:46:27 -0700
Message-ID: <7v39k4aeos.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <20110523234131.GB10488@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 06:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOjW2-0004Zm-61
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 06:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab1EXEqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 00:46:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1EXEqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 00:46:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A19705E64;
	Tue, 24 May 2011 00:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RQb81Vewn3dNeytWDYAbKT8tVEs=; b=CiiC5x
	6ILYPjE7Pn99x/p3/Q/sCg+Z3oko+QyLBUts0S7H9Ut3fnBOmaY1jgojSgJHeiYC
	IykmBq9l0RpIKCUV3bBiUGxKLQI5aaQgFKwuKq2FR/6N5STtoKQpIw+YkXflQGfq
	lV+/RzM3yq3/zMmpuqQXUukavnWMQzjihcmE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrNpXDH9lsGXEdq5t7Psn7lpDqVATrYT
	cdMNLIlcePCxmsok7teXP1d6UCDNuv2j1zuTpIm8z88n0KTyzDJLCyQ93G3rWCWF
	z7bb5RNh+Il69oFAi/inXHZZTmCLcCcPZlk2+uKe8cRWZDEvimpexUG2OYS5lhGc
	Qs+ZTzN5u2M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F0B25E63;
	Tue, 24 May 2011 00:48:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C8D705E60; Tue, 24 May 2011
 00:48:36 -0400 (EDT)
In-Reply-To: <20110523234131.GB10488@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 May 2011 19:41:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 196F4180-85C1-11E0-A7C8-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174313>

Jeff King <peff@peff.net> writes:

>> However, custom diff drivers (still) don't work. :-)
>
> Yeah, I didn't add any support for that. I'm not sure what it should do;
> custom diff drivers don't know how to handle combined diff, do they?
>
> If you write me a test case that explains what _should_ happen, I'll see
> what I can do. :)

I do not think it is sensible to expect anybody to come up with a sane
semantics for combined diff to work with GIT_EXTERNAL_DIFF (and external
diff driver that can be specified via the attributes mechanism) in any
meaningful way.

The whole point of the external diff mechanism is that an external command
can take _two_ files and represent the change between them in a way that
is more suited for the need of the user than the patch form. The output
from such an external command does not have any obligation to even follow
the convention used by the patch output, namely:

  @@ from here to there things have changed @@
   this is common
  -this was the removed content
  +this is the new content

as the _whole_ point of the external diff mechanism is to give something
that is _different_ from the patch form, in the hope that it is in a more
appropriate form for whoever consumes the output.

On the other hand, combined diff is all about combining multiple patches
show them side-by-side in a combined fashion. Without the above four kinds
of cues, there is no way to even _align_ the change outputs from two
parents, let alone _combining_ them.

Anybody interested can check "compare-cooking.perl" in the todo branch,
which is used as an external diff driver to view the differences between
"What's cooking" postings via these:

    [diff "whatscooking"]
            xfuncname = "^\\[(.*)\\]$"
            command = ./compare-cooking.perl

in the .git/config file, together with

    whats-cooking.txt diff=whatscooking

in the .gitattributes file. Running

    $ git log -p --ext-diff todo -- whats-cooking.txt

would give a sample output.

It is conceivable that we _could_ newly define a "combined external diff
driver" that would take 3 or more files, and compute and show the combined
result by itself, but that will certainly not go through the codepath you
touched with the textconv patch. Calling out to such a new type of
external diff driver would have to happen at the level where we have 1+N
blob object names for a N-parent commit, namely, at the beginning of
show_patch_diff(), bypassing the entire contents of that function and
instead letting the new n-way external diff driver do everything.

I however highly doubt that such an interface would make sense. For
example, what would be the desirable format to compare three versions of
"What's cooking" postings, and how would the updated compare-cooking.perl
script would look like?
