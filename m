From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Mon, 20 May 2013 09:17:34 -0700
Message-ID: <7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
	<CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 18:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeSmP-0001uS-CT
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 18:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3ETQRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 12:17:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab3ETQRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 12:17:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3090E2058E;
	Mon, 20 May 2013 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JGu0hrGK30zCj6ZXpNJXtrgKX6E=; b=NfwCJp
	5tNG0zGyOMtywlf7mAU556h+bascp/QsPdEthBSaRTtt+NyRQSwHY0DoRGiMBapV
	fOc2kv+F+Bp77yasF+sKoRPfne8QlFw3+LHAb+81BifnmPLJ29PWI4VXE8d4Sn9N
	7Xv+yBSLHapZP3Tx8orSHN5Iusmu20HKGUNYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DS+qwuUv/sOZ/3DIAgopaxflK1iJEjKy
	vggcPXHXOVO6JFS0469r4kQVq6YRJYrVM6TtnE5bx3wefQdHtmu9ZH8e/ay5caqk
	vbRyPfpkadydY3GmhPZvECPEQPJg0QdVJbrfaLMPsPr8ejnclpyzFTgaP7tGN3PV
	Et4IQTTqHTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 239CC2058D;
	Mon, 20 May 2013 16:17:38 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B3242058A;
	Mon, 20 May 2013 16:17:37 +0000 (UTC)
In-Reply-To: <CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 20 May 2013 17:18:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C942523E-C168-11E2-9F6E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224960>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, May 16, 2013 at 6:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/warn-ambiguous-object-name (2013-05-07) 1 commit
>>  - get_sha1: improve ambiguity warning regarding SHA-1 and ref names
>>
>>  "git cmd <name>", when <name> happens to be a 40-hex string,
>>  directly uses the 40-hex string as an object name, even if a ref
>>  "refs/<some hierarchy>/<name>" exists.  This disambiguation order
>>  is unlikely to change, but we should warn about the ambiguity just
>>  like we warn when more than one refs/ hierachies share the same
>>  name.
>>
>>  The message needs to be fixed up, as this is not "refname is
>>  ambiguous".
>
> hm.. how should the message be rephrased? ambiguity of 40-hex string
> and a ref path?

At that point, the user gave us a full object name and we are going
to treat it as a full object name, no?  Wouldn't it be necessary to
let the user know that it is different from having two ambiguous refs?

Think why the user has such a hard to type ref in the first place.
The user may have done this previously, thinking that he is detaching
the HEAD to fix an earlier mistake in a branch:

    $ BAD_COMMIT=$(git rev-parse nd/magic~8)
    $ git checkout $BAD_COMMIT

but by mistake gave a "-b" after "checkout", i.e.

    $ git checkout -b $BAD_COMMIT

After this, commands that want to work on branch name would still
work as "expected", with the expectation being the user would be
working on the refs/heads/$BAD_COMMIT branch, e.g.

    $ git checkout $BAD_COMMIT
    $ git branch -m $BAD_COMMIT nd/magic-fix

but commands that want to work on commit object name will resolve it
to the $BAD_COMMIT object (i.e. nd/magic~8), e.g.

    $ git log $BAD_COMMIT

and needs disambiguation if the user wants to work on the commit at
the tip of the branch, e.g.

    $ git log heads/$BAD_COMMIT

So we really do want the users to notice and take corrective action,
and one way to attract the attention of the users is to phrase the
message more explicitly to let them know what is going on.

In addition to your topic, it may be a good idea to notice this at
the Porcelain level (e.g. "checkout -b" and "branch", but not at the
"update-ref" level) and warn or even die if a Porcelain tries to
create a branch with such a name.
