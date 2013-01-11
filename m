From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Fri, 11 Jan 2013 08:31:19 -0800
Message-ID: <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TthWC-0002S7-FD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab3AKQbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:31:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974Ab3AKQbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:31:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEF0B9B0;
	Fri, 11 Jan 2013 11:31:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7VaWERTtG86wP9tKcyg/DNQKLp8=; b=Ot95xm
	AMWTcG7uXlCjsB0p0Ljp8kin+8rOrUKBm0LJgEBG5b7HcEeCFgAUCocT1K5CtZlT
	PeVaF7juEmaEsWU+S4rYwZRQEvu3Hhw+TkI+QFbNd2Et9yDL+xBQdplAuT6/U91w
	AeOFhRgAE/zq8+p+yls9Maq4QCIOK5dwQxhA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUqfYoeMK9/6KqmF6Blqv9pEkvdFFrq7
	urQbjFMa+TIDo0sPbK7J70YWqjGdCetGSdP0LBv0cj8p+CLfSpZaMSE/xlnapXmr
	XKk3TCNjWwMeZ809OZwfBZ4ZfY+9GBcWzt1qKZXl3C8kQ1byfo1fYMhbEnpYRBGH
	WG1QoP+o8zE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 037A2B9AF;
	Fri, 11 Jan 2013 11:31:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CBF8B9AE; Fri, 11 Jan 2013
 11:31:21 -0500 (EST)
In-Reply-To: <1357875152-19899-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 10 Jan 2013 19:32:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5527B130-5C0C-11E2-853B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213222>

> From: "Eric S. Raymond" <esr@thyrsus.com>
> ...
> diff --git a/git-cvsimport.perl b/git-cvsimport-fallback.perl
> similarity index 98%
> rename from git-cvsimport.perl
> rename to git-cvsimport-fallback.perl
> index 0a31ebd..4bc0717 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport-fallback.perl
> @@ -1,4 +1,8 @@
>  #!/usr/bin/perl
> +# This code became obsolete in January 2013, and is retained only as a
> +# fallback from git-cvsimport.py for users who have only cvsps-2.x.
> +# It (and the code in cvsimport.py that calls it) should be removed
> +# once the 3.x version has had a reasonable time to propagate.
>  
>  # This tool is copyright (c) 2005, Matthias Urlichs.
>  # It is released under the Gnu Public License, version 2.
> @@ -27,6 +31,10 @@
>  use POSIX qw(strftime tzset dup2 ENOENT);
>  use IPC::Open2;
>  
> +print(STDERR "You do not appear to have cvsps 3.x.\n");
> +print(STDERR "Falling back to unmaintained Perl cvsimport for cvsps 2.x.\n");
> +print(STDERR "Upgrade your cvsps for best results.\n");

I think the prevalent style in this script is to write "print"
without parentheses:

	print STDERR "msg\n";

> diff --git a/git-cvsimport.py b/git-cvsimport.py
> new file mode 100755
> index 0000000..129471e
> --- /dev/null
> +++ b/git-cvsimport.py
> @@ -0,0 +1,354 @@
> +#!/usr/bin/env python
> +#
> +# Import CVS history into git
> +#
> +# Intended to be a near-workalike of Matthias Urlichs's Perl implementation.
> ...
> +class cvsps:
> +    "Method class for cvsps back end."
> +    def __init__(self):
> +        self.opts = ""
> +        self.revmap = None
> +    def set_repo(self, val):
> +        "Set the repository root option."
> +        if not val.startswith(":"):
> +            if not val.startswith(os.sep):
> +                val = os.path.abspath(val)
> +            val = ":local:" + val
> +        self.opts += " --root '%s'" % val

This looks lazy and unsafe quoting.  Is there anything that makes
sure repository path does not contain a single quote?

> +    def set_authormap(self, val):
> +        "Set the author-map file."
> +        self.opts += " -A '%s'" % val
> +    def set_fuzz(self, val):
> +        "Set the commit-similarity window."
> +        self.opts += " -z %s" % val
> +    def set_nokeywords(self):
> +        "Suppress CVS keyword expansion."
> +        self.opts += " -k"
> +    def add_opts(self, val):
> +        "Add options to the engine command line."
> +        self.opts += " " + val

... especially for callers of this method.

