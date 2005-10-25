From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 25 Oct 2005 16:42:45 +0200
Message-ID: <200510251642.46169.blaisorblade@yahoo.it>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mRkXDqJgVkHVs3I"
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 16:40:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUPx1-0007mI-ET
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 16:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVJYOin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 10:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJYOin
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 10:38:43 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:11104 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932167AbVJYOim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 10:38:42 -0400
Received: (qmail 18588 invoked from network); 25 Oct 2005 14:38:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=N7MpiNDZqSH+L7kYkUNPqxI74r5TDYvaeJyixyJgAO3HA03xb83MiUJBxCe0Xchm54flkhEUYbyFWz5GMSVAOq/MADoWbkbZhVWkuFrR90/8G3Itq0ebsHw7uJIre0ii4U4E/lGLAAVSA8XwYEVGXlMQwIhsW79xppxhSPdZ/G8=  ;
Received: from unknown (HELO ?151.97.230.22?) (blaisorblade@151.97.230.22 with login)
  by smtp003.mail.ukl.yahoo.com with SMTP; 25 Oct 2005 14:38:40 -0000
To: Ben Clifford <benc@hawaga.org.uk>
User-Agent: KMail/1.8.3
In-Reply-To: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10589>

--Boundary-00=_mRkXDqJgVkHVs3I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 October 2005 14:24, Ben Clifford wrote:
> hi. I'm interested in playing with the stg/git commandline completion code
> - are you still actively working on it?
Well, yes, I've been still tuning it - but actually I'm not _maintaining_ it, 
I'm using stgit on the Linux kernel so when on a command I don't have tab 
completion I add the needed one (having the time and feeling to do it).

However, it's still done with enough care and polish to be shippable.

> if so, do you have any more 
> formalised distribution process (like a git repo!) rather than grabbing
> code out of email list postings? I can't seem to find much on google...
Well, Catalin's TODO included "bash completions", so I assume the thing could 
be merged by him. Anyway,

I'm attaching the current version.

Btw, it's under GPL v2.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_mRkXDqJgVkHVs3I
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

_stg_range()
{
    #Ugly - should return the result rather than set COMPREPLY.
    local cur=$1 patches=$2
    if [ "${cur#*:}" != "${cur}" ]; then
	# Complete the 2nd range component, after ':'.
	COMPREPLY=( $(compgen -W "${patches}" -- ${cur#*:}) )
    else
	COMPREPLY=( $(compgen -W "${patches}" -- $cur) )
    fi
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
		_stg_range "$cur" "$(__stg_unapplied)"
#		if [ "${cur#*:}" != "${cur}" ]; then
#		    COMPREPLY=( $(compgen -W "$(__stg_unapplied)" -- ${cur#*:}) )
#		else
#		    COMPREPLY=( $(compgen -W "$(__stg_unapplied)" -- $cur) )
#		fi
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

	    export)
	    if [ "$prev" = "-r" -o "$prev" = "--range" ]; then
		_stg_range "$cur" "$(__stg_applied)"
	    else
		opts="-n --numbered -d --diff -t --template -r --range \
		$o_branch $o_help"

		COMPREPLY=( $(compgen $default -W "${opts}" -- $cur) )
	    fi
	    ;;
	    mail)
	    if [ "$prev" = "-r" -o "$prev" = "--range" ]; then
		_stg_range "$cur" "$(__stg_applied)"
#		if [ "${cur#*:}" != "${cur}" ]; then
#		    COMPREPLY=( $(compgen -W "$(__stg_applied)" -- ${cur#*:}) )
#		else
#		    COMPREPLY=( $(compgen -W "$(__stg_applied)" -- $cur) )
#		fi
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

--Boundary-00=_mRkXDqJgVkHVs3I--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
