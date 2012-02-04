From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 03 Feb 2012 22:20:14 -0800
Message-ID: <7vhaz7jf1d.fsf@alter.siamese.dyndns.org>
References: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
 <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
 <20120204050818.GA2477@tgrennan-laptop>
 <7vsjirjhp7.fsf@alter.siamese.dyndns.org>
 <20120204055656.GC2477@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com, tom.grennan@ericsson.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:20:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtYz2-0000Fd-OD
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab2BDGUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:20:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2BDGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:20:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0512F75;
	Sat,  4 Feb 2012 01:20:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jnPI+6w4lIE2m96SjkdjfkwTnMc=; b=aNKHg6
	8JF2lC2mkw5RCKBj3ozZb+6Vt8Ju8pt5N6NkJMEHAeWz9AY28fUO8xOOC7e6iNKZ
	zkhJwl+3CNKN+ou4m45eoGCJe7BZnUFDC9KF364Z/rmVOuln5s58e4Wjr33EFqfz
	WJUMcVWlspihrfWtFfpWnbgD1P+CA8PP8xaGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJlVg/UvhoaN4kJ3p2HEFgifC6RM2fnL
	Glm0oEElkVA6vw/tAXsQycwgyyCnEBS+uCiFl9wq9GdbFhqQJIe19PK0zUsC/myc
	bZNORMOfDuhAzMVcmvGHc2RB0DgY3nqSEsIa3U77qw1Cb67QUnaio8vQvHx839RI
	Sk3mAuMuk90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44B202F74;
	Sat,  4 Feb 2012 01:20:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF55F2F72; Sat,  4 Feb 2012
 01:20:15 -0500 (EST)
In-Reply-To: <20120204055656.GC2477@tgrennan-laptop> (Tom Grennan's message
 of "Fri, 3 Feb 2012 21:56:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D99CD12-4EF8-11E1-AE11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189848>

Tom Grennan <tmgrennan@gmail.com> writes:

> On Fri, Feb 03, 2012 at 09:22:44PM -0800, Junio C Hamano wrote:
>>Tom Grennan <tmgrennan@gmail.com> writes:
>>
>>> Wouldn't you want Shawn and Jeff to tag the object (commit, tree, or
>>> blob) that you had tagged?
>>
>>No.
>>
>>We _designed_ our tag objects so that they are capable of pointing at
>>another tag, not the object that is pointed at that other tag.  And that
>>is the example usage I gave you.
>>
>>The statement by Shawn and Jeff, "This tag is Gitster's" is exactly that.
>>It was not about asserting the authenticity of the commit. It was about
>>the tag object I created.
>
> Hmm, how about "git verify-tag [[-v] [--to]] <tag|object>"?
> With "--to", all tags to the given tag (or object) are verified.
> Without "--to" just the given <tag> is verified.
>
>>>    gitster$ git verify-tag --pointed v1.7.10
>>>    tag v1.7.10: OK
>>
>>Just saying "$name: OK" will *never* be acceptable. "A signature made by
>>any key in my keychain is fine" is not the usual use case. At least the
>>output needs to be "Good signature from X".
>
> OK, I'll have to play with the gpg --verify-options.

If it wasn't clear enough from my other message, I would rather not to see
any change to --verify codepath as the first step.  Don't you think that
the simplest and cleanest first step is to add --points-at to the list
mode, so that with help from "| xargs git tag -v" you can bulk-verify
without any other change?
