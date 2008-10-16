From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Wed, 15 Oct 2008 23:15:07 -0700
Message-ID: <7vtzbdjcb8.fsf@gitster.siamese.dyndns.org>
References: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
 <7vzll887ps.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0810131529l37d67b61q3589f15700d38261@mail.gmail.com>
 <4ac8254d0810151047p7e12e8efk6fea666d2ac85f0f@mail.gmail.com>
 <7vy70p3cga.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0810151220l48b81325yf3aca48cda49ef3a@mail.gmail.com>
 <7vprm1pfmd.fsf@gitster.siamese.dyndns.org>
 <4ac8254d0810152254i615bca9dye0aedd8689c946e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 08:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqMA2-0006YQ-3l
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 08:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626AbYJPGPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 02:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756624AbYJPGPY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 02:15:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbYJPGPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 02:15:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 97CC66F849;
	Thu, 16 Oct 2008 02:15:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3E0676F848; Thu, 16 Oct 2008 02:15:12 -0400 (EDT)
In-Reply-To: <4ac8254d0810152254i615bca9dye0aedd8689c946e7@mail.gmail.com>
 (Tuncer Ayaz's message of "Thu, 16 Oct 2008 07:54:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD0BBFA8-9B49-11DD-8A51-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98346>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> On Thu, Oct 16, 2008 at 2:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>
>>> On Wed, Oct 15, 2008 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>>>
> Would you prefer to leave -v out?

Not at all.

Perhaps there is a deeper misunderstanding.

It makes perfect sense _at the end user interface level_ to have -v and -q
as two separate options, perhaps with "later one wins" semantics.  Another
possible semantics is "-q and -v are mutually incompatible", but I think
"later one wins" makes it much more usable from the end user's point of view.

The only thing I was objecting to was your repeated (verbose || !quiet)
expression in the _implementation_, which would have been much easier to
read and maintain, if it were expressed as a single variable "verbosity"
that can have one of three values.

IOW,

	static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
        ...

        	if (!strcmp("--quiet", arg))
                	verbosity = QUIET;
		else if (!strcmp("--verbose", arg))
                	verbosity = VERBOSE;
		else ...

	...
                if (verbosity > QUIET)
                	print informational message;
		if (verbosity > NORMAL)
                	print verbose message;

See?
