From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: StGit command completions - and Git ones?
Date: Tue, 4 Oct 2005 11:57:50 +0200
Message-ID: <200510041157.50747.blaisorblade@yahoo.it>
References: <200510021303.44960.blaisorblade@yahoo.it> <b0943d9e0510040023h287b9d44w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eIlQDC1v4MRbT3s"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 11:59:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMjYW-0003gm-2t
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 11:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVJDJ5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVJDJ5t
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 05:57:49 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:37455 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751205AbVJDJ5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 05:57:48 -0400
Received: (qmail 711 invoked from network); 4 Oct 2005 09:57:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=tW/QHi96vxOMwts5o2055O88o/TeKj81N7QiifAMIB2EELLSeYg1PxBsswHVHEx/l632cILTagyvsjUsqByIc8CZn62aNCqEGZzIuz0a7i79TcoIahQajaHQuNEmA2eC+bNYBO5kHzxvOlUj93WEeRv99JqJu4N7ieKPMoHEKyE=  ;
Received: from unknown (HELO ?151.97.230.22?) (blaisorblade@82.89.148.157 with login)
  by smtp005.mail.ukl.yahoo.com with SMTP; 4 Oct 2005 09:57:45 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.2
In-Reply-To: <b0943d9e0510040023h287b9d44w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9672>

--Boundary-00=_eIlQDC1v4MRbT3s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 04 October 2005 09:23, Catalin Marinas wrote:
> On 02/10/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > I noticed in your TODO you talk about adding command line completions.
> > I've been doing it for my needs, and the thing is still very incomplete,
> > even if it's not a "XXX hack hack hack", and I wanted to send this first
> > draft.
>
> Thanks, I will have a look at it.
If you haven't yet, here's today's version.
> FYI, the tla-contrib package has a script which automatically
> generates the bash completion script from the help messages (well,
> only for tla, but can be adapted).
Yes, I wanted to do something like that to speed things up...

if possible, I'd also like to generate option lists from help messages but 
that doesn't seem so obvious (not much thought on this, though).

Finally, I'd like to reimplement directly stg applied and unapplied, since 
they reduce to trivial "cat"...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_eIlQDC1v4MRbT3s
Content-Type: text/plain;
  charset="iso-8859-1";
  name="stg-compl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stg-compl"

#Stacked git bash completion.

#TODO:
# My opinion about bash completion is that they're excessively slow, especially
# when the system is under load.
#
# So:
# - save the list of stg commands in a file, created at install moment; on an
# idle Athlon 64 laptop at 800MHz, stg help takes 0.22 seconds of CPU time,
# without disk I/O.
#
# - read .git/patches/$branch/{applied,unapplied} directly instead of invoking
# stg.
#

#XXX: must test for bash version, done in generic bash-completion and the
#generic value can be seen from here, if we are included by the loop at the end
#of /etc/bash_completion, i.e. if we're installed in /etc/bash-completion.d.
#
#Gentoo should be fixed to allow this.

bashdefault="-o bashdefault"
default="-o default"

