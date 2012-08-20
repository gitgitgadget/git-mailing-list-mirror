From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Mon, 20 Aug 2012 12:36:37 +0200
Message-ID: <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Jan Engelhardt'" <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 12:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3PLp-0006wi-To
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 12:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab2HTKgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 06:36:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab2HTKgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 06:36:46 -0400
Received: from DualCore (dsdf-4db55923.pool.mediaWays.net [77.181.89.35])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MdWxQ-1TJyI00LKm-00Px76; Mon, 20 Aug 2012 12:36:42 +0200
In-Reply-To: <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkAetPHqoCQtTAR5dFJ+fQ
Content-Language: de
X-Provags-ID: V02:K0:pGf2zmKmsnpJwqo3HLMVnA1iLQiZsk/ah8yRo0fTOVo
 jEV+bFu8y5mtKFbwkbF8jcKLFWe0vZWwOKwWr0xvZDQLYqOvRM
 qtpHOyHy4sDHRbvFzC5oXW+5RssoIf1aIOBfj7toutLXlxCzfa
 T/8WbX7af3U/xHkE00XsJtGK7BsdnGyMt4g0mcDcFkiF7HrWea
 ptd7kyMJNxWXZB+vjgcyIOVccXXrkx5sg0kDjKz26/kgGkmVpw
 TZkcuukgtoLF1unj0+29I2wQXnv7GmcjOtNB4WoaGyD2ZmkQcJ
 4SVrvHMZlSh86IbBVEavOTE1DIrs0ZM39aBt8QHpXt56McKu+d
 ASlMN0r4Xzisnon7ADCGfYVmW0SnUHhdl7as87WYE6ItCmnlbL
 pDSuq3LMu6f0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203767>

> From: Jan Engelhardt [mailto:jengelh@inai.de]
> Sent: Sunday, August 19, 2012 6:26 PM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org
> Subject: RE: git on HP NonStop
> 
> 
> On Tuesday 2012-08-14 17:52, Joachim Schmitz wrote:
> > @@ -98,6 +99,11 @@
> > #include <stdlib.h>
> > #include <stdarg.h>
> > #include <string.h>
> >+#ifdef __TANDEM
> >+# include <strings.h> /* for strcasecmp() */
> >+  typedef int intptr_t; /* not "int *" ?!? */
> >+  typedef unsigned int uintptr_t; /* not "unsigned int *" ?!? */
> 
> Of course not. intptr_t is an integral value capable of holding a pointer;
it is not
> a pointer to int (because that would really be redundant to int*.)

OK, thanks for the clarification.

Another issue I stumbled across:
There are numerous places (well, some 10) were something like the following
is done

int var = var;
char *othervar = othervar;

Here this leads to Compiler warnings  'variable "var" is used before its
value is set' on NonStop. This self-initialization seems to be a GCC
extension (?), but even gcc has a -Winit-self option to warn about this.
Shouldn't that better be like the following?

int var = 0;
char *othervar = NULL;

What is the reason for using that self-init stuff? I don't think it is
really portable, is it?

Bye, Jojo
