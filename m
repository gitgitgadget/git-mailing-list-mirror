From: Alex Blewitt <Alex.Blewitt@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 9 Oct 2009 08:54:17 +0000 (UTC)
Message-ID: <loom.20091009T104530-586@post.gmane.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 10:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwBHj-0006ah-3j
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 10:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760282AbZJIIzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 04:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759785AbZJIIzb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 04:55:31 -0400
Received: from lo.gmane.org ([80.91.229.12]:40576 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZJIIz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 04:55:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MwBFS-0005YA-KJ
	for git@vger.kernel.org; Fri, 09 Oct 2009 10:54:50 +0200
Received: from 80.187.211.123 ([80.187.211.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 10:54:50 +0200
Received: from Alex.Blewitt by 80.187.211.123 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 10:54:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.187.211.123 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_8; en-gb) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129754>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> +URL Format
> +----------
> +
> +URLs for Git repositories accessed by HTTP use the standard HTTP
> +URL syntax documented by RFC 1738, so they are of the form:
> +
> +  http://<host>:<port>/<path>
> +
> +Within this documentation the placeholder $GIT_URL will stand for
> +the http:// repository URL entered by the end-user.

It's worth making clear here that $GIT_URL will be the path to the repository,
rather than necessarily just the host upon which the server sits. Perhaps
including an example, like http://example:8080/repos/example.git
would make it clearer that there can be a path (and so leading to
a request like http://example:8080/repos/example.git/info/refs?service=...

It's also worth clarifying, therefore, that multiple repositories can be served
by the same process (as with the git server today) by using different path(s).
And for those that are interested in submodules, it's worth confirming that
http://example/repos/master.git/child.git/info/refs?service= will ensure 
that the repository is the 'child' git rather than anything else.

> HEX = [0-9a-f]

Is there any reason not to support A-F as well in the hex spec, even if they
SHOULD use a-f? This may limit the appeal for some case-insensitive systems.

It would also be good to document, like with the git daemon, whether all
repositories under a path are exported or only those that have the magic
setting in the config like git-daemon-export-ok.

Lastly, it would be good to clarify when the result of this GET/POST exchange
is a text-based (and encoded in UTF-8) vs when binary data is returned; we 
don't want to get into the state where we're returning binary data and 
pretending that it's UTF-8.

Alex
