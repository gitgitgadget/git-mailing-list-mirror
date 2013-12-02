From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: Change prompt to display the number of files in the diff queue
Date: Mon, 02 Dec 2013 13:08:26 -0800
Message-ID: <xmqqfvqbq7ud.fsf@gitster.dls.corp.google.com>
References: <1385599794-6002-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 22:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnajQ-0004hk-Af
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 22:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202Ab3LBVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 16:08:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3LBVIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 16:08:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E0458293;
	Mon,  2 Dec 2013 16:08:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VgzrXjzvIEKubh6Q1P0NUCg+IaQ=; b=cTFtW/
	JFPfJUSCsbGdUeJCQB8iTnywWP8y2sz9RqlVxLvi6Qq6Aqv4FNdg/r4r3JnI3jaW
	boKCQtqQmVnyL/aRXbnJN3QpPJcAEp6NbCOmd/PDAeXsqoWzBF9LxpPhnAQaLWu6
	6+33FySTayJlKASTOeAGPii4r1JNgFXsGktuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vajxi9OzdF0NqE5FTS1xsg4OujDiqeCG
	sv5Y28GG/sNr3lzT8PwthOIqlKzYowVFURW6/Ts8lqUS3d+Qo4hYZIUjm/ieeJVR
	h1fuF/WUqIb2wTxsT1GTKn0sKgAb08JC627PYcks7uKBMzF9gx63nH09dO+YQDmN
	rsnEpvM7p0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDDB58291;
	Mon,  2 Dec 2013 16:08:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CDA158290;
	Mon,  2 Dec 2013 16:08:29 -0500 (EST)
In-Reply-To: <1385599794-6002-1-git-send-email-zoltan.klinger@gmail.com>
	(Zoltan Klinger's message of "Thu, 28 Nov 2013 11:49:54 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E48C0B26-5B95-11E3-889E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238653>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> When --prompt option is set, git-difftool displays a prompt for each
> modified file to be viewed in an external diff program. At that point it
> could be useful to display a counter and the total number of files in
> the diff queue.
>
> Below is the current difftool prompt for the first of 5 modified files:
> Viewing: 'diff.c'
> Launch 'vimdiff' [Y/n]:
>
> Consider the modified prompt:
> Viewing (1/5): 'diff.c'
> Launch 'vimdiff' [Y/n]:
>
> (1) Modify run_external_diff() function in diff.c to pass a counter and
> the total number of files in the diff queue to the external program.
>
> (2) Modify git-difftool--helper.sh script to display the counter and the
> diff queue count values in the difftool prompt.
>
> (3) Update git.txt documentation
>
> (4) Update t4020-diff-external.sh test script
>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
> ---
>  Documentation/git.txt    |  6 +++++-
>  diff.c                   | 14 +++++++++++++-
>  git-difftool--helper.sh  |  8 +++++---
>  t/t4020-diff-external.sh | 27 +++++++++++++++++++++------
>  4 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index b73a24a..d8241bb 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -785,9 +785,10 @@ Git Diffs
>  	When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
>  	program named by it is called, instead of the diff invocation
>  	described above.  For a path that is added, removed, or modified,
> -        'GIT_EXTERNAL_DIFF' is called with 7 parameters:
> +	'GIT_EXTERNAL_DIFF' is called with 9 parameters:
>  
>  	path old-file old-hex old-mode new-file new-hex new-mode
> +	counter total

As the "git difftool" is not the only thing that reads using the
GIT_EXTERNAL_DIFF mechanism (it is for general consumption by end
user scripts), I wonder how/if this change breaks existing scripts.
I do recall writing an EXTERNAL_DIFF script myself that began by
switching on $# (i.e. the number of arguments) to check the state of
the given path, like this:

	case $# in
        1)
        	... handle unmerged path ...
                ;;
	7)
        	... handle comparison ...
		;;
	*)
        	die "Unexpected number of arguments to $0: $#"
                ;;
	esac

which will be broken by this change. Updating such scripts is
trivial but that does not change the fact that this change is
forcing an unnecessary work on our users to adjust their scripts
that have been working perfectly fine.  So I think this, if we were
to apply, may need a compatibility warning in large flashing red
letters in the release notes.

>  +
>  where:
>  
> @@ -795,6 +796,9 @@ where:
>                           contents of <old|new>,
>  	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
>  	<old|new>-mode:: are the octal representation of the file modes.
> +	counter:: is a numeric value incremented by one for every modified
> +				file
> +	total:: is the total number of modified files
>  +
>  The file parameters can point at the user's working file
>  (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
> diff --git a/diff.c b/diff.c
> index e34bf97..938f00a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -37,6 +37,7 @@ static int diff_stat_graph_width;
>  static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
>  static long diff_algorithm;
> +static int diff_display_counter = 1;

There should be a place somewhere, e.g. diff_setup_done(), to reset
this counter to 0 (and the site that uses the variable should
pre-increment it instead of relying the initial value being 1), so
that a single program could later run the diff machinery more than
once for different set of files.  This counter may actually belong
to diff_options, just like existing "found_changes" and
"found_follow" fields are there to keep track of state of the diff
machinery per invocation.

Having said all that, the fact that the current arrangement since we
introduced GIT_EXTERNAL_DIFF mechanism does not tell how many paths
there are in the output is indeed bad.  If a script that uses
GIT_EXTERNAL_DIFF wants to first collect all the paths and the
parameters and then show everything in a single UI, such a script
may want to (1) start collecting the paths and args to a persistent
place (e.g. starting a GUI diff daemon for the first path it gets,
or starting a new temporary file), (2) keep collecting the paths and
args, and then (3) after collecting all, present diff for all paths
it obtained, but it is impossible because there is no cue when a
series of external diff calls starts or ends.

And this "counter/total" mechanism could be one possible solution to
it (another possibility is to make an extra dummy call to signal the
end, perhaps with no parameters---the one that is collecting can
then know how many paths there are and which one is the Nth path).
