From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting
 GIT_EXIT_OK to GIT_EXIT_CODE
Date: Fri, 9 Oct 2009 14:28:12 -0500
Message-ID: <20091009192812.GA4122@progeny.tock>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, drizzd@aon.at, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 09 21:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwL39-0004IG-JM
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 21:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761088AbZJITUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760877AbZJITUl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 15:20:41 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:37700 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758847AbZJITUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 15:20:40 -0400
Received: by bwz6 with SMTP id 6so1839556bwz.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7XA4CJ3tGs6/8cynEL4bZX5N1FRBqcml6VOGS1NaAH8=;
        b=pZ+rcAC70sKZL7h3JFFs4BPRf8TaJ4aF5bqpXSQ4fStMdhYwUTE9CtFDsW/AEjJ+j7
         jt2Itfk593qhE5n/H/s+nJgW2l1um3XCuVSAlO0HWmq/5b6nZp+kuv1MYxFSbF/x6YnG
         p+B5Wj4VaJWUSXH/3J/QlE1GlDoeNmS32Pm8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=djRqSAE4iJuespuv0Im9NimWsS02JUxenoAmWPZ7IeDqk+NN/mX479EWc8QAJVOI3d
         TR0riVQsRzGlXNCTShqiDjCiiWAYKDH7oRFF6Ps1u/k6j4ZYfo+ZX4Dzwh6RQGDeoyq2
         bWcGR2PxlvfJ0wVnLFUjkpaYBTY+4jI8vvp7U=
Received: by 10.103.87.26 with SMTP id p26mr1268705mul.44.1255116002820;
        Fri, 09 Oct 2009 12:20:02 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e9sm120033muf.39.2009.10.09.12.19.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 12:20:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129834>

Brandon Casey wrote:

> So, rather than relying on the behavior of Bash in order to get the e=
xit
> code from $? inside die(), change GIT_EXIT_OK into GIT_EXIT_CODE, and=
 set
> it to the code that we want to exit with.  This allows the test suite=
 to
> be run with the Korn shell.
>=20
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

Sounds like a good idea.  A few thoughts:

start_httpd() from lib-httpd.sh uses a similar pattern:

lib-httpd.sh:96:        trap 'code=3D$?; stop_httpd; (exit $code); die'=
 EXIT

It is probably worth changing that, too, unless GIT_TEST_HTTPD would no=
t
work on these platforms for some other reason.

"GIT_EXIT_CODE=3D1; exit 1" sounds repetitive to my ear.  It=E2=80=99s =
probably just
me, but if not, it might be worth adding a function like

	expected_exit() {
		GIT_EXIT_CODE=3D$1
		exit "$1"
	}

I=E2=80=99m not sure.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f2ca536..64e793a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
[...]
> @@ -183,16 +183,16 @@ test_success=3D0
> =20
>  die () {
>  	code=3D$?
> -	if test -n "$GIT_EXIT_OK"
> +	if test -n "$GIT_EXIT_CODE"
>  	then
> -		exit $code
> +		exit $GIT_EXIT_CODE
>  	else
>  		echo >&5 "FATAL: Unexpected exit with code $code"
>  		exit 1
>  	fi
>  }

$code can be removed now, right?

Jonathan
