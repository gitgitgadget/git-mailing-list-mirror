From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add a string_list_foreach macro
Date: Fri, 2 Jul 2010 22:54:17 +0200
Message-ID: <20100702205417.GA4941@blimp.localdomain>
References: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 22:54:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUnFw-0004as-9z
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 22:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab0GBUy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 16:54:29 -0400
Received: from mout6.freenet.de ([195.4.92.96]:40876 "EHLO mout6.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756401Ab0GBUy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 16:54:29 -0400
Received: from [195.4.92.20] (helo=10.mx.freenet.de)
	by mout6.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1OUnFe-0001uL-6H; Fri, 02 Jul 2010 22:54:22 +0200
Received: from krlh-5f720059.pool.mediaways.net ([95.114.0.89]:55886 helo=tigra.home)
	by 10.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1OUnFe-0005SP-1W; Fri, 02 Jul 2010 22:54:22 +0200
Received: from blimp.localdomain (unknown [192.168.0.83])
	by tigra.home (Postfix) with ESMTP id 57CF79FD14;
	Fri,  2 Jul 2010 22:54:18 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id CC02C36D28; Fri,  2 Jul 2010 22:54:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150165>

This is more lightweight than for_each_string_list function with
callback function and a cookie argument.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Tue, Jun 29, 2010 10:35:15 +0200:
> On Tue, Jun 29, 2010 at 10:33, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> > BTW, now that I took a look at it... The iteration over string_list
> > items looks a little overengineered. At least from the point of
> > view of the existing users of the feature. Wouldn't a simple loop
> > be just as simple to use (if not simplier) and faster (no uninlinea=
ble
> > function calls and argument preparation and passing needed)?
> >
> > #define string_list_foreach(item,list) \
> > =A0 =A0 =A0 =A0for (item =3D (list)->items; item < (list)->items + =
(list)->nr; ++item)
> >

Rebased on current head (after Julian Philips patches).

 string-list.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/string-list.h b/string-list.h
index 680d600..acf0450 100644
--- a/string-list.h
+++ b/string-list.h
@@ -24,6 +24,8 @@ void string_list_clear_func(struct string_list *list,=
 string_list_clear_func_t c
 typedef int (*string_list_each_func_t)(struct string_list_item *, void=
 *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
+#define string_list_foreach(item,list) \
+	for (item =3D (list)->items; item < (list)->items + (list)->nr; ++ite=
m)
=20
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char =
*string);
--=20
1.7.1.304.g8446
