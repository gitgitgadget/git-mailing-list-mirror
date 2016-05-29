From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [RFC-PATCH v2 2/2] send-email: quote-email quotes the message
 body
Date: Sun, 29 May 2016 13:41:14 +0200
Message-ID: <6f76c691-c822-a9bc-4568-819e4ff31491@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464369102-7551-3-git-send-email-tom.russello@grenoble-inp.org>
 <vpqlh2ujkg8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 29 13:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6z60-0004PW-94
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 13:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbcE2LlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 07:41:19 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:36966 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134AbcE2LlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 07:41:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 210B320A4;
	Sun, 29 May 2016 13:41:15 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nf2Q8jAKaNhS; Sun, 29 May 2016 13:41:15 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0B7762098;
	Sun, 29 May 2016 13:41:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F409B2077;
	Sun, 29 May 2016 13:41:14 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fiUbiEdsIH-o; Sun, 29 May 2016 13:41:14 +0200 (CEST)
Received: from [192.168.0.19] (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id AD5EF2064;
	Sun, 29 May 2016 13:41:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqlh2ujkg8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295832>

On 05/28/16 17:01, Matthieu Moy wrote:
>> Currently, `send-email` without `--compose` implies `--annotate`.
>
> I don't get it. Did you mean s/without/with/? Even if so, this is not
> exactly true: "git send-email --compose -1" will open the editor only
> for the cover-letter, while adding --annotate will also open it for the
> patch.

We meant that the default behavior of `--quote-email` (i.e. without
--compose enabled) will open the editor with the given patches in
argument and will quote the message body in the first one.

> (Note: we discussed this off-list already, but I'll try to summarize my
> thoughts here)
>
> I don't have strong opinion on this, but I think there's a difference
> between launching the editor directly on the input patch files
> (resulting in _user_'s edit being done directly on them) and having the
> script modify it in-place (resulting in automatic changes done directly
> on the user's files).
>
> I usually use "git send-email" directly without using "git
> format-patch", so I'm not the best juge. But I can imagine a flow like
>
> 1) run "git send-email *.patch"
>
> 2) start editting
>
> 3) notice there's something wrong, give up for now (answer 'q' when git
>    send-email prompts for confirmation, or kill it via Control-C in a
>    terminal)
>
> 4) run "git send-email *.patch" again
>
> 5) be happy that changes done at 2) are still there.
>
> With --quote-email, it's different. The scenario above would result in
>
> 5') WTF, why is the email quoted twice?

Actually the Control-C during the edition will cancel all the
annotations written (including the cited email).

> Unfortunately, I don't really have a solution for this. My first thought
> was that we should copy the files to a temporary location before
> starting the editor (that what I'm used to when using "git send-email"
> without "git format-patch"), but that would prevent 5) above.

It's already what we did: the first original patch is copied in a
temporary file. However, if the edition went well (i.e. the editor
closed by the user), the temporary file will erase the original one.

>> @@ -109,7 +109,10 @@ is not set, this will be prompted for.
>>  --quote-email=<email_file>::
>>  	Reply to the given email and automatically populate the "To:",
"Cc:" and
>>  	"In-Reply-To:" fields. If `--compose` is set, this will also fill the
>> -	subject field with "Re: [<email_file>'s subject]".
>> +	subject field with "Re: [<email_file>'s subject]" and quote the
message body
>> +	of <email_file>.
>
> I'd add "in the introductory message".

Agreed.

>> +	while (<$fh>) {
>> +		# Only for files containing crlf line endings
>> +		s/\r//g;
>
> The comment doesn't really say what it does.
>
> What about "turn crlf line endings into lf-only"?

Yes, I completely agree this suggestion.

> When writing comment, always try to ask the question "why?" more than
> "what?". This part is possibly controversial, think about a contributor
> finding this piece of code later without having followed the current
> conversation. He'd probably expect an explanation about why you need a
> temp file here and not elsewhere.

Thank you for the advice, I'll keep it in mind.

>> +	open my $c, "<", $original_file
>> +	or die "Failed to open $original_file : " . $!;
>> +
>> +	open my $c2, ">", $tmp_file
>> +		or die "Failed to open $tmp_file : " . $!;
>
> No space before :.

Sorry, I copied the previous error messages.

> When the spec says "if --compose ... then ...", "after the triple-dash",
> and "in the first patch", one would expect at least one test with
> --compose and one without, something to check that the insertion was
> done below the triple-dash, and one test with two patches, checking that
> the second patch is not altered by --quote-email.

Yes, indeed. I'll add these tests in the next version.

Thank you for the review.
