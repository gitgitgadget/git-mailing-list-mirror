From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix
 to output file names
Date: Sun, 14 Jun 2009 01:29:33 -0700
Message-ID: <4A34B4ED.6060301@gmail.com>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org> <1244963400-1739-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFl61-0007bA-Pi
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbZFNI3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 04:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbZFNI3g
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:29:36 -0400
Received: from mail-px0-f187.google.com ([209.85.216.187]:56350 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbZFNI3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:29:33 -0400
Received: by pxi17 with SMTP id 17so1416728pxi.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 01:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=xSglo+vkXOVrI/8pME5ehBkCqHoIsa6MfB/EA2EpESk=;
        b=C6DP38QTnzcXjMnDX1iMh4Hn5oM9mwk5rCs7VJVxGbhlT1pWekyqHDr6pIwcHy5DOA
         jm/p0uFwldE+ghyk3RZ+J+jU0Eo1WBw7GYkz7hPFysk1R48kKVwOK/CrljRlzBFIEziw
         GpOW82d1DjdUVKcMdbgeg2G2XpXvQI2NYQ9j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tXcP7sjBZyaNuYQE7cJZMAop9WJe34kcPQQGm7+I1wKdyDfRQZUO0RAf8aysR8QARQ
         qGZdFtWS9M1izS8gJJbVxTIb0momDeSgvlO4J+DHDlcECipBjkCSJLZFP1c10BJM/N9A
         dW/8OkuAgBRASIcAKQIQVzDTarf+S/A/yeBgg=
Received: by 10.114.211.2 with SMTP id j2mr9473389wag.139.1244968175873;
        Sun, 14 Jun 2009 01:29:35 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id c26sm4002520waa.50.2009.06.14.01.29.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 01:29:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1244963400-1739-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121546>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> diff --git a/log-tree.c b/log-tree.c
> index 59d63eb..139c8b5 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -180,12 +180,13 @@ static int has_non_ascii(const char *s)
>  	return 0;
>  }
> =20
> -void get_patch_filename(struct commit *commit, int nr, const char *s=
uffix,
> -			struct strbuf *buf)
> +void get_patch_filename(struct commit *commit, int nr, const char *p=
refix,
> +			const char *suffix, struct strbuf *buf)
>  {
>  	int suffix_len =3D strlen(suffix) + 1;
> -	int start_len =3D buf->len;
> +	int start_len =3D buf->len + strlen(prefix);
> =20
> +	strbuf_addstr(buf, prefix);
>  	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
>  	if (commit) {
>  		int max_len =3D start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
>  =20

Why does the prefix length not count against the filename length? I
think you want to subtract a prefix_len.

Also, this doesn't replace the numbering (0001, 0002, etc.) which I
consider to be a prefix. Does anyone else feel the same way?

This is kind of a funny thought, but I'll throw it out there. Could you
just put the desired prefix in your patch subjects, and then add an
option for no-numbered-files? So in your case, you add "dbus 1.2.3" at
the start of each subject during git-commit and then format-patch with
--no-numbered-files. This way you get git to insert the dashes you want=
,
other people get files with no numbers, and you don't have to deal with
slashes and directory prefixes.

I'm kind of confused about this though. The patches you're generating
for Gentoo are not being read by humans; merely being applied by portag=
e
correct? Are you going back and removing the mail headers and commit
messages from these patches? What I'm getting at is for your case
format-patch may be overkill.
