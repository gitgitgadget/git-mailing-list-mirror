From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add completion for 'git grep'
Date: Sat, 2 Aug 2008 14:05:25 -0700
Message-ID: <20080802210525.GD24723@spearce.org>
References: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:06:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOJ0-0000Qv-TR
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYHBVF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYHBVF0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:05:26 -0400
Received: from george.spearce.org ([209.20.77.23]:55845 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYHBVF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:05:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 90D4338420; Sat,  2 Aug 2008 21:05:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91180>

Lee Marlow <lee.marlow@gmail.com> wrote:
> +_git_grep ()
> +{
> +	__git_has_doubledash && return
> +
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "
> +			--cached
> +			--text --ignore-case --word-regexp --invert-match
> +			--full-name
> +			--extended-regexp --basic-regexp --fixed-strings
> +			--files-with-matches --name-only
> +			--files-without-match
> +			--count
> +			--and --or --not --all-match
> +			"
> +		return
> +		;;
> +	esac
> +	COMPREPLY=()
> +}


Hmm.  The has_doubledash test seems redundant since we don't do
anything with args that aren't --foo.  Even though git-grep will
accept a tree-ish and thus completion of __git_refs here may
make sense.

I wonder if we shouldn't just add to the end something like:

	__gitcomp "$(__git_refs)"

like the _git_reset function does.  Then we can complete a tree-ish
for searching, as well as honor -- to stop tree-ish completion and
go back to file/directory completion.

But that is very much a user question.  Do users mostly search a
file in the current working directory, or do they mostly search
a tree-ish?

-- 
Shawn.
