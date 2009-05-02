From: Mark Struberg <struberg@yahoo.de>
Subject: AW: [EGIT] [PATCH RFC v1 5/5] Use the ignore patterns cache to determine ignores
Date: Sat, 2 May 2009 11:51:58 +0000 (GMT)
Message-ID: <947431.4782.qm@web27806.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org, Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Sat May 02 13:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0DlI-0007mH-NE
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 13:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbZEBLwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2009 07:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZEBLwA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 07:52:00 -0400
Received: from web27806.mail.ukl.yahoo.com ([217.146.182.11]:39886 "HELO
	web27806.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753842AbZEBLv7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 May 2009 07:51:59 -0400
Received: (qmail 5613 invoked by uid 60001); 2 May 2009 11:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1241265118; bh=mclW2jhoPNlB9kU09aR0rkA836nV2JBSBLDUrNfPzAM=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TY0Zzl8lTHO0TYqUtgU+qGVxhFfz5rme4tHiTykZk6euPueFdMNGfKk7HWkRnG5Yk/wWXuRfxbcnPbY+TgdiKqFXXwEjpZY/0z4eq9kz/PmebYI7DzPi5kth4SDaCQhe7c8HjxdJF85IBJUrOsC8gwWvXGrfSDe0fM74Gu9sZZ8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Lxj2PyDQBjllfjPCHySWvAktVs0PKufsdso67QcFtbirr6/xwprKDRtTDhgpCF1A7fvu2mzokLPYKVT8JK4vHepSxJR+E6d/TcWHT87r4KwjfXYQsWMBBjPGo/ot3A1JszljNDsmBmglspqWNQ/H0h1PBCM+VpQs7DeWoB8RgVY=;
X-YMail-OSG: bUK1lrsVM1n3WKsf459Itp_NzXGIoQ0x7YcQ4u5kbke85xqLLOeLiYP0KklntK7STk_Rt3Y7T9zfnBRo.o1PSbr5QkFCejv_IFA5CIe4j5mZX8NPGh5z9FDMkoOc4a852MX0YPNUMgWj.fIjMHtWr9P82TF0fXASDU7D32hVXUfMRIKS7Lh4ZZS2.pg7uneoO6iMuOlGK1OwPEDJCr7Pc_ZRBZkUob2LKU9TIEgzOK62yh1YMHgyZmkNaH3rXPYalzHEseokwTGbcE35T3VK2H143QT9rmrmLh7Gu7R6QdUfi3P8L.99.Y0pCovYwTyncNx4IAk-
Received: from [62.47.157.201] by web27806.mail.ukl.yahoo.com via HTTP; Sat, 02 May 2009 11:51:58 GMT
X-Mailer: YahooMailClassic/5.2.20 YahooMailWebService/0.7.289.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118131>


=46erry,

I was just quickly hacking a rudimentary IgnoreRules class in jgit-core=
 [1] mainly for the purpose of not forgetting about handling ignores fi=
nally ;)

I now saw you worked on introducing gitignore to EGIT, but wasn't able =
to find any repo with your code but only a few old patches.=20

Do you see a way we can move your work into jgit-core? I've seen you ha=
ve a lot of Eclipse specific stuff in your code, so we'd obviously have=
 to cut those things in slices.

One possible strategy would be to make the IgnoreRules stuff in jgit-co=
re contain only the 'readonly' evaluation code, thus no addIgnore(File)=
 and addIgnore(String rule). Eclipse (or others, e.g. editor) could the=
n manipulate the .gitignore files, and all the other ignore options and=
 afterwards tells the IgnoreRules to re-initialise.

A second thing: Not looked at your code close enough, but I noticed tha=
t quite a few Eclipse plugins look at the subclipse when it comes to ig=
nore handling, and try to 'hide' the ignore files from the user. I pers=
onally don't like that because the propset based ignore handling is a h=
ighly SVN specific thing. I prefer the way it's handled with the CVS pl=
ugin: show the .gitignore files to the user and even let him edit those=
 files with an editor. As soon as we detect a change (even after a refr=
esh if someone edited it with vi), we simply re-init our IgnoreRules.

WDYT?

Btw: Do you have a github account already? We could create an 'ignore' =
branch and I'm sure Jason can give you push rights to it.=20

txs and LieGrue,
strub

[1] http://github.com/sonatype/JGit/blob/ad8d1460919f1c5d34fff17a2ea54a=
cea62e4107/org.spearce.jgit/src/org/spearce/jgit/ignore/IgnoreRules.jav=
a



--- Ferry Huberts <ferry.huberts@pelagic.nl> schrieb am Do, 26.3.2009:

> Von: Ferry Huberts <ferry.huberts@pelagic.nl>
> Betreff: [EGIT] [PATCH RFC v1 5/5] Use the ignore patterns cache to d=
etermine ignores
> An: git@vger.kernel.org
> CC: "Shawn O. Pearce" <spearce@spearce.org>, "Robin Rosenberg" <robin=
=2Erosenberg@dewire.com>, "Ferry Huberts" <ferry.huberts@pelagic.nl>
> Datum: Donnerstag, 26. M=E4rz 2009, 22:34
> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
> ---
[patch cutted]


     =20
