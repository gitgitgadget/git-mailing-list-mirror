From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 07/12] utf8: keep NULs in reencode_string()
Date: Sat, 30 Mar 2013 18:06:26 +0100
Message-ID: <51571B92.80303@web.de>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com> <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?InRibyA+PiBUb3JzdGVuIELDtmdlcnNoYXVzZW4i?= 
	<tboegi@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 18:07:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULzFG-000606-EY
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 18:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab3C3RGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 13:06:42 -0400
Received: from mout.web.de ([212.227.15.3]:59419 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756706Ab3C3RGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 13:06:41 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lp7HY-1UpoCl106e-00fEPQ; Sat, 30 Mar 2013 18:06:27
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1364636112-15065-8-git-send-email-pclouds@gmail.com>
X-Provags-ID: V02:K0:Px7z0got82jZ5uVHitu8BxLcMfdJ8j5UGJdX9ONulvI
 OLLEvByn0WMl46H4VOJPWEdWmut26toWxAAXRVyEaVqZBaiBJB
 yCeenXm1lN8hqYRAHmhN+sPXCyXVSMULBQyZd/RE6+Rf7k43ES
 80IA+fOBw+ejIx6KyrnIYPUVHTga7BId+L1GAGnAddKaSJyGLa
 gRzrp4E0uUPwxtoZeWk/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219593>

On 30.03.13 10:35, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[...]
The short version of a review:
Would it make sense to leave  reencode_string() as it is,
and add a new function reencode_string_len()

+char *reencode_string_len(const char *in, int insz,
+		      const char *out_encoding, const char *in_encoding,
+		      int *outsz)

And I didn't manage to apply the patch on master (631bc94e67383b66da190=
550866566f09d32)
is there a specific commitID it should be applied on ?

/Torsten




> pretty output, which can contain NULs.
> -		reencoded =3D reencode_string(message, "UTF-8", encoding);
> +		reencoded =3D reencode_string(message, strlen(message),
> +					    "UTF-8", encoding, NULL);

> -	out =3D reencode_string(line->buf, metainfo_charset, charset);
> +	out =3D reencode_string(line->buf, line->len,
> +			      metainfo_charset, charset, NULL);

> -			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose);
> +			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, =
NULL);
> -		char *reencoded =3D reencode_string(msg, output_encoding, utf8);

> +		char *reencoded =3D reencode_string(msg, strlen(msg),
> +						  output_encoding, utf8,
> +						  NULL);

> -		out =3D reencode_string(msg, output_encoding, use_encoding);
> +		out =3D reencode_string(msg, strlen(msg),
> +				      output_encoding, use_encoding, NULL);

> -		out->reencoded_message =3D reencode_string(commit->buffer,
> -					git_commit_encoding, encoding);
> +		out->reencoded_message =3D
> +			reencode_string(commit->buffer, strlen(commit->buffer),
> +					git_commit_encoding, encoding, NULL);

> =20
> +char *reencode_string_len(const char *in, int insz,
> +		      const char *out_encoding, const char *in_encoding,
> +		      int *outsz)
> =20
