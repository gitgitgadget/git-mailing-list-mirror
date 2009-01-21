From: chadrik <chadrik@gmail.com>
Subject: read-only working copy using symlinks to blobs
Date: Wed, 21 Jan 2009 00:15:11 -0800 (PST)
Message-ID: <21578696.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 09:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYGL-0002a4-H5
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbZAUIPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZAUIPN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:15:13 -0500
Received: from kuber.nabble.com ([216.139.236.158]:32930 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbZAUIPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:15:11 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LPYEx-0000pv-1J
	for git@vger.kernel.org; Wed, 21 Jan 2009 00:15:11 -0800
X-Nabble-From: chadrik@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106574>


hi all,
i'm looking into using git to manage a lot of very large binary data.  git
seems particularly suited to this task because it has features for saving
disk space such as clone--shared, and it's fast due to simple compression by
default (instead of deltas).

in my mind, there's still one major feature for working with large binaries
that has not been addressed:  the ability to check out symbolic/hard links
to blobs into the working copy instead of creating duplicates of the files.

imagine a scenario where one user is putting large binary files into a git
repo.  100 other users need read-only access to this repo.  they clone the
repo shared, which saves disk space for the object files, but each of these
100 working copies also creates copies of all the binary files at the HEAD
revision. it would be 100x as efficient if, in place of these files,
symbolic or hard links were made to the blob files in .git/objects.  

the crux of the issue is that the blob objects would have to be stored as
exact copies of the original files.  i did some googling and it would seem
there are two things that currently prevent this from happening.  1) blobs
are stored with compression and 2) they include a small header.  compression
can be disabled by setting core.loosecompression to 0, so that seems like
less of an issue.  as for the header, wouldn't it be possible to store it as
a separate file per blob object and thus keep the original data completely
pristine? 

what are the caveats to a system like this?  any thoughts on the
feasibility?

-chad


-- 
View this message in context: http://www.nabble.com/read-only-working-copy-using-symlinks-to-blobs-tp21578696p21578696.html
Sent from the git mailing list archive at Nabble.com.
