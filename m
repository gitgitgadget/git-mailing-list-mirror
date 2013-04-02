From: Junio C Hamano <gitster@pobox.com>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 02 Apr 2013 10:16:55 -0700
Message-ID: <7v1uasg8e0.fsf@alter.siamese.dyndns.org>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
 <20130402163034.GA19252@sigill.intra.peff.net>
 <7vhajog9xp.fsf@alter.siamese.dyndns.org>
 <20130402165128.GA19712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4pr-0000Et-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761784Ab3DBRQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:16:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761172Ab3DBRQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:16:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3A8126D5;
	Tue,  2 Apr 2013 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rEHgq4lkCPD2dXNeIu4mP8RJ5g=; b=l6588m
	//oFt0mCgowtVvo55PsfGXEq7WPZsgy8tVPfzxq/mrZjfGR3ZU2PCplAw77X8pmr
	GW084GB3hiFjw3HPM8pM58KyCcHz5PCca/2ebaP64AT0OzVuAuW4JTKHF85fGVkm
	/ZRKPCWrSj8fmcMJ/utbB3V65vgoKw6+FW1xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X+aRlcjxHDLHp9u6gHrwS8aVxiGD2k5g
	nKQ57peJmK4dsxcvVPgG8UE+j3tfc8nEruoYxwbeFNWhNgrGv04ZW/IpQyXXjc+i
	I1XqgtQBb5qXXEIo6pNn+/KrpBZK6Y70X8bPdq/2VoiaGRUI1yF15ns9BEXP/RJz
	Rc8yMnoja/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 071C4126D3;
	Tue,  2 Apr 2013 17:16:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CE78126CF; Tue,  2 Apr
 2013 17:16:57 +0000 (UTC)
In-Reply-To: <20130402165128.GA19712@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 12:51:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F6651D6-9BB9-11E2-A649-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219807>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 02, 2013 at 09:43:30AM -0700, Junio C Hamano wrote:
>
>> > In some systems, yes, but git does not have any notion of "doc/" as an
>> > item (after all, we track content in files, not directories), so I do
>> > not see what it means to specify a directory except to say "everything
>> > under it has this property".
>> 
>> That was true back when gitattributes (and ignore) was defined to
>> apply only to the paths we track.  But export-ignore abuses the
>> attrtibute system, allows a directory to be specified in the match
>> pattern, and we declared that is a kosher use by the patch that
>> caused 1.8.1.X regression, no?  So "Git does not have any notion of
>> "doc/' as an item" is no longer true, I think.
>
> Yes, but as I explained later, the meaning of "apply an attribute to
> dir" in such cases is always equivalent to "apply attribute
> recursively to dir/*". So I do not think we are violating that rule to
> recursively apply all attributes.

I think this is where we disagree.  Attribute does not recursively
apply in general.  It was _never_ designed to (and that is the
authoritative answer, as I was who designed it in Apr 2007 ;-)).

It is not even true to say that "archive" applies export-ignore to
the directory recursively, with or without the recent change.  Would
it allow everything but dir/file to be excluded and still dir/file
to be included in the archive if you have a .gitattribute file like
this?

	dir/ export-ignore
        dir/file !export-ignore

I do not think so.

If we _were_ living in an alternate universe where we did not have
the .gitignore file and instead expressed what it does with an
"ignore" attribute, then having "dir" in the top-level .gitignore
file and "!file" in the .gitignore file in "dir/" directory may be
equivalent to having

	dir/ ignore
        dir/file -ignore

in your .gitattribute, and we would want to ignore dir/other while
including dir/file in the "may be interesting" paths.

The point is, yes, we could choose to define individual attribute
keys to apply recursively, but in general attributes were designed
not to recurse, and no existing attribute recurses.

> But let's take a step back. I think Jan is trying to do a very
> reasonable thing: come up with the same set of paths that git-archive
> would. What's the best way to solve that?

Because the attribute does not recursively apply in general, and it
is entirely up to the application and a particular attribute key to
decide how the key is applied in the context of the application,
"check-attr" by itself cannot know.  You need to know how "archive"
treats "export-ignore" attribute and then use "check-attr" with that
knowledge.

> Using:
>
>   git ls-tree --name-only -zrt HEAD |
>   git check-attr --stdin -z export-ignore
>
> means we can find out that "foo/" is ignored.

Yes, and after learning that, we need to reject everything foo/*
using the knowledge that "git archive" cuts all subpaths of a path
that has "export-ignore" attribute is attached to.
