From: =?UTF-8?B?Wm9sdMOhbiBGw7x6ZXNp?= <zfuzesi@eaglet.hu>
Subject: Re: [RFC/PATCH v3] tag: display original sha1 of deleted/overwritten 
	tag
Date: Thu, 10 Dec 2009 15:09:49 +0100
Message-ID: <9ab80d150912100609m29bf4862yc7b1abd680c96c54@mail.gmail.com>
References: <1260451579-4400-1-git-send-email-zfuzesi@eaglet.hu>
	 <1260453537-6156-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 15:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIjiP-0007P7-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 15:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760815AbZLJOJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 09:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760658AbZLJOJo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 09:09:44 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:39419 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbZLJOJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 09:09:43 -0500
Received: by fxm5 with SMTP id 5so8941726fxm.28
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 06:09:49 -0800 (PST)
Received: by 10.103.67.25 with SMTP id u25mr3926238muk.45.1260454189044; Thu, 
	10 Dec 2009 06:09:49 -0800 (PST)
In-Reply-To: <1260453537-6156-1-git-send-email-zfuzesi@eaglet.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135031>

=46orget v2 and v3, v1 is the good one. Sorry.

2009/12/10 Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>:
> It makes possible to undo accidental tag deletion and overwriting.
>
> Signed-off-by: Zolt=C3=A1n F=C3=BCzesi <zfuzesi@eaglet.hu>
> ---
> This patch was created in response to this feature request:
> http://article.gmane.org/gmane.comp.version-control.git/135016
> I named it "RFC" because of the overwriting part.
>
> v3: works when tag object is created (I should slow down...)
>
> =C2=A0builtin-tag.c | =C2=A0 10 ++++++----
> =C2=A01 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-tag.c b/builtin-tag.c
> index c479018..1404a0e 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -140,7 +140,7 @@ static int delete_tag(const char *name, const cha=
r *ref,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (delete_ref(ref, sha1, 0))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;
> - =C2=A0 =C2=A0 =C2=A0 printf("Deleted tag '%s'\n", name);
> + =C2=A0 =C2=A0 =C2=A0 printf("Deleted tag '%s' %s\n", name, sha1_to_=
hex(sha1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> @@ -363,7 +363,7 @@ static int parse_msg_arg(const struct option *opt=
, const char *arg, int unset)
> =C2=A0int cmd_tag(int argc, const char **argv, const char *prefix)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf buf =3D STRBUF_INIT;
> - =C2=A0 =C2=A0 =C2=A0 unsigned char object[20], prev[20];
> + =C2=A0 =C2=A0 =C2=A0 unsigned char object[20], prev[20], tag_object=
[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char ref[PATH_MAX];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *object_ref, *tag;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ref_lock *lock;
> @@ -472,13 +472,15 @@ int cmd_tag(int argc, const char **argv, const =
char *prefix)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (annotate)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_tag(obj=
ect, tag, &buf, msg.given || msgfile,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0sign, prev, object);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0sign, prev, tag_object);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lock =3D lock_any_ref_for_update(ref, prev=
, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!lock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("%s: canno=
t lock the ref", ref);
> - =C2=A0 =C2=A0 =C2=A0 if (write_ref_sha1(lock, object, NULL) < 0)
> + =C2=A0 =C2=A0 =C2=A0 if (write_ref_sha1(lock, annotate ? tag_object=
 : object, NULL) < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("%s: canno=
t update the ref", ref);
> + =C2=A0 =C2=A0 =C2=A0 else if (force && hashcmp(object, prev))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("Overwritte=
n tag '%s' (%s)\n", ref, sha1_to_hex(prev));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_release(&buf);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> --
> 1.6.6.rc2
>
>
