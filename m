From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in
 gittutorial
Date: Tue, 26 Aug 2008 11:13:34 -0700
Message-ID: <7viqtnabld.fsf@gitster.siamese.dyndns.org>
References: <20080825215023.11822a20@paolo-desktop>
 <loom.20080825T200956-169@post.gmane.org>
 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY345-0002nh-PV
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbYHZSNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbYHZSNp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:13:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbYHZSNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:13:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F27B468ECE;
	Tue, 26 Aug 2008 14:13:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E45FB68ECC; Tue, 26 Aug 2008 14:13:36 -0400 (EDT)
In-Reply-To: <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
 (Paolo Ciarrocchi's message of "Tue, 26 Aug 2008 10:16:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B7627F56-739A-11DD-8D7F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93792>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> Maybe something like that?
> Not intended to be applied, probably manglade and with no sob.
> Just for discussion:
>
> diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
> index 48d1454..4f6d4e9 100644
> --- a/gittutorial.txt.txt
> +++ b/gittutorial.txt.txt
> @@ -321,10 +321,51 @@ pulling, like this:
>
>  ------------------------------------------------
>  alice$ git fetch /home/bob/myrepo master
> -alice$ git log -p ..FETCH_HEAD
> +alice$ git log -p HEAD..FETCH_HEAD
>  ------------------------------------------------
>
>  This operation is safe even if Alice has uncommitted local changes.
> +Note that HEAD, that means your current state, can be dropped on either
> +side of the two-dot range notation.

Descriptions of individual steps all looked good, but the presentation
order is a bit screwy here.  You are introducing two-dot range without
explaining what it means here, and the explanation comes a bit later.

So here are the tweaks I would suggest:

 * Show only "git log -p HEAD..FETCH_HEAD" here;

 * After "This operation is safe ... local changes.", say "The range
   notation HEAD..FETCH_HEAD" means "show everything that is reachable
   from the FETCH_HEAD but exclude anything that is reachable from HEAD.
   Alice already knows everything that leads to her current state (HEAD),
   and reviewing what Bob has in his state (FETCH_HEAD) that she has not
   seen with this command";

 * Drop "This means..." and "log -p ..FETCH" example;
 
 * Replace the explanation for the two-dot range notation after "gitk
   HEAD..FETCH_HEAD" with "This uses the same two-dot range notation we
   saw earlier with 'git log'".

 * And finally, if we wanted to, we can top about omission of HEAD in
   either end of the range notation.  Just before "Please note that these
   range notation...", say "Because viewing range between your current
   state and something else is common, you can omit HEAD from either side
   of two- or three-dot range notation.  I.e. 'git log ..FETCH_HEAD' is a
   shorthand for 'git log HEAD..FETCH_HEAD', and 'gitk ...FETCH_HEAD' is a
   shorthand for 'gitk HEAD...FETCH_HEAD'.

> +This means that Alice can also inspect what Bod did issuing the following
> +command:
> +
> +------------------------------------------------
> +alice$ git log -p ..FETCH_HEAD
> +------------------------------------------------
> +
> +Alice can use gitk to compare what both of them did:
> +
> +------------------------------------------------
> +$ gitk HEAD FETCH_HEAD
> +------------------------------------------------
> +
> +This shows both histories leading to Alice's current state (HEAD) and the
> +state Alice just fetched from Bob (FETCH_HEAD).
> +
> +If Alice wants to visualize what Bob did since their historie forked
> +she can issue the following command:
> +
> +------------------------------------------------
> +$ gitk HEAD..FETCH_HEAD
> +------------------------------------------------
> +
> +Two commits written with two dots in between means "show
> +everything that is reachable from the latter but excluding
> +anything that is reachable from the former".
> +
> +Alice may want to view what both of them did since they forked.
> +She can use three-dot form instead of the two-dot form:
> +
> +------------------------------------------------
> +$ gitk HEAD...FETCH_HEAD
> +------------------------------------------------
> +
> +This means "show everything that is reachable from either one, but
> +exclude anything that is reachable from both of them".
> +
> +Please note that these range notation can be used with both gitk
> +and "git log".
>
>  After inspecting what Bob did, if there is nothing urgent, Alice may
>  decide to continue working without pulling from Bob.  If Bob's history
