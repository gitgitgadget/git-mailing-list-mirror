From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 15:35:46 +0200
Message-ID: <200707221535.46422.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707212150.49351.stimming@tuhh.de> <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 15:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICbbM-0003zy-LA
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 15:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbXGVNfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 09:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXGVNfq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 09:35:46 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:50830 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbXGVNfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 09:35:45 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6MDZYk2015132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 22 Jul 2007 15:35:34 +0200
Received: from [192.168.2.102] (p5490117A.dip0.t-ipconnect.de [84.144.17.122])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6MDZWae019886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 15:35:33 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53269>

Am Samstag, 21. Juli 2007 23:28 schrieb Junio C Hamano:
> > Agreed. I propose to throw away the "add glossary" patch and I'll
> > resubmit, this time in a separate po/glossary/ directory, where each
> > language will get a po file for the glossary.
>
> Actually, I would even suggest that we should NOT have a
> separate glossary file at all, if gettext suite allows what I
> outline below.
>
> How about having it as a part of header comment in each of the
> xx.po file?

I don't think this would work well. In particular, you don't get all the nice 
gettext *merging* features that you only get with a full-blown po file.

> The division of labor I think would make sense for message l10n
> process goes like this:
>
>  - The software developer (primarily Shawn): responsible for
>    marking messages subject to i18n;

Yes, except those developers who don't happen to be translators as well tend 
to forget the markups. I don't blame anyone for doing so - just keep in mind 
that translators have to give feedback about missing markups, and they 
hopefully will do so.

>  - The i18n coordinator (could be Shawn but anybody else can
>    volunteer; as things stand, I think Christian and Johannes
>    are doing this): responsible for running "make
>    po/git-gui.pot; make update-po" from time to time in order to
>    keep po/*.po in sync with the vocabulary.

Actually, please DO NOT RUN update-po except right before a new tarball is 
being packaged and distributed! It sucks royally if I have updated my de.po 
translation, only to discover someone has run update-po on the server and I 
have to figure out how to get out of the de.po conflicts. There will be 
conflicts after each and every update-po because the line numbers in the po 
file will have changed inevitably -- but the actualy content in terms of 
messages might be completely unchanged.

For that reason, please use the update-po rule AS SELDOM AS POSSIBLE. Thanks a 
lot.

>    initially, populate "glossary" part in po/git-gui.pot;
>
>    as needed, add entries "glossary" part in po/git-gui.pot, and
>    (if possible) add corresponding placeholders to po/*.po;

Again, this doesn't work well, and depending on the po file editor that is 
used by a translator they might not see this comment block anyway. I would 
instead propose a subdirectory po/glossary; a CSV file that contains the 
terms itself; a csv-to-po converter script that will turn the terms into a 
git-gui-glossary.pot; and a po file for each language.

>  - Translators (one for each language): responsible for updating
>    po/xx.po file;
>
>    initially, start by copying po/git-gui.pot to create
>    po/xx.po;
>
>    maintainance of "glossary" part of po/xx.po could also be
>    made this person's responsibility instead of i18n
>    coordinator's.
>
> This way, the translators do not have to be so familiar with the
> gettext toolchain nor even have to have gettext installed.

Translators who are unfamiliar with gettext are a mixed blessing. Anyone is 
able to contribute a bunch of initial string translations, especially if 
there hasn't been a translation before. But if someone or a team wants to 
achieve a really *high-quality*, 100%, consistent, and understandable 
translation, the translators must be able to test the translation a lot, 
which implies they must be able to generate the .msg files, which requires 
the gettext toolchain anyway. For that reason I wouldn't spent too much 
effort to enable translation work without gettext tools; instead, I'd rather 
encourage to optimize the setup for those translators that have the full 
toolchain available.

Christian
