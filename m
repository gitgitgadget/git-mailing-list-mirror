From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Fri, 8 Mar 2013 17:29:57 +0100 (CET)
Message-ID: <349468457.245193.1362760197563.JavaMail.root@openwide.fr>
References: <1027208424.206728.1362672550530.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_245191_1106730729.1362760197562"
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 17:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE0Bn-0003Lb-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 17:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934369Ab3CHQaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 11:30:06 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:43060 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933136Ab3CHQaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 11:30:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id A53D6281DE;
	Fri,  8 Mar 2013 17:30:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6LQwCK0YV9-m; Fri,  8 Mar 2013 17:29:57 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 9E9232818F;
	Fri,  8 Mar 2013 17:29:57 +0100 (CET)
In-Reply-To: <1027208424.206728.1362672550530.JavaMail.root@openwide.fr>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217667>

------=_Part_245191_1106730729.1362760197562
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ok, attached is a patch on top of your patch that solves my particular
problem

I am not "formally submitting it" since its on top of your part and i'd
really like your input before submitting.

It solves my problem and afaict does what your fix did and what git-subtree
originally intended to do...

tell me what you think

    Cordialement

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim

----- Mail original -----
> >=20
> > I think I tried adding the ^{} syntax, but I don't think it works
> > on
> > remote repos. Or I couldn't get the right syntax.
> >=20
>=20
> indeed, it doesn't work on fetch, but it could be used somewhere
> between the fetch and the commit-tree to move from the ref to the
> associated commit
>=20
>=20
>=20
>=20
> >=20
> > Latest patch:
> >=20
> >   http://thread.gmane.org/gmane.comp.version-control.git/217257
> >=20
>=20
> oh, that patch, yes I found it while looking around it is a step in
> the right direction but it doesn't help in my case since i'm using a
> valid remote ref that can be fetched
>=20
> (on a side note you could use git ls-remote to check for the remote
> ref and avoid a fetch in case of an incorrect ref, but that's just a
> detail)
>=20
>=20
>=20
> I just tested with it and here is what happens
>=20
> git subtree add --squash -P br2 git://git.buildroot.net/buildroot
> 2013.02 =3D> works ok, br2 is created
>=20
> however the message of the squash commit is
>=20
>=20
>     Squashed 'br2/' content from commit f1d2c19
>    =20
>     git-subtree-dir: br2
>     git-subtree-split: f1d2c19091e1c2ef803ec3267fe71cf6ce7dd948
>=20
>=20
> which is not correct :
>=20
> git ls-remote git://git.buildroot.net/buildroot 2013.02
> f1d2c19091e1c2ef803ec3267fe71cf6ce7dd948=09refs/tags/2013.02
>=20
> git ls-remote git://git.buildroot.net/buildroot 2013.02^{}
> 15ace1a845c9e7fc65b648bbaf4dd14e03d938fd=09refs/tags/2013.02^{}
>=20
>=20
> as you can see git subtee thinks it splited from the tag SHA instead
> of the tag's commit SHA
>=20
> this is incorrect because the tag isn't here, and at split time git
> subtree won't be able to find the correct ancestor. We just need to
> make sure we use the tag's commit instead
> of the tag
>=20
>=20
>=20
> changing
> =09revs=3DFETCH_HEAD
> to
> =09revs=3DFETCH_HEAD^{}
> in cmd_add_repository
>=20
> seems to fix it, both for remote branch pull and remote tag pull
>=20
>=20
> we still have a bug lurking around it's the case where the user does
> the fetch himself then use subtree add with a tag SHA. but let's
> discuss problems one at a time :)
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

------=_Part_245191_1106730729.1362760197562
Content-Type: text/x-patch; name=gst.diff
Content-Disposition: attachment; filename=gst.diff
Content-Transfer-Encoding: base64

NTA2LDUxM2M1MDYsNTA3CjwgCQljYXNlICIkMiIgaW4KPCAJCSpcKiopICMgQXZvaWQgcHVsbGlu
ZyBpbiBtdWx0aXBsZSBicmFuY2hlcwo8IAkJCWRpZSAiJyQyJyBjb250YWlucyBhIHdpbGRjYXJk
Igo8IAkJCTs7CjwgCQkqOiopICMgRG9uJ3QgY3JlYXRlIGEgbG9jYWwgYnJhbmNoIGZvciB0aGUg
c3VidHJlZQo8IAkJCWRpZSAiJyQyJyBjb250YWlucyBhIGxvY2FsIGJyYW5jaCBuYW1lIgo8IAkJ
CTs7CjwgCQllc2FjCi0tLQo+IAkJZ2l0IGxzLXJlbW90ZSAtLWV4aXQtY29kZSAkMSAkMiB8fAo+
IAkJZGllICInJDInIGlzIG5vdCBhIGNvcnJlY3QgcmVmZXJlbmNlIG9uICckMSciCjUzNWM1MjkK
PCAJcmV2cz0kKGdpdCByZXYtcGFyc2UgJGRlZmF1bHQgLS1yZXZzLW9ubHkgIiRAIikgfHwgZXhp
dCAkPwotLS0KPiAJcmV2cz0kKGdpdCByZXYtcGFyc2UgJGRlZmF1bHQgLS1yZXZzLW9ubHkgIiQx
Xntjb21taXR9IikgfHwgZXhpdCAkPwo=
------=_Part_245191_1106730729.1362760197562--
