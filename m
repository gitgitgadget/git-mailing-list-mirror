From: Ulrike Fischer <luatex@nililand.de>
Subject: zip files created with git archive flags text files as binaries
Date: Mon, 23 Feb 2015 14:58:42 +0100
Message-ID: <12g5ss8uqwflv.dlg@nililand.de>
Reply-To: luatex@nililand.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 15:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPtYa-0006u6-0j
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 15:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbbBWOAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 09:00:13 -0500
Received: from plane.gmane.org ([80.91.229.3]:39806 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbBWOAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 09:00:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YPtYJ-0006mu-UG
	for git@vger.kernel.org; Mon, 23 Feb 2015 15:00:03 +0100
Received: from p5b391692.dip0.t-ipconnect.de ([91.57.22.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 15:00:03 +0100
Received: from luatex by p5b391692.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 15:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5b391692.dip0.t-ipconnect.de
User-Agent: 40tude_Dialog/2.0.15.41de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264259>

I'm using git on windows 7.

$ git --version
git version 1.9.4.msysgit.0

Some days ago I uploaded a latex package to CTAN (www.ctan.org). 
I created the zip-file with 

git archive --format=zip --prefix=citeall/
--output=zip/citeall_2015-02-20.zip HEAD 

The zip contained four text files and a pdf. 

The CTAN maintainers informed me that all files in the zip are
flagged as binaries and this makes it difficult for them to process
them further (they want to correct line feeds of the text files:
http://mirror.ctan.org/tex-archive/help/ctan/CTAN-upload-addendum.html#crlf) 

unzip -Z reports for my zip:

$ unzip -Z citeall_2015_02_20.zip
Archive:  citeall_2015_02_20.zip
Zip file size: 105509 bytes, number of entries: 6
drwx---     0.0 fat        0 bx stor 15-Feb-20 17:07 citeall/
-rw----     0.0 fat      458 bx defN 15-Feb-20 17:07 citeall/README
-rw----     0.0 fat   102244 bx defN 15-Feb-20 17:07
citeall/citeall.pdf
-rw----     0.0 fat     3431 bx defN 15-Feb-20 17:07
citeall/citeall.sty
-rw----     0.0 fat     3971 bx defN 15-Feb-20 17:07
citeall/citeall.tex
-rw----     0.0 fat      557 bx defN 15-Feb-20 17:07
citeall/examples-citeall.bib
6 files, 110661 bytes uncompressed, 104669 bytes compressed:  5.4%

The problem are all the "bx" entries. 

When I zip all the files with the standard windows zip-tool I get
this:

$ unzip -Z citeall-win.zip
Archive:  citeall-win.zip
Zip file size: 105275 bytes, number of entries: 5
-rw----     2.0 fat   102244 b- defN 15-Feb-20 17:07
citeall/citeall.pdf
-rw----     2.0 fat     3431 t- defN 15-Feb-20 17:07
citeall/citeall.sty
-rw----     2.0 fat     3971 t- defN 15-Feb-20 17:07
citeall/citeall.tex
-rw----     2.0 fat      557 t- defN 15-Feb-20 17:07
citeall/examples-citeall.bib
-rw----     2.0 fat      458 t- defN 15-Feb-20 17:07 citeall/README
5 files, 110661 bytes uncompressed, 104675 bytes compressed:  5.4%

Here the text files have a correct t flag. 

I don't know if it the problem exists also with zips created with
git archive on non-windows OS.

Would it be possible to correct the zip-backend so that it flags
text files correctly? Or alternativly could one configure git
archive to use another zip programm? 

(I tried to sent this already some hours ago, but the message seems
to be lost ...)

-- 
Ulrike Fischer 
http://www.troubleshooting-tex.de/
