From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
Date: Fri, 13 Jul 2012 10:48:54 +0200
Message-ID: <20120713084854.GD592@pengutronix.de>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <11987916.rOoNGcb1ly@dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel@lists.infradead.org,
	Samuel Ortiz <samuel.ortiz@intel.com>,
	"Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>,
	git@vger.kernel.org
To: Marc Reilly <marc@cpdesign.com.au>
X-From: linux-kernel-owner@vger.kernel.org Fri Jul 13 10:49:52 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1SpbZM-0003sO-Pb
	for glk-linux-kernel-3@plane.gmane.org; Fri, 13 Jul 2012 10:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab2GMItj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 Jul 2012 04:49:39 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42949 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab2GMItY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jul 2012 04:49:24 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1SpbYW-0005pt-JG; Fri, 13 Jul 2012 10:48:56 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1SpbYU-0003RM-VO; Fri, 13 Jul 2012 10:48:54 +0200
Content-Disposition: inline
In-Reply-To: <11987916.rOoNGcb1ly@dev1>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201396>

Hello,

[I added git@vger.k.o to Cc: please strip the recipents accordingly if
you reply.]

On Fri, Jul 13, 2012 at 09:02:56AM +1000, Marc Reilly wrote:
> Hi Uwe,
>=20
> > This series was tested on a Phytec pcm038 (mc13783 on spi) using
> > traditional boot (i.e. not dt) and on a i.MX53 based machine (mc347=
08 on
> > i2c) using dt boot.
> >=20
> > Philippe's patches are already in next, they are just included here=
 for
> > those who want to test the patches. The 'mfd/mc13xxx: drop modifyin=
g
> > driver's id_table in probe' was already sent out yesterday and is
> > included here because the last patch depends on it.
> >=20
>=20
> For all patches (that don't already have it):
> Acked-by: Marc Reilly <marc@cpdesign.com.au>
Thanks.

> If for some reason you do a V2:
> - In patch 6 moves line "#define MC13XXX_NUMREGS 0x3f" around, is thi=
s=20
> necessary?
It doesn't move it around, that's only how it looks. I removed enum
mc13xxx_id (above MC13XXX_NUMREGS) and added struct mc13xxx_variant
(below MC13XXX_NUMREGS). Git choosed to use the closing brace of enum
mc13xxx_id and struct mc13xxx_variant respectively as context (together
with the following empty line).
(For the new readers, here is how git represented the relevant part:

 #include <linux/regmap.h>
 #include <linux/mfd/mc13xxx.h>

-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
+#define MC13XXX_NUMREGS 0x3f
+
+struct mc13xxx;
+
+struct mc13xxx_variant {
+	const char *name;
+	void (*print_revision)(struct mc13xxx *mc13xxx, u32 revision);
 };

-#define MC13XXX_NUMREGS 0x3f
+extern struct mc13xxx_variant
+		mc13xxx_variant_mc13783,
+		mc13xxx_variant_mc13892;

 struct mc13xxx {
 	struct regmap *regmap;
=2E..
)

The following would be an equivalent and (for humans) easier to review
patch:

 #include <linux/regmap.h>
 #include <linux/mfd/mc13xxx.h>

-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
-};
-
 #define MC13XXX_NUMREGS 0x3f

+struct mc13xxx;
+
+struct mc13xxx_variant {
+	const char *name;
+	void (*print_revision)(struct mc13xxx *mc13xxx, u32 revision);
+};
+
+extern struct mc13xxx_variant
+		mc13xxx_variant_mc13783,
+		mc13xxx_variant_mc13892;
+
 struct mc13xxx {
 	struct regmap *regmap;
=2E..

But as this touches 17 lines compared to only 15 using the way git
choosed to represent patch 6, git used the smaller representation. (I'm
not sure this is the correct reason, but at least it sounds sensible.)
Usually this metric is sane, but here it's not. I don't know if you can
do anything about it? E.g. take the number of +, - and context blocks
into account. Then it would be 5 for the patch above vs. 7 for the
way git did it.
Or weight a context line containing

	#define MC13XXX_NUMREGS 0x3f

more than two lines one of which is empty and the other only contains a
}?

> - Patch 4 should come last, ie after "add support for mc34708"
Yeah, but it doesn't break bisectibility, and as the rtc patches go in =
via a
different tree (in fact akpm already took them) it doesn't matter much.

Best regards and thanks for your feedback
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
