From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 23 Sep 2014 10:15:47 -0700
Message-ID: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
	<CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 19:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWTgw-0001NN-OK
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 19:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbaIWRPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 13:15:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60757 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbaIWRPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 13:15:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 234783960B;
	Tue, 23 Sep 2014 13:15:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHzvNLXmtKUHGfLo4ShlgpKZOt0=; b=U5japI
	PROH7qBn7+C4DmZ9k37NGJzPgbyKzPMhL/FjsNs0aqdmpCRrZ9MoqkbsT4+BQHVd
	5aomvE3uOV0ni8raxxWjsWORrJmAa/WdBock2fClNP3O1lOwvrUHVzRL4aCER4j+
	YM5q06i9KC3K8rU5FQcGwQFLBKHB7qqHrup+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udN1OMUsGDRItIeIXziLiQ6kDJ6B+piY
	+3zMhzqQ0xXyrQdFtaIIbrjgc8sDfJ1jQX0ZwupLgowcvlt6xtQDh/bjzanmCiaz
	FbsA1t59ZRdvMTf8plZ50DDb+yy9v3aAel9JLq9Csl6LB6hW8fGcgtfVKw+8n2FV
	2iXVpIrNGdk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1975D3960A;
	Tue, 23 Sep 2014 13:15:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 901E539609;
	Tue, 23 Sep 2014 13:15:48 -0400 (EDT)
In-Reply-To: <CAP8UFD2W1r9859FgpBXqvdNLAfXoCwjpEFpTKXU6fGuC_8uvBg@mail.gmail.com>
	(Christian Couder's message of "Tue, 23 Sep 2014 09:45:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43217940-4345-11E4-A5B5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257429>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Sep 22, 2014 at 4:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> ...
>> As a reminder, this old patchset (that I replied to) enhanced git am -s
>> with an option to add different signatures depending on
>> the option passed to the -s flag.
>> E.g. I have
>> [am "a"]
>>         signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
>>
>> [am "r"]
>>         signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
>>
>> [am "t"]
>>         signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"
>>
>> and now:
>>         git am -s art
>> adds all 3 signatures when applying the patch.
>
> This is probably not as simple as you would like but it works with
> something like:
>
> $ git interpret-trailers --trailer "Acked-by: Michael S. Tsirkin
> <mst@redhat.com>" --trailer "Reviewed-by: Michael S. Tsirkin
> <mst@redhat.com>"  --trailer "Tested-by: Michael S. Tsirkin
> <mst@redhat.com>" 0001-foo.patch >to_apply/0001-foo.patch
>
> and then:
>
> $ git am to_apply/*.patch

If I understand it correctly, Michael is envisioning to implement
his "git am -s art" (I would recommend against reusing -s for this,
though.  "git am --trailer art" is fine) and doing so by using
interpret-trailers as an internal implementation detail, so I would
say the above is a perfectly fine way to do so.  An equivalent of
that command line is synthesized and run internally in his version
of "git am" when his "git am" sees "--trailer art" option using
those am.{"a","r","t"}.trailer configuration variables.

> Also by using something like:
>
> $ git config trailer.a.key Acked-by
> $ git config trailer.r.key Reviewed-by
> $ git config trailer.t.key Tested-by
>
> the first command could be simplified to:

So I think this mechanism buys Michael's use case very little, if
any.  It might be useful in other contexts, though.

What would be more interesting is if the primitives you have,
e.g. "replace", "append", etc. are sufficient to express his use
case and similar ones.  For example, when working on multiple
trailers (e.g. "am --trailer art" would muck with three kinds), how
should "do this if exists at the end and do that otherwise" work?
To an existing message ends with Michael's Signed-off-by:, if his
"git am --trailer arts" is called to add these three and then a
Signed-off-by: from him, should it add an extra S-o-b (because his
existing S-o-b will no longer be the last one after adding Acked and
others), or should it refrain from doing so?  Can you express both
preferences?

Another thing that got me wondered this morning while I was thinking
about this topic was if "replace" is flexible enough.  We may want
to have "if an entry exists (not necessarily at the end), remove it
and then append a new one with this value at the end" to implement
"Last-tested-by: me@my.domain", for example.
