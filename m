From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add a for_each_string_list_item macro
Date: Sat, 3 Jul 2010 14:40:04 +0200
Message-ID: <20100703124004.GA5511@blimp.localdomain>
References: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com> <20100702205417.GA4941@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 14:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV21C-0000C0-2U
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 14:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab0GCMkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 08:40:21 -0400
Received: from mout4.freenet.de ([195.4.92.94]:52549 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab0GCMkU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 08:40:20 -0400
Received: from [195.4.92.13] (helo=3.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1OV20z-0008IV-7Q; Sat, 03 Jul 2010 14:40:13 +0200
Received: from krlh-5f7252d7.pool.mediaways.net ([95.114.82.215]:55089 helo=tigra.home)
	by 3.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1OV20z-0003Me-0l; Sat, 03 Jul 2010 14:40:13 +0200
Received: from blimp.localdomain (unknown [192.168.0.83])
	by tigra.home (Postfix) with ESMTP id 99AA69FD2C;
	Sat,  3 Jul 2010 14:40:09 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 3211136D28; Sat,  3 Jul 2010 14:40:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100702205417.GA4941@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150189>

This is more lightweight than a call to for_each_string_list function w=
ith
callback function and a cookie argument.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Fri, Jul 02, 2010 22:54:17 +0200:
> This is more lightweight than for_each_string_list function with
> callback function and a cookie argument.
>=20
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>=20
> Alex Riesen, Tue, Jun 29, 2010 10:35:15 +0200:
> > On Tue, Jun 29, 2010 at 10:33, Alex Riesen <raa.lkml@gmail.com> wro=
te:
> > > BTW, now that I took a look at it... The iteration over string_li=
st
> > > items looks a little overengineered. At least from the point of
> > > view of the existing users of the feature. Wouldn't a simple loop
> > > be just as simple to use (if not simplier) and faster (no uninlin=
eable
> > > function calls and argument preparation and passing needed)?
> > >
> > > #define string_list_foreach(item,list) \
> > > =A0 =A0 =A0 =A0for (item =3D (list)->items; item < (list)->items =
+ (list)->nr; ++item)
> > >
>=20
> Rebased on current head (after Julian Philips patches).
>=20

Changed the macro name to make it look like the for_each* functions.

 string-list.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/string-list.h b/string-list.h
index 680d600..a37cae5 100644
--- a/string-list.h
+++ b/string-list.h
@@ -20,10 +20,12 @@ void string_list_clear(struct string_list *list, in=
t free_util);
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
 void string_list_clear_func(struct string_list *list, string_list_clea=
r_func_t clearfunc);
=20
-/* Use this function to iterate over each item */
+/* Use this function or the macro below to iterate over each item */
 typedef int (*string_list_each_func_t)(struct string_list_item *, void=
 *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
+#define for_each_string_list_item(item,list) \
+	for (item =3D (list)->items; item < (list)->items + (list)->nr; ++ite=
m)
=20
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char =
*string);
--=20
1.7.1.304.g8446
