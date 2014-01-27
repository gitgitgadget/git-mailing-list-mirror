From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to substructure rewrites?
Date: Mon, 27 Jan 2014 07:58:27 -0800
Message-ID: <xmqqppndpgbg.fsf@gitster.dls.corp.google.com>
References: <877g9ocjsk.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 27 16:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7oaK-0006Vi-1e
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 16:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbaA0P6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 10:58:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbaA0P6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 10:58:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91922679A6;
	Mon, 27 Jan 2014 10:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9Rs6UFMPun6uKv/uwthvOXrZ+Q=; b=FhI+lZ
	bleeGC46nT6HM6Ks8uoDeV26BDH+DeMhXfItSFCc9sWAjqK6B06e33IfzJD8lKrM
	Z0RMiutgmqLNHIKgJqc9dKeIkksKA6dgKx0buzHZxWYBayYq2X6OFEcotydDFvck
	ezAT95+ustK65p6vUTYFk0WTYdFdOC0RSvA2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlsyGvXfNvcbLwY7yef6qV8GgElDgUK3
	Xg5Fqzyt37fUcZ8lv9duU4fsb48lAy1IAT4hURzyuvpI2MK9gTFQe1+/4nGbBdVJ
	YvK8Ky/iglRjSWkXzJ5vZV5m4JYDDEA/QoIjEs3xI8PIAu72pal2KKmTAres0Fw3
	lhMh3bKnEHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F876679A5;
	Mon, 27 Jan 2014 10:58:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C109679A3;
	Mon, 27 Jan 2014 10:58:31 -0500 (EST)
In-Reply-To: <877g9ocjsk.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 25 Jan 2014 13:44:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE86241C-876B-11E3-8E35-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241142>

David Kastrup <dak@gnu.org> writes:

> As it can easily be guessed, the "add xxx function" commits are
> basically adding not-yet-used code (and so will not disrupt
> compilation), but everything starting with "Reorganize blame data
> structures" up until the final commit will not work or compile since the
> code does not match the data structures.
>
> So there is little point in substructing all that, right?  Even
> something seemingly isolated like
>
> commit f64b41c472442ae9971321fe8f62c3885ba4d8b7
> Author: David Kastrup <dak@gnu.org>
> Date:   Sun Jan 19 02:16:21 2014 +0100
>
>     blame.c: Let output determine MORE_THAN_ONE_PATH more efficiently
>
> is not really useful as a separate commit since while it does implement
> a particular task, this is done starting with non-working code relying
> on no-longer existent data structures.

Small pieces that are incrementally added with their own
documentation would certainly be a lot easier to read than one big
ball of wax.  I am wondering if it would make it easier for
everybody to tentatively do "git-blame vs git-blame2" dance here,
just like we did "git-blame vs git-annotate" dance some years ago.
That is, to add a completely new command and have them in parallel
while cooking in 'next' (or we could even keep them in a few
releases if we are not absolutely certain about the correctness of
the result of the new code), aiming to eventually retire the current
implementation and replace it with the new one.  We have already
have test infrastructure to allow us to run variants of blames, too,
to help that kind of transition.

> In general, the rule is likely "any commit should not create a
> non-working state" right?

Yes.
