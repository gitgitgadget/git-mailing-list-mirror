From: Jeff King <peff@peff.net>
Subject: Re: valgrind test script integration
Date: Sat, 12 Jan 2008 06:36:09 -0500
Message-ID: <20080112113608.GB24589@coredump.intra.peff.net>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <200801120926.14307.ismail@pardus.org.tr> <7vejcnwl85.fsf@gitster.siamese.dyndns.org> <200801120947.48602.ismail@pardus.org.tr> <20080112090432.GA6134@coredump.intra.peff.net> <20080112111044.GA24257@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 12:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDefI-00024g-WB
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 12:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762827AbYALLgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 06:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762742AbYALLgM
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 06:36:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762727AbYALLgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 06:36:12 -0500
Received: (qmail 6736 invoked by uid 111); 12 Jan 2008 11:36:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 12 Jan 2008 06:36:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2008 06:36:09 -0500
Content-Disposition: inline
In-Reply-To: <20080112111044.GA24257@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70309>

On Sat, Jan 12, 2008 at 06:10:44AM -0500, Jeff King wrote:

>  - We only catch calls to 'git', not 'git-foo' (and in fact for that
>    reason this doesn't catch the t7300 bug by itself, since that uses
>    git-clean). A follow-on patch will deal with this.

And here it is.

This replaces all usage of "git-foo" with "git foo" in the
test scripts. The replacement was done semi-manually; a
fully automatic replacement won't work because the pattern
"git-" appears in several other contexts (e.g.,
"--git-dir=", ref names, filenames, etc).

Obviously another route would be intercepting git-* calls,
as well, but my impression is that we are ultimately heading
towards a "git foo is the right way" situation, in which
case this cleanup is eventually necessary anyway.

[the original got eaten by the list since the patch is almost 150K;
 the diffstat is below, and I am making the patch available at

   git://repo.or.cz/git/peff.git master
]

 t/t1400-update-ref.sh                  |   10 +-
 t/t2005-checkout-index-symlinks.sh     |    4 +-
 t/t2050-git-dir-relative.sh            |    4 +-
 t/t2102-update-index-symlinks.sh       |    2 +-
 t/t2200-add-update.sh                  |   12 +-
 t/t3020-ls-files-error-unmatch.sh      |    2 +-
 t/t3030-merge-recursive.sh             |   14 +-
 t/t3200-branch.sh                      |   16 +-
 t/t3210-pack-refs.sh                   |    4 +-
 t/t3400-rebase.sh                      |    6 +-
 t/t3401-rebase-partial.sh              |   20 +-
 t/t3500-cherry.sh                      |   12 +-
 t/t3600-rm.sh                          |    4 +-
 t/t3800-mktag.sh                       |    8 +-
 t/t3900-i18n-commit.sh                 |    6 +-
 t/t3901-i18n-patch.sh                  |   16 +-
 t/t4012-diff-binary.sh                 |    2 +-
 t/t4103-apply-binary.sh                |   26 ++--
 t/t5300-pack-object.sh                 |   14 +-
 t/t5301-sliding-window.sh              |    4 +-
 t/t5302-pack-index.sh                  |   10 +-
 t/t5400-send-pack.sh                   |   30 ++--
 t/t5401-update-hooks.sh                |    4 +-
 t/t5402-post-merge-hook.sh             |    4 +-
 t/t5403-post-checkout-hook.sh          |    4 +-
 t/t5500-fetch-pack.sh                  |    4 +-
 t/t5510-fetch.sh                       |    2 +-
 t/t5530-upload-pack-error.sh           |    4 +-
 t/t5600-clone-fail-cleanup.sh          |    6 +-
 t/t6006-rev-list-format.sh             |    6 +-
 t/t6025-merge-symlinks.sh              |   32 ++--
 t/t6026-merge-attr.sh                  |   12 +-
 t/t6030-bisect-porcelain.sh            |    2 +-
 t/t6120-describe.sh                    |   30 ++--
 t/t6300-for-each-ref.sh                |   28 ++--
 t/t7001-mv.sh                          |   12 +-
 t/t7003-filter-branch.sh               |   18 +-
 t/t7004-tag.sh                         |  316 ++++++++++++++++----------------
 t/t7101-reset.sh                       |    6 +-
 t/t7300-clean.sh                       |   38 ++--
 t/t7400-submodule-basic.sh             |   46 +++---
 t/t7501-commit.sh                      |   44 +++---
 t/t9100-git-svn-basic.sh               |   44 +++---
 t/t9101-git-svn-props.sh               |   62 +++---
 t/t9102-git-svn-deep-rmdir.sh          |    6 +-
 t/t9104-git-svn-follow-parent.sh       |   36 ++--
 t/t9105-git-svn-commit-diff.sh         |    8 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   12 +-
 t/t9107-git-svn-migrate.sh             |   16 +-
 t/t9108-git-svn-glob.sh                |    4 +-
 t/t9110-git-svn-use-svm-props.sh       |    8 +-
 t/t9111-git-svn-use-svnsync-props.sh   |    8 +-
 t/t9112-git-svn-md5less-file.sh        |    4 +-
 t/t9116-git-svn-log.sh                 |    4 +-
 t/t9119-git-svn-info.sh                |  120 ++++++------
 t/t9200-git-cvsexportcommit.sh         |   10 +-
 t/t9300-fast-import.sh                 |   64 ++++----
 t/t9400-git-cvsserver-server.sh        |   30 ++--
 58 files changed, 640 insertions(+), 640 deletions(-)
