From: Christian Couder <christian.couder@gmail.com>
Subject: Re: On "interpret-trailers" standalone tool
Date: Wed, 16 Apr 2014 14:27:03 +0200
Message-ID: <CAP8UFD0w9xUwuk9UZ_mu=qvjtYN1r5skidweruM8t1KbfQpQyA@mail.gmail.com>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
	<20140412.213003.73509455950485398.chriscool@tuxfamily.org>
	<xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 14:27:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaOwA-0006yN-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 14:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbaDPM1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 08:27:24 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:38208 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbaDPM1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 08:27:04 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so10453011vcb.39
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8fon8mS3axoirjhbdEml90cdGAGgFMK7KVE5KGZ2Tug=;
        b=zN3ifjrHI6RfkGvICas2OS/oRIsAnqM19nlsdWGrn5qf9bUtDfzQOoI90i1ODu4tBR
         3Cg3INL6olE5/KVLZwKao6oxDLExBRO5Vn5nI0AjlQWmjlpZ1ZYjwOzcUqencpjb+QNN
         4mcCIrjiZoXiVw32qfX9RvBukOFdXt/4HMoTeG4hFXN1YnES9bCs1k5xWKFQqdEzeVVQ
         UNUe+lhGLKKCj+ZULB44YM9iBmyNSDe5aC5WzpFXG3BmqoFMmbOqC8/InTrAb+QICOdh
         Yq1guCdCJutYJf9hThKxrqtP+ta9w11CjfCcfBO6ttWMvFq0SjWrOOjQB3Xv+SKbb34W
         GHhw==
X-Received: by 10.220.92.135 with SMTP id r7mr2814051vcm.11.1397651223130;
 Wed, 16 Apr 2014 05:27:03 -0700 (PDT)
Received: by 10.58.137.166 with HTTP; Wed, 16 Apr 2014 05:27:03 -0700 (PDT)
In-Reply-To: <xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246332>

On Mon, Apr 14, 2014 at 11:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Yeah, except that we could add for example a '-o' option that would
>> take a directory as argument and that would mean that the command
>> should operate on all the files in this directory. It would be like
>> the -o option of the format-patch command.
>
> For output for which users do not know offhand what files are to be
> produced, giving a single directory with -o makes tons of sense, but
> for input, naming each individual file (and with help with shell
> globs *) is a lot more natural UNIX tool way, I would think.

Yeah, but the "git interpret-trailers" command is a special, because,
if it takes files as arguments, then it is logical that its output
would be also files and not stdout. (See also at the end of this
message.)

> "Take
> everything from this directory" cannot be substitute for that, even
> though the reverse (i.e. by naming the input files with "dir/*") is
> true.  It is not a viable replacement.
>
>> First, if you think that the command might often be used along with
>> format-patch,
>
> ... I am not singling out format-patch output.  Any text file/stream
> that has the commit log message may benefit from the "trailers" filter,
> and format-patch output is merely one very obvious example.  As to
> the detection of the end of commit log message, the current "EOF is
> where the log message ends (but we would remote trailing blank line)"
> can easily be updated to "EOF or the first three-dash line".

Ok, I think that it's an interesting feature anyway, so I can add it
now instead of later.

>> Third, if trailers arguments are passed to the command using an
>> option like "-z token=value" or "-z token:value", it would be nice
>> to the user for consistency if the same option could be used when
>> passing the same arguments to "git commit" and perhaps other
>> commands like "git rebase", "git cherry-pick" and so on. This
>> means that we now have to choose carefully the name of this
>> option. Perhaps we can just give it a long name now like --trailer
>> and care later about a short name,...
>
> Absolutely.  That is a very sensible way to go.

Ok, I will use "--trailer" then. As I said in my previous message,
this unfortunately means that the command will not be very user
friendly until we integrate it with other commands like "git commit"
and find a short option name that hopefully work for all the commands.

>> Fourth, some users might want the command to be passed some files as
>> input, but they might not want the command to modify these input
>> files. They might prefer the command to write its ouput into another
>> set of output files. Maybe a syntax like cat or sed is not very well
>> suited for this kind of use, while having a -o option for the output
>> directory and a -i option for the input directory (if different from
>> the output dir) would be nicer.
>
> Sure.  I would expect we would require something like Perl's '-i'
> (in-place rewrite) option for this sequence to really work:
>
>         git format-patch -o there -5
>         git that-command --options -i there/*
>
> and without, I would expect the output to come to its standard
> output.

If the input comes from stdin, then I agree that the command should be
a filter, so its output should be on stdout. But if the input comes
from files given as arguments, then I would say that the command
should behave as an editor and by default it should edit its input
file inplace. Its input and output files should be different only if
it is given one or more special option,

Otherwise the example you gave:

    $ git format-patch -5 --cover-letter -o +my-series/ my-topic
    $ git interpret-trailers "some args" ./+my-series/0*.patch

would result in having on stdout all the patches edited by "git
interpret-trailers".
How would people could then easily send these edited patches?

Thanks,
Christian.
