From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 6/6] send-email: add option --cite to quote the message
 body
Date: Wed, 15 Jun 2016 00:53:36 +0200
Message-ID: <e339c77f-ecb8-b7aa-1c8f-38a1f9eca93e@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130833.32274-1-samuel.groot@grenoble-inp.org>
 <vpqvb1ir38m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 15 00:53:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCxDQ-0003GM-08
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 00:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbcFNWxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 18:53:42 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:53426 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbcFNWxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 18:53:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9068020B2;
	Wed, 15 Jun 2016 00:53:37 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UL8UBu-OSR1Q; Wed, 15 Jun 2016 00:53:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6E2F120AF;
	Wed, 15 Jun 2016 00:53:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5D1B82066;
	Wed, 15 Jun 2016 00:53:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgtYaW0bOPSB; Wed, 15 Jun 2016 00:53:37 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id EDFC02064;
	Wed, 15 Jun 2016 00:53:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqvb1ir38m.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297346>

On 06/09/2016 01:49 PM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> If used with `in-reply-to=<email_file>`, cite the message body of the given
>> email file. Otherwise, do nothing.
>
> It should at least warn when --in-reply-to=<email_file> is not given
> (either no --in-reply-to or --in-reply-to=<id>). I don't see any
> use-case where a user would want --cite on the command-line and not want
> --in-reply-to=<email_file>. OTOH, it seems a plausible user-error, and
> the user would appreciate a message saying what's going on.

We weren't sure how to warn the user.

If --in-reply-to is not an mail file, should we check it with a regex to 
make sure it's a message-id?

>> @@ -56,6 +57,8 @@ git send-email --dump-aliases
>>      --subject               <str>  * Email "Subject:"
>>      --in-reply-to           <str>  * Email "In-Reply-To:"
>>      --in-reply-to          <file>  * Populate header fields appropriately.
>> +    --cite                         * Quote the message body in the cover if
>> +                                     --compose is set, else in the first patch.
>>      --[no-]xmailer                 * Add "X-Mailer:" header (default).
>>      --[no-]annotate                * Review each patch that will be sent in an editor.
>>      --compose                      * Open an editor for introduction.
>
> Just wondering: would it make sense to activate --cite by default when
> --in-reply-to=file is used, and to allow --no-cite to disable this?
>
> This is something we can easily do now without breaking backward
> compatibility (--in-reply-to=file doesn't exist yet), but would be more
> painful to do later.

It's an interesting question.

IMHO we should have `--cite` by default and allow `--no-cite` to disable 
quoting the message body, because it's easier to remove extra unwanted 
lines than copying lines from another file and adding "> " before each line.

>> @@ -640,6 +644,7 @@ if (@files) {
>>  	usage();
>>  }
>>
>> +my $message_cited;
>
> Nit: I read "$message_cited" as "Boolean saying whether the message was
> cited". $cited_message would be clearer to me (but this is to be taken
> with a grain of salt as I'm not a native speaker), since the variable
> holds the content of the cited message.
>
>> +sub do_insert_cited_message {
>> +	my $tmp_file = shift;
>> +	my $original_file = shift;
>> +
>> +	open my $c, "<", $original_file
>> +	or die "Failed to open $original_file: " . $!;
>> +
>> +	open my $c2, ">", $tmp_file
>> +		or die "Failed to open $tmp_file: " . $!;
>> +
>> +	# Insertion after the triple-dash
>> +	while (<$c>) {
>> +		print $c2 $_;
>> +		last if (/^---$/);
>> +	}
>> +	print $c2 $message_cited;
>
> I would add a newline here to get a blank line between the message cited
> and the diffstat.

A newline here makes it easier to distinguish the different sections in 
the email file indeed.

> I think non-ascii characters would deserve particular attention here
> too. For example, if the patch contain only ascii and the cited part
> contains UTF-8, does the generated patch have a proper Content-type:
> header?

Non-ascii characters are still an issue, I'll work on that next week.

> I can imagine worse, like a patch containing latin1 character and a
> cited message with another 8-bit encoding.
>
>> +test_expect_success $PREREQ 'correct cited message with --in-reply-to and --compose' '
>> +	grep "> On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt3 &&
>
> I would prefer to have the full address including the real name here (A
> <author@example.com>) in this example. Actually, after a quick look at
> the code, I don't understand where the name has gone (what's shown here
> is extracted from the From: header).

Yep, after a quick look at the code involved, I don't understand either, 
I will investigate this week.
