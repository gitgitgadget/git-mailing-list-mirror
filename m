Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A781F576
	for <e@80x24.org>; Tue, 30 Jan 2018 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeA3Kis (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 05:38:48 -0500
Received: from eight.schwarz.eu ([78.47.62.209]:50304 "EHLO eight.schwarz.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbeA3Kir (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 05:38:47 -0500
X-Greylist: delayed 2026 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jan 2018 05:38:47 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schwarz-online.org; s=x; h=To:Date:Message-Id:Subject:Mime-Version:
        Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Iqgr5NEJOAjQKJMuE0EFYOsNTwzWiUJ69N2y0FWTEpI=; b=NomhTULYGBSa+Yxt3tpvvZJD4m
        dA7WfpTHAPgAKggMkJKf/HYzR32kOqwfqYQQ+i2PGsG9AM56+u3295mUp/FZXOdQjJNM3P3iEkt5o
        GJmruxqhj4QwI7B90P4QHW1bFv4KAziJLkWBgVUW5UlSCpp/O4GjVNk/7u7vSd1/t51OjgicrWsXC
        niLN1X008wkg+YmPG2+u/lvB3IWFEBwP9Vq4TKpPjnCJnZRybVFMqnryedH7Ro9AaKg7lYS2tJmQ2
        FFYi6S1RH+glWAmUm0+8677+qFgpkHj6FtsS83dNFRlrskekZo+5zkPkhSrDPeZAazPnfz6ydtgYo
        C6GpXTqg==;
From:   =?utf-8?Q?Martin_H=C3=A4cker?= <mhaecker@schwarz-online.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EF7E90A1-E40C-4BA3-8070-F02BED4F9425";
        protocol="application/pgp-signature";
        micalg=pgp-sha1
X-Mao-Original-Outgoing-Id: 538999499.732083-7201fb32545a8ca551e1abf82ebe7d3b
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: git stash ; git stash pop unstages all staged changes 
Message-Id: <454AAA27-B8D3-47F9-8E49-EC5415A26FCE@schwarz-online.org>
Date:   Tue, 30 Jan 2018 11:05:00 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
X-Received: by eight.schwarz.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mhaecker@schwarz-online.org>)
        id 1egSmi-0006hc-G1; Tue, 30 Jan 2018 11:38:46 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_EF7E90A1-E40C-4BA3-8070-F02BED4F9425
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi there,

I just lost quite some work, because `git stash; git stash pop` =
doesn=E2=80=99t seem to understand the concept of the index correctly.

To reproduce:

=E2=80=94 snip =E2=80=94
dwt@crest ~/Desktop % mkdir test
dwt@crest ~/Desktop % cd test
dwt@crest ~/Desktop/test % git init
Initialized empty Git repository in /Users/dwt/Desktop/test/.git/
dwt@crest ~/Desktop/test (git)-[master] % touch foo
dwt@crest ~/Desktop/test (git)-[master] % git add foo
dwt@crest ~/Desktop/test (git)-[master] % git commit -m "initial commit"
[master (root-commit) 893b428] initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
dwt@crest ~/Desktop/test (git)-[master] % echo "bar" >> foo
dwt@crest ~/Desktop/test (git)-[master] % git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working =
directory)

	modified:   foo

no changes added to commit (use "git add" and/or "git commit -a")
dwt@crest ~/Desktop/test (git)-[master] % git add foo
dwt@crest ~/Desktop/test (git)-[master] % git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   foo

dwt@crest ~/Desktop/test (git)-[master] % echo "baz" >> foo
dwt@crest ~/Desktop/test (git)-[master] % git diff
diff --git a/foo b/foo
index 5716ca5..e2994c5 100644
--- a/foo
+++ b/foo
@@ -1 +1,2 @@
 bar
+baz
dwt@crest ~/Desktop/test (git)-[master] % git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   foo

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working =
directory)

	modified:   foo

dwt@crest ~/Desktop/test (git)-[master] % git stash
Saved working directory and index state WIP on master: 893b428 initial =
commit
dwt@crest ~/Desktop/test (git)-[master] % git status
On branch master
nothing to commit, working tree clean
dwt@crest ~/Desktop/test (git)-[master] % git stash pop
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working =
directory)

	modified:   foo

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (7a8d892120c0a231a529222dabeec1fd3594f514)
dwt@crest ~/Desktop/test (git)-[master] % git diff
diff --git a/foo b/foo
index e69de29..e2994c5 100644
--- a/foo
+++ b/foo
@@ -0,0 +1,2 @@
+bar
+baz

=E2=80=94 snap =E2=80=94

What git stash does get right is that it does remove everything that is =
stashed from the current state of the repo, but what it doesn=E2=80=99t =
get right is restoring that state fatefully in `git stash pop`.

As a user, I would expect that `git stash pop` undoes the change that =
`git stash` inflicted.

Best Regards,
Martin H=C3=A4cker

--Apple-Mail=_EF7E90A1-E40C-4BA3-8070-F02BED4F9425
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF0EARECAB0WIQRyALCMEeyeJp2h5aqZEm8JhZOQPgUCWnBDSwAKCRCZEm8JhZOQ
Ps14AJ9glwZpLdDuZNuWoYq1KN4OfU1MRwCfdbsG4m5dNH9Cw07rAfAdOYV7GGE=
=CZdc
-----END PGP SIGNATURE-----

--Apple-Mail=_EF7E90A1-E40C-4BA3-8070-F02BED4F9425--
