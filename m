From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Fri, 31 Jul 2009 10:17:45 -0700
Message-ID: <7v1vnwsreu.fsf@alter.siamese.dyndns.org>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vljm84htf.fsf@alter.siamese.dyndns.org>
 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
 <20090729174000.6117@nanako3.lavabit.com>
 <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com>
 <7v3a8d65kv.fsf@alter.siamese.dyndns.org>
 <94a0d4530907310838nbca0037u1a192dc07a379e66@mail.gmail.com>
 <cb7bb73a0907310916i309c99cax2f2d5aa02084103f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 19:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWvk1-0007Vh-55
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 19:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZGaRRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 13:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZGaRRx
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 13:17:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbZGaRRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 13:17:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DFC711BD87;
	Fri, 31 Jul 2009 13:17:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DCB911BD86; Fri,
 31 Jul 2009 13:17:46 -0400 (EDT)
In-Reply-To: <cb7bb73a0907310916i309c99cax2f2d5aa02084103f@mail.gmail.com>
 (Giuseppe Bilotta's message of "Fri\, 31 Jul 2009 18\:16\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 149E8352-7DF6-11DE-A3C1-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124584>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Before I go on with the next revision of the patch, I would like to
> have some kind of agreed convention to implement.
>
> My suggestion would be the following:
> (1) implement options --ignore-space-change, --ignore-all-space
> mirroring their 'git diff' meaning.
> (2) add --ignore-whitespace as a synonym to --ignore-space-change, for
> consistency with 'patch'
> (3) apply.ignore-whitespace accepts values
>      * false,no,none,0 to mean no whitespace ignoring
>      * true,yes,change,1 to mean ignore whitespace change
>      * all,2 to mean ignore all whitespace

I'd suggest taking one small bite at a time.  You do not have code to do
the ignore-all-space semantics that has been reviewed, and you neither
have the configuration variables.  So my preference would be to do in the
first round the first half of (1) with (2), docs, tests and nothing else.

A later follow-up patch would complete your (1) and (2) by supporting
ignore-all-space.  And perhaps you would give it --ignore-all-whitespace
synonym perhaps?  You may want to ask "GNU patch" people if they are
interested in ignoring all whitespaces, and if so what their plan is to
name that option, so that you can use the same name.

As to configuration:

 - I think the naming convention (I know, there are existing violators,
   but that is not an excuse to add new ones) is without dashes (again, I
   know I personally do not like CamelCase but that is what we have);

 - I personally think 0/1/2 would be more cluttering than they are useful.

 - I'd say "no (never, none)", "change", "all".  You could throw in
   "false" if you want, as declining this option is quite boolean-ish, but
   activating it is _not_ boolean decision and I would suggest actively
   keeping "true" or "yes" out of the choices.  Otherwise anybody who is
   tempted to answer "yes" has to ask himself "Ok, I want to say 'yes' but
   which semantics does it mean?  What would I be ignoring?"

That non-booleanness of "true" is why I am somewhat negative on your (2)
above.  It would only be there for people who know "GNU patch" because
they would understand it.
