From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 27 May 2013 09:14:15 +0200
Message-ID: <CALWbr2xzSC8ZGggCUYbS7ZWEOHnZnxFJWOfHCOBkVZFQS9KcEw@mail.gmail.com>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
	<51A2722A.8040200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 27 09:14:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgrdM-0007FV-6P
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 09:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3E0HOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 03:14:16 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:49147 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3E0HOP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 03:14:15 -0400
Received: by mail-qa0-f42.google.com with SMTP id bs12so836208qab.8
        for <git@vger.kernel.org>; Mon, 27 May 2013 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cYVF0fAJgZO1FVbLxHY5H/VBZ6jF1Wy5nDsOmrjWnB4=;
        b=cbisbFFBNICMeYLkPYVNYaIGS0GHVAOnTVpLyTTgPv+4v1axJgYPzTnpCuktgIRGtn
         y/RHotDwuK0dMNXJv0uZ2JdZ84UQGjIReDK5sJ3r08w2x6dcI556Z2u/TYGsma9Xo/8y
         FoAp5VWHC6Jw0AGdnWb0jkH7yS50r9plbdEVGjfM9RGgjYFmjZ+YTC82is3Oo3mQEleo
         myDu4YNvXka4dIbY62OPgLLwAhfmx4pJ1ZLNtx7CjDpudFGIrvZhztXDWf2rqhEK2tdv
         dNbS2mnMtMulzHCCZdSICcqnBpR9n0hQNQ6JV695C5ol/Ck6bbdnACQGOhOMwhMPHQzz
         4mCQ==
X-Received: by 10.49.96.104 with SMTP id dr8mr23178218qeb.43.1369638855213;
 Mon, 27 May 2013 00:14:15 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Mon, 27 May 2013 00:14:15 -0700 (PDT)
In-Reply-To: <51A2722A.8040200@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225578>

On Sun, May 26, 2013 at 10:35 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.05.2013 19:58, schrieb Antoine Pelisse:
>> The goal of the patch is to introduce the GNU diff
>> -B/--ignore-blank-lines as closely as possible. The short option is not
>> available because it's already used for "break-rewrites".
>>
>> When this option is used, git-diff will not create hunks that simply
>> adds or removes empty lines, but will still show empty lines
>> addition/suppression if they are close enough to "valuable" changes.
>
> So when an addition or removal of a blank line appears in a hunk that
> also has non-blank-line changes, the addition or removal is not treated
> specially?

Exactly.

> How is a blank line defined? What happens if a line that has only
> whitespace is added or removed?

xdl_blankline() is the best description of what I considered a blank line.
If no --ignore-space-* option is given, it's a line that starts and
ends with '\n'.
If any --ignore-space-* option is given, it's a line that has any
number of isspace(3)-defined characters, followed by '\n'.

> I'm thinking of diffs of files with CRLF

Good you did, because I didn't ;-)

> line breaks, where the CR would count as whitespace in the line, I think.

With the current implementation, an empty line with CRLF will not show
as a blank line if no space option is given. As CR is a space
according to isspace(3), the line will be removed with any space
option.

>> +--ignore-blank-lines::
>> +     Ignore changes whose lines are all blank.
>
> I think this is too terse and does not convey what the option really does.

That's the description from GNU diff man page. But indeed it could be
more precise.

>> +test_expect_success 'ignore-blank-lines: only new lines' '
>> +     seq 5 >x &&
>
> Please use test_seq instead of seq in all new tests.

Will fix.

> -- Hannes
>
