From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] clone: support atomic operation with --separate-git-dir
Date: Sat, 05 Jan 2013 22:20:30 +0100
Message-ID: <50E8991E.4090605@gmail.com>
References: <50E74145.4020701@gmail.com> <7vzk0osjli.fsf@alter.siamese.dyndns.org> <50E83224.2070701@web.de> <50E83DAE.1080500@web.de> <50E88A40.9010904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbAl-0002pd-Sl
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab3AEVUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:20:37 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:51727 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab3AEVUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:20:36 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so8648787wey.19
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=gmf9FbKXjXuWX4+WBiEyNu7eaYekrH7ntIPRYPOD+Dk=;
        b=wxZ6jCL2WP9knwGDqemdpqZ82eRKjIGHGhLKqxKyDFjKCpev/jbHWB47WUK5gxVMv5
         MOm5+j9dLA1lKEBTRC4D4j7HW5flAhQoi6dshSBocZWDfd6PhQ/fuvwQanX15+3FYvSb
         Ulp4297CY3cuAx2BUZIh1yttHmZspGK4W337LIB1LJhHXqOTn+EExjJ3/qsQMAriZhNV
         E1Rh1hSwxTSoLRSrXqILv+5PIdhzvsA8fz3Yu9cCV7NNabkGh7spAl8OwqdH7gaMphHJ
         AivtR0hkxJUOcztTGziyeRqf8pkFNAA2WHOjLx8ha+3DjNtIZPhSBQ4bQDk8VySwXFBb
         agDw==
X-Received: by 10.194.121.74 with SMTP id li10mr78502096wjb.5.1357420834784;
        Sat, 05 Jan 2013 13:20:34 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id bd6sm5027014wib.10.2013.01.05.13.20.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Jan 2013 13:20:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <50E88A40.9010904@web.de>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212715>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 21:17, Jens Lehmann ha scritto:
> Since b57fb80a7d (init, clone: support --separate-git-dir for .git file)
> git clone supports the --separate-git-dir option to create the git dir
> outside the work tree. But when that option is used, the git dir won't be
> deleted in case the clone fails like it would be without this option. This
> makes clone lose its atomicity as in case of a failure a partly set up git
> dir is left behind. A real world example where this leads to problems is
> when "git submodule update" fails to clone a submodule and later calls to
> "git submodule update" stumble over the partially set up git dir and try
> to revive the submodule from there, which then fails with a not very user
> friendly error message.
> 
> Fix that by updating the junk_git_dir variable (used to remember if and
> what git dir should be removed in case of failure) to the new value given
> with the --seperate-git-dir option. Also add a test for this to t5600 (and
> while at it fix the former last test to not cd into a directory to test
> for its existence but use "test -d" instead).
> 
> Reported-by: Manlio Perillo <manlio.perillo@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> [...]
> And this fixes it for me. Manlio, it'd be great if you could test
> this patch (but please not only remove .git/modules/<name> but also
> the submodule work tree before doing that).
> 

I can confirm that the patch solves the problem I reported.


Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDomR4ACgkQscQJ24LbaUQszACfV42L9Xcy+mme6RY/vY+K2H4T
QDAAoIIupUSjwv6qUgzUMQV1aNplrWJD
=uN3W
-----END PGP SIGNATURE-----
