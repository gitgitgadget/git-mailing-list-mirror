From: Adam Mercer <ramercer@gmail.com>
Subject: Using filter-branch to move repo contents in subdirectory
Date: Thu, 29 Jul 2010 13:37:38 +0100
Message-ID: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 14:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeSNG-0006WS-UN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 14:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab0G2MiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 08:38:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40196 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab0G2MiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 08:38:03 -0400
Received: by iwn7 with SMTP id 7so298559iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=+d6pdCCd4NHr9Nsbid2pq6rJbIMGci59yFk0Pdw5Ius=;
        b=d8WxRy8B6/nW/5qk5vpTpBljP/M1q7ZT6/5mt2H8N9K+2a4nH3nHIlAmgclNm5N5ys
         mPX93XlmG1mO8KoOW4Q0I6oTFPKw6eeQ8zQd8RMkQhL/4sXJWLfbInKnAKd/ztixGlzl
         TBEsiLK2hjv3f/RKGoa2OaI1paA1BTpy7I8kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=xYVxQWpRocMe45VFQyGBsUZvJawkOZiRH49dSFRI12R8VYrbpzGQuU1bQdtSReFm+R
         aiN7f07v3dWISh0M2itpooFyMOFUbZDNHzzqSDbK7W25ob5iQZKnlPcz4pogF8DnKjQs
         +Fwfg48qxY6VSbgt553RxSVnlReQFTXfIPxPM=
Received: by 10.231.39.134 with SMTP id g6mr76080ibe.8.1280407082336; Thu, 29 
	Jul 2010 05:38:02 -0700 (PDT)
Received: by 10.231.182.18 with HTTP; Thu, 29 Jul 2010 05:37:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152172>

Hi

I'm trying to use git filter-branch to move all contents of a repo
into a subdirectory of the repo root. The git filter-branch man page
has the following example:

       To move the whole tree into a subdirectory, or remove it from there:

           git filter-branch --index-filter \
                   'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
                           GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                                   git update-index --index-info &&
                    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

So I've been trying to use this, the original structure of the repo is:

$ ls
00boot                 SFTdumpall.c     debian
Makefile.am            SFTdumpheader.c  ligodcc.cls
README                 SFTvalidate.c    pdfdraftcopy.sty
SCCB_2004_09_09        SFTwrite.c       run_validate.sh
SFTReferenceLibrary.c  T040164.tex      sftreferencelibrary-2.2.tar.gz
SFTReferenceLibrary.h  configure.in     sftreferencelibrary-2.3.tar.gz
$

and I want all this in a subdirectory call "sftlib", so using the
example from the manpage I ran:

$ git filter-branch --index-filter \
    'git ls-files -s | sed "s-\t\"*-&sftlib/-" |
        GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
            git update-index --index-info &&
    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
Rewrite 223651f2ebd5d5d9341bcfc9e7cb6caaa3f4d171 (56/65)Ignoring path
00bootsftlib/
Rewrite c979ee835ebb89408e2f5f345ddefbb4d8cd75f5 (57/65)Ignoring path
00bootsftlib/
Rewrite 10037389e41fb4b4d04234ca2e302a7a491616d5 (58/65)Ignoring path
00bootsftlib/
Rewrite 21b4c31a02c6b7718145d471ba20e6fa70eb30d0 (59/65)Ignoring path
00bootsftlib/
Rewrite dc5cebbe14050f52f2effaa5eac4eb579dd440c3 (60/65)Ignoring path
00bootsftlib/
Rewrite 3b83fdd19b5d674445f5263df8cb2fc35c3c0092 (61/65)Ignoring path
00bootsftlib/
Rewrite 5246038ceeb2d28fba462076b62f3cf1b2b7e9ab (62/65)Ignoring path
00bootsftlib/
Rewrite 0fd3256ff401b405c677e83db350ad41ee74ef0d (63/65)Ignoring path
00bootsftlib/
Ignoring path debian/compatsftlib/
Ignoring path debian/copyrightsftlib/
Rewrite 9aca227c807658b951e81a6ca4460115b2fe8ccc (64/65)Ignoring path
00bootsftlib/
Ignoring path debian/compatsftlib/
Ignoring path debian/copyrightsftlib/
Rewrite 00274be10e10920d84db145268d85faf1b06539f (65/65)Ignoring path
00bootsftlib/
Ignoring path debian/compatsftlib/
Ignoring path debian/copyrightsftlib/

Ref 'refs/heads/to_merge' was rewritten
$

now the directory structure is:

$ ls
Makefile.am  SCCB_2004_09_09        SFTReferenceLibrary.h
SFTdumpheader.c   SFTwritsftlib    configure.in  ligodcc.cls
run_validatsftlib
README       SFTReferenceLibrary.c  SFTdumpall.c
SFTvalidatsftlib  T040164.tsftlib  debian        pdfdraftsftlib
sftsftlib
$

which is clearly not what I'm wanting. What I am doing wrong here? As
far as I can I'm using the example from the man-page?

Cheers

Adam
