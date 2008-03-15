From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update Japanese translation
Date: Fri, 14 Mar 2008 22:51:38 -0700
Message-ID: <7vlk4ko7px.fsf@gitster.siamese.dyndns.org>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
 <20080315050840.GF8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 06:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaPKF-0000IV-ME
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 06:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbYCOFvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 01:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbYCOFvy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 01:51:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYCOFvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 01:51:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 03FF6239A;
	Sat, 15 Mar 2008 01:51:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 77D232399; Sat, 15 Mar 2008 01:51:46 -0400 (EDT)
In-Reply-To: <20080315050840.GF8410@spearce.org> (Shawn O. Pearce's message
 of "Sat, 15 Mar 2008 01:08:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77311>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>>  "Report-Msgid-Bugs-To: \n"
>> -"POT-Creation-Date: 2007-11-24 10:36+0100\n"
>> -"PO-Revision-Date: 2007-12-05 06:12+0900\n"
>> +"POT-Creation-Date: 2008-02-16 21:24+0100\n"
>> +"PO-Revision-Date: 2008-03-14 20:32+0900\n"
>
> Unfortunately this patch does not apply after Peter's regeneration
> of the POT file (0212242d66):
>
>   "POT-Creation-Date: 2008-03-14 07:18+0100\n"

Here is the guide to your translators, in your po/README:

    By comparing "POT-Creation-Date:" line in po/git-gui.pot file and
    po/af.po file, you can tell if there are new messages that need to be
    translated.  You would need the GNU gettext package to perform this
    step.

            $ msgmerge -U po/af.po po/git-gui.pot

    [NEEDSWORK: who is responsible for updating po/git-gui.pot file by
    running xgettext?  IIRC, Christian recommended against running it
    nilly-willy because it can become a source of unnecessary merge
    conflicts.  Perhaps we should mention something like "

    The po/git-gui.pot file is updated by the internationalization
    coordinator from time to time.  You _could_ update it yourself, but
    translators are discouraged from doing so because we would want all
    language teams to be working off of the same version of git-gui.pot.

    " here?]

Shawn, I think you guys should nail down the workflow right first, and
then mention the above a bit more prominently to avoid future accidents
like this.

It is perfectly fine if Peter regenerated the POT file for everybody as
the i18n coordinator, but the thing is, I think that regeneration should
have been done *before* you asked for translators to send in the
translation updates, not _after_ they have fetched from you in response to
your call for help and started working.

Probably it would be the easiest to reduce unnecessary work from
translators, if you just applied the patch to the version _before_
re-generation of POT, then msgmerge the updated POT after that.

It appears the patch was done on top of 48ed49f, so I would imagine a
sensible approach would be for _you_ to do:

    $ git checkout 48ed49f
    $ git am -s ja.patch
    $ git checkout master
    $ git checkout HEAD@{1} po/ja.po
    $ git commit -a -C HEAD@{1}
    $ msgmerge -U po/ja.po po/git-gui.pot
    $ git commit -m 'Adjusted older translation to updated POT' po/ja.po

Then ask Nana to re-fetch and fix that up.  At least that would reduce the
need for re-translation.
