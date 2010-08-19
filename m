From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: fix syntax error in "Use advise() for hints"
 test
Date: Wed, 18 Aug 2010 23:30:36 -0500
Message-ID: <20100819043036.GD25649@burratino>
References: <20100811083100.GA16495@burratino>
 <1282142204-14720-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 06:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olwns-0007Ev-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 06:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911Ab0HSEcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 00:32:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50600 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0HSEcT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 00:32:19 -0400
Received: by gyd8 with SMTP id 8so513498gyd.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YZ4lcT9O542wNBVTkRM8nk6qW9/g408qR+BEVtFX3HI=;
        b=Fjt3jUGkIfXCD4xmYsdhWk5AHZsAwmqumquKpFpSNPrXFB+DHD1kHVsBEB/MQK7e3q
         1hQWjvVDXN3MVV/fJXio9mr2mutTnU5l1tq2h1FxUNjaW4j2NipwYyleopuPwTrPCzg1
         DBF6l5+hUH0c+NmJdKuyFErT80Nzc4vFgpvxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jddZtm2D79WgeuYoqphWBXFqypvGB8CNVyEgE2mapBJ6pci03eJ5xazgwIwh4RZK7r
         mQpVzzV3SkZ5MbksePg2F+ikuMgSH1iUC0hYTH3NaBBDmAoJ/d1/JOVrqX+oNUovNWGN
         NhFYrqi7U+q78VI7rwfLE3e26DJ+HB9pP28k4=
Received: by 10.100.138.6 with SMTP id l6mr10485949and.192.1282192338175;
        Wed, 18 Aug 2010 21:32:18 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id i25sm1641033anh.17.2010.08.18.21.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 21:32:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282142204-14720-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153908>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the test introduced in the "Use advise() for hints" patch by
> Jonathan Nieder not to use '' for quotes inside '' delimited code.

Yikes.  Thanks for catching this.

> -test_expect_success 'advice from failed cherry-pick' '
> +test_expect_success 'advice from failed cherry-pick' "
[...]
>  	cat <<-EOF >expected &&
> -	error: could not apply $picked... picked
> +	error: could not apply \$picked... picked

Although the style you chose is arguably the least ugly, nested shell
interpolation can be hard to follow.  How about this?

-- 8< --
Subject: t3507 (cherry-pick): escape quotes in "Use advise()" test

Do not use unescaped '' quotes inside ''-delimited code.  Otherwise,
this test tries to read a file named "paths" in the test repository,
resulting in the error:

 t3507-cherry-pick-conflict.sh: 59: cannot open paths: No such file

Based-on-patch-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 3f29594..6026e7e 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -50,8 +50,8 @@ test_expect_success 'advice from failed cherry-pick' =
'
 	cat <<-EOF >expected &&
 	error: could not apply $picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
-	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit -c $picked'
+	hint: with '\''git add <paths>'\'' or '\''git rm <paths>'\''
+	hint: and commit the result with '\''git commit -c $picked'\''
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
=20
--=20
1.7.2.1.544.ga752d.dirty
