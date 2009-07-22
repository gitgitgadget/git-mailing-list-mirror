From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [JGIT PATCH 10/12] Match config subsection names using case 
	sensitive search
Date: Wed, 22 Jul 2009 15:11:07 +0400
Message-ID: <85647ef50907220411w356000bcuda21e9318eab094@mail.gmail.com>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
	 <1248207570-13880-3-git-send-email-spearce@spearce.org>
	 <1248207570-13880-4-git-send-email-spearce@spearce.org>
	 <1248207570-13880-5-git-send-email-spearce@spearce.org>
	 <1248207570-13880-6-git-send-email-spearce@spearce.org>
	 <1248207570-13880-7-git-send-email-spearce@spearce.org>
	 <1248207570-13880-8-git-send-email-spearce@spearce.org>
	 <1248207570-13880-9-git-send-email-spearce@spearce.org>
	 <1248207570-13880-10-git-send-email-spearce@spearce.org>
	 <1248207570-13880-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 13:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTZjK-0004VI-77
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 13:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZGVLLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbZGVLLL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 07:11:11 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:22335 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZGVLLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 07:11:09 -0400
Received: by ey-out-2122.google.com with SMTP id 9so90814eyd.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UkKiPbtJkzAV6xBVI1EVi2xcAMXzd/YOMBomDOipb24=;
        b=kxf96gFv5/frSlwSz2aWQjRePpCecjcWshhRi5/PlNnu0WuaQSWrP0GZ/HS1BJWf9Z
         D7GoJBH6AWJUoqaoiubigmrvZUChGL8hvN1xwOvJ4nL6L82qkI/zZHgi8aUf9kmABRsl
         LLZqgFNA1VFhsVcOqozeCN47+UHeC27UH3Bi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xRfdGQJEUayG4E82hvdg/Adz3bb8cW5hAF/lg3KAmw3cZ999wi6x7S784X/HFmpAZD
         8koF0xB5Nzvyorb6GSYOokr4Hk0HX111wqnsRB3jtmCdB6Bxfn6VcQuqwBQdXea0fGcv
         auiWtQbOepYavsnEMeTKk7OLNLvHdaUtLX11Q=
Received: by 10.216.30.195 with SMTP id k45mr195777wea.197.1248261067969; Wed, 
	22 Jul 2009 04:11:07 -0700 (PDT)
In-Reply-To: <1248207570-13880-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123747>

This patch is incomplete. The method getRawEntry(...) and
setStringList(...) should be fixed as part of this patch too. There is
subsection is converted to lowercase. I was planning to submit it as
separate patch.

Also I'm somewhat bothered by usage of toLowerCase() without locale
specified and equalsIgnoreCase(). When turkish locale is default one
there could be surprising results with the letter "I".  The program:

import java.util.Locale;
public class Test {
	public static void main(String[] args) {
		Locale tr_TR =3D new Locale("tr", "TR");
		System.out.printf("i =3D U+%04x LC(I, tr_TR) =3D U+%04x\n", (int)'i',
(int)"I".toLowerCase(tr_TR).charAt(0));
		System.out.printf("I =3D U+%04x UC(i, tr_TR) =3D U+%04x\n", (int)'I',
(int)"i".toUpperCase(tr_TR).charAt(0));
	}
}

Gives the following output:

i =3D U+0069 LC(I, tr_TR) =3D U+0131
I =3D U+0049 UC(i, tr_TR) =3D U+0130

So I suggest to explicitly use Locale.US for all toLowerCase()
invocation in Config class just in case and to replace
equalsIgnoreCase() with something else. But this possibly should be
some other patch series. I do not know what C git doing in case
turkish locale and whether it is a bug or "feature".

Regards,
Constantine

On Wed, Jul 22, 2009 at 12:19 AM, Shawn O. Pearce<spearce@spearce.org> =
wrote:
> The subsection name is case sensitive, and should be matched as such.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> =A0.../src/org/spearce/jgit/lib/Config.java =A0 =A0 =A0 =A0 =A0 | =A0=
 19 ++++++++++++++-----
> =A01 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/=
org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> index e379c37..974ffea 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
> @@ -4,6 +4,7 @@
> =A0* Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
> =A0* Copyright (C) 2008, Thad Hughes <thadh@thad.corp.google.com>
> =A0* Copyright (C) 2009, JetBrains s.r.o.
> + * Copyright (C) 2009, Google, Inc.
> =A0*
> =A0* All rights reserved.
> =A0*
> @@ -1024,17 +1025,25 @@ private static String readValue(final Buffere=
dReader r, boolean quote,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0boolean match(final String aSection, f=
inal String aSubsection,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0final =
String aKey) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return eq(section, aSec=
tion) && eq(subsection, aSubsection)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && eq(name, aKey);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return eqIgnoreCase(sec=
tion, aSection)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && eqSameCase(subsection, aSubsection)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && eqIgnoreCase(name, aKey);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 private static boolean eq(final String =
a, final String b) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 private static boolean eqIgnoreCase(fin=
al String a, final String b) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (a =3D=3D null && b=
 =3D=3D null)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (a =3D=3D null || b=
 =3D=3D null)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return a.equalsIgnoreC=
ase(b);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 }
>
> -}
> \ No newline at end of file
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 private static boolean eqSameCase(final=
 String a, final String b) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (a =3D=3D null && b =
=3D=3D null)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (a =3D=3D null || b =
=3D=3D null)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return a.equals(b);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> --
> 1.6.4.rc1.186.g60aa0c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
