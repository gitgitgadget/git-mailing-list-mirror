From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 4/9] index-helper: new daemon for caching index and
 related stuff
Date: Mon, 02 Nov 2015 17:14:11 -0500
Organization: Twitter
Message-ID: <1446502451.4131.26.camel@twopensource.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
	 <1446385369-8669-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:14:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNMv-0001vR-J4
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbbKBWOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 17:14:20 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35884 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbKBWON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:14:13 -0500
Received: by qgad10 with SMTP id d10so128343948qga.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 14:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=X3QGwa+xT8ms/5nkuj5FiqwdHH0SkAZWRwumrbKSlt0=;
        b=K6Gl/LTD9lvro+KkzEnw50A43VVxMnnXcmtpG883oEdQXo2vWN6n+9FloRs3FNnM8I
         zHRxNV2NzpqSfIyzH9FwKMlUZEiMIrmH5gZeBmG0oyawvsPkztzDpvI81lxffK4kSvLS
         qcRN46j9UUmwJvUb/6YOGB+wDV+r6UyY1PpXVBYxnQUO5cvAnyM2o7GvOJoODjxB9Qsc
         ZBJBsBFKKfuAjQDm1nChl6MZ+80M5ESwBJE64Mjucdvize2EGy8mFkEZQtr8VCPuP//w
         UrhHnBLGwOQb4Tf3as0hNM2j1OGF1rI0Q1lZ2//PfxTajmqiH1h3UUBNBI+fmXJpG2vp
         UWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=X3QGwa+xT8ms/5nkuj5FiqwdHH0SkAZWRwumrbKSlt0=;
        b=hEhykDGoMI9bCgQpX6L2m4H1omgA88o7OjdbClcwWoype+zb23Lqn8vHQNHOkeowUy
         3Fh0Gy/E7f5eY9B6iKXE019o8sxmu4+DwUcMGVqoz1YdMCFPWLd9GqS14yMA5E1eCBpd
         yAxJ8D+nTUAd0jtS6IaaZismtsDIyKKkdgcYS3ZNJyb9jqDZ5VDx3Y1yaapetjTvTPvl
         FtmQW2NhV5QLA435w7XsOwo8LiRfOzr/9zoNFsu4WcpSS0UZ4sGX5S9f1N+7CgmF70S4
         vGVXGsSHv2cde/ELDOcZYLmpa/WKiGaF/CF/9mNJorjph3Z0B83L4h6os+Nb51PK9VYA
         9s5w==
X-Gm-Message-State: ALoCoQmd1GA6swRWo6ke4FIP5bYIugtCttkNxJEBkHug9MF53SAvxWVFA3f/7+XEL8BEKG8w65ju
X-Received: by 10.140.165.205 with SMTP id l196mr33122802qhl.101.1446502453038;
        Mon, 02 Nov 2015 14:14:13 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id m64sm5395117qhm.1.2015.11.02.14.14.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 14:14:12 -0800 (PST)
In-Reply-To: <1446385369-8669-5-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280729>

On Sun, 2015-11-01 at 14:42 +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> +	memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
> +
> +	/*
> +	 * The trailing hash must be written last after everything is
> +	 * written. It's the indication that the shared memory is now
> +	 * ready.
> +	 */
> +	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha=
1);
> +}

You need a memory barrier here.  Otherwise, compilers may reorder these
statements.

> +#define SHM_PATH_LEN 72		/* we don't create very long paths.. */
> +
> +ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap=
,
> +		    int prot, int flags, const char *fmt, ...)
> +{
> +	va_list ap;
> +	char path[SHM_PATH_LEN];
> +	int fd;
> +
> +	path[0] =3D '/';
> +	va_start(ap, fmt);
> +	vsprintf(path + 1, fmt, ap);
> +	va_end(ap);

This would be safer with vsnprintf.
