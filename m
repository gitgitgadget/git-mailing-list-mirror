From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] revert: improve success message by adding
 abbreviated commit sha1
Date: Thu, 15 Jul 2010 17:51:41 -0500
Message-ID: <20100715225141.GB7253@burratino>
References: <20100713232816.7738.78221.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 00:52:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZXIG-0001Ic-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 00:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934929Ab0GOWwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 18:52:35 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41332 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934916Ab0GOWwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 18:52:34 -0400
Received: by qyk38 with SMTP id 38so251137qyk.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SaABTArg/qP8+CmoQDFw1oZ6OKneqhyUkeYzJScO/aU=;
        b=Efo52vu9/Y3FdSH6NNafDsm72mbnZH6+u5FaJiZpZKW/ZRDAPFoBmtMsnkAF62Fj/5
         66V8c7vCpwnam56zfJI/Dk878N3hu50Wf+XBxxmu21xRwEASXk4RgyIHfpmrV6pyQgoM
         W1HAxSjxZNL+bM6IBl65Pu8+xLTpMA8Uu00EI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FS9DtHvIa9CMoh70iSQeb6w+uYAd31Oz/LFL4q3jw+3aEGr5cipXp9itNQQwciAhAF
         pIXlF4WnHHtIoeGjO0sbd+dgKa0j5rDdj4KOTfvajQbHccea9m19BUq+7e4o62YGooBP
         UjOz+a9D2gzhw6HHLFcr/uG3QDQlXz4L7xOrE=
Received: by 10.224.103.20 with SMTP id i20mr135211qao.263.1279234352313;
        Thu, 15 Jul 2010 15:52:32 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id fb41sm6843170qcb.3.2010.07.15.15.52.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 15:52:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713232816.7738.78221.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151126>

Christian Couder wrote:

> --- a/t/t3508-cherry-pick-many-commits.sh
> +++ b/t/t3508-cherry-pick-many-commits.sh
> @@ -24,9 +24,9 @@ test_expect_success setup '
> =20
>  test_expect_success 'cherry-pick first..fourth works' '
>  	cat <<-EOF > expected &&
> -	Finished one cherry-pick.
> -	Finished one cherry-pick.
> -	Finished one cherry-pick.
> +	Finished cherry-pick commit $(git rev-parse --short second).
> +	Finished cherry-pick commit $(git rev-parse --short third).
> +	Finished cherry-pick commit $(git rev-parse --short fourth).

If the redirections are changed to <<-\EOF before, then they would
need to be changed back to <<-EOF here.

> Instead of "Finished one cherry-pick." or "Finished one
> revert.", we now print "Finished cherry-pick commit
> <abbreviated sha1>."

=E2=80=9CFinished cherry-pick of commit f67ab8.=E2=80=9D sounds more be=
tter to my ear.

	Finished cherry-pick of foo.
	Finished cherry-pick of bar.
	Finished cherry-pick of baz.
	etc

is a lot saner than

	Finished one cherry-pick.
	Finished one cherry-pick.
	Finisehd one cherry-pick.
	etc

Thanks for making it happen.

diff --git a/builtin/revert.c b/builtin/revert.c
index 36479f9..e261fb2 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -492,7 +492,7 @@ static int do_pick_commit(void)
 		}
 	}
=20
-	strbuf_addf(&mebuf, "%s commit %s", me,
+	strbuf_addf(&mebuf, "%s of commit %s", me,
 		    find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
=20
 	if (!strategy || !strcmp(strategy, "recursive") || action =3D=3D REVE=
RT) {
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-=
many-commits.sh
index 1bd3ca1..5af5905 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -24,9 +24,9 @@ test_expect_success setup '
=20
 test_expect_success 'cherry-pick first..fourth works' '
 	cat <<-EOF > expected &&
-	Finished cherry-pick commit $(git rev-parse --short second).
-	Finished cherry-pick commit $(git rev-parse --short third).
-	Finished cherry-pick commit $(git rev-parse --short fourth).
+	Finished cherry-pick of commit $(git rev-parse --short second).
+	Finished cherry-pick of commit $(git rev-parse --short third).
+	Finished cherry-pick of commit $(git rev-parse --short fourth).
 	EOF
=20
 	git checkout -f master &&
@@ -41,9 +41,9 @@ test_expect_success 'cherry-pick first..fourth works'=
 '
=20
 test_expect_success 'cherry-pick --strategy resolve first..fourth work=
s' '
 	cat <<-EOF > expected &&
-	Finished cherry-pick commit $(git rev-parse --short second) with stra=
tegy resolve.
-	Finished cherry-pick commit $(git rev-parse --short third) with strat=
egy resolve.
-	Finished cherry-pick commit $(git rev-parse --short fourth) with stra=
tegy resolve.
+	Finished cherry-pick of commit $(git rev-parse --short second) with s=
trategy resolve.
+	Finished cherry-pick of commit $(git rev-parse --short third) with st=
rategy resolve.
+	Finished cherry-pick of commit $(git rev-parse --short fourth) with s=
trategy resolve.
 	EOF
=20
 	git checkout -f master &&
--=20
