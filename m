From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in
 gittutorial
Date: Mon, 25 Aug 2008 17:29:19 -0700
Message-ID: <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
References: <20080825215023.11822a20@paolo-desktop>
 <loom.20080825T200956-169@post.gmane.org>
 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 02:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXmSY-0004xM-Qz
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 02:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYHZA33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 20:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbYHZA33
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 20:29:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbYHZA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 20:29:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FE4E68F42;
	Mon, 25 Aug 2008 20:29:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 01B5968F3F; Mon, 25 Aug 2008 20:29:20 -0400 (EDT)
In-Reply-To: <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
 (Paolo Ciarrocchi's message of "Mon, 25 Aug 2008 22:42:44 +0030")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09ECA46C-7306-11DD-9B4B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93697>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> On 8/25/08, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Raible <raible@gmail.com> writes:
>>
>>> Paolo Ciarrocchi <paolo.ciarrocchi <at> gmail.com> writes:
>>>
>>>> +Alice can also use gitk to browse that Bob did:
>>>
>>> s/that/what/ ?
>>>
>>>> +------------------------------------------------
>>>> +alice$ gitk master origin/master
>>>> +------------------------------------------------
>>>
>>> I think that you meant:
>>>
>>> alice$ gitk master..origin/master
>>
>> I'd suggest rewording the explanation to have Alice "compare what both of
>> them did", not just "browse what Bob did".
> ...
>> And for that purpose, I think the original form used by Paolo's patch is
>> the most appropriate here in an early part of the tutorial, as it teaches
>> how to view full histories leading to the tips of these two branches.
>
> well, it might be a good idea to mention both.
>
> do you think we should add a note about git log --graph as well?

"Probably yes" and "not here".

>> Earlier in the tutorial sequence we teach "gitk" without any parameter to
>> view the history of the current branch, and here the user learns one new
>> thing, to view more than just the current branch.
> ...
>> Limiting the output with "..origin/master" (or "...origin/master") can be
>> taught after demonstrating this most basic form.

With the existing flow, I would actually suggest you not to use
origin/master at all.  The example before you inserted your changes does
not update origin/master.

	Alice can use gitk to compare what both of them did:

	$ gitk HEAD FETCH_HEAD

then teach the limiting:

	Notice unlike the earlier example that you used gitk to view the
	history leading to current status, this shows both histories
	leading to Alice's current state (HEAD) and the state you just
	fetched from Bob (FETCH_HEAD).  You can limit what is shown by
	using revision range notation:

        $ gitk HEAD..FETCH_HEAD

	Two commits written with two dots in between means "show
	everything that is reachable from the latter but excluding
	anything that is reachable from the former".  Alice already knows
	what she did well, as well as what she and Bob started working on,
	and she is only interested in what Bob did since their histories
	forked, working independently.

	By the way, the notation "git log -p ..FETCH_HEAD" you saw
	earlier is a short-hand for "git log -p HEAD..FETCH_HEAD".  HEAD,
	that means your current state, can be dropped on either side of
	the two-dot range notation.

It might be better to remove the last paragraph, and instead explain the
meaning of "..FETCH_HEAD" notation immediately after "git log -p" was used
to "fetch-review-but-not-integrate" description (i.e. before the part your
patch touched).

If you want to, you can also teach three-dot form after showing how to use
the two-dot form.

	Alice may want to view what both of them did since they forked.
	She can use three-dot form instead of the two-dot form:

        $ gitk HEAD...FETCH_HEAD

	This means "show everything that is reachable from either one, but
	exclude anything that is reachable from both of them".

	Again, note that these range notation can be used with both gitk
	and "git log".
