From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Tue, 16 Feb 2016 00:09:15 -0500
Message-ID: <20160216050915.GA5765@flurp.local>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan =?iso-8859-1?Q?Fr=FChwirth?= 
	<stefan.fruehwirth@uni-graz.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:09:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVXt9-0002ml-ST
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 06:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbcBPFJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 00:09:24 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33743 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcBPFJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 00:09:22 -0500
Received: by mail-ig0-f171.google.com with SMTP id y8so89343097igp.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W2V6NWOuYRtFCvCtikCdRnHW6QSx1kEdhs070Z1nFI0=;
        b=BY9F375ydRteBnt2wrQYAMdeUNARrOH6K/bwnmkkTmGLRHkme1HAgf29gmNYoe87QM
         Pc3q+/T3nBeFhFPbonjKoUivHtnkhnilYNTLV/036jD/UcamSAJLnz3npK0VKaVGfouf
         VGsGIb1mGwHR7Q5t5UWxuW2X7SMw6clekSgCtd6NcNnTNeLXG08M2jSMh5qdaSu1hj/M
         E9H54qkEi4kIwkStStG0QYY3eXi0kJfLAhhHDILpXxdX1AGSD/wFP2q+TBnm4tO4xTeY
         ggCSauR4TQQcRn/4/zZo2mSIvYOZwL3kAR2zCuTFjKgcg0koFOzzrIZbtOZG39HWZwTv
         glfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=W2V6NWOuYRtFCvCtikCdRnHW6QSx1kEdhs070Z1nFI0=;
        b=eelwxZseuxv75TNVZ2hADIF48BmB4azlIZRDZo5L1JU/y+/fqDXLc2QcTd3BUGtNvz
         utAjg2oVyGADhLqAy/+ro50+ML4XL4nszB3oQXY2qDdJPAy62AxoyDV6sJQjKa0wGMSG
         PXkfEeqjiv3Py3xJIoOL9vg+jhmRncMkUKSjq7UyxKSfruC7W0Ms9VyRDxp/iaixNfi1
         zDw2HQl8Zo3bpxYy9fcn+EIHP1W41Yhnv+pIhqnoxKE8pBOeHEWztxqS6AXeC5Jv1ZJn
         OICVSRsvzFEu56Ao5TyuMEVMOPgW5g/s/skpuqjH6+Pa78UXaQDUBV3F9wVBNOR5hqjo
         HVdA==
X-Gm-Message-State: AG10YORAeh2FgkRww6/qKZOUmOPWqt1iHspJkYF24BFjzgv97ubrwPO5l1plpBc4I7iMeQ==
X-Received: by 10.50.142.9 with SMTP id rs9mr4719278igb.26.1455599362290;
        Mon, 15 Feb 2016 21:09:22 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id 8sm13291757ioe.8.2016.02.15.21.09.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Feb 2016 21:09:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160216011258.GA11961@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286320>

On Mon, Feb 15, 2016 at 08:12:58PM -0500, Jeff King wrote:
> On Mon, Feb 15, 2016 at 10:39:39PM +0100, Stefan Fr=FChwirth wrote:
> > in one specific circumstance, git-merge-tree exits with a segfault =
caused by
> > "*** Error in `git': malloc(): memory corruption (fast)":
> >=20
> > There is a test case[1] kindly provided by chrisrossi, which he cra=
fted
> > after I discovered the problem[2] in the context of Pylons/acidfs.
>=20
> -- >8 --
> Subject: merge_blobs: use strbuf instead of manually-sized mmfile_t
>=20
> [...]
> It does so by calling xdiff with XDIFF_EMIT_COMMON, and
> stores the result in a buffer that is as big as the smaller
> of "ours" and "theirs".
>=20
> In theory, this is right; we cannot have more common content
> than is in the smaller of the two blobs. But in practice,
> xdiff may give us more: if neither file ends in a newline,
> we get the "\nNo newline at end of file" marker.
> [...]
>=20
> Reported-by: Stefan Fr=FChwirth <stefan.fruehwirth@uni-graz.at>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/merge-blobs.c b/merge-blobs.c
> @@ -51,19 +51,16 @@ static void *three_way_filemerge(const char *path=
, mmfile_t *base, mmfile_t *our
>  static int common_outf(void *priv_, mmbuffer_t *mb, int nbuf)
>  {
>  	int i;
> -	mmfile_t *dst =3D priv_;
> +	struct strbuf *dst =3D priv_;
> =20
> -	for (i =3D 0; i < nbuf; i++) {
> -		memcpy(dst->ptr + dst->size, mb[i].ptr, mb[i].size);
> -		dst->size +=3D mb[i].size;
> -	}
> +	for (i =3D 0; i < nbuf; i++)
> +		strbuf_add(dst, mb[i].ptr, mb[i].size);
>  	return 0;
>  }
> =20
>  static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_=
t *f2)
>  {
> -	unsigned long size =3D f1->size < f2->size ? f1->size : f2->size;
> -	void *ptr =3D xmalloc(size);
> +	struct strbuf out =3D STRBUF_INIT;
>  	xpparam_t xpp;
>  	xdemitconf_t xecfg;
>  	xdemitcb_t ecb;
> @@ -75,11 +72,15 @@ static int generate_common_file(mmfile_t *res, mm=
file_t *f1, mmfile_t *f2)
>  	xecfg.flags =3D XDL_EMIT_COMMON;
>  	ecb.outf =3D common_outf;
> =20
> -	res->ptr =3D ptr;
> -	res->size =3D 0;
> +	ecb.priv =3D &out;
> +	if (xdi_diff(f1, f2, &xpp, &xecfg, &ecb) < 0) {
> +		strbuf_release(&out);
> +		return -1;
> +	}
> =20
> -	ecb.priv =3D res;
> -	return xdi_diff(f1, f2, &xpp, &xecfg, &ecb);
> +	res->size =3D out.len; /* avoid long/size_t pointer mismatch below =
*/

It took a minute or two for me to realize that "mismatch below" was
talking about the second argument to strbuf_detach(). I tried
rewriting the comment to mention the second argument explicitly, but
couldn't come up with one sufficiently succinct. Oh well.

> +	res->ptr =3D strbuf_detach(&out, NULL);
> +	return 0;
>  }

My reviewed-by may not be worth much since this code is new to me
too, but this patch looks "obviously correct" to me, so:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Perhaps squash in the following test which I adapted from the
reproduction recipe provided by Chris Rossi[1]?

[1] https://gist.github.com/chrisrossi/f09c8bed70b364f9f12e


--- 8< ---
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 9015e47..1f2aa74 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -352,4 +352,22 @@ test_expect_success 'turn tree to file' '
 	test_cmp expect actual
 '
=20
+test_expect_success "don't underallocate result buffer" '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan some &&
+	git rm -rf . &&
+	printf "b\n" >a &&
+	git add a &&
+	git commit -m "first commit" &&
+	printf "\na" >b &&
+	git add b &&
+	git commit -m "second commit, first branch" &&
+	git checkout @^ &&
+	git checkout -b other &&
+	printf "a" >b &&
+	git add b &&
+	git commit -m "second commit, second branch" &&
+	git merge-tree @^ some other
+'
+
 test_done
--- 8< ---
