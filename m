From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/2] gitk: Import msgcat for translation support
Date: Sat, 28 Jul 2007 12:40:17 +0200
Message-ID: <200707281240.17915.stimming@tuhh.de>
References: <157938.79347.qm@web38908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 12:40:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEjix-00009H-Qu
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 12:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXG1Kke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 06:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbXG1Kke
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 06:40:34 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:57517 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbXG1Kkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 06:40:33 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6SAePpe013592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 28 Jul 2007 12:40:25 +0200
Received: from [192.168.2.102] (p549024E3.dip0.t-ipconnect.de [84.144.36.227])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6SAeN6P031421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 12:40:24 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <157938.79347.qm@web38908.mail.mud.yahoo.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54022>

Am Samstag, 28. Juli 2007 09:28 schrieb Brett Schwarz:
> > > Import tcl's msgcat package to have the [mc...] procedure for
> > > translation available.
> >
> > if {[catch {
> >     package require msgcat
> >     # rest of your new stuff
> > }]} {
> >     proc mc {str} {
> >     return $str
> >     }
> > }
> >
> > so that everything still works if msgcat isn't available.  
>
> Junio already replied to this, and he was correct. 

The conclusion is that tcl8.1 is old enough so that you can safely assume 
msgcat exists? Or rather: Gitk probably requires tcl8.1 anyway (is there a 
known required tcl version for gitk?), and hence this can be relied upon here 
as well.

> However, this made me 
> think of something (that probably should be in git-gui as well) to make it
> a little more robust. We should check that the msg directory is where we
> think it is, and either give a warning, or exit the app (I would vote for
> the former).

>From what I've seen during testing, if the directory passed to msgload doesn't 
exists, the function simply does nothing. Its documentation doesn't say what 
is going to happen on a non-existing directory, though:
http://www.tcl.tk/man/tcl8.4/TclCmd/msgcat.htm#M10

> set msgdir [file join . msgs]      ;# or whatever this turns out to be
> if {[file exists $msgdir]} {
>     ::msgcat::mcload $msgdir
> } else {
>     puts stderr "WTF: can't find message catalog directory"
> }
>
> Or you could just use [catch] around the ::msgcat::mcload too.

I don't think [catch] changes anything, as the function rather seems to be 
no-op on nonexisting directory. So I think this wouldn't 
improve "robustness". I think this would only help in order to point out to 
the user that no translation has been found; however, it can't be known at 
this point whether this happens only because no translation exists, or 
whether there was some error in the installation. Probably only the latter is 
actually interesting to the user. 

Well, in conclusion I think the msgcat function is already robust enough and 
neither [catch] nor the directory checking buys us anything here.

Christian
