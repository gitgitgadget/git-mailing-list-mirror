From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [RFC-PATCH v2 1/2] send-email: quote-email populates the fields
Date: Mon, 30 May 2016 01:38:02 +0200
Message-ID: <16f3b6f8-0a4c-3102-8723-e4dfacc51906@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-2-git-send-email-tom.russello@grenoble-inp.org>
 <vpqk2iel081.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 01:38:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7AHd-0007sY-C5
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 01:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbcE2XiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 19:38:09 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:45346 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcE2XiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 19:38:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C39C520A5;
	Mon, 30 May 2016 01:38:03 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uiu4SOUlqs_a; Mon, 30 May 2016 01:38:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id AF78B20A4;
	Mon, 30 May 2016 01:38:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A3D992077;
	Mon, 30 May 2016 01:38:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipZdTC5i3LLh; Mon, 30 May 2016 01:38:03 +0200 (CEST)
Received: from [192.168.0.19] (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 5C31E2064;
	Mon, 30 May 2016 01:38:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqk2iel081.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295845>

On 05/28/16 16:35, Matthieu Moy wrote:
>> +--quote-email=<email_file>::
>> +	Reply to the given email and automatically populate the "To:",
"Cc:" and
>> +	"In-Reply-To:" fields.
>
> I think this is a bit too technical for a user documentation. To: and
> Cc: is OK, but people need not know about "In-Reply-To:" to understand
> this. See what the doc of --in-reply-to says. If you want to be
> technical, you'd need to mention the References: field too.

You have a point here. Maybe, we can explain that the `--quote-email`
option behaves like a mailer when replying to someone without getting
into details.

> Talking about Reference: field, something your patch could do is to add
> all references in <email_file> to the references of the new email (see
> what a mailer is doing when replying). This way, the recipient can still
> get threading if the last message being replied-to is missing.

I didn't know about this field, it looks like it appends all the
parent message ID's.

>> +"Re: [<email_file>'s subject]".
>
> Perhaps `Re: ...` instead of double-quotes.

Agreed.

>> +if ($quote_email) {
>> +	my $error = validate_patch($quote_email);
>> +	$error and die "fatal: $quote_email: $error\nwarning: no patches
were sent\n";
>
> I know it's done this way elsewhere, but I don't like this "$error and
> die", I'd rather see a proper if here.

You're right, I'll change that in the next version.

>> +		if (defined $input_format && $input_format eq 'mbox') {
>
> To me, the input format refers to patch files, not the <email_file>.
>
> I'm not sure anyone still use the "lots of email" format, and you are
> not testing it. So, this is claiming that we have a feature without
> being sure we have it nor that anyone's ever going to use it.

You summed up the situation well.

> I'd just drop this "if" and the "else" branch, and just assume the email
> file is a normal email file.

I'll do that.


Thank you for the review.
