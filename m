From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V3 4/4] git-mw: Add preview subcommand into git mw.
Date: Sun, 16 Jun 2013 22:39:50 +0200
Message-ID: <vpqr4g1eqnd.fsf@anie.imag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-5-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Sun Jun 16 22:39:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJjy-000383-5B
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab3FPUjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 16:39:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57496 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab3FPUjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 16:39:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5GKdmnV000979
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 22:39:48 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UoJjq-0003vT-OD; Sun, 16 Jun 2013 22:39:50 +0200
In-Reply-To: <1371349893-7789-5-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Sun, 16 Jun 2013 04:31:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 16 Jun 2013 22:39:48 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228027>

[ Just a quick look, no time for a detailed review ]

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> Add the subcommand to 'git-mw.perl'.

That's already said in the Subject field.

> Add a new constant in GitMediawiki.pm 'HTTP_CODE_PAGE_NOT_FOUND'.

And this brings zero information compared to

> --- a/contrib/mw-to-git/GitMediawiki.pm
> +++ b/contrib/mw-to-git/GitMediawiki.pm
> -				EMPTY HTTP_CODE_OK);
> +				EMPTY HTTP_CODE_OK HTTP_CODE_PAGE_NOT_FOUND);

I'd say your commit messages looks like a GNU-style changelog entry,
which I do not consider a compliment ;-).

Still, after removing rendundant information, you may notice that the
reader has no idea what "preview" is or does, and *why* it is a good
thing to have it. How about:

"
In the current state, a user of git-remote-mediawiki can edit the markup
text locally, but has to push to the remote wiki to see how the page is
rendered. Add a new "git mw preview" command that allows rendering the
markup text on the remote wiki without actually doing any change on the
wiki.

This uses MediaWiki's API to render the markup, and inserts the result
in an actual HTML page from the wiki so that CSS be rendered properly.
"

?

(The first paragraph answers "*why* did you do this?" and the second
"*why* did you do it this way?")

(did I put enough emphasis on the "why"? ;-) )

> +	# file_name argumeent is mandatory

argumeent -> argument

> +	if (!defined $file_name) {
> +		die "File not set, see `git mw help` \n";

Perhaps "missing file argument"?

> +		# Search all possibles mediawiki remotes
> +		if (! $remote_url) {

The "why" thing about commit message also applies to comments: when you
start saying what you're doing in a comment, it usually means your code
should be refactored.

Wouldn't it better to add a function here? The name of the function
would probably carry the same information as the comment.

> +				print {*STDERR} "do you want ? Use the -r option to specify the remote\n";

Missing period (.).

> +	}) or die "No response from distant mediawiki\n";

distant -> remote.

> +	$template_content_id = Git::config('mediawiki.IDContent')
> +		|| $template_content_id;

It would be cool to have also remote.<name>.IDContent or something like
this in case you have several remotes with different div ids. But this
can be added later.

> @@ -41,6 +341,7 @@ usage: git mw <command> <args>
>  
>  git mw commands are:
>      help        Display help information about git mw
> +    preview 	Parse and render local file into HTML

Space/tab mix after preview.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
