From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git submodule output on invalid command
Date: Fri, 05 Sep 2008 22:03:02 -0700
Message-ID: <7vd4jhuard.fsf@gitster.siamese.dyndns.org>
References: <1220631370-19777-1-git-send-email-pdebie@ai.rug.nl>
 <7vy726v30m.fsf@gitster.siamese.dyndns.org>
 <20080906042217.GB18930@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 07:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbpzX-00036g-Mj
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 07:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYIFFDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 01:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYIFFDs
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 01:03:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYIFFDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 01:03:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 29E46750F2;
	Sat,  6 Sep 2008 01:03:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 913DA750ED; Sat,  6 Sep 2008 01:03:08 -0400 (EDT)
In-Reply-To: <20080906042217.GB18930@gmail.com> (David Aguilar's message of
 "Fri, 5 Sep 2008 21:22:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D11C0D4-7BD1-11DD-B89E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95060>

David Aguilar <davvid@gmail.com> writes:

> On  0, Junio C Hamano <gitster@pobox.com> wrote:
>> Pieter de Bie <pdebie@ai.rug.nl> writes:
>> ...
>> >  module_list()
>> >  {
>> > -       git ls-files --stage -- "$@" | grep '^160000 '
>> > +       git ls-files --stage -- "$@" | grep '^160000 ' ||
>> > +       if test -z "$@"; then
>> 
>> Shell nit; this must be "$*" not "$@", right?
>
> I added the module_list() function when moving the duplicated
> code into a separate function.  The code was lifted verbatim.
> I can submit a patch cleaning that up if it should indeed use
> "$*".  Just let me know.

Nothing you did is involved in this nit; I was talking about "test -z"
argument.

	cmd "$@"

gives N separate argument to the "cmd", as if each of them is surrounded
by a dq pair, i.e.

	cmd "$1" "$2" "$3"...

while

	cmd "$*"

gives a single argument to the "cmd", all separated with the first
character of $IFS (typically a SP), i.e.

	cmd "$1 $2 $3..."

which is what the "test -z" above would want to test (testing $# is Ok for
the purpose of this test as well).

The "$@" you moved is the argument given to ls-files; that one should be
"$@" and replacing it to "$*" would be wrong.
