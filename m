From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/25] reflog: avoid constructing .lock path with git_path
Date: Tue, 25 Feb 2014 14:44:37 -0800
Message-ID: <xmqqr46q4xt6.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 23:44:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIQk1-0003Ii-W3
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 23:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbaBYWol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Feb 2014 17:44:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbaBYWol convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 17:44:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AC817012A;
	Tue, 25 Feb 2014 17:44:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uHh/ePAO1s9J
	YOYtfkDPcFwSfoU=; b=QhbElHzKOdoBiux6jXt/u2bYpvhNjJi9rO7ciLFUw3XF
	G0Zc5lAyuKClu9SYRVjv8AgtQYRSywvXJ16jr+IeoBSwzVf5WroZZr1B1EuqfIa9
	jJZVcDFCks5iJK6nruVft4yrVHFOZcosVgnJ/m+TQ6Lybclr7YlHivgrtTSaZ2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FDmZix
	4AJ0xJtUuh2Ih1FxWKhB1DHgwfFc2vPts8ynNXjyYCGAypKg5hcRce6XN7aorpGX
	VnmpkJGH2YrZOLytEga85bK2XOJYkR5x0lOwlWrQ7jPItMorXad0DtLx1xUFuYx8
	2p2E3Ah5yfgbG/knulKZeo3RUnnh4VNzHsbp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 642F170129;
	Tue, 25 Feb 2014 17:44:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A552770126;
	Tue, 25 Feb 2014 17:44:39 -0500 (EST)
In-Reply-To: <1392730814-19656-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6906397E-9E6E-11E3-8E5E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242691>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> git_path() soon understands the path given to it. Some paths "abc" ma=
y
> become "def" while other "ghi" may become "ijk". We don't want
> git_path() to interfere with .lock path construction. Concatenate
> ".lock" after the path has been resolved by git_path() so if "abc"
> becomes "def", we'll have "def.lock", not "ijk".

Hmph.  I am not sure if the above is readable (or if I am reading it
correctly).

If "abc" becomes "def", it would take deliberate work to make
"abc.lock" into "ijk", and it would be natural to expect that
"abc.lock" would become "def.lock" without any fancy trick, no?


> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/reflog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 852cff6..ccf2cf6 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -372,7 +372,7 @@ static int expire_reflog(const char *ref, const u=
nsigned char *sha1, int unused,
>  	if (!file_exists(log_file))
>  		goto finish;
>  	if (!cmd->dry_run) {
> -		newlog_path =3D git_pathdup("logs/%s.lock", ref);
> +		newlog_path =3D mkpathdup("%s.lock", log_file);
>  		cb.newlog =3D fopen(newlog_path, "w");
>  	}
