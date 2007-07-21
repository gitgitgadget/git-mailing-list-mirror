From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 14:28:38 -0700
Message-ID: <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<Pine.LNX.4.64.0707211427190.14781@racer.site>
	<7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
	<200707212150.49351.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICMVH-0001Gv-UA
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762965AbXGUV2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762831AbXGUV2l
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 17:28:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51297 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763156AbXGUV2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 17:28:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721212840.XDHF1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 17:28:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SMUe1X00P1kojtg0000000; Sat, 21 Jul 2007 17:28:39 -0400
In-Reply-To: <200707212150.49351.stimming@tuhh.de> (Christian Stimming's
	message of "Sat, 21 Jul 2007 21:50:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53189>

Christian Stimming <stimming@tuhh.de> writes:

>> There are two HUGE problems with that.
>>
>>  * Supporting many languages means looooong lines in that file.
>>    Translators for languages later on the line would have hard
>>    time updating or looking at that file.
>>
>>  * Mixed encodings.  What if next language wants its strings in
>>    UTF-8?  How would you have that and ISO-8859 on a same line?
>>
>> I would suggest having one glossary file per language.
>
> Agreed. I propose to throw away the "add glossary" patch and I'll resubmit, 
> this time in a separate po/glossary/ directory, where each language will get 
> a po file for the glossary. 
>
> As I've written in another thread: In the glossary for the gnucash project [1] 
> we've actually added an extra 
> directory and encourage translators to add an extra po file for their 
> glossary translations. However, the glossary of gnucash has more than 150 
> terms and many of them require to be defined clearly as well, as translators 
> would otherwise be unable to translate them concisely. In git-gui, the 
> glossary is 25 terms so far and I think the git documentation already 
> contains enough definitions of all of them. Nevertheless, maybe it would make 
> a better structure if the translations of the glossary are kept in a separate 
> po file for each language. 

Actually, I would even suggest that we should NOT have a
separate glossary file at all, if gettext suite allows what I
outline below.

How about having it as a part of header comment in each of the
xx.po file?

The division of labor I think would make sense for message l10n
process goes like this:

 - The software developer (primarily Shawn): responsible for
   marking messages subject to i18n;

 - The i18n coordinator (could be Shawn but anybody else can
   volunteer; as things stand, I think Christian and Johannes
   are doing this): responsible for running "make
   po/git-gui.pot; make update-po" from time to time in order to
   keep po/*.po in sync with the vocabulary.

   initially, populate "glossary" part in po/git-gui.pot;

   as needed, add entries "glossary" part in po/git-gui.pot, and
   (if possible) add corresponding placeholders to po/*.po;

 - Translators (one for each language): responsible for updating
   po/xx.po file;

   initially, start by copying po/git-gui.pot to create
   po/xx.po;

   maintainance of "glossary" part of po/xx.po could also be
   made this person's responsibility instead of i18n
   coordinator's.

This way, the translators do not have to be so familiar with the
gettext toolchain nor even have to have gettext installed.

     
