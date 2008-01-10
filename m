From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Thu, 10 Jan 2008 12:51:42 +0600
Message-ID: <7bfdc29a0801092251p3d46a3cau3db4d57c4f705043@mail.gmail.com>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	 <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 07:52:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCrGv-0004NQ-LI
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 07:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYAJGvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 01:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYAJGvo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 01:51:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:27233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYAJGvn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 01:51:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so567009fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GOjwsRAuSxunawOQVGo2IJzTXgNlWxl88Q8tPFSrEaQ=;
        b=ncdXZMWZZVkokN+Y0uNqJAyhvyYjL/N+QIvWyyNbZY2+iizrlGLSCUsZXehyhglY4rueBUudrnhkKOwF/tkIg52g1KbcVeQ5a1nuC6In0wWKvHnd98JypNeMGsBeWlWGHn6DTxWkAdRvM8VeiX5j3OPIK0Q21jGXJKd5Sh8nEX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qAHfDA/920YHLDh4W9OUx3sSCRdb0b8otstJDcXDfLmoR0Oey3rLHNAa458xQ/VOl5lNZU7vlEJbNMWPOTrbAv6wRaWax1H+0rknog3VH92tOgjI7gaP5NNGuXNr8ekM2SWt3q9nd0DBLHB+1TebnUBs/Nmmqh/Lb27ZnJCWAhE=
Received: by 10.78.170.17 with SMTP id s17mr1703044hue.35.1199947902067;
        Wed, 09 Jan 2008 22:51:42 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 22:51:42 -0800 (PST)
In-Reply-To: <7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70045>

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

I agree that your comment is better than, I will change it accordingly
when resubmitting it.

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
>

I will recode it to have all options except for --quiet (which is
inverse of -v or --verbose) be mentioned after the subcommand.

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

Actually module_$command is not possible because only add's module is
module_add rest are modules_$command. Thus I would require another if
else and that was the original reason for not using it. Instead I
should have (and will) used -

       case "$1" in
       add)
               add=1
               command="module_$1"
               shift
               break
               ;;
       init|update|status)
               init=1
               command="modules_$1"
               shift
               check_for_terminator "$1"
               break
               ;;

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

As add subcommand does not support --cached it should be considered in
-*, just mentioning for your FYI, I got the point of module parsing
their own arguments and I am in agreement.

>

I will make the necessary changes and resubmit the patch tomorrow.

Best regards,

-- 
Imran M Yousuf
