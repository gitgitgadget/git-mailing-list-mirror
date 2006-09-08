From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some issues with current qgit on exit
Date: Fri, 08 Sep 2006 07:32:22 -0400
Message-ID: <1157715142.3018.1.camel@dv>
References: <1157493650.2803.8.camel@dv>
	 <e5bfff550609061028y25aeb928i2c49d4a5d1be7a60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 13:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLebE-0001CJ-PZ
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 13:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWIHLce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 07:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWIHLce
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 07:32:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:27524 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750817AbWIHLcd
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 07:32:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GLeb1-00067v-9i
	for git@vger.kernel.org; Fri, 08 Sep 2006 07:32:31 -0400
Received: from proski by dv.roinet.com with local (Exim 4.63)
	(envelope-from <proski@dv.roinet.com>)
	id 1GLeas-0005Vz-T7; Fri, 08 Sep 2006 07:32:22 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550609061028y25aeb928i2c49d4a5d1be7a60@mail.gmail.com>
X-Mailer: Evolution 2.7.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26696>

Hi, Marco!

On Wed, 2006-09-06 at 19:28 +0200, Marco Costalba wrote:

> Thanks for the very good bug reports. I have just  pushed the fix: it
> was a bogus delayed delete on exit the origin of this issues.

You never cease to amaze me by your quick (and hopefully correct) fixes.

> I was planning (well, still I am) to release new version this week
> end, and your bug report is arrived just in time ;-)

I tried to push qgit a bit harder, and it's still easy to crash:

Run qgit
Select a patch and an affected file in the file pane
Press Ctrl-A to open a tab for that file
Press Ctrl-Shift-A and hold it for some time to open more tabs
Close qgit before all tabs load

Two things can happen.  Either glibc detects double free or it doesn't.

Output in the case when double free is not detected:

Thrown exception 'Closing file viewer'
ASSERT in remove: 22228848 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 15 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 14 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 13449472 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 18662832 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 15427120 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 10 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 9 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
ASSERT in remove: 8 is not the first in list
Exception 'Closing file viewer' not handled in file viewer...re-throw
terminate called after throwing an instance of 'int'
Aborted (core dumped)


Output in the case if double free is detected, filtered through c++filt
(I have no idea how to make the glibc stack trace show qgit symbols)

