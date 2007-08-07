From: bdowning@lavos.net (Brian Downing)
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 09:58:25 -0500
Message-ID: <20070807145825.GO21692@lavos.net>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 16:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIQW8-0003Cq-FL
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 16:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbXHGO6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 10:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbXHGO6h
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 10:58:37 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:35414 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbXHGO6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 10:58:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AplZAJIluEZKhvbzRmdsb2JhbACBUoUkhxcBAQE1AQ
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 07 Aug 2007 10:58:35 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id E9934309F31; Tue,  7 Aug 2007 09:58:25 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070807143616.GO9527@spearce.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55262>

On Tue, Aug 07, 2007 at 10:36:16AM -0400, Shawn O. Pearce wrote:
> Now on a normal UNIX system open(2) *always* by definition does
> binary IO.  But Cygwin's text mount option tries to make UNIX
> programs DOS-friendly by making all files treated as text, even if
> it supposedly doing binary IO via open(2).
> 
> I think its a mis-feature of Cygwin.  Git has no way (that I know
> of) to defend itself from this, other than to tell the user to make
> sure they only store a Git repository in a location that is mounted
> with the binary flag.

Cygwin, like Windows' own open(2) simulation, defines an O_BINARY to pass
as a flag to open(2).  I once got Git half-working on Cygwin text-mode
mounts by doing a horrible hack approximating:

#define open(name, flag, ...) \
	open(name, (flag) | O_BINARY, ## __VA_ARGS__)

But it only half worked.  Eventually it managed to corrupt itself again,
and worse, the test suite was completely hopeless, as all shell activity
still results in text-mode files.

-bcd
