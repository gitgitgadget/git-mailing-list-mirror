From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Fri, 28 Feb 2014 10:45:39 -0800
Message-ID: <xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
References: <20140124022822.GC4521@sigill.intra.peff.net>
	<52E1D39B.4050103@fb.com>
	<20140128060954.GA26401@sigill.intra.peff.net>
	<xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
	<20140224082459.GA32594@sigill.intra.peff.net>
	<xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
	<20140226101353.GA25711@sigill.intra.peff.net>
	<xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
	<20140227112734.GC29668@sigill.intra.peff.net>
	<xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
	<20140228085546.GA11709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 19:45:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJSRR-0007ir-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 19:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbaB1Spp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 13:45:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbaB1Spo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 13:45:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCDC36F5D1;
	Fri, 28 Feb 2014 13:45:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dXW9klJZFAo98voFsB5byDzy5d4=; b=EIRcdJ
	Re+PNE4df7TDReZSFZyLDhIHwYVwq0HF+qgHIHIeMnE0C6rHwHVWEwjoWPebtMCx
	O3mFF/tGi0o7DUPY7Kgn05y3qveu5ZNlVstiBQWFLxumKlepHHEXJNFJ9KB3Cm0m
	ZRTQNCiCSn9XuFALyXpamPlzux3V/EWt18H3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k8aY+QvrlEKMM8ELktv4sGisI6OGmZC7
	kugAqwXKVRTEFJfZXgzcl6fciRhkwwS6gXAWwO9G5tCECW9HEr2UkUiBvUq69mmr
	us1EcLR1PMifKnpzSaCtKqzDVJWOQcoqmefzCAsN7YutgGi+xOUQc+dWGTLBrAyA
	5RANUFpvzoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA1A6F5D0;
	Fri, 28 Feb 2014 13:45:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF9436F5CE;
	Fri, 28 Feb 2014 13:45:41 -0500 (EST)
In-Reply-To: <20140228085546.GA11709@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Feb 2014 03:55:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8636FFB0-A0A8-11E3-8E17-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243002>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 27, 2014 at 10:04:44AM -0800, Junio C Hamano wrote:
>
>> I wonder if it makes sense to link it with "pack.writebitmaps" more
>> tightly, without even exposing it as a seemingly orthogonal knob
>> that can be tweaked, though.
>> 
>> I think that is because I do not fully understand the ", because ..."
>> part of the below:
>> 
>> >> This patch introduces an option to disable the
>> >> `--honor-pack-keep` option.  It is not triggered by default,
>> >> even when pack.writeBitmaps is turned on, because its use
>> >> depends on your overall packing strategy and use of .keep
>> >> files.
>> 
>> If you ask --write-bitmap-index (or have pack.writeBitmaps on), you
>> do want the bitmap-index to be written, and unless you tell
>> pack-objects to ignore the .keep marker, it cannot do so, no?
>> 
>> Does the ", because ..." part above mean "you may have an overall
>> packing strategy to use .keep file to not ever repack some subset of
>> the objects, so we will not silently explode the kept objects into a
>> new pack"?
>
> Exactly. The two features (bitmaps and .keep) are not compatible with
> each other, so you have to prioritize one. If you are using static .keep
> files, you might want them to continue being respected at the expense of
> using bitmaps for that repo. So I think you want a separate option from
> --write-bitmap-index to allow the appropriate flexibility.

What is "the appropriate flexibility", though?  If the user wants to
use bitmap, we would need to drop .keep, no?  Doesn't always having
two copies in two packs degrade performance unnecessarily (without
even talking about wasted diskspace)?  An explicit .keep exists in
the repository because it is expensive and undesirable to duplicate
what is in there in the first place, so it feels to me that either

 - Disable with warning, or outright refuse, the "-b" option if
   there is .keep (if we want to give precedence to .keep); or

 - Remove .keep with warning when "-b" option is given (if we want
   to give precedence to "-b").

and nothing else would be a reasonable option.  Unfortunately, we
can do neither automatically because there could be a transient .keep
file in an active repository.

So I think I agree with this...

> The default is another matter.  I think most people using .bitmaps on a
> server would probably want to set repack.packKeptObjects.  They would
> want to repack often to take advantage of the .bitmaps anyway, so they
> probably don't care about .keep files (any they see are due to races
> with incoming pushes).

... which makes me think that repack.packKeptObjects is merely a
distraction---it should be enough to just pass "--pack-kept-objects"
when "-b" is asked, without giving any extra configurability, no?

> So we could do something like falling back to turning the option on if
> --write-bitmap-index is on _and_ the user didn't specify
> --pack-kept-objects.

If you mean "didn't specify --no-pack-kept-objects", then I think
that is sensible.  I still do not know why we would want the
configuration variable, though.
