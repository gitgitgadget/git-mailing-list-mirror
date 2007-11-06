From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 05 Nov 2007 21:30:52 -0800
Message-ID: <7vbqa8j5yr.fsf@gitster.siamese.dyndns.org>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	<11942029442710-git-send-email-shawn.bohrer@gmail.com>
	<11942029474058-git-send-email-shawn.bohrer@gmail.com>
	<7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
	<20071106050512.GA6768@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 06:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpH20-0004Pn-JC
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 06:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbXKFFbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 00:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbXKFFbE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 00:31:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48693 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXKFFbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 00:31:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 679E62EF;
	Tue,  6 Nov 2007 00:31:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B20148FCDF;
	Tue,  6 Nov 2007 00:31:16 -0500 (EST)
In-Reply-To: <20071106050512.GA6768@mediacenter.austin.rr.com> (Shawn Bohrer's
	message of "Mon, 5 Nov 2007 23:05:12 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63628>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> On Mon, Nov 05, 2007 at 01:14:32PM -0800, Junio C Hamano wrote:
>> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>> [...]
>> > +static int disabled = 1;
>> 
>> This means we are committed to make clean.requireForce default
>> to true, which is fine by me.  I need to warn the users about
>> this early.
>
> Actually I don't care either way, but in my last rebase on next this
> change was already made to git-clean.sh so I adjusted accordingly.

Oh, that was not a question to you, but a note to me.

>> > +static int show_only = 0;
>> > +static int remove_directories = 0;
>> > +static int quiet = 0;
>> > +static int ignored = 0;
>> > +static int ignored_only = 0;
>> 
>> Please do not explicitly initialize static variables to zero.
>
> I realize that static variables will be automatically initialized to
> zero so this is unnecessary, but is there some technical reason not to
> initialize explicitly?  If the answer is simply a style preference that
> is fine, I'm just here to learn.

Both readability and style have to do much with this.

The style has a historical background which is a slight
technical merit.  It results in a smaller executable file, as C
compilers traditionally placed file-scope static variables that
are not explicitly initialized in the BSS section, instead of
explicitly storing N-bytes of zero as the the initial data in it
(although I do not see a reason for compilers not to do the same
for variables explicitly initialized to zero.  In fact, I think
modern gcc produces the same allocation with or without "= 0"
initialization).

> Of course as already pointed out these don't actually need to be static
> in the first place so I'll simply move them into cmd_clean().  This does
> lead me to another question though.  Now that Dscho has converted my
> patch to use parse-options, what is the best way to update my patch
> while still giving credit to Dscho?

Please send a rewritten replacement version as a single patch
that is cleanly applicable to 'next', and mention people whose
input helped you in polishing the patch in the proposed commit
log message.
