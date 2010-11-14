From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 12:16:05 -0600
Message-ID: <20101114181605.GI26459@burratino>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
 <1289747245-23263-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 19:16:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHh88-0008RO-UF
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 19:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab0KNSQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 13:16:39 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39422 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNSQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 13:16:38 -0500
Received: by ywc21 with SMTP id 21so1378946ywc.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IJEAorgbYt0QzB3SDGJOEWcbWS1NaLj/3aPG3vFS/x8=;
        b=Vp6Hh+zB9JEXFQcNVloIQeROpnWFPCwSln2Y2sY43vZQxiQ0utNJcAZ7hl8CLZg+gN
         W1MNeqUNDAQ5sPi1p3OoediDxkVbM0yFJ/dAp3NUnaKIJsbhcn5iu2KG/pCv0mEa3bgU
         Qh9c64q+tPqU6Rntx2GCkaRJj+gFoJYaptXTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KK4k7H4VaMsVwgD3o+0t+O9iUXvkQ8oYKRPR0+BI7PlP/yUyzglBkRwN7INp4Y5dwm
         vJWQvPXqD2h8kyUqD/NN6TR1WlQc4vW5FxuKymrShmpt3yTMXPJ0NrADmpBVXitvmgJ6
         1MOVUW8Q8rqh4aGnzpHASWO/O+fp7wIAzv5co=
Received: by 10.150.212.1 with SMTP id k1mr8011906ybg.257.1289758597953;
        Sun, 14 Nov 2010 10:16:37 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r6sm2305962yba.11.2010.11.14.10.16.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 10:16:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289747245-23263-3-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161430>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> These are the modifications I made to envsubst.c as I turned it into
> sh-i18n--envsubst.c:
>=20
>  * Added our git-compat-util.h header for xrealloc() and friends.
>=20
>  * Removed inclusion of gettext-specific headers.
>=20
>  * Removed most of main() and replaced it with my own. The modified
>    version only does option parsing for --variables. That's all it
>    needs.
>=20
>  * Modified error() invocations to use our error() instead of
>    error(3).
>=20
>  * Replaced the gettext XNMALLOC(n, size) macro with just
>    xmalloc(n). Since XNMALLOC() only allocated char's.
>=20
>  * Removed the string_list_destroy function. It's redundant (also in
>    the upstream code).
>=20
>  * Replaced the use of stdbool.h (a C99 header) by doing the followin=
g
>    replacements on the code:

Nit: can this be moved to a subdir?  Maybe po or i18n, or even
envsubst.  This could make it clearer that the code has an upstream
and should be updated when upstream is.

Jonathan
