From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Fri, 4 Jun 2010 16:18:11 -0500
Message-ID: <20100604211811.GA7471@progeny.tock>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 23:18:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKeHY-0005Xu-BN
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab0FDVST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 17:18:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:36833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0FDVSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 17:18:18 -0400
Received: by pxi8 with SMTP id 8so446703pxi.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RzLyyZtbeRovrsSdhsfDqldyBVNRpkhpYMsBJukn0F8=;
        b=gx0ZpuT7ne0fb+9MnZcOhovZLBSjjxHPpEFUTUYKm9JRehgqS0KOktYsGKe6jfzZS4
         hY0feEBriBsXuCIxoduQiQ9SNjKTN4m/bScfIJWW1catH3458c2cJM3Mu7JD8IvqIDKu
         x723TC/WZCOeS9d/IxpLIiTVRDwoYArzLmQl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=L/zZDlhQOnvyQwQKCJJj3oWxbZdPgAgozJUSV1bW5ay7dJY79Gle9Oo7dt1cDgzFLJ
         lwnaCnjZLai64woYrisNckX+egujtR6rwvqFn3RRdCemPcoEHE/D92G7y2nNdXsALd/B
         iLrMLRkfTtu3tovUy3CPV9mkDoSyjD2bWWRj0=
Received: by 10.143.25.38 with SMTP id c38mr8545010wfj.251.1275686297717;
        Fri, 04 Jun 2010 14:18:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v41sm1000461wfh.9.2010.06.04.14.18.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 14:18:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148439>

Junio C Hamano wrote:

> * gv/portable (2010-05-14) 18 commits
[...]
>  - Do not use "diff" found on PATH while building and installing

That patch (d1b1a919) breaks merge-one-file when run outside the test
suite as far as I can tell.

Maybe it could be made portable with =E2=80=98git diff --no-index=E2=80=
=99?

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 3145009..d067894 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -107,7 +107,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# remove lines that are unique to ours.
 		orig=3D`git-unpack-file $2`
 		sz0=3D`wc -c <"$orig"`
-		$DIFF -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
+		diff -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
 		sz1=3D`wc -c <"$orig"`
=20
 		# If we do not have enough common material, it is not
--=20
