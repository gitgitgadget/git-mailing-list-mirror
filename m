From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Wed, 25 May 2016 01:31:28 +0200
Message-ID: <b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <vpq60u4bl4e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed May 25 01:31:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5LnW-0007d5-QO
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 01:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbcEXXbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 19:31:34 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:49659 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbcEXXbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 19:31:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4110E2506;
	Wed, 25 May 2016 01:31:29 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kyX6jb4OFSlI; Wed, 25 May 2016 01:31:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E807924DE;
	Wed, 25 May 2016 01:31:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id DE3BF2077;
	Wed, 25 May 2016 01:31:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWCn7KP3NJcj; Wed, 25 May 2016 01:31:28 +0200 (CEST)
Received: from localhost.localdomain (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 851992066;
	Wed, 25 May 2016 01:31:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpq60u4bl4e.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295545>

On 05/23/2016 10:00 PM, Matthieu Moy wrote:
> I don't think this is right: I often reply to an email with a single
> patch, for which it would clearly be overkill to have a cover-letter.

Yes indeed, we are working on inserting the quoted message body in the 
patch's "below-triple-dash" section.

> Your --quote-mail does two things:
>
> 1) Populate the To and Cc field
>
> 2) Include the original message body with quotation prefix.
>
> When not using --compose, 1) clearly makes sense already, and there's no
> reason to prevent this use-case. When sending a single patch, 2) also
> makes sense as "below-tripple-dash comment", like
>
>   This is the commit message for feature A.
>   ---
>   John Smith wrote:
>   > You should implement feature A.
>
>   Indeed, here's a patch.
>
>   modified-file.c   | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>
> When sending multiple patches without --compose, 2) may not make sense,
> but I think a sane behavior would be:
>
> * If --compose is given, cite the message there.
>
> * If --compose is not given, don't send a cover-letter but cite the body
>   as comment in the first patch.
>
> As a first step, the second point can be changed to "if --compose is not
> given, don't cite the message, just populate the To: and Cc: fields".

It seems a good behavior to me too.

> * If --compose is not given, don't send a cover-letter but cite the body
>   as comment in the first patch.

Then should the option imply `--annotate`, to let the user edit the 
patch containing the quoted email?

>> +			push(@header, $_);
>
> I think the code would be clearer if @header was a list of pairs
> (header-name, header-content). Then you'd need much less regex magic
> when going through it.

The next series of patches may include (if the code is clean enough by 
then) a cleaner subroutine to parse the email, probably returning 
something like:

   return (
     "from" => $from,
     "subject" => $subject,
     "date" => $date,
     "message_id" => $message_id,
     "to" => [@to],
     "cc" => [@cc],
     "xh" => [@xh],
     "config" => {%config}
   );

>> +			elsif (/^From:\s+(.*)$/i) {
>> +				push @initial_to, $1;
>> +			}
>> +			elsif (/^To:\s+(.*)$/i) {
>> +				foreach my $addr (parse_address_line($1)) {
>> +					if (!($addr eq $initial_sender)) {
>> +						push @initial_to, $addr;
>> +					}
>> +				}
>
> This adds the content of the To: field in the original email to the Cc:
> field in the new message, right? If so, this is a weird behavior: when
> following up to an email, one usually addresses to the person s/he's
> replying, keeping the others Cc-ed, hence the original From: becomes the
> To header, and the original To: and Cc: become Cc:.

We made the option behave like Thunderbird does, but indeed RFC 2822 [1] 
sees it the same you do, it will be fixed in next iteration.

>> @@ -676,6 +771,8 @@ From: $tpl_sender
>>  Subject: $tpl_subject
>>  In-Reply-To: $tpl_reply_to
>>
>> +$tpl_quote
>> +
>>  EOT
>
> Doesn't this add two extra useless blank lines if $tpl_quote is empty?

Yes it does, it will be fixed in the next series of patches.

Thank you for your time!


[1] https://www.ietf.org/rfc/rfc2822.txt
