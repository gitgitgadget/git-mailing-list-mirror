From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH v2 2/5] git-submodule.sh: Add recurse subcommand with basic options
Date: Tue, 13 May 2008 12:40:25 +0600
Message-ID: <7bfdc29a0805122340t7edef1fdl837392b0c480e1@mail.gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
	 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
	 <7vprrs1fns.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvoCb-0002F7-74
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbYEMGkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 02:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbYEMGkn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:40:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35203 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYEMGkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:40:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1498161ywe.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=llOn2jlMCHcyh/WSbgtp+wPaWPHEtiDbeUKi3pvdIC4=;
        b=Ac/TiLqNFjfOQO0NJe6ON0I+1QOvK83HuXHnsS5Dq33z75wM5DZ3odUVa4DItqeDTnmKG9V5vjgL8p1Tlc1bKEkKhfYo5k7m7LAMp2UdFNuhk6DpyT2R2ZZGp7euR/JjymEBG2CV5WoG9UrB/E59ShpYdMMMTUrPTmovVeQmZ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8w3ytrhY6gpO/DjtseCzgU9MqyVW/YNmgGSVKWfH5xOYxKL6OZkgKlsYVNscJ+SY0jvsbB88B61ivAy/jG/jEHnGK/5tpP0FY1TXBbSyUqYWaTQocevUksDhaG1ClewFiuJn0OtP4+maaVhr6IzS7Lb+r0mDQj5zboXJMXF3Jo=
Received: by 10.150.144.9 with SMTP id r9mr9209786ybd.242.1210660825761;
        Mon, 12 May 2008 23:40:25 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Mon, 12 May 2008 23:40:25 -0700 (PDT)
In-Reply-To: <7vprrs1fns.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81993>

On Mon, May 12, 2008 at 7:20 AM, Junio C Hamano <junio@pobox.com> wrote:
> imyousuf@gmail.com writes:
>
>  > The recurse commands behavior can be customized with several arguments
>  > that it accepts. The synopsis for the recurse command is:
>  >
>  >       git-submodule recurse [-q|--quiet] [-e|--exit-after-error]
>  >       [-d|--depth <recursion depth>] [-b|--breadth-first]
>  >       <git command> [<arguments> ...]
>
>  Is there a reason to limit the command that can be run per submodule to
>  only "git" commands?  To me, this "recurse" looks like a glorified "find"
>  command that can trigger its action only to submodule directories, but
>  limits what can be given to its -exec option to "git" commands.  While it
>  would not make sense to give certain git command to recurse (e.g. neither
>  "git show 65ea3b8" nor "git clone $there" would make any sense), it would
>  be handy if we can give certain non-git commands to it (e.g. "du -sh").

I do agree how the recurse command looks, but considering that it is a
'git submodule' subcommand I thought having a general command might
have faced a greater criticism from the community. Similarly about not
allowing certain git commands is also in my list for the later version
as it would require a bigger discussion in the community.

>
>
>  > @@ -580,6 +585,129 @@ cmd_status()
>  >       done
>  >  }
>  >
>  > +# Check whether the submodule is initialized or not
>  > +initialize_sub_module()
>
>  Everybody else seems to spell "<do-something>_submodule"; should this be
>  any different?
>
>
>  > +{
>  > +     if test ! -d "$1"/.git
>  > +     then
>  > +             say "Submodule $1 is not initialized and skipped"
>  > +             return 1
>  > +     # Returns true if submodule is already initialized
>
>  Micronit; s/Returns/Return/.  A sentence that begins with a capitalized
>  verb in comments is almost always in imperative mood, not third-person
>  singular present.
>

Got it, thanks for the correction.

>
>  > +     elif test -d "$1"/.git
>  > +     then
>  > +             return 0
>  > +     fi
>  > +}
>
>  Otherwise, what does it return?  Do you need elif there, or just "else"?
>

Yup, else would be sufficient. Sorry for the mistake

>
>  > +# This function simply checks whether the depth is traverseable in terms of
>  > +# depth and if so then it sequentially traverses its submodules
>  > +traverse_submodules()
>  > +{
>  > +     # If current depth is the range specified than it will continue
>  > +     # else return with success
>  > +     if test "$depth" -gt 0 &&
>  > +             test "$current_depth" -ge "$depth"
>  > +     then
>  > +             return 0;
>  > +     fi
>  > +     # If submodules exists than it will traverse over them
>  > +     if test -f .gitmodules
>  > +     then
>  > +             # Incrementing the depth for the next level of submodules
>  > +             current_depth=$(($current_depth + 1))
>  > +                for mod_path in `sed -n -e 's/path = //p' .gitmodules`; do
>  > +                        traverse_module "$mod_path" "$@"
>  > +                done
>  > +             # Decremented the depth to bring it back to the depth of
>  > +             # the current submodule
>  > +             current_depth=$(($current_depth - 1))
>  > +     fi
>  > +}
>
>  This makes me wonder if you should be iterating over .gitmodules, or
>  perhaps you may want to iterate over output of git-ls-files (picking
>  entries of gitlink type).  How should a local change that adds a new
>  submodule or removes an existing submodule, or moves an existing submodule
>  interact with "submodule recurse"?

Actually once I am done with the recurse command I was planning to add
submodule mv and rm subcommands :). About the git-ls-files command yes
that is also an option, but in case of move it would require editing
.gitmodules and .git/config. AFAIK user need to currently manually
edit them for updating, hoping to write a shell script to get it done.

