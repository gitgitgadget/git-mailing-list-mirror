From: Wayne Scott <wsc9tt@gmail.com>
Subject: [PATCH] Change git-cvsimport to handle slashes in CVS tags
Date: Fri, 28 Oct 2005 13:46:45 -0500
Message-ID: <59a6e5830510281146s7b25da76l8bf97287522b89f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Oct 28 20:48:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVZFZ-00088Y-F6
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 20:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbVJ1Sqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbVJ1Sqq
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 14:46:46 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:56051 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030619AbVJ1Sqq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 14:46:46 -0400
Received: by xproxy.gmail.com with SMTP id s14so303282wxc
        for <git@vger.kernel.org>; Fri, 28 Oct 2005 11:46:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YPg/DW3ScfmfvN+PqonHzs2HNRWdalADlXV1ipS5KAmq/ui+fwF+DjFeo19mSDXsI0AOhDk0SSmezh30hf17bEraUVfMKTmey+g8woI7xYk5t6Ds7/ouVOoYQCbjPvR+cjltCi4iLEtPrM8Lc9km8RGiMuuGYiy/MD11dXHwJ7k=
Received: by 10.70.37.7 with SMTP id k7mr386976wxk;
        Fri, 28 Oct 2005 11:46:45 -0700 (PDT)
Received: by 10.70.7.3 with HTTP; Fri, 28 Oct 2005 11:46:45 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10770>

The Tcl/Tk CVS tree contains some tags like this one:
  dev-stubs-merge-8-1-3/9/99

CVS doesn't mind that tag, but git can't handle the slash
characters in the tag.  Just change those to underscore
so imports can complete.

Signed-off-by: Wayne Scott <wsc9tt@gmail.com>
---

 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: cf6439199f61d87dbb70fd7b43144e41462a359d
225c95454711467fc889c15cb3f7ca3230fce58d
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbb83fb..d71c30c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -636,6 +636,7 @@ my $commit = sub {
                my($xtag) = $tag;
                $xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and *
* FUNKY **
                $xtag =~ tr/_/\./ if ( $opt_u );
+               $xtag =~ tr/\//_/;

                my $pid = open2($in, $out, 'git-mktag');
                print $out "object $cid\n".
---
0.99.8.GIT
