From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 8 Apr 2014 13:35:48 +0200
Message-ID: <CAP8UFD0RftewWj-oivojUrXCDqXUq6xX7ndQdixA2i=1BzZEFg@mail.gmail.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
	<5343A589.10503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 08 13:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXUJo-00020a-W3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 13:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382AbaDHLfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 07:35:51 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:59946 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbaDHLfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 07:35:50 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so776481wes.26
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WuHsSXPwsibQGAKxgvaheO0dUvigx4PpR8zWrnrZ8s8=;
        b=HNSlHOpeJ3KV41Gcgz31hlfAqwO+Uu5HNQDnCGubb//KsRVa2gdYfgCuiMdS+rvoRe
         3+1Rw/Zr7Nr0Wc+2eLnDjdk7SkwXLbfYKR6b4e/0s/1nx0snxMn3Zmg8YpFCH7f0SHJq
         ivozRPs5UtakBqVSvE1NsnBBFaQipDw8h87/lIIX9DXYxbCoQbP73eyY6Mr72Dc5gmaE
         jZ51tOXqS6juxPsTsxVM3RRDrJRX2Dyi1ud8WV4HlRffHSADzkYkxwfZaw5BWDBv+EHv
         Ul4aQpj/rKaSoQyRHO7cbP6G5CnTdOd8YpMP2rPl8XCsolEmR1eO/PzsMMZrCah6rjdJ
         ZXVQ==
X-Received: by 10.180.205.230 with SMTP id lj6mr4046331wic.15.1396956949030;
 Tue, 08 Apr 2014 04:35:49 -0700 (PDT)
Received: by 10.216.174.68 with HTTP; Tue, 8 Apr 2014 04:35:48 -0700 (PDT)
In-Reply-To: <5343A589.10503@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245922>

On Tue, Apr 8, 2014 at 9:30 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> +This command is a filter. It reads the standard input for a commit
>> +message and applies the `token` arguments, if any, to this
>> +message. The resulting message is emited on the standard output.
>
> s/emited/emitted/

Ok.

>> +Some configuration variables control the way the `token` arguments are
>> +applied to the message and the way any existing trailer in the message
>> +is changed. They also make it possible to automatically add some
>> +trailers.
>> +
>> +By default, a 'token=value' or 'token:value' argument will be added
>> +only if no trailer with the same (token, value) pair is already in the
>> +message. The 'token' and 'value' parts will be trimmed to remove
>> +starting and trailing whitespace, and the resulting trimmed 'token'
>> +and 'value' will appear in the message like this:
>> +
>> +------------------------------------------------
>> +token: value
>> +------------------------------------------------
>> +
>> +By default, if there are already trailers with the same 'token', the
>> +new trailer will appear just after the last trailer with the same
>> +'token'. Otherwise it will appear at the end of the message.
>
> How are existing trailers recognized in the input commit message?  Do
> trailers have to be configured to be recognized?  Or are all lines
> matching a specific pattern considered trailers?  If so, it might be
> helpful to include a regexp here that describes the trailer "syntax".

The trailers are recognized in the input commit message using the
following rules:
 - only lines that contains a ':' are considered trailers,
 - the trailer lines must all be next to each other,
 - after them it's only possible to have some lines that contain only spaces,
 - before them there must be at least one line with only spaces

> What about blank lines?  I see that you try to add a blank line before
> new trailers.  But what about on input?

One line with only spaces has to be before the trailers. Some can be
after the trailers.

> Do the trailer lines have to be
> separated from the free-form comment by a blank line to be recognized?

Yes.

> What if there are blank lines between trailer lines, or after them?

After them is ok. Between is not ok (only the trailers after the blank
lines will be recognized).

> Is it allowed to have non-trailer lines between or after trailer lines?

No except lines with spaces after the trailers lines.

>> +Note that 'trailers' do not follow and are not intended to follow many
>> +rules that are in RFC 822. For example they do not follow the line
>> +breaking rules, the encoding rules and probably many other rules.
>> +
>> +OPTIONS
>> +-------
>> +--trim-empty::
>> +     If the 'value' part of any trailer contains only whitespace,
>> +     the whole trailer will be removed from the resulting message.
>
> Does this apply to existing trailers, new trailers, or both?

Both.

> If it applies to existing trailers, then it seems a bit dangerous, in the
> sense that the command might end up changing trailers that are unrelated
> to the one that the command is trying to add.

The command is not just for adding trailers.
But there could be an option to just trim trailers that are added.

>> +CONFIGURATION VARIABLES
>> +-----------------------
>> +
>> +trailer.<token>.key::
>> +     This 'key' will be used instead of 'token' in the
>> +     trailer. After some alphanumeric characters, it can contain
>
> Trailer keys can also contain '-', right?

Yes.
I should have written "after the last alphanumeric character".
I will fix that.

>> +     some non alphanumeric characters like ':', '=' or '#' that will
>> +     be used instead of ':' to separate the token from the value in
>> +     the trailer, though the default ':' is more standard.
>
> Above it looks like the default separator is not ':' but rather ': '
> (with a space).  Is the space always added regardless of the value of
> this configuration variable, or should the configuration value include
> the trailing space if it is desired?  Is there any way to get a trailer
> that doesn't include a space, like
>
>     foo=bar
>
> ?  (Changing this to "foo= bar" would look pretty ugly.)