About it interacting with these changes, as long as the .gitmodules
file is updated correctly it should not be a problem, but if it
becomes inconsistent then it will chokes. In this regard, I checked
how 'git submodule update' works and it uses git-ls-fiiles --stage
with grep to find the gitlinks path and then search them through
.git/config, but it also faces the same problem if move is done
manually without changing the files. Also to be noted is the status
command also uses git-ls-files.

The reason why I did .gitsubmodule is I want to introduce auto-init
and update as an option, and plan to do it once the basic recurse
patches are accepted :). Then reading the .gitmodules would have been
necessary.

About the sed script another option would be to use -

git config -f ./.gitmodules --get-regexp '^submodule\..*\.path$' |
sed -n -e 's|^submodule\.\(.*\)\.path \(.*\)$|\2|p'

Will using this be preferable? I think so :).

>
>  Also the same micronits (s/Incrementing/Increment/; s/Decremented/Decrement/).
>
>  Even if iterating over .gitmodules entries is a good idea, I suspect that
>  sed script is too fragile.  Doesn't .gitmodules use the same format as git
>  configuration files, allowing spaces around values, value quoting and
>  trailing comments on the same line?

I agree on the fragile point and I think I will replace it with the
one I mentioned above.

>
>
>  > +# This actually traverses a submodule; checks whether the its initialized
>  > +# or not, does nothing if not initialized.
>
>  s/the //;?
>
>
>  > +traverse_module()
>  > +{
>  > +     # Will work in the submodule if and only if its initialized
>  > +     initialize_sub_module "$1" &&
>
>  "initialize_sub_module" does not sound like a function that checks if it
>  is initialized, but more like a function to, eh, initialize the submodule.
>  Perhaps the function should be renamed to make it clearer that it is a
>  predicate?

I thought of renaming it but I was a bit lazy as I am writing another
patch for auto initialize :).

>
>
>  > +     (
>  > +             submod_path="$1"
>  > +             shift
>  > +             cd "$submod_path"
>  > +             # If depth-first is specified in that case submodules are
>  > +             # are traversed before executing the command on this submodule
>  > +             test -n "$depth_first" && traverse_submodules "$@"
>  > +             # pwd is mentioned in order to enable the ser to distinguish
>  > +             # between same name modules, e.g. a/lib and b/lib.
>  > +             say "git submodule recurse $submod_path $*"
>  > +             git "$@"
>  > +             # if exit on error is specifed than script will exit if any
>  > +             # command fails. As there is no transaction there will be
>  > +             # no rollback either
>
>  s/than/then/;?
>
>
>  > +             # TODO - If possible facilitate transaction
>  > +             if test "$?" -ne 0 && test -n "$on_error"
>  > +             then
>  > +                     die "FAILED: git submodule $submod_path $*"
>
>  Dying before doing further damage to the repository tree may be a good
>  idea, but I did not see the calling loop in traverse_submodules pay
>  attention to the exit code from here.

Thanks for pointing out this bug, will fix it in the next version.

>
>
>  > +             fi
>  > +             # If depth-first is not specified in that case submodules are
>  > +             # are traversed after executing the command on this submodule
>  > +             test -z "$depth_first" && traverse_submodules "$@"
>  > +     )
>  > +}
>  > +
>  > +# Propagates or recurses over all the submodules at any depth with any
>  > +# git command, e.g. git-clone, git-status, git-commit etc., with the
>  > +# arguments supplied exactly as it would have been supplied to the command
>  > +# otherwise. This actually starts the recursive propagation.
>
>  Is "git-clone" a good example to give here?  What would that mean to
>  recurse into each submodule directories in a superproject to run "clone"?
>

I agree that git-clone is infact a bad example, will remove it :).

>
>  > +cmd_recurse() {
>  > +     while :
>  > +     do
>  > +             case "$1" in
>  > +             -q|--quiet)
>  > +                     quiet=1
>  > +                     ;;
>  > +             -d|--depth)
>  > +                     shift
>  > +                     if test -z "$1"
>  > +                     then
>  > +                             echo "No <recursion depth> specified"
>  > +                             usage
>  > +                     # Arithmatic operation will give an error if depth is not number
>  > +                     # thus chose to check intergerness with regular expression.
>  > +                     # $1 is underquoted becuase the expr is in quotation
>  > +                     elif test "$(expr $1 : '[1-9][0-9]*')" -eq "$(expr $1 : '.*')"
>
>  Huh?
>
>         $ a='1 2 3'
>         $ expr $a : '[1-9]'
>         expr: syntax error
>         $ expr "$a" : '[1-9]'
>         1
>         $ z=$(expr $a : '[1-9]')
>         expr: syntax error
>         $ z=$(expr "$a" : '[1-9]')
>         $ echo $z
>         1
>         $ echo "$(expr $a : '[1-9]')"
>         expr: syntax error
>         $ echo "$(expr "$a" : '[1-9]')"
>         1
>
>  If you want to make sure that $(( ... )) would not choke with given "$1",
>  you can check by attempting to do a simple $(( ... )) to see if it errors
>  out, which would be simpler.
>
>
>         if test -z "$1"
>         then
>                 ...
>         elif ! echo $(( "$1" + 0 )) >/dev/null
>         then
>                 die "$1 is not an integer"
>         ...

This was what I was looking for a simpler and cleaner way :), thanks a
lot Junio.

BTW: its nice to see your emails once again :).

Best regards,

Imran

>
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Mobile: +880-1711402557
