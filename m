From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Sun, 01 Feb 2009 13:33:44 -0800
Message-ID: <7vbptlsuyv.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7v63juzz9m.fsf@gitster.siamese.dyndns.org>
 <1233459475.17688.128.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:35:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTjyT-0006Df-Qn
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 22:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbZBAVd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 16:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZBAVd5
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 16:33:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbZBAVd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 16:33:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CA852A3EA;
	Sun,  1 Feb 2009 16:33:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E9842A3E7; Sun, 
 1 Feb 2009 16:33:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 064A7BFC-F0A8-11DD-BD97-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108007>

Sam Vilain <sam@vilain.net> writes:

> I just can't understand the
> resistance to this safety feature.  People who encounter the bug can
> just change the setting and move on... it seems like an argument based
> on "principles", usually a sign that one has run out of actual
> arguments..

There is no resitance to any safety feature.  The resistance is to
something entirely different.

The change we all share as the desired end result is to introduce a
different behaviour, even if it is a better one, that will deliberately
break people's working setup.

The end result being better does not justify breaking people's setup.  You
need to help people whose setups will be broken prepare for such a change.

Perhaps you already forgot the fiasco after 1.6.0, which moved tons of
git-foo scripts out of the users' way.  It resulted in a better layout in
the end, but we knew it would break people's working setup from the
beginning.

It was a change that many people argued for, saying that too many commands
in the path scared new people, that we thought we planned very carefully,
and that we thought we gave ample warning to existing users.  Yet it
resulted in a huge fallout.

You probably forgot about it already, but that is because you weren't the
one who had to take the flak.  I was, and I haven't forgotten.

The resistance is to an irresponsible transition strategy that causes pain
unnecessarily.  We need to improve the situation incrementally, helping
new people a bit in one step while not hurting old people along the way,
aiming to help everybody more in the end.

One of the concluding comments after the 1.6.0 fiasco was that the
old-timers _heard about_ the upcoming change, but were too busy to stop
and think to realize that it is any urgent that they need to prepare for
it, and we should have warned them more actively.  In the end, they didn't
mind the change itself per-se because we had an escape hatch (i.e. to
prepend the output from "git --exec-path" to the PATH in your script), but
the primary pain was having to adjust their setup on _our_ timetable, not
theirs.

Even k.org, which is one of the early adopters of new releases among the
larger sites (with larger proportion of old timers), has started using the
version with the "updating the branch you have checked out" warning (which
happened in v1.6.1) fairly recently, and during the discussion we noticed
that the warning didn't say we will be switching the default to "refuse"
any time soon.  We haven't yet given them enough advance warning telling
them they will have to go running around flipping the bit in their
repositories.  Dismissing the issue by saying "old-timers can simply flip
the configuration once" makes an irresponsible argument for repeating the
same mistake of 1.6.0.  That is what I am resisting to.

I think the plan outlined in this thread would ease the transition in much
better way, and the patch I sent yesterday uses a deliberately loooooooong
warning message whose primary purpose is to be annoyingly obvious that the
users need to adjust their configuration now, so that the eventual change
in the default we will make won't inconvenience them.

I was reluctant to change the default for new repositories to refuse
during 1.6.2 timeframe, but I think with the attached patch on top of the
second patch I sent out earlier, it would force people choose before they
do any real damange to their repositories, and having it early would make
the overall transition plan smoother.

 builtin-init-db.c      |    2 +-
 builtin-receive-pack.c |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git c/builtin-init-db.c w/builtin-init-db.c
index 26c10cc..ea2765c 100644
--- c/builtin-init-db.c
+++ w/builtin-init-db.c
@@ -251,7 +251,7 @@ static int create_default_files(const char *template_path)
 			git_config_set("core.worktree", work_tree);
 		}
 		if (!reinit)
-			git_config_set("receive.denyCurrentBranch", "refuse");
+			git_config_set("receive.denyCurrentBranch", "refuse-with-insn");
 	}
 
 	if (!reinit) {
diff --git c/builtin-receive-pack.c w/builtin-receive-pack.c
index f2c94fc..82d372f 100644
--- c/builtin-receive-pack.c
+++ w/builtin-receive-pack.c
@@ -16,6 +16,7 @@ enum deny_action {
 	DENY_IGNORE,
 	DENY_WARN,
 	DENY_REFUSE,
+	DENY_REFUSE_WITH_INSN,
 };
 
 static int deny_deletes = 0;
@@ -39,6 +40,8 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 			return DENY_WARN;
 		if (!strcasecmp(value, "refuse"))
 			return DENY_REFUSE;
+		if (!strcasecmp(value, "refuse-with-insn"))
+			return DENY_REFUSE_WITH_INSN;
 	}
 	if (git_config_bool(var, value))
 		return DENY_REFUSE;
@@ -236,6 +239,20 @@ static char *warn_unconfigured_deny_msg[] = {
 	"configuration variable set to either 'ignore' or 'warn'."
 };
 
+static char *refuse_current_insn_msg[] = {
+	"By default, updating the current branch in a non-bare repository",
+	"is denied, because it will make the index and work tree inconsistent",
+	"with what you pushed, and will require 'git reset --hard' to match",
+	"the work tree to HEAD.",
+	"",
+	"You can set 'receive.denyCurrentBranch' configuration variable to",
+	"'ignore' or 'warn' in the repository to allow pushing into the",
+	"current branch of it; this is not recommended unless you really know",
+	"what you are doing.",
+	"",
+	"To squelch this message, you can set it to 'refuse'.",
+};
+
 static void warn_unconfigured_deny(void)
 {
 	int i;
@@ -243,6 +260,12 @@ static void warn_unconfigured_deny(void)
 		warning(warn_unconfigured_deny_msg[i]);
 }
 
+static void refuse_current_insn(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(refuse_current_insn_msg); i++)
+		error(refuse_current_insn_msg[i]);
+}
 
 static const char *update(struct command *cmd)
 {
@@ -268,7 +291,10 @@ static const char *update(struct command *cmd)
 				warn_unconfigured_deny();
 			break;
 		case DENY_REFUSE:
+		case DENY_REFUSE_WITH_INSN:
 			error("refusing to update checked out branch: %s", name);
+			if (deny_current_branch == DENY_REFUSE_WITH_INSN)
+				refuse_current_insn();
 			return "branch is currently checked out";
 		}
 	}
