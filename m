From: Max Kirillov <max@max630.net>
Subject: per-repository and per-worktree config variables
Date: Wed, 18 Mar 2015 23:33:42 +0200
Message-ID: <20150318213342.GA25692@wheezy.local>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
 <54D79EAB.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLb1-00047r-VC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbbCRVdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:33:43 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:33024
	"EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755954AbbCRVdm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 17:33:42 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-02.prod.phx3.secureserver.net with 
	id 59Za1q00g5B68XE019ZgeY; Wed, 18 Mar 2015 14:33:42 -0700
Content-Disposition: inline
In-Reply-To: <54D79EAB.6060301@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265765>

On Sun, Feb 08, 2015 at 09:36:43AM -0800, Jens Lehmann wrote:
> I wonder if it's worth all the hassle to invent new names. Wouldn't
> it be much better to just keep a list of per-worktree configuration
> value names and use that inside the config code to decide where to
> find them for multiple work trees. That would also work easily for
> stuff like EOL-config and would push the complexity in the config
> machinery and not onto the user.

I actually thought about the same, and now tend to think
that most of config variables make sense to be per-worktree
in some cases. Only few variable must always be per
repository. I tried to summarize the variables which now
(in current pu) should be common, also listed all the rest
so somebody could scan through the list and spot anything I
could miss.

PS: some variables are with older case, they were mostly
collected before I got aware of their rename.

-- 
Max

Strictly common only
~~~~~~~~~~~~~~~~~~~~

Distributiveness
^^^^^^^^^^^^^^^^

A repository should behave same way regartdless of
which worktree is being accessed.

core.gitProxy::
core.askpass::
credential.helper::
credential.useHttpPath::
credential.username::
credential.<url>.*::
fetch.fsckObjects::
fetch.prune::
gitcvs.*::
gitweb.*::
gui.pruneduringfetch::
http.*::
push.followTags::
receive.*::
remote.<name>.*::
remotes.<group>::
transfer.fsckObjects::
transfer.hiderefs::
uploadarchive.allowUnreachable::
uploadpack.*::
url.<base>.insteadOf::
url.<base>.pushInsteadOf::
imap.*::

Repository storage options
^^^^^^^^^^^^^^^^^^^^^^^^^^

There should be same options of purging, compression etc.

core.compression::
core.loosecompression::
core.packedGitWindowSize::
core.packedGitLimit::
core.deltaBaseCacheLimit::
core.bigFileThreshold::
core.fsyncobjectfiles::
core.createObject::
core.logAllRefUpdates::
core.protectHFS::
core.protectNTFS::
fetch.unpackLimit::
fsck.skipList::
fsck.error::
fsck.warn::
fsck.ignore::
gc.*
pack.*
repack.*

Branch tracking settings
^^^^^^^^^^^^^^^^^^^^^^^^

Since branch are shared, they should be tracked same way
regardless of where are they updated.

branch.<name>.remote::
branch.<name>.pushremote::
branch.<name>.merge::
branch.<name>.mergeoptions::
branch.<name>.rebase::

Notes handling
^^^^^^^^^^^^^^

I don't know much about notes, and not sure about these ones, but notes looks
like a part of common history, and the options affect all of them.

notes.rewrite.<command>::
notes.rewriteMode::
notes.rewriteRef::

Misc
^^^^

core.preferSymlinkRefs::
	As description says, useful mostly for older scripts, which definitely
	not going to understand the new format. Probably incompatible with
	multiple worktrees at all.
core.repositoryFormatVersion::
	Looks like this is not used.
init.templatedir::
	This makes sense only as a global option.

Prefer common
~~~~~~~~~~~~~

Technically can be used per-worktree, but does not seem to have much sense.

Many of them are are actualy expected to be global.

advice.*::
core.ignorecase::
core.precomposeunicode::
core.trustctime::
core.checkstat::
core.quotepath::
core.symlinks::
core.ignoreStat::
core.warnAmbiguousRefs::
core.attributesfile::
	This should be common if it names tracked file.
core.editor::
core.commentchar::
sequence.editor::
core.pager::
core.preloadindex::
alias.*::
browser.<tool>.path::
color.branch::
color.diff::
color.diff.<slot>::
color.decorate.<slot>::
color.grep::
color.grep.<slot>::
color.interactive::
color.interactive.<slot>::
color.pager::
color.showbranch::
color.status::
color.status.<slot>::
color.ui::
color.branch.<slot>::
column.*::
commit.cleanup::
commit.gpgsign::
commit.status::
commit.template::
difftool.*::
fetch.recurseSubmodules::
	Since submodules can differ, this also can.
gui.commitmsgwidth::
gui.diffcontext::
gui.encoding::
	While in theory possible to use per-workree value, probably this is intended
	to correspond to the actual data in repository. Not sure though.
gui.trustmtime::
gui.spellingdictionary::
help.*
i18n.commitEncoding::
i18n.logOutputEncoding::
index.version::
instaweb.*::
mailmap.*::
man.*::
mergetool.*::
pager.*::
sendemail.*::
tar.umask::
user.email::
user.name::
user.signingkey::
web.browser::
mailinfo.scissors::

Ok to be per-worktree
~~~~~~~~~~~~~~~~~~~~~

core.fileMode::
core.eol::
core.safecrlf::
core.autocrlf::
core.bare::
core.worktree::
core.excludesfile::
core.whitespace::
core.notesRef::
core.sparseCheckout::
core.abbrev::
add.ignore-errors::
add.ignoreErrors::
am.keepcr::
apply.ignorewhitespace::
apply.whitespace::
branch.autosetupmerge::
branch.autosetuprebase::
clean.requireForce::
format.*::
filter.*::
	For some worktrees it may be desired to have them unsmudged.
grep.*::
gpg.program::
gui.displayuntracked::
gui.matchtrackingbranch::
gui.newbranchtemplate::
gui.fastcopyblame::
gui.copyblamethreshold::
gui.blamehistoryctx::
guitool.*
interactive.singlekey::
log.*::
notes.displayRef::
pretty.<name>::
pull.ff::
pull.rebase::
pull.octopus::
pull.twohead::
push.default::
rebase.stat::
rebase.autosquash::
rebase.autostash::
remote.pushdefault::
rerere.*::
showbranch.*::
status.*::
submodule.*::
tag.sort::
diff.*::
	not sure about  "diff.<driver>" commands, but I could imagine cases when it is desirable
merge.*::
	not sure about  "merge.<driver>" commands, but I could imagine cases when it is desirable
versionsort.prereleaseSuffix::
