From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC memory leak?] Minor memory leak fix
Date: Tue, 11 Mar 2014 13:40:09 +0100
Message-ID: <20140311124009.GI14327@paksenarrion.iveqy.com>
References: <1394534706-28987-1-git-send-email-iveqy@iveqy.com>
 <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 13:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNLvw-0000fI-2v
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 13:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbaCKMhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 08:37:16 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45287 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbaCKMhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 08:37:14 -0400
Received: by mail-lb0-f179.google.com with SMTP id p9so5644807lbv.10
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q/bR09nqKW+2EWkSmG/GV22W1VJfnDIJBS1DExuJV6U=;
        b=wVTn6OB/5w5+aSF4AIRAjecRpnlSUw7Ymp687MpH2BkkugGs6fxtk6ILRtX+qypFMG
         LQEf4LGFteALPKmEH6mWMUv7rQhGa+QGbNINXp1LDcojHHiA3qRsL+5hFJ3ZXVwhNRMf
         sYVvn3CoLd046f6VYnXjR4LUudK8W/vZkyIg5xik6oAouxOvZHb2zVEKGzwrcqr2FhIW
         HXeEneD1D5XV66hEjuqjaxu7uIzHRr/eO7knMtbo4ENRnqZNW5Y4myTJYaSgCfjeG7O8
         Cyns46uO8gkjqc9RXuslWiAB5hm4GT2q7yClOZZ3fsrIQZh4DvF2JM99UZ9LHTgdgPLj
         3QEg==
X-Received: by 10.112.50.194 with SMTP id e2mr26129756lbo.4.1394541433018;
        Tue, 11 Mar 2014 05:37:13 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id qx7sm25046880lbb.9.2014.03.11.05.37.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 05:37:12 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1WNLyb-0000nM-9A; Tue, 11 Mar 2014 13:40:09 +0100
Content-Disposition: inline
In-Reply-To: <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243861>

On Tue, Mar 11, 2014 at 06:58:11PM +0700, Duy Nguyen wrote:
> On Tue, Mar 11, 2014 at 5:45 PM, Fredrik Gustafsson <iveqy@iveqy.com>=
 wrote:
> > Strbuf needs to be released even if it's locally declared.
>=20
> "path" is declared static. So yes it's a leak but the leak is minimum=
=2E
> Your patch would make more sense if "static" is gone and it's leaked
> after every write_archive_entry call.

That's one of the reasons of the RFC. I know Junio thinks that minor
things shouldn't be fixed by themselfes because it takes up review
bandwidth, so it's better to fix them once you touch that part of the
code anyway. (At least that's how I've understood him).

This leak is at about 4.1 kB so it's not huge.

> > +               if (ATTR_TRUE(check[0].value)) {
> > +                       to_ret =3D 0;
> > +                       goto cleanup;
> > +               }
>=20
> to_ret is already 0 so I think "goto cleanup;" is enough.

Agree, fixed in next iteration.

> >                 err =3D write_entry(args, sha1, path.buf, path.len,=
 mode);
> > -               if (err)
> > -                       return err;
> > -               return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> > +               if (err) {
> > +                       to_ret =3D err;
> > +                       goto cleanup;
> > +               }
> > +               to_ret =3D (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0=
);
> > +               goto cleanup;
>=20
> Maybe if (err) to_ret =3D ...; else to_ret =3D ...; so we only need o=
ne
> "goto cleanup" statement. Going even further:
>=20
> to_ret =3D write_entry(...);
> if (!to_ret) to_ret =3D (S_ISDIR(...));
> goto cleanup;

Agree, fixed in next iteration.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
