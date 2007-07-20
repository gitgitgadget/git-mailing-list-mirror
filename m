From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Fri, 20 Jul 2007 23:40:27 +0200
Message-ID: <200707202340.27496.stimming@tuhh.de>
References: <772058.65660.qm@web38907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 23:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC0D7-0001pX-28
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 23:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbXGTVkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755411AbXGTVkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 17:40:25 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45762 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbXGTVkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 17:40:23 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6KLe9vK031904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 20 Jul 2007 23:40:10 +0200
Received: from [192.168.2.102] (p54902ADD.dip0.t-ipconnect.de [84.144.42.221])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6KLe8ff023004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 23:40:09 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <772058.65660.qm@web38907.mail.mud.yahoo.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53121>

Am Freitag, 20. Juli 2007 20:34 schrieb Brett Schwarz:
> After the glossary of terms has been create, it is easy to create the
> catalog file (assuming we use Tcl's standard mechanism). Each locale should
> have it's own file, named <locale_name>.msg (for example, es.msg for
> spanish). Inside that file, you just create entries for each glossary term
> (the below assumes that the msgcat namespace was imported):
>
>   mcset es Hello Hola
>   mcset es "Hello %s" "Hola %s"

I beg your pardon, but I think you grossly misunderstood what I meant 
by "glossary". So before we end up in further confusion, let me clarify how 
the general translation approach works. I'll use gettext wording because 
that's what I know (from being the i18n guy in the gnucash project), but you 
can easily insert any other wording you like here.

#1 For the translation in general, there is the set of all user-visible 
strings in the source language (here: english). In gettext terms this is 
called the "PO template file", git-gui.pot, also called the message template 
file. This set of to-be-translated strings needs to be extracted from the 
source code, which can be done by the xgettext program.

#2 For each target language, there is a human-readable mapping file that maps 
each source string (english) into the target language. In gettext terms this 
is the "PO file", de.po and it.po and ja.po and whatnot, also called the 
translation file. This is the *only* file translators actually work with. 
Gettext uses its PO file format here and a plethora of different tools exist 
to help translators editing these files. (Examples: emacs po-mode, 
KBabel, ...)

#3 For each target language, the translation files are converted to a 
(potentially not human-readable) "compiled" mapping file, which is then read 
at program runtime and used for the actual translation. For the gettext po 
file format, the msgfmt program can convert this to Tcl's .msg files.

If I understand correctly, your above suggestion implies that for Tcl msgcat, 
the file in #2 and #3 are one and the same? In my opinion this might make 
sense if and only if that file format is supported by at least as many 
translation tools and offers as flexible translation updates as gettext's po 
file format does. From my experience the po file format indeed offers a bunch 
of features that other translation file formats are missing but which are of 
significant help to the translator. That's why I would strongly suggest to do 
the actual translation inside a po file, and have it converted to the msg 
file afterwards. 

On the other hand when I mentioned a "glossary", I was talking about a simple 
text file that should collect the 15-20 most important single words from 
within the project. Those words usually show up in many different translation 
strings, and as a translator you would easily lose track of which word you 
translated into which translation. (Example glossary terms: repository, 
commit [both the verb and the noun, heh], fetch, pull, push.) That's why you 
would first collect that glossary, then come up with a one-to-one translation 
for each of the 20 words of the glossary, and *then* use that fixed wording 
throughout all 200-500 message translations of the actual project. 

Christian
