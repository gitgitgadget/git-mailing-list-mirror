From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add -k option to cvsexportcommit to squash CVS keywords
Date: Sun, 31 May 2009 13:28:05 -0700
Message-ID: <7vk53xqap6.fsf@alter.siamese.dyndns.org>
References: <b2cdc9f30905280636p404525e2u6f3eb21700b6da66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MArdf-0004Jc-01
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 22:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZEaU2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbZEaU2F
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 16:28:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65042 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZEaU2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 16:28:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531202805.RYPT25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 31 May 2009 16:28:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id yLU51b00G4aMwMQ04LU5HP; Sun, 31 May 2009 16:28:05 -0400
X-Authority-Analysis: v=1.0 c=1 a=RQkueCtqpwkA:10 a=_28cSoEYqAIA:10
 a=XOUOgEBVAAAA:8 a=jJcqXwGPsSwZMFBvchoA:9 a=229jMg9RttWixV6dmAwA:7
 a=j1uBnG1mbjuR8eZtaPjRp0c2-WUA:4 a=MuuwAMw52CwA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120430>

Alex Bennee <kernel-hacker@bennee.com> writes:

> My CVS repo is converted by parsecvs and although I don't often mess
> around in the headers I did hit a problem when exporting some commits
> that had removed some lines which would have had an expanded
> $Revision$ in a code string.
>
> Rather than make it default behaviour I've added a quick filter to
> cvsexportcommit so I don't have to go back to patching and committing
> those commits by ahdn :-)
>
>
> From a1a9477d6e332617526aaab488602552b77832d9 Mon Sep 17 00:00:00 2001

Thanks.

You would want to put all the commentary up to here below the "---" line,
if you want to give an introductory text that is not part of your proposed
commit log message.

> From: Alex Bennee <alex@bennee.com>
> Date: Thu, 28 May 2009 14:31:51 +0100
> Subject: [PATCH] Add -k option to cvsexportcommit to squash CVS keywords

You generally do not want these three lines, unless the "From: " your
e-mail shows is different from the name and e-mail of the real author of
the patch.

I presume you would want alex-at-bennee-dot-com in the commit, so in this
case it might be Ok, but then it may be more straightforward to use that
name on the "From: " line of your e-mail to begin with, but on the other
hand, you have a commit as kernel-dash-hacker-at-the-same-domain in our
history already.  If you prefer the latter, you do not need any of the
above three lines (the subject is the same as your e-mail "Subject: "
anyway).

> Depending on how your CVS->GIT conversion went you will have some
> unexpanded CVS keywords in your
> GIT repo. If any of your git commits touch these lines then the patch
> application will fail. This
> patch addresses that by filtering files before applying the patch
> ---

The message is wrapped in a funny way, and it lacks sign-off.

Isn't it "expanded" (not "unexpanded") keyword the problem you are trying
to address?  "By filtering files" in what way?  I can guess "filtering them
back to unexpanded form", but please do not make me guess.

> diff --git a/Documentation/git-cvsexportcommit.txt
> b/Documentation/git-cvsexportcommit.txt
> index 2da8588..b328dd4 100644
> --- a/Documentation/git-cvsexportcommit.txt
> +++ b/Documentation/git-cvsexportcommit.txt
> @@ -63,6 +63,9 @@ OPTIONS
>  -u::
>  	Update affected files from CVS repository before attempting export.
>
> +-k::
> +	Filter CVS keywords (like $Revision$) before applying patch.
> +	

"Filter in what way" applies here as well.

Is it really sufficient to unmunge "$Revision$? and "$Id"?  What about
"$Date$", for example?

> @@ -266,9 +266,32 @@ foreach my $f (@files) {
>  	$dirty = 1;
>  	warn "File $f not up to date but has status '$cvsstat{$f}' in your
> CVS checkout!\n";
>      }
> +
> +    # Depending on how your GIT tree got imported some of the CVS
> +    # expansion keywords would have been squashed. This will break
> +    # application of the patch if you touched any lines that had them.

I am not quite getting this comment.  "Squashed" sounds like "$Revision$"
without expansion instead of "$Revision: 1.4 $"; I thought the issue you
are addressing is that the automated change that comes from the CVS side
to the expanded keyword gets in the way, i.e. if these always were
"squashed", then you would not have to fight with spurious conflicts.

> +    if ($opt_k)
> +    {

This open brace come on the same line as "if", like "if (...) {" to match
the style of the surrounding code.

> +	my $orig_file ="$f.orig";
> +	rename $f, $orig_file;
> +	open(FILTER_IN, "<$orig_file") or die "Cannot open $orig_file\n";
> +	open(FILTER_OUT, ">$f") or die "Cannot open $f\n";
> +	while (<FILTER_IN>)
> +	{
> +	    my $line = $_;
> +	    $line =~ s#\$Revision:[ \.\d]+ \$#\$Revision\$#;
> +	    $line =~ s#\$Id: [^\$]+\$#\$Id\$#;

When there is no '/' in substitution or pattern, it is _far_ easier to
read if you used the standard s/foo/bar/, not custom s#foo#bar#.

Can "$Revision:" immediately be followed by a digit while "$Id:" must
always be followed by a whitespace?  I doubt it.

Why isn't this something like:

	$line =~ s/\$(Revision|Id|Date|....):[^\$]+\$/\$\1\$/g;

or even (not bothering to enumerate the possible set of keywords):

	$line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$\1\$/g;

> +	    print FILTER_OUT $line;
> +	}
> +	close FILTER_IN;
> +	close FILTER_OUT;
> +    }
>  }
> +
>  if ($dirty) {
> -    if ($opt_f) {	warn "The tree is not clean -- forced merge\n";
> +    if ($opt_f) {
> +	warn "The tree is not clean -- forced merge\n";

This may be a good change, but is distracting, and does not have anything
to do with what you are doing with this patch.
