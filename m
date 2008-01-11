From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Fri, 11 Jan 2008 15:09:29 +0600
Message-ID: <7bfdc29a0801110109v10135afmd57c604e0d23250d@mail.gmail.com>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	 <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 10:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDFuA-0006hg-Rp
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 10:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbYAKJJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 04:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758133AbYAKJJg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 04:09:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:30652 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759811AbYAKJJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 04:09:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1051180fga.17
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bpGiO1KZd8d9ygFtBEGy7waZE/TlhJNBATqm2HPJCss=;
        b=uQv+wLgN5X9iGMREJfP0+QoFjm+hM6b2eYWjy77aXhQ8R2trYeRT9OOBAMrzVdYAu52eobx3Q65uJCguyux3THr6kclVc1wKDh7CXe2xpHOqw2jEIdcECPDvaTdZcbssokFQwDaKcpUNlcN5/1SVEnoWq59mddgwrvm3kL7Hq/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uz1YEjNhbDRQLZTJ7vrbU9i/hjodUMlNzTAXtlhezCsK/WXQtKUqrD2NPL9fAF9zFrNU1/jNov5aCd+GT1Wwgkj3HNqTDaol2y8FsC91YKABICMm2g561anO/4uaQQxp7Zvalr/wGc/dulLRo63jNlzGfPfkmx1FZOu/s9p+GHs=
Received: by 10.78.122.16 with SMTP id u16mr3417719huc.28.1200042569421;
        Fri, 11 Jan 2008 01:09:29 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Fri, 11 Jan 2008 01:09:29 -0800 (PST)
In-Reply-To: <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70141>

On Jan 10, 2008 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> imyousuf@gmail.com writes:
>
> > From: Imran M Yousuf <imyousuf@smartitengineering.com>
> >
> > - manual page of git-submodule and usage mentioned in git-subcommand.sh
> > were not same, thus synchronized them. In doing so also had to change the
> > way the subcommands were parsed.
> >
> > - Previous version did not allow commands such as "git-submodule add init
> > update". Thus not satisfying the following case -
> >
> > mkdir g; mkdir f; cd g/
> > touch g.txt; echo "sample text for g.txt" >> ./g.txt; git-init;
> > git-add g.txt; git-commit -a -m "First commit on g"
> > cd ../f/; ln -s ../g/ init
> > git-init; git-submodule add init update;
> > git-commit -a -m "With module update"
> > mkdir ../test; cd ../test
> > git-clone ../f/; cd f
> > git-submodule init update; git-submodule update update
> > cd ../..; rm -rf ./f/ ./test/ ./g/
>
> I find this too verbose with too little information.
>
> If I am reading you correctly, what you meant was that the way
> command parser was structured made subcommand names such as
> "init" and "update" reserved words, and it was impossible to use
> them as arguments to commands.
>
> You could have said something like this instead:
>
>         The command parser incorrectly made subcommand names to
>         git-submodule reserved, refusing them to be used as
>         parameters to subcommands.  For example,
>
>                 $ git submodule add init update
>
>         to add a submodule whose (symbolic) name is "init" and
>         that resides at path "update" was refused.
>
> That would have been much cleaner and easier on the reader than
> having to decipher what the 20+ command shell script sequence
> was doing.
>
> I do agree that the breakage is worth fixing, though.
>
> > +# Synopsis of this commands are as follows
> > +# git-submodule [--quiet] [-b branch] add <repository> [<path>]
> > +# git-submodule [--quiet] [--cached] [status] [--] [<path>...]
> > +# git-submodule [--quiet] init [--] [<path>...]
> > +# git-submodule [--quiet] update [--] [<path>...]
>
> I somehow feel that syntactically the original implementation
> that allowed subcommand specific options to come before the
> subcommand name was a mistake.  It may be easier for users that
> both "-b branch add" and "add -b branch" are accepted, but I
> have to wonder if it would really hurt if we made "-b branch
> add" a syntax error.

Just a point in this regard, if we allow to have both "-b branch add"
and "add -b branch" in that case there will be code redundancy as
there will have to parsing of "-b branch" in the subcommand parsing
and in the command module (module_add). I will be implementing now, to
support both; with the exception for --quiet.

>
> So how about reorganizing the top-level option parser like this:
>
>         while :
>         do
>                 case $# in 0) break ;; esac
>                 case "$1" in
>                 add | status | init | update)
>                         # we have found subcommand.
>                         command="$1"
>                         shift
>                         break ;;
>                 --)
>                         # end of parameters
>                         shift
>                         break ;;
>                 --quiet)
>                         quiet=1
>                         ;;
>                 -*)
>                         die "unknown option $1"
>                 esac
>                 shift
>         done
>         test -n "$command" || command=$default_command
>         module_$command "$@"
>
> And then make individual command implementations responsible for
> parsing their own options (and perhaps the common ones, to allow
> "git submodule add --quiet", but that is optional), like:
>
>         module_add () {
>                 while :
>                 do
>                         case $# in 0) break ;; esac
>                         case "$1" in
>                         --cached)
>                                 cached=1
>                                 ;;
>                         -b | --branch)
>                                 shift
>                                 branch="$1"
>                                 test -n "$branch" ||
>                                 die "no branch name after -b?"
>                                 ;;
>                         --)
>                                 shift
>                                 break
>                                 ;;
>                         --quiet)
>                                 quiet=1
>                                 ;;
>                         -*)
>                                 die "unknown option $1"
>                         esac
>                         shift
>                 done
>                 repo=$1
>                 path=$2
>                 ...
>         }
>
> In the above illustration I did not bother eliminating cut&paste
> duplication, but there may be a better way to share the piece to
> parse common options across subcommands option parsers and the
> toplevel one.
>
>



-- 
Imran M Yousuf
