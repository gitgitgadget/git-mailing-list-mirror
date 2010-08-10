From: James Shubin <purpleidea@gmail.com>
Subject: [PATCH v3] Gitweb: Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 12:47:29 -0400
Message-ID: <1281458849.28858.18.camel@ping.CS.McGill.CA>
References: <AANLkTi=42V8=26oEwcNOHubuK+VAf-QaYnvCLAKQ0xtg@mail.gmail.com>
	 <vpq4of2scen.fsf@bauges.imag.fr>
	 <AANLkTi=UCJa9uT5i9TRB9hGsH1D8b9DgB49TPM5k1htQ@mail.gmail.com>
	 <AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, avarab@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 18:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ois6f-0005Dk-BR
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 18:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab0HJQzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 12:55:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56479 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab0HJQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 12:55:10 -0400
Received: by qyk7 with SMTP id 7so7638960qyk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=9J2qlhBLtvDRmRrN/mL4E8ycrUzyIQCmv6nnpC3B75k=;
        b=jBekyrfqoKk6EGrTsLP3oMn0+YiBPJ8VuLDbyXjqmwLKOOBqkeRluSLW0s9AALE/G5
         /l4VZ7fHakDNlTpHJBiQHKktHk0DbDBT8M8pmlbRHftWfU4yPD8zodwzquRLJBC2ce4I
         XCjbrZARjf7SyM6QlwpftY5N4G8aydhC0p9Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GPxAHXsdcEqpPYuWOe8kNZtC2VsFz0ZA4Fcf/bKwwwKoGZufcXHNZHAO36dhG65Lmy
         HNoqE4lgUKE164HNpkOCuZVvoH+r9u1rAaVWxLGHIlid7JWFicZdeX2I4fYVL/Qw+JO8
         OWphhp3jjKaL5V2PzIdJhz/oYqwuze4BNDZxs=
Received: by 10.224.72.212 with SMTP id n20mr4216603qaj.179.1281459309780;
        Tue, 10 Aug 2010 09:55:09 -0700 (PDT)
Received: from [132.206.2.24] (ping.CS.McGill.CA [132.206.2.24])
        by mx.google.com with ESMTPS id t1sm8090491qcs.33.2010.08.10.09.55.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 09:55:08 -0700 (PDT)
In-Reply-To: <AANLkTikDtK0vyRwJE3Un5uFkK7FzoWtiWpL8gPqLQjH5@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153131>

=46rom: James Shubin <purpleidea@gmail.com>
Signed-off-by: James Shubin <purpleidea@gmail.com>
---
It's quite trivial really, all that changes is that if someone sets
the environment variable: $GITWEB_CONFIG_SYSTEM, and this points to
something like: /srv/gitosis/gitweb.conf, which doesn't actually
exist, then gitweb will default to trying out the built in default of
/etc/gitweb.conf (if it was built with that value).

This patch should make it easier for people who are configuring
gitweb+gitosis, so that a separate gitweb.conf config file can be used
to call the main config, but which doesn't null out the system
defaults if it is missing.

PS: thanks to everyone for their patience with my first patch.
This applied cleanly with git am, let me know if I should do anything
else differently.

 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4efeebc..43294e1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
 	} elsif (-e $GITWEB_CONFIG_SYSTEM) {
 		do $GITWEB_CONFIG_SYSTEM;
 		die $@ if $@;
+	# if config file from env is missing, then try the default anyways
+	} elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
+		do "++GITWEB_CONFIG_SYSTEM++";
+		die $@ if $@;
 	}
 }
=20
--=20
1.7.0.4


-----Original Message-----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
To: James <purpleidea@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
Subject: Re: [Patch] Use a default for a bad env config file variable
Date: Tue, 10 Aug 2010 16:02:48 +0000

On Tue, Aug 10, 2010 at 15:54, James <purpleidea@gmail.com> wrote:
> Sorry about that,
> I guess I had only read the README.
> Hope this is better:

Not really, no. You should send the patches you produce with
git-format-patch with git-send-email, and try sending to yourself
first and apply it with git-am (this is all mentioned in
SubmittingPatches).

This is what your new patch looks like after being applied with
git-am:

    commit 7be6207e8923cd7c4c48243f5257a0fdba6bfa0a
    Author: James <purpleidea@gmail.com>
    Date:   Tue Aug 10 11:54:43 2010 -0400

        Use a default for a bad env config file variable

        Sorry about that,
        I guess I had only read the README.
        Hope this is better:

        From d29adf8c788b8a747bfd38dd7e10f684de9aa8e9 Mon Sep 17 00:00:=
00 2001
        From: James Shubin <purpleidea@gmail.com>
        Date: Tue, 10 Aug 2010 10:30:22 -0400
        Subject: [PATCH] Use a default for a bad env config file variab=
le.

        Signed-off-by: James Shubin <purpleidea@gmail.com>

    diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
    index 4efeebc..43294e1 100755
    --- a/gitweb/gitweb.perl
    +++ b/gitweb/gitweb.perl
    @@ -605,6 +605,10 @@ sub evaluate_gitweb_config {
            } elsif (-e $GITWEB_CONFIG_SYSTEM) {
                    do $GITWEB_CONFIG_SYSTEM;
                    die $@ if $@;
    +       # if config file from env is missing, then try the default =
anyways
    +       } elsif (-e "++GITWEB_CONFIG_SYSTEM++") {
    +               do "++GITWEB_CONFIG_SYSTEM++";
    +               die $@ if $@;
            }
     }

I.e. your message has become part of the patch. To include commentary
on resend add it after -- and before the diffstat (also in
SubmittingPatches).

Thanks.
