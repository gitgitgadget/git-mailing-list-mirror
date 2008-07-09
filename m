From: Jan Rychter <jan@rychter.com>
Subject: Idea: "live branches"?
Date: Wed, 09 Jul 2008 11:56:36 +0200
Message-ID: <m28wwbz8h7.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 18:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGcZR-0008D9-Ln
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 18:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYGIQaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 12:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbYGIQaL
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 12:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:37036 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbYGIQaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 12:30:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KGcYM-0006IH-PN
	for git@vger.kernel.org; Wed, 09 Jul 2008 16:30:02 +0000
Received: from bk-gw.rychter.com ([85.222.88.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 16:30:02 +0000
Received: from jan by bk-gw.rychter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 16:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: bk-gw.rychter.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (darwin)
Cancel-Lock: sha1:fM1qjOZHukdnmOwZO9mkXYAoR4Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87891>

I've been trying out a number of DVCS tools recently and finally found
that git is the best fit for me. There is one thing I found missing,
though.

The problem is that there are usually two distinct concepts:

-- topic branches, representing longer-term ongoing development in a
   certain direction, large-scale features, etc,
-- patches that represent complete functionality, to be committed
   upstream, but continuously improved.

My local repositories are usually a combination of both. I will often
have a number of feature patches that I don't want to push upstream just
yet. These patches change often. My topic branches will all want to use
them, in their latest form/revision. This is not a workflow that you can
easily represent with any of today's DVCS tools. One can do this with
careful cherry-picking and merging, but it is a lot of manual work and
clutters up history with lots of merge commits.

StGIT is *almost* there. It lets you manage a pile of patches, modify
them, apply them selectively, as well as update the mainstream
repository and reapply local patches. It fails in two ways: 1) when you
want to reuse the same patches on multiple branches. One-way migration
is doable (not pleasant, but doable), but if you modify a patch in one
of your branches, your other branches which use the same patch will not
see the change. And 2) StGIT patches are simple by design, and you can't
have internal commit history within a patch, which is a problem for
larger features.

Which brings me to my point. I think we need a system that can maintain
"live branches". We already have impressive systems for dealing with
patches and we have made the patch into a first-class citizen of our
software development world. Now, instead of statically tracking commits
and following a one-way development history, let's have live branches --
branches that can change, causing code that depends on them to change.

The way this would work is I would have one or two long-term development
branches, and each of those would depend on a list of "live branches",
managed by a tool similar to StGIT. I should be able to commit to either
the main development branch, or to one of the "live branches", in which
case I should be able to easily "resync" the main development branch (do
a merge or a rebase, but I would prefer the tool to first remove old
merge commits, so as not to clutter history). 

The tool should also let me pick a commit I've made and move it to one
of the live branches easily (similar to stgit).

Does this make sense, or am I missing something very obvious?

--J.

PS: I am obviously aware that this is something which is suitable for
local development work only.
