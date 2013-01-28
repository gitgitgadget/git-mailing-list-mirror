From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 10/11] format-patch: update append_signoff prototype
Date: Sun, 27 Jan 2013 19:35:41 -0800
Message-ID: <20130128033540.GN8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-11-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfWC-0008CQ-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab3A1Dfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 22:35:50 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:50037 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab3A1Dfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 22:35:47 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so1029177dak.34
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ffI9kVIh+3UBZnWMsWlrwcOsVpePoXS5GNbA/ZPC7CY=;
        b=KhedENdxW7h0BoAe+fo+UumXIZzSJPUnI0Re52bxOih3k8S73f9E1ik6T7qmCT2Nhd
         I4zlbTBs+LGrwj+0XtewrkhlktKS6H8wqV7dwmyl/QcjfefH3Om1OQ9rGYebFc57mEPQ
         0JijghyAmUIFcJCImh1CRieb/c3Df1YegG8t4JfvX/vkNEhgsyyruyg7sXM6ndCnS+9G
         falQcbbzHw8xkUcOxX1SAgg5NnVD4YD6JQ/WyL/7zY8u8uK376/3N72z8mwqNc9rW1nk
         tq8ef8fTN/pj4l4wf5Qn1RTi7eYy5Gdqj5VcDuTE9vzm2p2uwPXLRinS/8ohR8WUQEGZ
         V91Q==
X-Received: by 10.68.226.230 with SMTP id rv6mr34099226pbc.90.1359344147098;
        Sun, 27 Jan 2013 19:35:47 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bv10sm5839838pab.14.2013.01.27.19.35.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:35:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-11-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214798>

Brandon Casey wrote:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> This is a preparation step for merging with append_signoff from
> sequencer.c

Avoids a small unfreed allocation, too.  Neat.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(On the other hand, this means more malloc churn when running
"format-patch -s" on a long series of patches, but I don't think
anyone will mind.)

[...]
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1193,16 +1192,6 @@ int cmd_format_patch(int argc, const char **ar=
gv, const char *prefix)
>  		rev.subject_prefix =3D strbuf_detach(&sprefix, NULL);
>  	}
> =20
> -	if (do_signoff) {
> -		const char *committer;
> -		const char *endpos;
> -		committer =3D git_committer_info(IDENT_STRICT);

sequencer.c uses fmt_name() which uses IDENT_STRICT, too.  Phew.
