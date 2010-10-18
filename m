From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: filemodify after M 040000 <tree> ""
 crashes
Date: Sun, 17 Oct 2010 20:44:04 -0500
Message-ID: <20101018014404.GD25524@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20101011063429.GA32034@burratino>
 <20101018010005.GA25524@burratino>
 <20101018010338.GB25524@burratino>
 <AANLkTik3iSSzKCxi9aeNw+ATPXvTN6yw-=NDGtqCidce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 03:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7epM-0002T6-9c
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 03:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040Ab0JRBrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Oct 2010 21:47:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35007 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0JRBrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 21:47:45 -0400
Received: by gyg13 with SMTP id 13so125229gyg.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 18:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vhI7CSZ1JKKzHVJ+gEyjlkRMh6NacaAjTPIRCZY/PMk=;
        b=xY6At3C4J0SP/MU0R6okKRJXQV/cInz8Cji4vopoRUz+ehMOOvKWO7wa1lhFuVJzM/
         pBaXEXrBHclhEib/LGph4PFDRkfL4vwib3oR7JTqlbf2ITuVuWq3bbNQsmCMWYXTM72z
         NsKnyO3rewOlwWDfY1HtQ7n3H4Bpepziy3lL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VDit9rBUt784L9SMi+tqhFf03n6ff2KSLZsyvQ5qAW1cj7Kyg6J/TMuT8OFtYtRkEs
         ytW23gipX6v9qCLHzD1U/xDiC6BSEuBB9wn2BnakzWVrRDTReyvL5awFtpK/a55HUFzE
         Dm8Kaq1CU8q++Gl+ywLGtjA8E+QB37216f6Bg=
Received: by 10.236.108.131 with SMTP id q3mr6685335yhg.43.1287366461677;
        Sun, 17 Oct 2010 18:47:41 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g25sm12069618yhc.39.2010.10.17.18.47.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 18:47:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik3iSSzKCxi9aeNw+ATPXvTN6yw-=NDGtqCidce@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159224>

Sverre Rabbelier wrote:
> On Sun, Oct 17, 2010 at 20:03, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 040000 <tree> ""
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 100644 :1 "foo"
>>
>> and similar commands (using D, C, or R after resetting the root
>> tree) segfault.
>
> I'm curious, how come this not found earlier? Would seem like a fairl=
y
> regular operation?

Sure, though that isn't what the feature has been used for so far.

Hooray for tests. :)

-- 8< --
Subject: t9300 (fast-import): another test for the "replace root" featu=
re

Another test for the replace root feature.  One can imagine an
implementation for which R "some/subdir" "" would free some state
associated to the subdir and leave fast-import confused.

Luckily, git's is not such an implementation.

While at it, change the previous test to use C "some/subdir" ""
instead of R (i.e., test both syntaxes).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   43 ++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ce09457..dd90a09 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -990,11 +990,52 @@ test_expect_success \
 	COMMIT
=20
 	M 040000 $branch ""
-	R "newdir" ""
+	C "newdir" ""
 	INPUT_END
 	 git fast-import <input &&
 	 git diff --exit-code branch:newdir N9'
=20
+test_expect_success \
+	'N: modify subtree, extract it, and modify again' \
+	'echo hello >expect.baz &&
+	 echo hello, world >expect.qux &&
+	 git fast-import <<-SETUP_END &&
+	commit refs/heads/N10
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
+	data <<COMMIT
+	hello, tree
+	COMMIT
+
+	deleteall
+	M 644 inline foo/bar/baz
+	data <<EOF
+	hello
+	EOF
+	SETUP_END
+
+	 tree=3D$(git rev-parse --verify N10:) &&
+	 git fast-import <<-INPUT_END &&
+	commit refs/heads/N11
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
+	data <<COMMIT
+	copy to root by id and modify
+	COMMIT
+
+	M 040000 $tree ""
+	M 100644 inline foo/bar/qux
+	data <<EOF
+	hello, world
+	EOF
+	R "foo" ""
+	C "bar/qux" "bar/quux"
+	INPUT_END
+	 git show N11:bar/baz >actual.baz &&
+	 git show N11:bar/qux >actual.qux &&
+	 git show N11:bar/quux >actual.quux &&
+	 test_cmp expect.baz actual.baz &&
+	 test_cmp expect.qux actual.qux &&
+	 test_cmp expect.qux actual.quux'
+
 ###
 ### series O
 ###
--=20
1.7.2.3
