From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 13:28:45 -0500
Message-ID: <20101019182845.GE25139@burratino>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:32:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8GzB-0000kd-LZ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab0JSSc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 14:32:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63286 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0JSSc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:32:27 -0400
Received: by ywi6 with SMTP id 6so1418599ywi.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WLBJIj3CbqhFcPsHK43TVbZX7i30RLwlbjbYGnS75BU=;
        b=kk2zG7ZEsqQUBvcS8zBSVjaD2OQnyFHZrxF4eY4sBtRu1CGM0XnaW6/SjpsxylpbvY
         gxndbJDr+8bWxnNpUuUgs01zCL37UGa+Gwr24P2TDEZy+Tw5gW18fyiyZO55isktnafx
         eBmknTdQrc+OZSwabAB6+Ccy2iw72ebr7LleQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Gt0UuHNoN/XMqHPoeRJA6QtYA5uJ0hezJ2fzInpS8K8sY42aTXDoMh/6AkEvsMpLcC
         ODpqfCaWbZTMeamcCkZ55Mm41Wek5LHSUv0e+14lk6zAeexKVw5QfpFYjvRBbQDouhDE
         T7bUNhO6CZU0wzfxvVZV8yuV9Ha9C2hk5DAhc=
Received: by 10.103.165.10 with SMTP id s10mr3778416muo.19.1287513145123;
        Tue, 19 Oct 2010 11:32:25 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id o6sm2495956fal.39.2010.10.19.11.32.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 11:32:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019175103.GA28847@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159348>

Ramkumar Ramachandra wrote:

> --=20
> 1.7.2.2.409.gdbb11.dirty

Please, one patch per message in the future.

> Sverre Rabbelier writes:
>> On Mon, Oct 18, 2010 at 15:45, Thore Husfeldt <thore.husfeldt@gmail.=
com> wrote:

>>> =C2=A0 =C2=A0(use "git unstage <file>" to unstage)
>>
>> This would be extra nice since 'git unstage' could also be used in a
>> fresh repository.

My vague unhappiness at "git reset" may have come from this.

Wouldn't it make sense to make "git reset" basically a synonym for
"git rm --cached" when in the 'branch yet to be born' case?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..cde103f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -236,6 +236,7 @@ static void die_if_unmerged_cache(int reset_type)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i =3D 0, reset_type =3D NONE, update_ref_status =3D 0, quiet =3D =
0;
+	int unborn_branch =3D 0;
 	int patch_mode =3D 0;
 	const char *rev =3D "HEAD";
 	unsigned char sha1[20], *orig =3D NULL, sha1_orig[20],
@@ -299,13 +300,27 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
 		}
 	}
=20
-	if (get_sha1(rev, sha1))
+	if (!strcmp(rev, "HEAD")) {
+		/* We may be on a branch yet to be born. */
+		resolve_ref("HEAD", sha1, 0, NULL);
+		if (is_null_sha1(sha1)) {
+			unborn_branch =3D 1;
+			commit =3D NULL;
+			hashcpy(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN);
+
+			/* Only accept "git reset -- <paths>" form, for now. */
+			if (i =3D=3D argc || patch_mode)
+				die("Failed to resolve 'HEAD' as a valid ref.");
+		}
+	} else if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
=20
-	commit =3D lookup_commit_reference(sha1);
-	if (!commit)
-		die("Could not parse object '%s'.", rev);
-	hashcpy(sha1, commit->object.sha1);
+	if (!unborn_branch) {
+		commit =3D lookup_commit_reference(sha1);
+		if (!commit)
+			die("Could not parse object '%s'.", rev);
+		hashcpy(sha1, commit->object.sha1);
+	}
=20
 	if (patch_mode) {
 		if (reset_type !=3D NONE)
