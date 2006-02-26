From: Rutger Nijlunsing <rutger@nospam.com>
Subject: NT directory traversal speed on 25K files on Cygwin
Date: Mon, 27 Feb 2006 00:17:01 +0100
Organization: M38c
Message-ID: <20060226231701.GA11961@nospam.com>
References: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 00:19:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVAB-000589-W1
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWBZXRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBZXRN
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:17:13 -0500
Received: from post-22.mail.nl.demon.net ([194.159.73.192]:707 "EHLO
	post-22.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932303AbWBZXRC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 18:17:02 -0500
Received: from wingding.demon.nl ([82.161.27.36]:52296)
	by post-22.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FDV8P-000Ov1-3F; Sun, 26 Feb 2006 23:17:01 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FDV8P-0004kJ-Mj; Mon, 27 Feb 2006 00:17:01 +0100
To: Christopher Faylor <me@cgf.cx>
Content-Disposition: inline
In-Reply-To: <20060226195552.GA30735@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16804>

On Sun, Feb 26, 2006 at 02:55:52PM -0500, Christopher Faylor wrote:
> On Thu, Feb 23, 2006 at 03:07:07PM +0100, Alex Riesen wrote:
> >filesystem is slow and locked down, and exec-attribute is NOT really
> >useful even on NTFS (it is somehow related to execute permission and
> >open files.  I still cannot figure out how exactly are they related).
> 
> Again, it's not clear if you're talking about Windows or Cygwin but
> under Cygwin, in the default configuration, the exec attribute means the
> same thing to cygwin as it does to linux.

I don't know about native Windows speed, but comparing NutCracker with
Cygwin on a simple 'find . | wc -l' already gives a clue that looking
at Cygwin to benchmark NT file inspection IO will give a skewed
picture:

##### NutCracker
$ time find . | wc -l

real    0m 1.44s
user    0m 0.45s
sys     0m 0.98s
  25794

##### Cygwin
$ time c:\\cygwin\\bin\\find . | wc -l

real    0m 6.72s
user    0m 1.09s
sys     0m 5.59s
  25794

##### CMD.EXE + DIR /S
C:\PROJECT> c:\cygwin\bin\time cmd /c dir /s >NUL
0.01user 0.01system 0:05.70elapsed 0%CPU (0avgtext+0avgdata 6320maxresident)k
0inputs+0outputs (395major+0minor)pagefaults 0swaps

##### Cygwin 'find -ls' (NutCracker doesn't have a '-ls')
C:\PROJECT> c:\cygwin\bin\time c:\cygwin\bin\find -ls | wc -l
2.79user 7.81system 0:10.60elapsed 100%CPU (0avgtext+0avgdata 14480maxresident)k
  25794


Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
