From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Thu, 09 Dec 2010 13:10:43 -0800
Message-ID: <7vipz2fy98.fsf@alter.siamese.dyndns.org>
References: <m3eiatfbg2.fsf@localhost.localdomain>
 <1289407021-30287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, peff@peff.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 22:11:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnle-0007N2-RB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0LIVLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 16:11:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab0LIVLD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 16:11:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 602A0360E;
	Thu,  9 Dec 2010 16:11:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dnsjNOriq1kV
	6nDFu0FHKmM4yUo=; b=LCj3GK+JWU7f/aIQnGHN1a9i6z6N9fkvLy8DObbgfiQE
	V/HRwTSFW+tKqVN6nGobjLWxSkcB2x1A71cavNJ/iiYEgrmWRFA3iQHXyDs2a9wm
	iKn3y7oobE0RpTehoo3b5ZtVuSh37fnQdRqRy1rUjIiLzZaULWDCZIfCXeFYSrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fP0Ikq
	OIwuCSWYDflH77nS86zqMzkBX0N8toBlqEMWp+MvCN6cK8RVpw+8q961Aq6mkeyg
	H1DOntio1ZgyheEpM3jhXcXdx567gOgVR16uc9TuhvFJVhHPNMrbv0/nyHsUCXnn
	jqwMBfK98iMueP/jLYA4LQL+I9gJ/2M7VKFLc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0ED7360D;
	Thu,  9 Dec 2010 16:11:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C632E3607; Thu,  9 Dec 2010
 16:11:09 -0500 (EST)
In-Reply-To: <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 10 Nov
 2010 23\:37\:01 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DD2A4B80-03D8-11E0-9ACD-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163321>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Currently :path and ref:path can be used to refer to a specific objec=
t
> in index or ref respectively. "path" component is absolute path. This
> patch allows "path" to be written as "./path" or "../path", which is
> relative to user's original cwd.
>
> This does not work in commands that startup_info is NULL
> (i.e. non-builtin ones).
> ---
>  On Wed, Nov 10, 2010 at 07:26:20AM -0800, Jakub Narebski wrote:
>  > The <obj>:<sth> is (with single exception of ':/<regexp>') about
>  > selecting subitem (path): <tree-ish>:<path>, [:<stage>]:<path>
>
>  I feel the urge of keeping ':./path' and ':../path' out of this
>  competition.
>
>  The idea is old although I don't remember if anybody has made any
>  attempt to realize it: use './' and '../' to specify the given path
>  is relative, not absolute.

I've had this queued for some time, with help from Jonathan, and am hap=
py
about it in general, but after taking another look at it, noticed one
minor thing.

> diff --git a/sha1_name.c b/sha1_name.c
> index 484081d..791608d 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1060,25 +1060,35 @@ int get_sha1_with_context_1(const char *name,=
 unsigned char *sha1,
>  	if (!ret)
>  		return ret;
>  	/* sha1:path --> object name of path in ent sha1
> -	 * :path -> object name of path in index
> +	 * :path -> object name of absolute path in index
> +	 * :./path -> object name of path relative to cwd in index
>  	 * :[0-3]:path -> object name of path in index at stage
>  	 * :/foo -> recent commit matching foo
>  	 */
>  	if (name[0] =3D=3D ':') {
>  		int stage =3D 0;
>  		struct cache_entry *ce;
> +		char *new_path =3D NULL;
>  		int pos;
>  		if (namelen > 2 && name[1] =3D=3D '/')
>  			return get_sha1_oneline(name + 2, sha1);
>  		if (namelen < 3 ||
>  		    name[2] !=3D ':' ||
> -		    name[1] < '0' || '3' < name[1])
> +		    name[1] < '0' || '3' < name[1]) {
>  			cp =3D name + 1;
> +			if (startup_info && cp[0] =3D=3D '.' &&
> +			    (cp[1] =3D=3D '/' || (cp[1] =3D=3D '.' && cp[2] =3D=3D '/')))=
 {
> +				new_path =3D prefix_path(startup_info->prefix,
> +						       strlen(startup_info->prefix),
> +						       cp);
> +				cp =3D new_path;
> +			}
> +		}

This deals with ":$foo" (path $foo in the index), which is a shorthand =
for
":0:$foo" (the path $foo at stage #0 in the index).  However...

>  		else {
>  			stage =3D name[1] - '0';
>  			cp =3D name + 3;

=2E.. this side does not do anything about it, so:

	$ cd Documentation
        ... working for a while ...
        $ git merge another_branch
        ... oops, got conflicts at ../Makefile
	$ git show :2:../Makefile

won't work.

Besides, it is a bad idea to make ":../Makefile" work while leaving
its longhand ":0:../Makefile" not.

I think it is just the matter of moving "if (startup-info)..." logic
outside the "is the :$path lacking an explicit stage number" block and
having it after that if/else, no?
