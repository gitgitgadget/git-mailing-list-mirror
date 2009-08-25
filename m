From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis-lite
Date: Tue, 25 Aug 2009 11:23:30 +0530
Message-ID: <2e24e5b90908242253v411ad5f3t8a2802079914d0bf@mail.gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
	 <m363cdm4pm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfoyU-0001qV-63
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbZHYFxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbZHYFx3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:53:29 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:35763 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbZHYFx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 01:53:29 -0400
Received: by iwn42 with SMTP id 42so1198490iwn.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0s03T/LOia6SAf5VXajJRZGvweRMVDBN2rOcCFA+Yus=;
        b=QtiJEjQdeGR01VF6+TdYo22bOUyUdivCxxUIlpZU3Db31Lp/3ffp08Sf/ELwpP9Sz1
         XTPO8Sz3KwWIKbfqUXQTkDTLG1Wzys3MFNzgYOC8NtBPSyKU5WcBstnAmDx0cjwSRkSO
         9AabLVcyr8tPedyI+JSojbbVvlt+FkQ+Z68c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iagd31O0uwGC5rg+57eBWwIvyfPfqrLsCliUpvUw3jKOm3y+33cQBqpGnCUYRNG05U
         Ls2/qaK5P4nZrqblOqtkvS7cSz8HiF/7WoHSFCMm+vV7Hl9XHZGiiEWVu+2JH+KMCLqu
         QhreNxf7amlGPsfAkEpcUuJ+DjEXUToK2XsCo=
Received: by 10.231.11.130 with SMTP id t2mr2597864ibt.51.1251179610933; Mon, 
	24 Aug 2009 22:53:30 -0700 (PDT)
In-Reply-To: <m363cdm4pm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127007>

[took Tommi out of cc; he must be getting enough mail as is...]

On Tue, Aug 25, 2009 at 12:14 AM, Jakub Narebski<jnareb@gmail.com> wrote:

> A few comments about the code, taking gl-auth-command as example.

> Wouldn't it be better to use "use warnings" instead of 'perl -w'?

I'm not sure what is the minimum perl required for git
itself.  Has it needed perl > 5.6.0 for more than a year at
least?  The only real difference between these two is scope,
which is a non-issue here, so I played safe.

> It would be, I think, better if you have used POD for such
> documentation.  One would be able to generate manpage using pod2man,
> and it is no less readable in source code.  See e.g. perl/Git.pm or
> contrib/hooks/update-paranoid.

Hmm... I've been spoiled by Markdown's sane bullet list
handling.  Visually, POD forces everything other than code
to be flush left -- any sort of list is definitely less
readable in source code as a result.  IMHO of course.

>> our $GL_ADMINDIR;
>> our $GL_CONF;
>> our $GL_KEYDIR;
>> our $GL_CONF_COMPILED;
>> our $REPO_BASE;
>> our %repos;
>
> Why is the reason behind using 'our' instead of 'my' here?

They are assigned values in some file being "do"-ed, so they
can't be lexical scoped.  However, I found a few others that
were holdovers from an earlier version.  Fixed; thanks for
catching that.

>> # first, fix the biggest gripe I have with gitosis, a 1-line change
>> my $user=$ENV{GL_USER}=shift;       # there; now that's available everywhere!
>
> Eh?  This is standalone script, isn't it?  Shouldn't it be
>
>   my $user = $ENV{GL_USER} = $ARGV[0];       # there; now that's available everywhere!

Hmm... I didn't know there was a difference, other than
depleting @ARGV, if you're outside a subroutine.  I'll take
a relook at it.

>> my $perm = 'W'; $perm = 'R' if $verb =~ $R_COMMANDS;
>
> Either split it into two lines, or use ?: confitional operator:
>
>   my $perm = ($verb =~ $R_COMMANDS ? 'R' : 'W');

much nicer... Fixed, thanks.

>> open(LOG, ">>", "$GL_ADMINDIR/log");
>> print LOG "\n", scalar(localtime), " $ENV{SSH_ORIGINAL_COMMAND} $user\n";
>> close(LOG);
>
> It is better practice to use lexical variables instead of barewords
> for filehandles:

Good catch; thanks!  I guess I'm showing my age :)  Fixed
all of them!

> Don't forget to check for error.

Hmm.. well I'm still debating if a log file write error
should block git access / push, but there were two more
important closes (again in gl-compile-conf) that were
unguarded.  Fixed, thanks.

>> $repo = "'$REPO_BASE/$repo.git'";
>> exec("git", "shell", "-c", "$verb $repo");
>
> That's not enough.  You have to shell-quote $repo, like in gitweb or
> using String::ShellQuote module, or somehow use list form to pass
> arguments to git-shell.  You protect here againts spaces in filename,
> but not againts "'" (single quote) and for show shells "!"
> (exclamation mark).

It'll never get here.  It'll die much earlier if the
reponame does not match a much stricter pattern.  Maybe too
strict, actually: ^[0-9a-zA-Z][0-9a-zA-Z._/-]*$

However, I then realised I should tighten up the R_COMMANDS
and W_COMMANDS patterns a wee bit; as it stands, if someone
could create a file called, say "git-upload-pack.pwned", and
put it in the PATH, he could get the "git" user to execute
it!  Sure if he managed to put something in the PATH that's
already game over in some sense but we have to stop what we
can :-)  Thanks for catching this.

And once again, I really appreciate the extra eyeballs on
the code!

-- 
Sitaram
