From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rev-list pretty format behavior
Date: Tue, 07 Apr 2015 15:53:57 +0200
Message-ID: <5523E175.2060607@drmicha.warpmail.net>
References: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>	<xmqqlhi6cma5.fsf@gitster.dls.corp.google.com> <CAHaCNWJ+S7Qa0=x2Xo2+HMQa0jz_tT8G+Wp1ugB4UHwBfOZRTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Oliver Runge <oliver.runge@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTxB-0004qM-0g
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbbDGNyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:54:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58067 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643AbbDGNyB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 09:54:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9D2EE20AC0
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 09:53:55 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 07 Apr 2015 09:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Y5y9JDkdCWguM9+3NNSpZrlCFTk=; b=brEcxF
	j1bYMXPbw9LwzAqcgqH1AJ0HCyOKTwlqIBin12FM9I1+0njrtGt89x3tIP4lXerX
	oARwBbw9RH+0Sz/MM2YYyzoavCdr1vaTFS1E0ln/A+8z04PGobvGRSKuIIX/TLI7
	U9QzFfiGn/6dcq1uJahczCUAAprrLvPVnO++Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Y5y9JDkdCWguM9+
	3NNSpZrlCFTk=; b=AHeVj3dNQ7Xi687ZrMcvBh0KKKzPQOqjdWXJnzRCLnvua0Y
	QRxz3CuXrSZ5cWLpeoQDFw+zPj1NYQg6M63eZ7Wez8Gy0/qo8lHQWXtB/6+1eFwf
	Dg1xPuclKPyarsfbmdnteapCDJrUotkIx2nksVFV3KPBqmTbr7BUQ3yNGFh4=
X-Sasl-enc: UTVJXKI8krtLky0mhvDnS9XVxCGRU5xoGZuc3QiUI8Ei 1428414839
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D9999C0001C;
	Tue,  7 Apr 2015 09:53:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAHaCNWJ+S7Qa0=x2Xo2+HMQa0jz_tT8G+Wp1ugB4UHwBfOZRTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266914>

Oliver Runge venit, vidit, dixit 06.04.2015 13:05:
> Hallo, Mr. Hamano.
> 
> Thank you for your quick and detailed response.
> 
> On 5 April 2015 at 23:12, Junio C Hamano <gitster@pobox.com> wrote:
>> This is very much the designed behaviour, I would think.  IIRC, the
>> user-format support of "rev-list" was designed so that the scripts
>> can customize the output from "rev-list -v", which was how scripts
>> were expected to read various pieces of information for each commit
>> originally.  And the 40-hex commit object name and/or a line that
>> begins with "commit ..." when a user format is used are meant to
>> serve as stable record separator (in that sense, having %H or %h in
>> the userformat given to rev-list is redundant) when these scripts
>> are reading output from "rev-list".
> 
> I see, but then I find it even stranger, because "rev-list -v" without
> "pretty" parameter will only output the hash as separator and "commit
> <sha1>" is only introduced if a "pretty" parameter other than
> "oneline" is specified. The docu states the formating is intended to
> make "git rev-list" behave more like "git log", and apart from the
> pretty settings "email" and "format"/"tformat" (which don't have
> "commit <sha1>" in "git log") the formating works exactly like it does
> in "git log".
> 
> docu:
> ------------------------------------------
> Commit Formatting
>        Using these options, git-rev-list(1) will act similar to the more
>        specialized family of commit log tools: git-log(1), git-show(1),
>        and git-whatchanged(1)
> ------------------------------------------
> and
> ------------------------------------------
> - format:<string>
> The format:<string> format allows you to specify which information you
> want to show. It works a little bit like printf format, with the
> notable exception that you get a newline with %n instead of \n.
> E.g, format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"
> would show something like this:
> 
>     The author of fe6e0ee was Junio C Hamano, 23 hours ago
>     The title was >>t4119: test autocomputing -p<n> for traditional
> diff input.<<
> ------------------------------------------
> 
>> A new option to tell "rev-list" that "I am designing an output that
>> is a-line-per-commit with the userformat and do not need the default
>> record separator" or "I will arrange record separator myself" would
>> be an acceptable thing to add, provided if many scripts yet to be
>> written would benefit from such a feature, though.
> 
> I searched github for usages of "git rev-list --pretty=format" to see
> whether I'm alone. I realize this is merely anecdotal, but perhaps
> still useful.
> 
> Scripts ignoring the separator:
> ------------------------------------------
> # no idea why it always prints those commit lines
> git rev-list --pretty=format:" - %s" "$@" |grep -v ^commit
> ------------------------------------------
> 
> ------------------------------------------
> git rev-list --pretty=format:"%H %h|%an:%s" "$@" | sed -n
> "s/^\([0-9a-f]\{40\}\) \(.*\)$/n\1 [$shape label=\"{\2}\"]/p"
> ------------------------------------------
> 
> (shortened with "..." by me)
> ------------------------------------------
> git rev-list --pretty=format:"%H %h %d" "$@" | awk '
> ...
> !/^commit/ {
> ...
> }'
> ------------------------------------------
> 
> Most of the scripts I found hack around the "commit <sha1>" lines,
> mostly in a way that would still work if the lines suddenly weren't
> there anymore. But unfortunately there are also some examples that
> would break:
> ------------------------------------------
> git rev-list --oneline --pretty=format:"%C(yellow)%h
> %C(red)%ad%C(green)%d %C(reset)%s%C(cyan) [%cn]" --date=short
> HEAD~2..HEAD | awk 'NR % 2 == 0'
> ------------------------------------------
> 
> And finally there are a few that really use the current behavior:
> ------------------------------------------
> # tcl
> set revisions [$::versioned_interpreter git rev-list
> "--pretty=format:%at%n%an <%ae>%n%s" -n 10 $revision]
> set result {}
> foreach {commit date author summary} [split $revisions \n] {
>     lappend result [list [lindex $commit 1] $date $author $summary]
> }
> ------------------------------------------
> 
> (shortened with "..." by me)
> ------------------------------------------
> save()
> {
>     awk '{print $2 " '$1'" }' | sort >$R/sha/$1
> }
> ...
> make_sha()
> {
>     git rev-list --pretty=format: ^Research-V6 BSD-1 | save BSD-1
>     git rev-list --pretty=format: ^BSD-1 BSD-2 | save BSD-2
>     ...
> }
> ------------------------------------------
> 
> I really feel that it should be the default behavior for "format",
> since the separator intention isn't described in the docu and isn't
> really needed for scripts that want to provide their own formating.
> That being said, I understand that that's likely not going to happen,
> especially since it would break quite a few legacy scripts.
> 
> But it would be prudent to update the docu to highlight the different
> behavior for the pretty settings "email" and "format"/"tformat", and
> even though I think another feature to turn off the separator lines
> makes the command more complex, the fact that so many scripts seem to
> write around the behavior might justify it.
> 
> I'd like to help with both tasks, if you think they are reasonable.
> 
> Oliver
> 

I'm wondering what the difference is - or should be - between "git log"
and "git rev-list" with (completely) user specified output. That
question goes both ways:

- Why do we need "rev-list" to have completely flexible output when we
have "log" with such flexibility?

- Why do we even have pretty formats for "rev-list"?

I'm thinking of rev-list as a raw (plumbing) revision lister much like
cat-file is the inspection tool for the objects, and log as the human
facing output with appropriate defaults (resp. show).

Note that "rev-list -v" isn't even documented afaics.

Michael