#XXX: not StGit specific, valid for git too.
__git_refs()
{
    for i in $(echo .git/refs/heads/*); do
	echo ${i#.git/refs/heads/}
    done
    for i in $(echo .git/refs/tags/*); do
	echo ${i#.git/refs/tags/}
    done
    echo HEAD
}

__stg_unapplied()
{
    stg unapplied 2>/dev/null $@
}

__stg_applied()
{
    stg applied 2>/dev/null $@
}

__stg_all_patches()
{
    __stg_applied $@; __stg_unapplied $@
}

#XXX: Find a better name for this.
#
__stg_all_patch_ranges()
{
    __stg_all_patches $@|while read i; do echo $i/; done
}

__stg_top()
{
    stg top 2>/dev/null $@
}

__stg_branches()
{
    #for i in $(compgen -f .git/patches/); do
    for i in $(echo .git/patches/*); do
	echo ${i#.git/patches/}
    done
}

_stg ()
{
    local cur cmd cmds opts
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=()
    if [ $COMP_CWORD -eq 1 ]; then
	cmds=$(stg help|tail +4|awk '{print $1}')
	COMPREPLY=( $(compgen -W "${cmds}" -- $cur) )
    else
	local cmd=${COMP_WORDS[1]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}
	local o_help="-h --help"
	local o_branch="-b --branch"
	#XXX: Add -b support - pass "-b branch" to unapplied and applied.
	#This can be done by calling __stg_unapplied directly below
	#instead of setting patches here.
	#But: how to look for -b? I'm scared about looping over opts
	#(I don't like completions when they take so much time).
	case $cmd in
	    push)
	    if [ "$prev" = "-t" -o "$prev" = "--to" ]; then
		if [ "${cur#*:}" != "${cur}" ]; then
		    # Complete the 2nd range component, after ':'.
		    COMPREPLY=( $(compgen -W "$(__stg_unapplied)" -- ${cur#*:}) )
		else
		    COMPREPLY=( $(compgen -W "$(__stg_unapplied)" -- $cur) )
		fi
	    else
		opts="-a --all -n --number -t --to --reverse --undo $o_help"
		COMPREPLY=( $(compgen -W "${opts} $(__stg_unapplied)" -- $cur) )
	    fi
	    ;;

	    pop)
	    if [ "$prev" = "-t" -o "$prev" = "--to" ]; then
		COMPREPLY=( $(compgen -W "$(__stg_applied)" -- $cur) )
	    else
		opts="-a --all -n --number -t --to $o_help"
		COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
	    fi
	    ;;

	    mail)
	    if [ "$prev" = "-r" -o "$prev" = "--range" ]; then
		if [ "${cur#*:}" != "${cur}" ]; then
		    COMPREPLY=( $(compgen -W "$(__stg_applied)" -- ${cur#*:}) )
		else
		    COMPREPLY=( $(compgen -W "$(__stg_applied)" -- $cur) )
		fi
	    else
		opts="-a --all -r --range --to --cc --bcc -v --version \
		-t --template -f --first -s --sleep --refid -u --smtp-user \
		-p --smtp-password $o_branch $o_help"

		COMPREPLY=( $(compgen $bashdefault -W "${opts} \
		$(__stg_applied)" -- $cur) )
	    fi
	    ;;
	    diff)
	    if [ "$prev" = "-r" ]; then
		if [ "${cur#*:}" != "${cur}" ]; then
		    COMPREPLY=( $(compgen -W "$(__stg_all_patch_ranges)" -- \
		    ${cur#*:}) )
		else
		    COMPREPLY=( $(compgen -W "$(__stg_all_patch_ranges)" -- \
		    $cur) )
		fi
	    else
		opts="-r -s --stat $o_help"

		COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
	    fi
	    ;;
	    id)
	    if [ "$prev" = "-b" -o "$prev" = "--branch" ]; then
		COMPREPLY=( $(compgen -W "$(__stg_branches)" -- $cur) )
	    else
		opts="$o_branch $o_help"
		#there's a lot of possible id's to complete
		COMPREPLY=( $(compgen -W "${opts} $(__stg_all_patch_ranges) \
		$(__git_refs)" -- $cur) )
	    fi
	    ;;
	    rename)
	    if [ "$prev" = "-b" -o "$prev" = "--branch" ]; then
		COMPREPLY=( $(compgen -W "$(__stg_branches)" -- $cur) )
	    else
		COMPREPLY=( $(compgen -W "$(__stg_all_patches)" -- $cur) )
	    fi
	    ;;
	    delete)
	    opts="${o_help}"
	    COMPREPLY=( $(compgen -W "${opts} $(__stg_unapplied; __stg_top)" \
	    -- $cur) )
	    ;;
	    series|unapplied|applied)
	    if [ "$prev" = "-b" -o "$prev" = "--branch" ]; then
		COMPREPLY=( $(compgen -W "$(__stg_branches)" -- $cur) )
	    else
		opts="$o_branch $o_help"
		[ "$cmd" = "series" ] && \
		    opts="$opts -e --empty"
		COMPREPLY=( $(compgen -W "${opts}" -- $cur) )
	    fi
	    ;;
	    refresh)
	    opts="-f --force -e --edit -s --showpatch -m --message \
	    -a --author --authname --authemail --authdate --commname
	    --commemail $o_help"

	    COMPREPLY=( $(compgen $bashdefault -W "${opts}" -- $cur) )
	    ;;
	    *)
	    COMPREPLY=( $(compgen $bashdefault -W "${o_help}" -f -- $cur) )
	    ;;
	esac
    fi
}

complete $default -F _stg stg

# vi: set ft=sh sw=4:

--Boundary-00=_eIlQDC1v4MRbT3s--

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
