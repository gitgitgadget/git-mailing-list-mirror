From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 25/26] upload-pack: add get_reachable_list()
Date: Sun, 5 Jun 2016 15:51:17 -0400
Message-ID: <CAPig+cS8ON9QtOWJ_eFtRmD7NUKjE8UnMc8GFgfr4HRKAWiq2A@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-26-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 21:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9e4z-00051W-Ek
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 21:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcFETvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 15:51:20 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36945 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbcFETvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 15:51:19 -0400
Received: by mail-it0-f41.google.com with SMTP id z123so28494702itg.0
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kAM6PYR1T+F8/RtsjTEx/pXDpkv0JMAUi1OZL4sM66M=;
        b=KLihcTrd/pP/xifcf02HGFE/DY3gKRD1lGQ30zDR6Cd2rPHPpghRGS3EHWY7Q6Bs68
         XD9AaR2tWKFzcvURk2qPuX3eZwCiwVd3GWmloXjUDwdEllfT1C5GicHASB4fPAsc7A0U
         rqLLzUTDoT5FAHr8/nYb1jrW7kh2HxHKtho7B9P7Ls81rtx8KLKS5i6s2CkFcWqpAKN2
         od7SGBlunccqBR36DLy740KOaxGmmd6GbnZulO/vsj1+EZ1WnMYw8V330jnu3Y3OFYfb
         B5fAlTZUOF8fOEVaMadWLcFuLhX5g543diDeJE0DoBj4VP8qMPv+4xtcRVIARshaKmKk
         dVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kAM6PYR1T+F8/RtsjTEx/pXDpkv0JMAUi1OZL4sM66M=;
        b=fRTiivv3NCQLt6fmB+VNS6BkqIuRxKzZ1LnaRMwNUCaddGNzc8izj8ErRGN65XOBJo
         9FavdnjEvHX1pmTRSxBORg/a0LUgswMiyvQ6wu4YjUuaQ5f8/86DWFM15aOGP8ErUOtP
         JQT34hkBPyK77zS7N/bMpRIiFfeV7dCZnYWLXT1oOqKuHQYErXz+akiwSmmJKz3Ceznl
         RH2xQ+Kns7goJ9zG9OqJGUBfjsVh6VsEOFs/PoE+72u00Qr0ktEUPKBFtctkZeoQiWxr
         sOGDMStfzo2NTymEp3MvM+I3rgI3Cy9l/NrNM2UMzBmc1iEpmnxKxzHsufrOqgm3swaS
         iGfg==
X-Gm-Message-State: ALyK8tJSSLEvWeWi7bOnWaOOuNa7jsB7LQq7k8cj5wqsQh3ZEC/bRKI/0qJIgXtnswNKdmMwnbMOVT+LU3hHIw==
X-Received: by 10.36.207.137 with SMTP id y131mr12419175itf.32.1465156278148;
 Sun, 05 Jun 2016 12:51:18 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sun, 5 Jun 2016 12:51:17 -0700 (PDT)
In-Reply-To: <1460552110-5554-26-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: rVrSvJE2kBn8vhkTcRTAtXAsHvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296480>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -505,10 +513,48 @@ static int do_reachable_revlist(struct child_pr=
ocess *cmd,
> +static int get_reachable_list(struct object_array *src,
> +                             struct object_array *reachable)
> +{
> +       struct child_process cmd =3D CHILD_PROCESS_INIT;
> +       int i, ret =3D do_reachable_revlist(&cmd, src, reachable);
> +       struct object *o;
> +       char namebuf[42]; /* ^ + SHA-1 + LF */
> +
> +       if (ret < 0)
> +               return -1;

Same comment as previous patch: It's a bit difficult to see what this
conditional is checking since it is so far removed (textually) from
the assignment. Perhaps:

    ret =3D do_reachable_revlist(...);
    if (ret < 0)

would make it clearer.

> +       while ((i =3D read_in_full(cmd.out, namebuf, 41)) =3D=3D 41) =
{
> +               struct object_id sha1;
> +
> +               if (namebuf[40] !=3D '\n' || get_oid_hex(namebuf, &sh=
a1))
> +                       break;
> +
> +               o =3D lookup_object(sha1.hash);
> +               if (o && o->type =3D=3D OBJ_COMMIT) {
> +                       o->flags &=3D ~TMP_MARK;
> +               }
> +       }
> +       for (i =3D get_max_object_index(); 0 < i; i--) {
> +               o =3D get_indexed_object(i - 1);
> +               if (o && o->type =3D=3D OBJ_COMMIT &&
> +                   (o->flags & TMP_MARK)) {
> +                       add_object_array(o, NULL, reachable);
> +                               o->flags &=3D ~TMP_MARK;
> +               }
> +       }
> +       close(cmd.out);
> +
> +       if (finish_command(&cmd))
> +               return -1;
> +
> +       return 0;
> +}
