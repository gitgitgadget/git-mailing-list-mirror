From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 20 Oct 2008 16:54:55 -0700
Message-ID: <7vwsg22568.fsf@gitster.siamese.dyndns.org>
References: <1224445691-1366-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vy70k5las.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0810200935sf7ad873tea53c0fb53bbe1c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 02:02:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks4bn-0007EV-Pm
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYJTXzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYJTXzE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:55:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYJTXzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:55:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1F718D6F4;
	Mon, 20 Oct 2008 19:55:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA9278D6F3; Mon, 20 Oct 2008 19:54:57 -0400 (EDT)
In-Reply-To: <4ac8254d0810200935sf7ad873tea53c0fb53bbe1c0@mail.gmail.com>
 (Tuncer Ayaz's message of "Mon, 20 Oct 2008 18:35:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 830E7B7C-9F02-11DD-B95D-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98748>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> On Sun, Oct 19, 2008 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>> @@ -23,6 +24,10 @@ rebase=$(git config --bool branch.$curr_branch_short.rebase)
>>>  while :
>>>  do
>>>       case "$1" in
>>> +     -q|--quiet)
>>> +             verbosity="$verbosity -q" ;;
>>> +     -v|--verbose)
>>> +             verbosity="$verbosity -v" ;;
>>
>> You know verbosity flags (-q and -v) are "the last one wins", so I do not
>> see much point in this concatenation.
>
> Without concatenation I would need to analyze the content
> of the variable each time the option is passed to the shell
> script. Do you know of a simpler/better way still keeping the
> functionality that
> $ git pull -q -v --quiet --verbose --quiet gives verbosity=QUIET
> and
> $ git pull -q -v --quiet --verbose --quiet -v yields verbosity=VERBOSE
> ?

Wouldn't

	verbosity=
	while :
        do
        	case "$1" in
                -q|--quiet) verbosity=-q ;;
                -v|--verbose) verbosity=-v ;;
		... others ...
                esac
                shift
	done
        git pull $verbosity other options

give the -q for the former and -v for the latter to "git pull"?
