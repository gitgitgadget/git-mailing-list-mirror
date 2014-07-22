From: Jean-Francois Bouchard <jfbouchard@accedian.com>
Subject: Re: Git + mod_auth_kerb
Date: Tue, 22 Jul 2014 12:41:19 -0400
Message-ID: <CAPYmS36r2fTeY4iB3k7VpgE7brAGxa+wt9HzfXtMStbMW4_Xvg@mail.gmail.com>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
	<20140721231721.GB5616@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9d82-00028w-5c
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 18:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbaGVQlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2014 12:41:22 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:53073 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbaGVQlU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2014 12:41:20 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so4953732ykb.6
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 09:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=W7nIvjX62PGYdW3EhhuLVzfSV77aPUZVBvtoS6CezYc=;
        b=QEEMC0T3thXZg7OAV8eqLk9zdWZyqqtt9/wWcZDjMdxSpoJM4g3/zb+iV3uzS19AWc
         dRBPo3hrvZb+00KLlWGOEYUrd26Tl0j5vmNkrVEiH4KLKBramAVRJzCEBPPlCUxHLWNP
         1rV/RkeGBRoSaf3ynxTrT2pvBKRKoaw32sqEX3D1XXAJRT32yW9K8MGi6seblN/Fjff3
         2oZvom1DDI/lGlbn5pyVojxLNOO5NrAmkGl8wbMYUVbyY2E3Xse87ldLKlZbU2enmkIq
         GvSDEl/Ryv/X3d+UPhyhmvEztvsx10dVlxj3o9BcZULknKz3feJHgglLIPbrNDZd0n8/
         JJ4Q==
X-Gm-Message-State: ALoCoQkNisyWKL5gBG3kHYUohmzYCjxOQff9R+GNdVksSONC1FkOyBDWcotpeL9AbIdg95rNixjJYZIs2M0ar4Nvd1Gz564oZPmruSlQT8VTMgZGI1QSqOY=
X-Received: by 10.236.116.202 with SMTP id g50mr5965457yhh.147.1406047279705;
 Tue, 22 Jul 2014 09:41:19 -0700 (PDT)
Received: by 10.170.196.150 with HTTP; Tue, 22 Jul 2014 09:41:19 -0700 (PDT)
In-Reply-To: <20140721231721.GB5616@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254020>

Hello,

Thanks for this info. This make a lot of sense system wise. For a user
point of view, it is a nightmare. Also, this break a lot of tools that
are waiting username/password authentication via HTTPS. (I name
Eclipse).

Also, I m not able to reproduce the kerberos login on Ubuntu 14.04. I
m asked to enter password even if a kerberos ticket is present and
this even when I've embedded the username in the URI.

Is there a better way to integrate Kerberos via HTTPS for git ?

Thanks,
JF

On Mon, Jul 21, 2014 at 7:17 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Jul 21, 2014 at 05:06:50PM -0400, Jean-Francois Bouchard wrot=
e:
>> Hello,
>>
>> We are currently working on a single sign on setup for our git insta=
ll. We are
>> using git 2.0.2 (ubuntu) plus apache/2.2.22 mod_auth_kerb on the
>> server side. Here some scenario we are trying to accomplish :
>>
>> -Without Kerberos ticket stored.
>> Git ask for username/password.
>> Result =3D Authentication failed
>>
>> -Kerberos ticket in store and BAD password :
>> Git ask for username/password.
>> Result =3D Authentication failed
>>
>> -Kerberos ticket in Store entering good password :
>> Git ask for username/password.
>> Result =3D Authentication failed on some host, other works
>>
>> -Kerberos ticket in Store and embedding the username in the URI (aka
>> https://username@repo)
>> Git don't ask for anything or ask for password
>> Result =3D Works on some host, other request the password. (Will fai=
l if
>> the kerberos ticket not in store)
>
> So git uses libcurl with CURLAUTH_ANY.  In order for authentication t=
o
> work with libcurl, you have to supply a username.  If you specify it =
in
> the URL, the libcurl realizes that it can use Kerberos, and goes on i=
ts
> merry way.
>
> If you don't specify the username in the URL, git notices that
> authentication has failed, and asks the credential store for a userna=
me
> and password.  git does not know that a password is not needed, so th=
e
> credential subsystem prompts for one anyway.
>
> I have mod_auth_kerb set up against Apache 2.4.9 at the moment, altho=
ugh
> I've used 2.2 before.  I always use a username in the URL, and if I g=
et
> prompted for the password, I just Ctrl-C out and run kinit before
> pushing again.
>
> I don't have mod_auth_kerb set up to fall back to basic auth, but if =
you
> do, using a username and password should work properly.  You can use
> set the environment variable GIT_CURL_VERBOSE to 1 to see more
> information about what's actually going over the wire.
>
>> This is a very strange behaviour. It seems to be cause by the way
>> libcurl and git interact and the way the authentication goes
>> (Negociate first, then basic auth). I have tried to use the helper t=
o
>> store invalid authentication information. With not much success.
>
> libcurl will always prefer something (anything) over basic auth, sinc=
e
> basic auth is completely insecure unless you're using HTTPS.
>
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion o=
nly
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B=
187

--=20


Avis de confidentialit=C3=A9

Les informations contenues dans le pr=C3=A9sent message et dans toute p=
i=C3=A8ce qui=20
lui est jointe sont confidentielles et peuvent =C3=AAtre prot=C3=A9g=C3=
=A9es par le secret=20
professionnel. Ces informations sont =C3=A0 l=E2=80=99usage exclusif de=
 son ou de ses=20
destinataires. Si vous recevez ce message par erreur, veuillez s=E2=80=99=
il vous=20
plait communiquer imm=C3=A9diatement avec l=E2=80=99exp=C3=A9diteur et =
en d=C3=A9truire tout=20
exemplaire. De plus, il vous est strictement interdit de le divulguer, =
de=20
le distribuer ou de le reproduire sans l=E2=80=99autorisation de l=E2=80=
=99exp=C3=A9diteur.=20
Merci.

Confidentiality notice

This e-mail message and any attachment hereto contain confidential=20
information which may be privileged and which is intended for the exclu=
sive=20
use of its addressee(s). If you receive this message in error, please=20
inform sender immediately and destroy any copy thereof. Furthermore, an=
y=20
disclosure, distribution or copying of this message and/or any attachme=
nt=20
hereto without the consent of the sender is strictly prohibited. Thank =
you.
