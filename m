From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: Make default smarter by considering user's desktop environment and editor
Date: Wed, 6 Jun 2007 17:20:31 -0400
Message-ID: <20070606212031.GD9708@thunk.org>
References: <466637E2.5040303@freedesktop.org> <7vabvd7bfg.fsf@assigned-by-dhcp.cox.net> <86tztljwgk.fsf@lola.quinscape.zz> <7vabvd5u7t.fsf@assigned-by-dhcp.cox.net> <86lkexjua3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2w6-000728-Kv
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933873AbXFFVUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934915AbXFFVUs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:20:48 -0400
Received: from thunk.org ([69.25.196.29]:43043 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934668AbXFFVUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:20:47 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Hw33F-0007s4-UH; Wed, 06 Jun 2007 17:28:22 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Hw2vf-00088l-5k; Wed, 06 Jun 2007 17:20:31 -0400
Content-Disposition: inline
In-Reply-To: <86lkexjua3.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49316>

This is what I've been experimenting in my tree; what do people think?

if test -z "$merge_tool" ; then
    if test -n "$DISPLAY"; then
	merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
	if test "$GNOME_DESKTOP_SESSION_ID"x != ""x; then
	    merge_tool_candidates="meld $merge_tool_candidates"
	fi
	if test "$KDE_FULL_SESSION"x = "true"x; then
	    merge_tool_candidates="kdiff3 $merge_tool_candidates"
	fi
    fi
    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
	merge_tool_candidates="$merge_tool_candidates emerge"
    fi
    if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
	merge_tool_candidates="$merge_tool_candidates vimdiff"
    fi
    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
    echo "merge tool candidates: $merge_tool_candidates"
    for i in $merge_tool_candidates; do
	if test $i = emerge ; then
	    cmd=emacs
	else
	    cmd=$i
	fi
	if type $cmd > /dev/null 2>&1; then
	    echo merge_tool chosen is $i
	    merge_tool=$i
	    break
	fi
    done
fi

						- Ted
