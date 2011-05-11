From: Robert <yayooo@gmail.com>
Subject: Re: http.receivepack==false && authenticated => Service not enabled
Date: Wed, 11 May 2011 10:26:29 +0000
Message-ID: <BANLkTi=14G2WvfoHfhJn_u_NDHnL+6cqCQ@mail.gmail.com>
References: <BANLkTikZdvW1ptVNBiJpCX7jdrqxq=CaDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 17:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBWz-0007xa-0M
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426Ab1EKPkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2011 11:40:33 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62207 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab1EKPkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2011 11:40:31 -0400
Received: by yia27 with SMTP id 27so203137yia.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=vvZiyoacjLv37/KCnlC/ivulL7bUgRuCUVp92YjUE8E=;
        b=iehFF9iA4qE5FWctbbOCBaPI5B23gBXuhw49Cyafgic4ZTjbr2r8LcTLbYhKqC5UU4
         41N9KkNQyt30ex9h+MJoBUk7r/ov3k5ZlCyBLRY9aZXDK0Xw1zMRu36/NTW/gC5VlIt2
         59tlFs4j1yim8NnWzLwYnVveYVUTRWSPkJAkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=SOMKYDc8GmQhfKIBd0tjYFpg9gndvXfuwM8Wsg3AlmRThxUNVl7digqvxPPLk9Lt/X
         XG2di/bo+eBOU4x17w9c5ZiKKU6Z9fZlyMvOqykBb/zRPu2Mji7quL3g8KSgKPVWYvwk
         Rf+hOpIQodvj4G10wwjbRkpPvVodyxhVudcOA=
Received: by 10.150.169.21 with SMTP id r21mr7462570ybe.60.1305109589897; Wed,
 11 May 2011 03:26:29 -0700 (PDT)
Received: by 10.150.220.4 with HTTP; Wed, 11 May 2011 03:26:29 -0700 (PDT)
In-Reply-To: <BANLkTikZdvW1ptVNBiJpCX7jdrqxq=CaDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173391>

Sorry=EF=BC=81It is my wrong ! It is not a bug !

On Wed, May 11, 2011 at 10:21, Robert <yayooo@gmail.com> wrote:
> Even a authenticated =C2=A0user can not push when http.receivepack se=
t to false.
> when
> git config http.receivepack false
> svc->enabled was set to 0 not -1
> so we should initialize with 0 not -1
>
> --- http-backend.c =C2=A0 =C2=A0 =C2=A0Thu May =C2=A05 01:16:14 2011
> +++ http-backend.c =C2=A0 Wed May 11 09:57:52 2011
> @@ -23,7 +23,7 @@
>
> =C2=A0static struct rpc_service rpc_service[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "upload-pack", "uploadpack", 1 },
> - =C2=A0 =C2=A0 =C2=A0 { "receive-pack", "receivepack", -1 },
> + =C2=A0 =C2=A0 =C2=A0 { "receive-pack", "receivepack", 0 },
> =C2=A0};
>
> =C2=A0static struct string_list *get_parameters(void)
> @@ -260,8 +260,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!svc)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0forbidden("Uns=
upported service: '%s'", name);
>
> - =C2=A0 =C2=A0 =C2=A0 if (svc->enabled < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *us=
er =3D getenv("REMOTE_USER");
> + =C2=A0 =C2=A0 =C2=A0 if (!svc->enabled) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0svc->enabled =3D=
 (user && *user) ? 1 : 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!svc->enabled)
>
