From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: removal of "percent done" messages from git pull
Date: Mon, 19 Feb 2007 16:12:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D5E06B.6020706@lightspeed.com> <tnxr6sm5m2u.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 16:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJABn-00060n-0j
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 16:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXBSPMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 10:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbXBSPMW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 10:12:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37050 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932330AbXBSPMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 10:12:22 -0500
Received: (qmail invoked by alias); 19 Feb 2007 15:12:21 -0000
X-Provags-ID: V01U2FsdGVkX18/0SkH+CU/YaiGUX+zFXRiteDcyadm9x+VBrn+T/
	3qzw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <tnxr6sm5m2u.fsf@arm.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40131>

Hi,

On Mon, 19 Feb 2007, Catalin Marinas wrote:

> Larry Streepy <larry@lightspeed.com> wrote:
> > I run a nightly script to build and test our product.  I capture all
> > the output and email it to interested parties.  One very annoying
> > thing is the "percent done" messages that come out of git pull.  It
> > results in log files that look like this:
> [...]
> > I have found no way to make these messages go away.  When running in a
> > "batch" mode, IMHO, interactive messages like these should not be
> > emitted. At least there should be a switch to suppress them.
> 
> Or (as done in StGIT for some messages), only print those interactive
> messages when stdout is a tty, i.e. "if (isatty(1))".

You mean something like this?

--
[PATCH] fetch: make things quiet when not outputting to a tty

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 fetch-pack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index c787106..9ec5479 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -725,6 +725,8 @@ int main(int argc, char **argv)
 		nr_heads = argc - i - 1;
 		break;
 	}
+	if (!verbose && !isatty(1))
+		quiet = 1;
 	if (!dest)
 		usage(fetch_pack_usage);
 	pid = git_connect(fd, dest, uploadpack);
