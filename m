From: Oliver Runge <oliver.runge@gmail.com>
Subject: Re: rev-list pretty format behavior
Date: Mon, 6 Apr 2015 13:05:20 +0200
Message-ID: <CAHaCNWJ+S7Qa0=x2Xo2+HMQa0jz_tT8G+Wp1ugB4UHwBfOZRTg@mail.gmail.com>
References: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>
	<xmqqlhi6cma5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 13:05:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf4qN-00085l-BF
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 13:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbDFLFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 07:05:22 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36432 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbDFLFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 07:05:21 -0400
Received: by qku63 with SMTP id 63so22195350qku.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WHTnwbbGERkc2JjhtlPAnF2KyseILgLkNwa9lDhCTZQ=;
        b=OVc2Q1cSBBMZCkyDWv1tva/8CWtvLPAks6EVQb+qyQLMpuB6BFpi3yJRxUfcR0Z5M7
         e8y10Qm1FG9XnYJmD7TZRIQSKZ0AuLjJ4F1awEFA8dvZRQyDCrqyz2o3JMyYgAOTr0n5
         yIbRT2S4+1IVRsH/QZeJgiCLgT0Uh5VGfODKTBt/gQTJo7eawHIjhtgI8s0QeYuJWQ0x
         v5sc97iMYumZR5nphZAR91CWd80iRe2I+2Qrhkhui0rFalIAmyqNI9oUdgtlJ3bLn2XI
         k2cPTRpXpWVQcnkXmqAZwy3zE1rTAKkA+xjhaDL8kEfq9Q2N5n3HjRb+nrkQldh6x/0f
         cO8g==
X-Received: by 10.55.52.67 with SMTP id b64mr26875397qka.47.1428318320639;
 Mon, 06 Apr 2015 04:05:20 -0700 (PDT)
Received: by 10.140.42.47 with HTTP; Mon, 6 Apr 2015 04:05:20 -0700 (PDT)
In-Reply-To: <xmqqlhi6cma5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266838>

Hallo, Mr. Hamano.

Thank you for your quick and detailed response.

On 5 April 2015 at 23:12, Junio C Hamano <gitster@pobox.com> wrote:
> This is very much the designed behaviour, I would think.  IIRC, the
> user-format support of "rev-list" was designed so that the scripts
> can customize the output from "rev-list -v", which was how scripts
> were expected to read various pieces of information for each commit
> originally.  And the 40-hex commit object name and/or a line that
> begins with "commit ..." when a user format is used are meant to
> serve as stable record separator (in that sense, having %H or %h in
> the userformat given to rev-list is redundant) when these scripts
> are reading output from "rev-list".

I see, but then I find it even stranger, because "rev-list -v" without
"pretty" parameter will only output the hash as separator and "commit
<sha1>" is only introduced if a "pretty" parameter other than
"oneline" is specified. The docu states the formating is intended to
make "git rev-list" behave more like "git log", and apart from the
pretty settings "email" and "format"/"tformat" (which don't have
"commit <sha1>" in "git log") the formating works exactly like it does
in "git log".

docu:
------------------------------------------
Commit Formatting
       Using these options, git-rev-list(1) will act similar to the more
       specialized family of commit log tools: git-log(1), git-show(1),
       and git-whatchanged(1)
------------------------------------------
and
------------------------------------------
- format:<string>
The format:<string> format allows you to specify which information you
want to show. It works a little bit like printf format, with the
notable exception that you get a newline with %n instead of \n.
E.g, format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"
would show something like this:

    The author of fe6e0ee was Junio C Hamano, 23 hours ago
    The title was >>t4119: test autocomputing -p<n> for traditional
diff input.<<
------------------------------------------

> A new option to tell "rev-list" that "I am designing an output that
> is a-line-per-commit with the userformat and do not need the default
> record separator" or "I will arrange record separator myself" would
> be an acceptable thing to add, provided if many scripts yet to be
> written would benefit from such a feature, though.

I searched github for usages of "git rev-list --pretty=format" to see
whether I'm alone. I realize this is merely anecdotal, but perhaps
still useful.

Scripts ignoring the separator:
------------------------------------------
# no idea why it always prints those commit lines
git rev-list --pretty=format:" - %s" "$@" |grep -v ^commit
------------------------------------------

------------------------------------------
git rev-list --pretty=format:"%H %h|%an:%s" "$@" | sed -n
"s/^\([0-9a-f]\{40\}\) \(.*\)$/n\1 [$shape label=\"{\2}\"]/p"
------------------------------------------

(shortened with "..." by me)
------------------------------------------
git rev-list --pretty=format:"%H %h %d" "$@" | awk '
...
!/^commit/ {
...
}'
------------------------------------------

Most of the scripts I found hack around the "commit <sha1>" lines,
mostly in a way that would still work if the lines suddenly weren't
there anymore. But unfortunately there are also some examples that
would break:
------------------------------------------
git rev-list --oneline --pretty=format:"%C(yellow)%h
%C(red)%ad%C(green)%d %C(reset)%s%C(cyan) [%cn]" --date=short
HEAD~2..HEAD | awk 'NR % 2 == 0'
------------------------------------------

And finally there are a few that really use the current behavior:
------------------------------------------
# tcl
set revisions [$::versioned_interpreter git rev-list
"--pretty=format:%at%n%an <%ae>%n%s" -n 10 $revision]
set result {}
foreach {commit date author summary} [split $revisions \n] {
    lappend result [list [lindex $commit 1] $date $author $summary]
}
------------------------------------------

(shortened with "..." by me)
------------------------------------------
save()
{
    awk '{print $2 " '$1'" }' | sort >$R/sha/$1
}
...
make_sha()
{
    git rev-list --pretty=format: ^Research-V6 BSD-1 | save BSD-1
    git rev-list --pretty=format: ^BSD-1 BSD-2 | save BSD-2
    ...
}
------------------------------------------

I really feel that it should be the default behavior for "format",
since the separator intention isn't described in the docu and isn't
really needed for scripts that want to provide their own formating.
That being said, I understand that that's likely not going to happen,
especially since it would break quite a few legacy scripts.

But it would be prudent to update the docu to highlight the different
behavior for the pretty settings "email" and "format"/"tformat", and
even though I think another feature to turn off the separator lines
makes the command more complex, the fact that so many scripts seem to
write around the behavior might justify it.

I'd like to help with both tasks, if you think they are reasonable.

Oliver
