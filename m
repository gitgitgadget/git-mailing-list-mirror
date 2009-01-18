From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: fix off-by-path_len
Date: Sun, 18 Jan 2009 08:49:11 +0100
Organization: glandium.org
Message-ID: <20090118074911.GB30228@glandium.org>
References: <alpine.DEB.1.00.0901171632330.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org,
	gitster@pobox.com, Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 08:51:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOSQh-00079M-Sv
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 08:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbZARHtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 02:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758193AbZARHtY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 02:49:24 -0500
Received: from vuizook.err.no ([85.19.221.46]:60914 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837AbZARHtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 02:49:23 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOSP9-0001ow-RJ; Sun, 18 Jan 2009 08:49:14 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOSP9-0001PQ-4Q; Sun, 18 Jan 2009 08:49:11 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901171632330.3586@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106148>

On Sat, Jan 17, 2009 at 04:36:26PM +0100, Johannes Schindelin wrote:
> 
> When getting the result of remote_ls(), we were advancing the variable
> "path" to the relative path inside the repository.
> 
> However, then we went on to malloc a bogus amount of memory: we were
> subtracting the prefix length _again_, quite possibly getting something
> negative, which xmalloc() interprets as really, really much.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Note that the push in t5540 is still broken, as http-push does
> 	not handle packed-refs (when looking what branches are on the 
> 	remote side).
> 
> 	It should not even try to access the directory structure under
> 	refs/ to begin with, but read info/refs instead.

It would actually need to do both, because nothing guarantees info/refs
is up-to-date.

> 	However, that is just one example of the ugliness that is 
> 	http-push.c; it also seems to be a perfect example of a copy-pasting 
> 	hell; just look at the output of "git grep
> 	curl_easy_setopt http-push.c".

Likewise for http.c.

> 	There _has_ to be lot of room for improvement.

And I realize I have had a partial improvement on that sitting on my
harddrive, without me having time (nor motivation) to go further.

Maybe it's time I let it go and post the work in progress for someone
else to take over.

Mike
