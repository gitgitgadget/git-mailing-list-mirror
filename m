From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Tue, 19 Jul 2011 12:58:48 -0700
Message-ID: <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
References: <4E21D295.7020600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: sam@vilian.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 21:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGRU-0006VL-Uf
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 21:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001Ab1GST6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 15:58:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1GST6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 15:58:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDCFA4BC6;
	Tue, 19 Jul 2011 15:58:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=73SYMfoVSh3k97hHEzWRZGTqPRo=; b=IfFy4V
	koSAQkHbfuLcdBvjk/Ae4MlU7/c1ITSS+f1L5lRQtYkq6UA2FAggYu6K/yCXQMYg
	Re2ItH/dTFhv7VJmJ6yHx7ZPgfDGVS5nvIpfz9Ng73PLYtfEvwMVQ3AuUwO3Zvfr
	G/rYRkpJi1vFdseJKBScHB3YKE89NlE3ji4xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QrCL+1g142Jwd3jAZw7bItyJY8keBeYC
	d7/1w1tBVsxbSy00WFhFVMC2MGUEJXUE3uvVutA57EJsLLMZFWzbHXwbCxQg/HQW
	QegHkD8NZ8xMoqwQBEkd56vG3PkSEYdZfDujwAktXRc63Y/3Mf/dbH1VbpchKfys
	zDOAdKBpIqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D497F4BC5;
	Tue, 19 Jul 2011 15:58:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 443934BC4; Tue, 19 Jul 2011
 15:58:50 -0400 (EDT)
In-Reply-To: <4E21D295.7020600@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 16 Jul 2011 19:04:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 857B6A46-B241-11E0-AB80-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177498>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Avoiding the use of the '@<rev>' syntax, in favour of an '-r <rev>'
> parameter, allows older versions of svn to execute the test.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> This test is failing for me on Linux and MinGW (I don't have svn
> installed on cygwin), again (i suspect) due to the older versions
> of svn I have. [v1.4.3 on Linux and v1.4.6 on MinGW]
>
> This patch fixes the test for me. However, I noticed that there are
> two other uses of the syntax in t9104-git-svn-follow-parent.sh which
> look like this:
>
>         (svn_cmd cp -m "resurrecting trunk as junk" \
>                "$svnrepo"/trunk@2 "$svnrepo"/junk ||
>          svn cp -m "resurrecting trunk as junk" \
>                -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
>
> which, unless I'm confused (possible), has been coded specifically
> to cater to just this problem!
> However, I think the above is a little too "belt & braces" for my
> liking. What do you think?

Hmm, but I am actually having trouble understanding what ffab626 (git-svn:
handle changed svn command-line syntax, 2007-09-21) wanted to do.  It
says:

    git-svn: handle changed svn command-line syntax
    
    Previously, if you passed a revision and a path to svn cp, it meant to look
    back at that revision and select that path.  New behaviour is to get the
    path then go back to the revision (like other commands that accept @REV
    or -rREV do).  The more consistent syntax is not supported by the old
    tools, so we have to try both in turn.
    
    Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
    Acked-by: Eric Wong <normalperson@yhbt.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

The explanation is not making sense at all. "Go back at the revision and
pick that path" vs "Pick the path and go back to the revision" would
change behaviour if the path was renamed since the revision, but it is not
like that the issue ffab626 wanted to fix was make sure which semantics is
used by using the right syntax that uses that semantics, so why did it
bring it up in the first place?  The first three lines and half might be
stating the fact, but it seems utterly irrelevant to what the commit does.

I am guessing that the "more consistent syntax" in the above is trying to
say that the author wants to see "path@REV" used as much as possible
instead of using "-rREV". But why use path@REV if newer subversion does
not drop support for the path@REV syntax?

Or is it "path@REV picks path and then goes to the REV, vs -rREV path goes
to REV and picks path"? If that is the case, then "we try both in turn"
needs a lot more explanation. If a newer subversion with path@REV support
that follows the "file identity" of path can be used, it copies from what
is now called "trunk" as it used to be at rev2, while an older subversion
without it cannot do so and copies from "trunk" that was at rev2. These
two may give vastly different results if "trunk" was renamed in between,
no? And if there was no such rename of "trunk" that affects what would
happen, then there is _no_ point in writing "path@REV || -rREV path" in
the first place---we know we can always use "-rREV path" without worrying
about what version of subversion is being used.

I am confused. Sam/Eric, care to help clarify the situation?

I also recall that svn:mergeinfo support is relatively new; is it even
supported in a old version that did not understand trunk@1 syntax?

>  t/t9159-git-svn-no-parent-mergeinfo.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
> index 85120b7..4cf26e9 100755
> --- a/t/t9159-git-svn-no-parent-mergeinfo.sh
> +++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
> @@ -11,7 +11,7 @@ test_expect_success 'test handling of root commits in merge ranges' '
>  		cd tmp &&
>  		echo "r2" > trunk/file.txt &&
>  		svn_cmd commit -m "Modify file.txt on trunk" &&
> -		svn_cmd cp trunk@1 branches/a &&
> +		svn_cmd cp -r1 trunk branches/a &&
>  		svn_cmd commit -m "Create branch a from trunk r1" &&
>  		svn_cmd propset svn:mergeinfo /trunk:1-2 branches/a &&
>  		svn_cmd commit -m "Fake merge of trunk r2 into branch a" &&
> @@ -21,7 +21,7 @@ test_expect_success 'test handling of root commits in merge ranges' '
>  		svn_cmd commit -m "Create branch b from thin air" &&
>  		echo "r6" > branches/b/file2.txt &&
>  		svn_cmd commit -m "Modify file2.txt on branch b" &&
> -		svn_cmd cp branches/b@5 branches/c &&
> +		svn_cmd cp -r5 branches/b branches/c &&
>  		svn_cmd commit -m "Create branch c from branch b r5" &&
>  		svn_cmd propset svn:mergeinfo /branches/b:5-6 branches/c &&
>  		svn_cmd commit -m "Fake merge of branch b r6 into branch c"
