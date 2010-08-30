From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: use subshell instead of cd $new && .. && cd
 $old
Date: Mon, 30 Aug 2010 10:57:23 -0500
Message-ID: <20100830155723.GC3292@burratino>
References: <1283169642-21917-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Carl Worth <cworth@cworth.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 17:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq6lS-0004cx-3W
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 17:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0H3P7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 11:59:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56836 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab0H3P7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 11:59:11 -0400
Received: by fxm13 with SMTP id 13so3342263fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vthsjIqeBZnyR0GQrXDRy+n3NfOeJ4r/PBF43U68UdU=;
        b=orkAkmTQkFfNKFgYHxQNM86INUOHCcYC14YvIJ0SbRJ4Q025lIN1RV5+ykc2GGkQYu
         xmJ8PRrL8vbm7T2pA86PKWEEnwZoPeJdjK1CkfVbSHi/jp5rv0MJG9gkkyIkOV7Eg71v
         8n/RiZOAYA7waA499ZNzXC74wr5IZzUbPiTqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sili2GLyMsuVun7unmW6usTWZj0nxbHJUJpB/Z9B6Xcxtwe5UdIE3xLqRmFCDdqMe1
         ZjntxcgCiuzUXro40opXk7Eo3q6V+hCxueBF+eMDuBk7NL6e/OWuORVSl0Z9Js0MZFlq
         mdimzha22n5w0kF6n+VB5sjM6cBfJK8H5og0Y=
Received: by 10.223.126.19 with SMTP id a19mr4009771fas.88.1283183950046;
        Mon, 30 Aug 2010 08:59:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r4sm3400671faa.43.2010.08.30.08.59.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 08:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283169642-21917-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154824>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/t/test-lib.sh
> @@ -687,14 +687,12 @@ test_when_finished () {
>  test_create_repo () {
>  	test "$#" =3D 1 ||
>  	error "bug in the test script: not 1 parameter to test-create-repo"
> -	owd=3D`pwd`
>  	repo=3D"$1"
>  	mkdir -p "$repo"
> -	cd "$repo" || error "Cannot setup test environment"
> +	(cd "$repo" || error "Cannot setup test environment"
>  	"$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BUILD_DIR/templates/bl=
t/" >&3 2>&4 ||
>  	error "cannot run git init -- have you built things yet?"
> -	mv .git/hooks .git/hooks-disabled
> -	cd "$owd"
> +	mv .git/hooks .git/hooks-disabled)

Style: why not use

	(
		cd "$repo" ...
		... .git/hooks-disabled
	)

?
