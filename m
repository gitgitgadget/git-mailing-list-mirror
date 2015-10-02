From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Fri, 2 Oct 2015 23:06:49 +0300
Message-ID: <20151002200649.GE26154@wheezy.local>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
 <33b74e875c7298f67640f5850e88c152@dscho.org>
 <20151002190646.GC26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 22:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi6bb-0004iV-76
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbbJBUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 16:06:55 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:44549
	"EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbbJBUGy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2015 16:06:54 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-04.prod.phx3.secureserver.net with 
	id QL6q1r0035B68XE01L6sqJ; Fri, 02 Oct 2015 13:06:54 -0700
Content-Disposition: inline
In-Reply-To: <20151002190646.GC26154@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278944>

On Fri, Oct 02, 2015 at 10:06:46PM +0300, Max Kirillov wrote:
> for i in $(seq 1000)
> t_git -c core.packedGitWindowSize=100 log

It was 32-bit build.
I cannot promise those exactly numbers will work, because I don not clearly
understand what do they mean. With 100 commits the pack size was 20K, but it
was mapped fully with the window=100.

But I believe with the same build same numbers should reproduce the issue.

For 32-bit builds I can see it on any significantly big repository, like the
git itself. Maybe for 64bit it is less likely.

The code which decides whether to close the pack is in use_pack() in sha1_file.c:
-----------
                        if (!win->offset && win->len == p->pack_size
                                && !p->do_not_close) {
                                close(p->pack_fd);
                                pack_open_fds--;
                                p->pack_fd = -1;
                        }
-----------
