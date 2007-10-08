From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Mon, 8 Oct 2007 17:57:29 -0400
Message-ID: <20071008215729.GC31713@thunk.org>
References: <11918785613855-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If0bf-0004eY-UX
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 23:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbXJHV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbXJHV5c
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 17:57:32 -0400
Received: from THUNK.ORG ([69.25.196.29]:44089 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbXJHV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 17:57:32 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1If0lA-00012K-OL; Mon, 08 Oct 2007 18:07:32 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1If0bR-0004lG-B5; Mon, 08 Oct 2007 17:57:29 -0400
Content-Disposition: inline
In-Reply-To: <11918785613855-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60343>

On Mon, Oct 08, 2007 at 11:22:40PM +0200, Steffen Prohaska wrote:
> This commit adds a mechanism to provide absolute paths to the
> commands called by 'git mergetool'. A path can be specified
> in the configuation variable merge.<toolname>path.

This patch doesn't work the config file doesn't specify an explicit
mergetool via merge.tool.   The reason for that is this loop:

    for i in $merge_tool_candidates; do
        if test $i = emerge ; then
            cmd=emacs
        else
            cmd=$i
        fi
        if type $cmd > /dev/null 2>&1; then
            merge_tool=$i
            break
        fi
    done

is only checking to see if $cmd is in the path; it's not looking up
the merge.<toolname>path variable in this loop.

I guess the other question is whether we would be better off simply
telling the user to specify an absolute pathname in merge.tool, and
then having git-mergetool strip off the directory path via basename,
and then on window systems, stripping off the .EXE or .COM suffix, and
then downcasing the name so that something like "C:\Program
Files\ECMerge\ECMerge.exe" gets translated to "ecmerge".  Would I be
right in guessing that the reason why you used merge.<toolname>path
approach was to avoid this messy headache?

					- Ted
