From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 22:35:01 +0100
Organization: OPDS
Message-ID: <996C8C8A69844E44890D09811C57DAC8@PhilipOakley>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org><1437416790-5792-5-git-send-email-philipoakley@iee.org> <xmqqoaj6y50b.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHIhl-0003cL-8U
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 23:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbbGTVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 17:34:29 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:39751 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877AbbGTVe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2015 17:34:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AGCQCcaK1VPHMBFlxcgxNUaYc9ti+FdwQEAoExTQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBCogLDAm5WY97BItMhCMRAVGDHoEUBYw4OIdiAYEKg2RmiA+HKow5g2GBCYMaPTGBDYE+AQEB
X-IPAS-Result: A2AGCQCcaK1VPHMBFlxcgxNUaYc9ti+FdwQEAoExTQEBAQEBAQcBAQEBQAEkG4QeBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBCogLDAm5WY97BItMhCMRAVGDHoEUBYw4OIdiAYEKg2RmiA+HKow5g2GBCYMaPTGBDYE+AQEB
X-IronPort-AV: E=Sophos;i="5.15,510,1432594800"; 
   d="scan'208";a="164332631"
Received: from host-92-22-1-115.as13285.net (HELO PhilipOakley) ([92.22.1.115])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 20 Jul 2015 22:34:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274355>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> +git-send-email invokes the cc-cmd like this:
>> +
>> + $cc-cmd $patchfilename
>> +
>> +Thus the patch itself can be processed to locate appropriate email 
>> address
>> +information if required.
>
> That's not even a valid command line (cc-cmd cannot be a shell
> variable name), so why bother writing it that way?  Rather

We seem to be going round in circles.

Currently the --cc-cmd isn't well documented.

I was trying to use, essentially, 'cat list.txt' as the command, which 
should work according to the current doc, which says nothing about 
how/if the patch file is to be passed to the command.

Eric was able to make clear (*) that the code 
https://github.com/git/git/blob/master/git-send-email.perl#L1602 does 
essentially execute  '$cc-cmd $patchfilename' where $cc-cmd is the value 
of the --cc-cmd option.

This meant that my plain vanilla 'cat list.txt' command errored out.

The question are:
What should the "command" look like. (can it be a command, or does it 
have to be a script??)
How should the patch/patchfile be passed - what should the documentation 
guarantee?

At the moment it's the perl code that defines execution of the rather 
flexible '$cc-cmd $patchfilename' command. (i.e. anything could be in 
the $cc-cmd string)

>
>    The program that is specified by `cc-cmd` is invoked by `git
>    send-email` with the name of the patch file as an argument;
>    the program can read from it and customize its output based on
>    what the patch file contains.
>
> or something like that, perhaps.
>
>> +
>> +A simple solution for a basic address list is to create a 'cc-cmd' 
>> file
>> +(executable) which provides a list of addressees:
>
> There is no "problem" stated here that requires your "solution".  In
> fact, what problem are you solving?

As noted above, it's so that I can state a direct command as 
the --cc-cmd, so that a plain text file listing cc addresses is offered 
to send-email, without needing to create a script.

>
>> + #!/bin/sh
>> + echo <<\EOF
>> + person1@example.com
>> + person2@example.com
>> + EOF
>
> That is one simple and denegerate use case; if the program does not
> need any information from the patch file, it surely has an option
> not to look at it.  But it is not an interesting usage.
>
> If you want to add a single example to illustrate how cc-cmd (or
> to-cmd, or anything that goes thru recipients_cmd()), you should
> have an example that reads the input and then adds a few hardcoded
> one.
>
> #!/bin/sh
> # always send it to the logger service
>        echo "patchlog@example.com"
> # tell the bug tracker as necessary
> if fixes=$(sed -ne 's/^Fixes bug#\([0-9]*\)/\1/p' "$1")
>        then
> echo "bugs+$fixes@example.com"
> fi
>
> or something silly like that.
>
> And this ...
>
>> +Simply, using `cat cc-cmd` as the --cc-cmd (with cc-cmd as the text 
>> file
>> +of email addresses), does not work as expected as the invocation 
>> becomes:
>> +
>> + $cat cc-cmd $patchfilename
>> +
>
> ... and the rest of the patch is unnecessary noise to a reader who
> read that the single argument to the program is the name of the
> patchfile, I think.  You were trying to avoid the same confusion
> caused by the sketchy documentaiton, and you already "solved" that

I'm not so sure that all other readers would 'know' what went wrong if 
they tried the same as I, without going through the same Q&A, hence the 
desire to inform.

> problem by telling the reader what the command takes as its input.
>
>> +    --cc-cmd='cat cc-cmd #'
>
> This heavily depends on the current implementation that happens to
> pass the command line string to a shell.

Not sure what effective alternative is being suggested - if its a shell 
script, it'll still hit the shell.

>
--
Philip 
