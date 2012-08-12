From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Let submodule command exit with error status if path
 does not exist
Date: Sat, 11 Aug 2012 22:43:22 -0700
Message-ID: <7vy5lkfyx1.fsf@alter.siamese.dyndns.org>
References: <1340872080.2103.92.camel@athena.dnet>
 <20120809200302.GA93203@book.hvoigt.net>
 <7vboijol03.fsf@alter.siamese.dyndns.org>
 <20120811064912.GA83365@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 07:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0QyB-00075O-Di
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 07:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab2HLFn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 01:43:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2HLFnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 01:43:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A2898C3;
	Sun, 12 Aug 2012 01:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BJEXwje1qIHJ4L+bZ9tRxQmN71Y=; b=sxJH3Z
	oJ8spBi9Z5vcPamgxF7JDXDmeDEhky6WHDrRdJSJsnQCENtGbZgamw2m1kqeZ7WE
	KZJj637r2AZPt5pa9flTkDjAqpPsL+40f3hH5dTt2rVYnx/ki98hSw6HOjuIo5AX
	xCq/TP9/1r14L41OLnnqvLmqxb4M8GKhPx3+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oxPnkm+wqTfqRUCxEdMZEvIyUExeuy+e
	/L+SdtEwA62jWU3dBrZTWA6gzWwWrhW0lcUTuZ8tuv78juuBr/RtgxhUJlw0z75j
	CSzPVF6UZopEAD2x1AZwCxxplCs4PlTwrBBsK3We5QwpAwIM1GsXM7N4c/Zs97NN
	yhqNM571qnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 926E798C2;
	Sun, 12 Aug 2012 01:43:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99C4598C1; Sun, 12 Aug 2012
 01:43:23 -0400 (EDT)
In-Reply-To: <20120811064912.GA83365@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 11 Aug 2012 08:49:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A17FEF3C-E440-11E1-ADAE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203305>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I did not know that you prefer a space after the function name. I simply
> imitated the style from C and there we do not have spaces. It makes the
> style rules a bit more complicated. Wouldn't it be nicer to have the
> same as in C so we have less rules?

I do not think so, as they are different languages.  The call site
of C functions have name and opening parenthesis without a SP in
between.  The call site of shell functions do not even have
parentheses.

In any case, personal preferences (including mine) do not matter
much, as there is no "this is scientificly superiour" in styles.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index aac575e..48014f2 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -109,7 +109,8 @@ resolve_relative_url ()
>  #
>  module_list()
>  {
> -	git ls-files --error-unmatch --stage -- "$@" |
> +	(git ls-files --error-unmatch --stage -- "$@" ||
> +		echo '160000 0000000000000000000000000000000000000000 0	') |

Is there a reason why the sentinel has to have the same mode pattern
as a GITLINK entry, NULL SHA-1, stage #0?  Or is the "path" being
empty all that matters?

Ah, OK, you did not want to touch the perl script downstream.  I
would have preferred a comment to document that, i.e.

	(
        	git ls-files --error-unmatch --stage -- "$@" ||
                # an entry with an empty $path used as a signal
                echo '160000 0.... 0 '
	) |
	perl -e '...

or

	(
		git ls-files --error-unmatch --stage -- "$@" ||
		echo 'unmatched pathspec exists'
	) |
	perl -e '
	...
	while (<STDIN>) {
		if (/^unmatched pathspec/) {
			print;
                        next;
		}
		chomp;
		my ($mode, $sha1, $stage, $path) = ...

Either way, the reader of the code would not have to scratch her
head that way.

>  	perl -e '
>  	my %unmerged = ();
>  	my ($null_sha1) = ("0" x 40);
> @@ -385,6 +386,10 @@ cmd_foreach()
>  	module_list |
>  	while read mode sha1 stage sm_path
>  	do
> +		if test -z "$sm_path"; then
> +			exit 1

Style:

	if test -z "$sm_path"
	then
		exit 1

I know module_list would have said "error: pathspec 'no-such' did
not match any file(s) known to git.  Did you forget to git add"
already, but because that comes at the very end of the input to the
filter written in perl (and with the way the filter is coded, it
will stay at the end), I am not sure if the user would notice it if
we exit like this.  By the time we hit this exit, we would have seen
"Entering $sm_path..." followed by whatever message given while in
the submodule for all the submodules that comes out of module_list,
no?

How about doing it this way to avoid that issue, to make sure we die
immediately after the typo is diagnosed without touching anything?

 git-submodule.sh | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3aa7644..3f99d71 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -109,26 +109,47 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" |
+	(
+		git ls-files --error-unmatch --stage -- "$@" ||
+		echo "unmatched pathspec exists"
+	) |
 	perl -e '
 	my %unmerged = ();
 	my ($null_sha1) = ("0" x 40);
+	my @out = ();
+	my $unmatched = 0;
 	while (<STDIN>) {
+		if (/^unmatched pathspec/) {
+			$unmatched = 1;
+			next;
+		}
 		chomp;
 		my ($mode, $sha1, $stage, $path) =
 			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
 		next unless $mode eq "160000";
 		if ($stage ne "0") {
 			if (!$unmerged{$path}++) {
-				print "$mode $null_sha1 U\t$path\n";
+				push @out, "$mode $null_sha1 U\t$path\n";
 			}
 			next;
 		}
-		print "$_\n";
+		push @out, "$_\n";
+	}
+	if ($unmatched) {
+		unshift @out, "#unmatched\n";
 	}
+	print for (@out);
 	'
 }
 
+check_unmatched ()
+{
+	if test "$1" = "#unmatched"
+	then
+		exit 1
+	fi
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -385,6 +406,7 @@ cmd_foreach()
 	module_list |
 	while read mode sha1 stage sm_path
 	do
+		check_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
 			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
@@ -437,6 +459,7 @@ cmd_init()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		check_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 
 		# Copy url setting when it is not set yet
@@ -537,6 +560,7 @@ cmd_update()
 	err=
 	while read mode sha1 stage sm_path
 	do
+		check_unmatched "$mode"
 		if test "$stage" = U
 		then
 			echo >&2 "Skipping unmerged submodule $sm_path"
@@ -932,6 +956,7 @@ cmd_status()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		check_unmatched "$mode"
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$sm_path"
@@ -1000,6 +1025,7 @@ cmd_sync()
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
+		check_unmatched "$mode"
 		name=$(module_name "$sm_path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
 
