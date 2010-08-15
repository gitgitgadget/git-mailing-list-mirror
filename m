From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 06/12] apply: run setup_git_directory_gently() sooner
Date: Mon, 16 Aug 2010 08:34:51 +1000
Message-ID: <AANLkTim6E8JFyjM=gdhbobm4sOskCJyHvT5oGj9fhoAd@mail.gmail.com>
References: <20100626192203.GA19973@burratino>
	<7vpqzacs3h.fsf@alter.siamese.dyndns.org>
	<7v630hyf5r.fsf@alter.siamese.dyndns.org>
	<20100806023529.GB22369@burratino>
	<20100806030844.GJ22369@burratino>
	<AANLkTi=pAvJ=R9XVvo9fJqo6RPa+hn3dMfj2UGqTFCbU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 00:34:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okln8-0004DO-SL
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 00:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab0HOWex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 18:34:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51496 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0HOWew convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 18:34:52 -0400
Received: by wwj40 with SMTP id 40so5650806wwj.1
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mCGgxB3jOxcB3sc+WZShFSTRD+5nVqXiLfc/60UYGxY=;
        b=kxgaqxhWyX3VXIjdNJhVFp9Fu7oqm6nf0lzvXoPaBnqNn3zoo+o7AIfXQrwbFHArzz
         Qn6zx2DQKuajiJWRtPA7RzfaNBaWHg3dETAcdcgfDK5sax2uI5caZOp5ae6mOMAbUOr9
         g//54gKbxyZQ8zQh/pc7XFL77glMZYmCFsuTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aND83bbWMNFgGYIRjCygDQI6JBXdqQGl+pxV7Z2WamYgKAUT00erR+LjSEEqoTztcJ
         4dXt/D8B58J5Rha85zV276yBR12Ym6rVUDti3MRONlcUm7v/9y2f31kauZ6LHAifqLFo
         eSLitm3eOVHzUKG9kPSe6GXURQKCqPfJtP+Ck=
Received: by 10.216.30.10 with SMTP id j10mr1909197wea.8.1281911691655; Sun,
 15 Aug 2010 15:34:51 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Sun, 15 Aug 2010 15:34:51 -0700 (PDT)
In-Reply-To: <AANLkTi=pAvJ=R9XVvo9fJqo6RPa+hn3dMfj2UGqTFCbU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153626>

On Mon, Aug 16, 2010 at 6:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> 2010/8/6 Jonathan Nieder <jrnieder@gmail.com>:
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> As v1.7.2~16^2 (2010-07-14) explains, without this change,
>> =E2=80=9Cgit --paginate apply=E2=80=9D can ignore the repository-loc=
al
>> =E2=80=9C[core] pager=E2=80=9D configuration.
>
> Applying this patch broke the following tests:
>
> =C2=A0 =C2=A0./t4119-apply-config.sh ./t4111-apply-subdir.sh
> ./t4131-apply-fake-ancestor.sh
>
> I didn't look into why, they're breaking in pu now at 6ea3604. I
> didn't look into why, see the smoke report at
> http://smoke.git.nix.is/app/projects/report_details/33

The patch loses prefix and git-apply couldn't find files on disk. This
patch may fix it. I'm running tests now.

diff --git a/builtin/apply.c b/builtin/apply.c
index 6c4b747..29f4194 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3779,7 +3779,7 @@ static int option_parse_directory(const struct
option *opt,
 	return 0;
 }

-int cmd_apply(int argc, const char **argv, const char *unused_prefix)
+int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
 	int errs =3D 0;
@@ -3856,6 +3856,7 @@ int cmd_apply(int argc, const char **argv, const
char *unused_prefix)
 		OPT_END()
 	};

+	prefix =3D prefix_;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
--=20
Duy