I will have a look, but I think that:

- a space is always added after ':' or '=',
- a space is never added after '#',
- it doesn't matter if there is a space or not in the configured key.

> If a commit message containing trailer lines with separators other than
> ':' is input to the program, will it recognize them as trailer lines?

No, '=' and '#' are not supported in the input message, only in the output.

> Do such trailer lines have to have the same separator as the one listed
> in this configuration setting to be recognized?

No they need to have ':' as a separator.

The reason why only ':' is supported is because it is the cannonical
trailer separator and it could create problems with many input
messages if other separators where supported.

Maybe we could detect a special line like the following:

# TRAILERS START

in the input message and consider everyhting after that line as trailers.
In this case it would be ok to accept other separators.

> I suppose that there is some compelling reason to allow non-colon
> separators here.  If not, it seems like it adds a lot of complexity and
> should maybe be omitted, or limited to only a few specific separators.

Yeah, but in the early threads concerning this subject, someone said
that GitHub for example uses "bug #XXX".
I will have a look again.

>> +trailer.<token>.where::
>> +     This can be either `after`, which is the default, or
>> +     `before`. If it is `before`, then a trailer with the specified
>> +     token, will appear before, instead of after, other trailers
>> +     with the same token, or otherwise at the beginning, instead of
>> +     at the end, of all the trailers.
>
> Brainstorming: some other options that might make sense here someday:
>
> `end`: add new trailer after all existing trailers (even those with
> different keys).  This would allow trailers to be kept in chronological
> order.
>
> `beginning`: add new trailer before the first existing trailer (allows
> reverse chronological order).
>
> `sorted`: add new trailer among the existing trailers with the same key
> so as to keep their values in lexicographic order.

Yeah, I thought about these, but I don't think there is a need for
them right now.

>> +trailer.<token>.ifexist::
>> +     This option makes it possible to choose what action will be
>> +     performed when there is already at least one trailer with the
>> +     same token in the message.
>> ++
>> +The valid values for this option are: `addIfDifferent` (this is the
>> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
>
> Are these option values case sensitive?  If so, it might be a little bit
> confusing because the same camel-case is often used in documentation for
> configuration *keys*, which are not case sensitive [1], and users might
> have gotten used to thinking of strings that look like this to be
> non-case-sensitive.

There were some discussions a few versions of this series ago with
Peff, Junio and perhaps others about this.
I thought that being case insensitive was better and Peff kind of
agreed with that, but as Junio disagreed it is now case sensitive.

>> +With `addIfDifferent`, a new trailer will be added only if no trailer
>> +with the same (token, value) pair is already in the message.
>> ++
>> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
>> +trailer with the same (token, value) pair is above or below the line
>> +where the new trailer will be added.
>> ++
>> +With `add`, a new trailer will be added, even if some trailers with
>> +the same (token, value) pair are already in the message.
>> ++
>> +With `overwrite`, the new trailer will overwrite an existing trailer
>> +with the same token.
>
> What if there are multiple existing trailers with the same token?  Are
> they all overwritten?

No, if where == after, only the last one is overwritten, and if where
== before, only the first one is overwritten.

I could add an "overwriteAll" option. It could be interesting to use
when a command using "$ARG" is configured, as this way the command
would apply to all the trailers with the given token instead of just
the last or first one.

>> +With `doNothing`, nothing will be done, that is no new trailer will be
>> +added if there is already one with the same token in the message.
>> +
>> +trailer.<token>.ifmissing::
>> +     This option makes it possible to choose what action will be
>> +     performed when there is not yet any trailer with the same
>> +     token in the message.
>> ++
>> +The valid values for this option are: `add` (this is the default) and
>> +`doNothing`.
>> ++
>> +With `add`, a new trailer will be added.
>> ++
>> +With `doNothing`, nothing will be done.
>> +
>> +trailer.<token>.command::
>> +     This option can be used to specify a shell command that will
>> +     be used to automatically add or modify a trailer with the
>> +     specified 'token'.
>> ++
>> +When this option is specified, it is like if a special 'token=value'
>> +argument is added at the end of the command line, where 'value' will
>> +be given by the standard output of the specified command.
>
> Maybe reword to
>
>     When this option is specified, the behavior is as if a special
>     'token=value' argument were added at the end of the command line,
>     where 'value' is taken to be the standard output of the specified
>     command.
>
> And if it is the case, maybe add "with leading and trailing whitespace
> trimmed off" at the end of the sentence.

Ok.

>> +If the command contains the `$ARG` string, this string will be
>> +replaced with the 'value' part of an existing trailer with the same
>> +token, if any, before the command is launched.
>
> What if the key appears multiple times in existing trailers?

It will be done only once for the last or first trailer with the key
depending on "where".

>> +
>> +SEE ALSO
>> +--------
>> +linkgit:git-commit[1]
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>>
>
> Doesn't this command have to be added to command-list.txt?

Maybe, I will have a look.

Thanks,
Christian.
