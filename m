From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git
 interpret-trailers'
Date: Mon, 27 Jan 2014 21:33:44 +0100 (CET)
Message-ID: <20140127.213344.212708599170084659.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
	<20140126170011.24291.26146.chriscool@tuxfamily.org>
	<CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Jan 27 21:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7sso-0008Ik-O4
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 21:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbaA0UeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 15:34:09 -0500
Received: from [194.158.98.45] ([194.158.98.45]:43961 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753860AbaA0UeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 15:34:07 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id D8EA85A;
	Mon, 27 Jan 2014 21:33:44 +0100 (CET)
In-Reply-To: <CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241155>

From: Eric Sunshine <sunshine@sunshineco.com>
>
> On Sun, Jan 26, 2014 at 12:00 PM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
>> new file mode 100644
>> index 0000000..f74843e
>> --- /dev/null
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -0,0 +1,137 @@
>> +git-interpret-trailers(1)
>> +=========================
>> +
>> +NAME
>> +----
>> +git-interpret-trailers - help add stuctured information into commit messages
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git interpret-trailers' [--trim-empty] [--infile=file] [<token[=value]>...]
> 
> Would it be more consistent with existing documentation to format this as so?
> 
>   [--infile=<file>] [<token>[=<value>]]...

No, it would be very inconsistent:

$ grep '\.\.\.\]' *.txt | wc -l
103
$ grep '\]\.\.\.' *.txt | wc -l
0

>> +DESCRIPTION
>> +-----------
>> +Help add RFC 822 like headers, called 'trailers', at the end of the
> 
> s/822 like/822-like/

Ok.

> Was the suggestion, early in the discussion, to use "footer" rather
> than "trailer" dismissed?

During the early discussions people initially talked about "footer"
while Junio and others talked about "trailer".

See:

http://thread.gmane.org/gmane.comp.version-control.git/236429/
http://thread.gmane.org/gmane.comp.version-control.git/236770/

I have no preference for one or the other, but by default I use what
Junio uses.

>> +otherwise free-form part of a commit message.
>> +
>> +Unless `--infile=file` is used, this command is a filter. It reads the
>> +standard input for a commit message and apply the `token` arguments,
> 
> s/apply/applies/

Ok.

>> +if any, to this message. The resulting message is emited on the
>> +standard output.
>> +
>> +Some configuration variables control the way the `token` arguments are
>> +applied to the message and the way any existing trailer in the message
>> +is changed. They also make it possible to automatically add some
>> +trailers.
>> +
>> +By default, a 'token=value' or 'token:value' argument will be added
>> +only if no trailer with the same (token, value) pair is already in the
>> +message. The 'token' and 'value' parts will be trimmed to remove
>> +starting and trailing white spaces, and the resulting trimmed 'token'
> 
> Other git documentation uniformly spells it as "whitespace" rather
> than "white spaces".

You are right I will change that.

>> +and 'value' will appear in the message like this:
>> +
>> +------------------------------------------------
>> +token: value
>> +------------------------------------------------
>> +
>> +By default, if there are already trailers with the same 'token' the
>> +trailer will appear just after the last trailer with the same
> 
> It might be a bit clearer to say "the _new_ trailer will appear...".

Ok.

>> +'token'. Otherwise it will appear at the end of the message.
>> +
>> +Note that 'trailers' do not follow and are not intended to follow many
>> +rules that are in RFC 822. For example they do not follow the line
>> +breaking rules, the encoding rules and probably many other rules.
>> +
>> +Trailers have become a de facto standard way to add helpful structured
>> +information into commit messages. For example the well known
>> +"Signed-off-by: " trailer is used by many projects like the Linux
>> +kernel and Git.
> 
> This "justification" paragraph might make more sense near or at the
> very the top of the Description section.

Yeah, or maybe I can remove it entirely.

>> +OPTIONS
>> +-------
>> +--trim-empty::
>> +       If the 'value' part of any trailer contains onlywhite spaces,
> 
> s/onlywhite spaces/only whitespace/

Ok.

>> +       the whole trailer will be removed from the resulting message.
>> +
>> +----infile=file::
>> +       Read the commit message from `file` instead of the standard
>> +       input.
>> +
>> +CONFIGURATION VARIABLES
>> +-----------------------
>> +
>> +trailer.<token>.key::
>> +       This 'key' will be used instead of 'token' in the
>> +       trailer. After some alphanumeric characters, it can contain
>> +       some non alphanumeric characters like ':', '=' or '#' that will
>> +       be used instead of ':' to separate the token from the value in
>> +       the trailer, though the default ':' is more standard.
>> +
>> +trailer.<token>.where::
>> +       This can be either `after`, which is the default, or
>> +       `before`. If it is `before`, then a trailer with the specified
>> +       token, will appear before, instead of after, other trailers
>> +       with the same token, or otherwise at the beginning, instead of
>> +       at the end, of all the trailers.
>> +
>> +trailer.<token>.ifexist::
>> +       This option makes it possible to chose what action will be
> 
> s/chose/choose/

Ok.

>> +       performed when there is already at least one trailer with the
>> +       same token in the message.
>> ++
>> +The valid values for this option are: `addIfDifferent` (this is the
>> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
>> ++
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
>> ++
>> +With `doNothing`, nothing will be done, that is no new trailer will be
>> +added if there is already one with the same token in the message.
>> +
>> +trailer.<token>.ifmissing::
>> +       This option makes it possible to chose what action will be
> 
> s/chose/choose/

Ok.

>> +       performed when there is not yet any trailer with the same
>> +       token in the message.
>> ++
>> +The valid values for this option are: `add` (this is the default) and
>> +`doNothing`.
>> ++
>> +With `add`, a new trailer will be added.
>> ++
>> +With `doNothing`, nothing will be done.
>> +
>> +trailer.<token>.command::
>> +       This option can be used to specify a shell command that will
>> +       be used to automatically add or modify a trailer with the
>> +       specified 'token'.
>> ++
>> +When this option is specified, it is like if a special 'token=value'
>> +argument is added at the end of the command line, where 'value' will
>> +be given by the standard output of the specified command.
> 
> What happens if the text returned by the command has multiple lines?

The 'value' part of trailer will be on multiple lines.

> Should the documentation say something about this?

I think it is better left as unspecified because we might want to
print a warning, or perhaps error out in this case.

Thanks,
Christian.