The same comment applies to many uses of "val" in the method
implementations of this class and the cvs2git class.

> +    def command(self):
> +        "Emit the command implied by all previous options."
> +        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)

Could we do something better with this overlong source line?

> +if __name__ == '__main__':
> ...
> +    for (opt, val) in options:
> +        if opt == '-v':
> +            verbose += 1
> +        elif opt == '-b':
> +            bare = True
> +        elif opt == '-e':
> +            for cls in (cvsps, cvs2git):
> +                if cls.__name__ == val:
> +                    backend = cls()
> +                    break
> +            else:
> +                sys.stderr.write("git cvsimport: unknown engine %s.\n" % val)
> +                sys.exit(1)
> +        elif opt == '-d':
> +            backend.set_repo(val)
> +        elif opt == '-C':
> +            outdir = val
> +        elif opt == '-r':
> +            remotize = True
> +        elif opt == '-o':
> +            sys.stderr.write("git cvsimport: -o is no longer supported.\n")
> +            sys.exit(1)

Isn't this a regression?

> +        elif opt == '-i':
> +            import_only = True
> +        elif opt == '-k':
> +            backend.set_nokeywords()
> +        elif opt == '-u':
> +            underscore_to_dot = True
> +        elif opt == '-s':
> +            slashsubst = val
> +        elif opt == '-p':
> +            backend.add_opts(val.replace(",", " "))
> +        elif opt == '-z':
> ...
> +        elif opt == '-P':
> +            backend = filesource(val)
> +            sys.exit(1)

???

> +        elif opt in ('-m', '-M'):
> +            sys.stderr.write("git cvsimport: -m and -M are no longer supported: use reposurgeon instead.\n")
> +            sys.exit(1)

I wonder if it is better to ignore these options with a warning but
still let the command continue; cvsps-3.x was supposed to get merges
right without the help of these ad-hoc options, no?

Otherwise it looks like a regression to me.

> +        elif opt == '-S':
> +            backend.set_exclusion(val)
> +        elif opt == '-a':
> +            sys.stderr.write("git cvsimport: -a is no longer supported.\n")
> +            sys.exit(1)
> +        elif opt == '-L':
> +            sys.stderr.write("git cvsimport: -L is no longer supported.\n")
> +            sys.exit(1)
> +        elif opt == '-A':
> +            authormap = os.path.abspath(val)
> +        elif opt == '-R':
> +            revisionmap = True
> +        else:
> +            print """\
> +git cvsimport [-A <author-conv-file>] [-C <git_repository>] [-b] [-d <CVSROOT>]
> +     [-e engine] [-h] [-i] [-k] [-p <options-for-cvsps>] [-P <source-file>]
> +     [-r <remote>] [-R] [-s <subst>] [-S <regex>] [-u] [-v] [-z <fuzz>]
> +     [<CVS_module>]
> +"""
> +    def metadata(fn, outdir='.'):
> +        if bare:
> +            return os.path.join(outdir, fn)
> +        else:
> +            return os.path.join(outdir, ".git", fn)
> +    # Ugly fallback code for people with only cvsps-2.x
> +    # Added January 2013 - should be removed after a decent interval.
> +    if backend.__class__.__name__ == "cvsps":
> +        try:
> +            subprocess.check_output("cvsps -V 2>/dev/null", shell=True)
> +        except subprocess.CalledProcessError as e:
> +            if e.returncode == 1:
> +                sys.stderr.write("cvsimport: falling back to old version...\n")
> +                sys.exit(os.system("git-cvsimport-fallback " + " ".join(sys.argv[1:])))
> +            else:
> +                sys.stderr.write("cvsimport: cannot execute cvsps.\n")
> +                sys.exit(1)

Having the code to die when it sees options the rewritten version
does not yet support before it calls the fallback makes the fallback
much less effective, no?

> +    # Real mainline code begins here
> +    try:
> +        if outdir:
> +            try:
> +                # If the output directory does not exist, create it
> +                # and initialize it as a git repository.
> +                os.mkdir(outdir)
> +                do_or_die("git init --quiet " + outdir)

Did anything made sure outdir is without $IFS chars up to this
point?

Not very impressed (yet).  The advertised "fix major bugs" sounds
more like "trade major bugs with different ones with a couple of
feature removals" at this point.