Thrown exception 'Closing file viewer'
Catched exception 'Closing file viewer' while in updating file viewer
*** glibc detected *** ./qgit: double free or corruption (out): 0x00007fff47d997a0 ***
======= Backtrace: =========
/lib64/libc.so.6[0x2b8863438b00]
/lib64/libc.so.6(cfree+0x8c)[0x2b886343c27c]
./qgit[0x499138]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QWidget::~QWidget()+0x152)[0x372399a6a2]
./qgit[0x4b3416]
./qgit[0x497ea1]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QObject::event(QEvent*)+0x79)[0x3723960089]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QWidget::event(QEvent*)+0x28)[0x3723997af8]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QMainWindow::event(QEvent*)+0x25)[0x3723a554b5]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::internalNotify(QObject*, QEvent*)+0x85)[0x37238ffda5]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::notify(QObject*, QEvent*)+0xa4)[0x3723901274]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::sendPostedEvents(QObject*, int)+0x179)[0x3723900da9]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int)+0x3fa)[0x37238af11a]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int, int)+0x48)[0x37239174f8]
./qgit[0x47751a]
./qgit[0x444e21]
./qgit[0x449f7f]
./qgit[0x44a159]
./qgit[0x43ae3a]
./qgit[0x440715]
./qgit[0x435291]
./qgit[0x435448]
./qgit[0x43f4a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QObject::event(QEvent*)+0x96)[0x37239600a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::internalNotify(QObject*, QEvent*)+0x85)[0x37238ffda5]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::notify(QObject*, QEvent*)+0xa4)[0x3723901274]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::sendPostedEvents(QObject*, int)+0x179)[0x3723900da9]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int)+0x3fa)[0x37238af11a]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int, int)+0x48)[0x37239174f8]
./qgit[0x47751a]
./qgit[0x444e21]
./qgit[0x449f7f]
./qgit[0x44a159]
./qgit[0x43ae3a]
./qgit[0x440715]
./qgit[0x435291]
./qgit[0x435448]
./qgit[0x43f4a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QObject::event(QEvent*)+0x96)[0x37239600a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::internalNotify(QObject*, QEvent*)+0x85)[0x37238ffda5]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::notify(QObject*, QEvent*)+0xa4)[0x3723901274]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::sendPostedEvents(QObject*, int)+0x179)[0x3723900da9]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int)+0x3fa)[0x37238af11a]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int, int)+0x48)[0x37239174f8]
./qgit[0x47751a]
./qgit[0x444e21]
./qgit[0x449f7f]
./qgit[0x44a159]
./qgit[0x43ae3a]
./qgit[0x440715]
./qgit[0x435291]
./qgit[0x435448]
./qgit[0x43f4a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QObject::event(QEvent*)+0x96)[0x37239600a6]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::internalNotify(QObject*, QEvent*)+0x85)[0x37238ffda5]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::notify(QObject*, QEvent*)+0xa4)[0x3723901274]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QApplication::sendPostedEvents(QObject*, int)+0x179)[0x3723900da9]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int)+0x3fa)[0x37238af11a]
/usr/lib64/qt-3.3/lib/libqt-mt.so.3(QEventLoop::processEvents(unsigned int, int)+0x48)[0x37239174f8]
./qgit[0x47751a]
./qgit[0x444e21]
./qgit[0x449f7f]
./qgit[0x44a159]
======= Memory map: ========
00400000-00526000 r-xp 00000000 08:08 1523903                            /usr/local/src/qgit/src/qgit
00726000-00729000 rw-p 00126000 08:08 1523903                            /usr/local/src/qgit/src/qgit
00729000-03635000 rw-p 00729000 00:00 0                                  [heap]
371ca00000-371ca17000 r-xp 00000000 08:01 4836913                        /usr/lib64/libart_lgpl_2.so.2.3.17
371ca17000-371cc16000 ---p 00017000 08:01 4836913                        /usr/lib64/libart_lgpl_2.so.2.3.17
371cc16000-371cc17000 rw-p 00016000 08:01 4836913                        /usr/lib64/libart_lgpl_2.so.2.3.17
371ce00000-371ce30000 r-xp 00000000 08:01 4848834                        /usr/lib64/liblcms.so.1.0.15
371ce30000-371d030000 ---p 00030000 08:01 4848834                        /usr/lib64/liblcms.so.1.0.15
371d030000-371d032000 rw-p 00030000 08:01 4848834                        /usr/lib64/liblcms.so.1.0.15
371d032000-371d034000 rw-p 371d032000 00:00 0 
371d200000-371d213000 r-xp 00000000 08:01 4850552                        /usr/lib64/libXft.so.2.1.2
371d213000-371d412000 ---p 00013000 08:01 4850552                        /usr/lib64/libXft.so.2.1.2
371d412000-371d413000 rw-p 00012000 08:01 4850552                        /usr/lib64/libXft.so.2.1.2
371e600000-371e614000 r-xp 00000000 08:01 4843230                        /usr/lib64/libz.so.1.2.3
371e614000-371e813000 ---p 00014000 08:01 4843230                        /usr/lib64/libz.so.1.2.3
371e813000-371e814000 rw-p 00013000 08:01 4843230                        /usr/lib64/libz.so.1.2.3
371ea00000-371ea05000 r-xp 00000000 08:01 4844451                        /usr/lib64/libXdmcp.so.6.0.0
371ea05000-371ec04000 ---p 00005000 08:01 4844451                        /usr/lib64/libXdmcp.so.6.0.0
371ec04000-371ec05000 rw-p 00004000 08:01 4844451                        /usr/lib64/libXdmcp.so.6.0.0
371ee00000-371ee02000 r-xp 00000000 08:01 4842899                        /usr/lib64/libXau.so.6.0.0
371ee02000-371f001000 ---p 00002000 08:01 4842899                        /usr/lib64/libXau.so.6.0.0
371f001000-371f002000 rw-p 00001000 08:01 4842899                        /usr/lib64/libXau.so.6.0.0
371f200000-371f304000 r-xp 00000000 08:01 4845440                        /usr/lib64/libX11.so.6.2.0
371f304000-371f504000 ---p 00104000 08:01 4845440                        /usr/lib64/libX11.so.6.2.0
371f504000-371f50b000 rw-p 00104000 08:01 4845440                        /usr/lib64/libX11.so.6.2.0
371f600000-371f610000 r-xp 00000000 08:01 4848836                        /usr/lib64/libXext.so.6.4.0
371f610000-371f810000 ---p 00010000 08:01 4848836                        /usr/lib64/libXext.so.6.4.0
371f810000-371f811000 rw-p 00010000 08:01 4848836                        /usr/lib64/libXext.so.6.4.0
371fa00000-371fa20000 r-xp 00000000 08:01 3790170                        /lib64/libexpat.so.0.5.0
371fa20000-371fc1f000 ---p 00020000 08:01 3790170                        /lib64/libexpat.so.0.5.0
371fc1f000-371fc22000 rw-p 0001f000 08:01 3790170                        /lib64/libexpat.so.0.5.0
3720200000-3720209000 r-xp 00000000 08:01 4848835                        /usr/lib64/libXrender.so.1.3.0
3720209000-3720408000 ---p 00009000 08:01 4848835                        /usr/lib64/libXrender.so.1.3.0
3720408000-3720409000 rw-p 00008000 08:01 4848835                        /usr/lib64/libXrender.so.1.3.0
3720600000-372063c000 r-xp 00000000 08:01 4850470                        /usr/lib64/libfontconfig.so.1.0.4
372063c000-372083c000 ---p 0003c000 08:01 4850470                        /usr/lib64/libfontconfig.so.1.0.4
372083c000-3720841000 rw-p 0003c000 08:01 4850470                        /usr/lib64/libfontconfig.so.1.0.4
3720841000-3720844000 rw-p 3720841000 00:00 0 
3720a00000-3720a23000 r-xp 00000000 08:01 4841936                        /usr/lib64/libpng12.so.0.10.0
3720a23000-3720c23000 ---p 00023000 08:01 4841936                        /usr/lib64/libpng12.so.0.10.0
3720c23000-3720c24000 rw-p 00023000 08:01 4841936                        /usr/lib64/libpng12.so.0.10.0
3720e00000-3720e02000 r-xp 00000000 08:01 4850036                        /usr/lib64/libXinerama.so.1.0.0
3720e02000-3721001000 ---p 00002000 08:01 4850036                        /usr/lib64/libXinerama.so.1.0.0
3721001000-3721002000 rw-p 00001000 08:01 4850036                        /usr/lib64/libXinerama.so.1.0.0
3721200000-3721203000 r-xp 00000000 08:01 4848837                        /usr/lib64/libXrandr.so.2.0.0
3721203000-3721402000 ---p 00003000 08:01 4848837                        /usr/lib64/libXrandr.so.2.0.0
3721402000-3721403000 rw-p 00002000 08:01 4848837                        /usr/lib64/libXrandr.so.2.0.0
3721600000-372160a000 r-xp 00000000 08:01 4849031                        /usr/lib64/libXcursor.so.1.0.2
372160a000-3721809000 ---p 0000a000 08:01 4849031                        /usr/lib64/libXcursor.so.1.0.2
3721809000-372180a000 rw-p 00009000 08:01 4849031                        /usr/lib64/libXcursor.so.1.0.2
3721a00000-3721a05000 r-xp 00000000 08:01 4848838                        /usr/lib64/libXfixes.so.3.1.0
3721a05000-3721c04000 ---p 00005000 08:01 4848838                        /usr/lib64/libXfixes.so.3.1.0
3721c04000-3721c05000 rw-p 00004000 08:01 4848838                        /usr/lib64/libXfixes.so.3.1.0
3721e00000-3721e31000 r-xp 00000000 08:01 4851247 Aborted (core dumped)


As always, it's Fedora development on x86_64.

-- 
Regards,
Pavel Roskin
