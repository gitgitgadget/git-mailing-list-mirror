From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update Japanese translation
Date: Sat, 15 Mar 2008 00:43:34 -0700
Message-ID: <7v4pb8o2jd.fsf@gitster.siamese.dyndns.org>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
 <20080315050840.GF8410@spearce.org>
 <7vlk4ko7px.fsf@gitster.siamese.dyndns.org>
 <20080315062734.GG8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 08:44:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaR4b-0002tU-VY
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 08:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbYCOHnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 03:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbYCOHnt
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 03:43:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYCOHnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 03:43:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82E9F2246;
	Sat, 15 Mar 2008 03:43:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8CAAC2244; Sat, 15 Mar 2008 03:43:38 -0400 (EDT)
In-Reply-To: <20080315062734.GG8410@spearce.org> (Shawn O. Pearce's message
 of "Sat, 15 Mar 2008 02:27:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77315>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Shawn, I think you guys should nail down the workflow right first, and
>> then mention the above a bit more prominently to avoid future accidents
>> like this.
>> 
>> It is perfectly fine if Peter regenerated the POT file for everybody as
>> the i18n coordinator, but the thing is, I think that regeneration should
>> have been done *before* you asked for translators to send in the
>> translation updates, not _after_ they have fetched from you in response to
>> your call for help and started working.
>
> Yes.  I clearly dropped the ball on that one.  I did try by asking
> for assistance _before_ a tagged release, but I failed to make sure
> the POT was up to date first.

After looking at the process and README once again, I think the problem
was not Peter's update to POT file itself.  Keeping POT up to date
relative to the software is absolutely necessary.  What was unwarranted
was that the same commit updated language files by running msgmerge before
checking if there is any outstanding translation work.  If we assume that
the translators do not have access to msgmerge, that is a good service to
them (the less they have to do, the better), but otherwise, it is better
to be leave po/${language}.po files alone.

How about doing something like this?

 po/README |   62 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/po/README b/po/README
index 9d8b736..8264079 100644
--- a/po/README
+++ b/po/README
@@ -178,18 +178,6 @@ step.
 
 	$ msgmerge -U po/af.po po/git-gui.pot
 
-[NEEDSWORK: who is responsible for updating po/git-gui.pot file by
-running xgettext?  IIRC, Christian recommended against running it
-nilly-willy because it can become a source of unnecessary merge
-conflicts.  Perhaps we should mention something like "
-
-The po/git-gui.pot file is updated by the internationalization
-coordinator from time to time.  You _could_ update it yourself, but
-translators are discouraged from doing so because we would want all
-language teams to be working off of the same version of git-gui.pot.
-
-" here?]
-
 This updates po/af.po (again, replace "af" with your language
 code) so that it contains msgid lines (i.e. the original) that
 your translation did not have before.  There are a few things to
@@ -207,3 +195,53 @@ watch out for:
 
  - New messages added to the software will have msgstr lines with empty
    strings.  You would need to translate them.
+
+The po/git-gui.pot file is updated by the internationalization
+coordinator from time to time.  You _could_ update it yourself, but
+translators are discouraged from doing so because we would want all
+language teams to be working off of the same version of git-gui.pot.
+
+****************************************************************
+
+This section is a note to the internationalization coordinator, and
+translators do not have to worry about it too much.
+
+The message template file po/git-gui.pot needs to be kept up to date
+relative to the software the translations apply to, and it is the
+responsibility of the internationalization coordinator.
+
+When updating po/git-gui.pot file, however, _never_ run "msgmerge -U
+po/xx.po" for individual language translations, unless you are absolutely
+sure that there is no outstanding work on translation for language xx.
+Doing so will create unnecessary merge conflicts and force needless
+re-translation on translators.  The translator however may not have access
+to the msgmerge tool, in which case the coordinator may run it for the
+translator as a service.
+
+But mistakes do happen.  Suppose a translation was based on an older
+version X, the POT file was updated at version Y and then msgmerge was run
+at version Z for the language, and the translator sent in a patch based on
+version X:
+
+         ? translated
+        /       
+    ---X---Y---Z (master)
+
+The coordinator could recover from such a mistake by first applying the
+patch to X, replace the translated file in Z, and then running msgmerge
+again based on the updated POT file and commit the result.  The sequence
+would look like this:
+
+    $ git checkout X
+    $ git am -s xx.patch
+    $ git checkout master
+    $ git checkout HEAD@{1} po/xx.po
+    $ msgmerge -U po/xx.po po/git-gui.pot
+    $ git commit -c HEAD@{1} po/xx.po
+
+State in the message that the translated messages are based on a slightly
+older version, and msgmerge was run to incorporate changes to message
+templates from the updated POT file.  The result needs to be further
+translated, but at least the messages that were updated by the patch that
+were not changed by the POT update will survive the process and do not
+need to be re-translated.
