From: Charles Bailey <charles@hashpling.org>
Subject: Re: Why does git-mergetool use /dev/tty?
Date: Tue, 24 Aug 2010 07:43:06 +0100
Message-ID: <20100824064306.GA18308@hashpling.org>
References: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 08:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnE6-0001QJ-JI
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 08:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab0HXGnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 02:43:11 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:32408 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab0HXGnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 02:43:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANMGc0zUnw4T/2dsb2JhbACgPXG5VIU3BA
Received: from outmx04.plus.net ([212.159.14.19])
  by relay.pcl-ipout02.plus.net with ESMTP; 24 Aug 2010 07:43:07 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx04.plus.net with esmtp (Exim) id 1OnnDv-0002ee-7p; Tue, 24 Aug 2010 07:43:07 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OnnDv-0004vd-0E; Tue, 24 Aug 2010 07:43:07 +0100
Content-Disposition: inline
In-Reply-To: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154297>

On Mon, Aug 23, 2010 at 09:49:57PM -0400, Brian Gernhardt wrote:
> git-mergetool.sh, lines 298-302:
> >     if test $last_status -ne 0; then
> >         prompt_after_failed_merge < /dev/tty || exit 1
> >     fi
> >     printf "\n"
> >     merge_file "$i" < /dev/tty > /dev/tty
> 
> Why does git-mergetool ignore the provided STDIN and STDOUT when not given a path to merge?

It doesn't deliberately ignore them, it merely loses them because what
you've quoted is in the middle of a redirect, you snipped:

    files_to_merge |
    while IFS= read i
    do  

mergetool is designed to be an interactive tool and didn't originally
have any tests so this was a reasonable (if ugly) way to restore
access to the user for the merge_file function.

This is also why all the previous test provided an explict list of
files to merge, because this was the only testable way to invoke
mergetool.

There's a proposed patch to save and restore the original stdin
instead of assuming that there is a tty in pu: af314714.

If the current behaviour is causing an issue for you then testing this
fix would be appreciated.

Thanks,

Charles.
