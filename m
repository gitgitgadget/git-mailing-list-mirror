From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 22:18:28 +0200
Message-ID: <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>	<7v628epzia.fsf@alter.siamese.dyndns.org>	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>	<7v4nnxld24.fsf@alter.siamese.dyndns.org>	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>	<503519B3.1020403@kdbg.org>	<CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>	<CA+sFfMdNmT5+sVdiRsWyBYNUwF+nkPcAiBswGs
 Tjp3Yr4yZLUQ@mail.gmail.com>	<7vtxvu7p5s.fsf@alter.siamese.dyndns.org> <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:18:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4HNz-0003bg-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 22:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab2HVUSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 16:18:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:59786 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2HVUSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 16:18:36 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MZlwE-1TNa9U2Ore-00LXKj; Wed, 22 Aug 2012 22:18:34 +0200
In-Reply-To: <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICtbjc6wG8pDJ9Ae6geNwC128XMAKnrh7KlP4FsNA=
Content-Language: de
X-Provags-ID: V02:K0:O1ek2vIVITezePLA6X51XZ5GIIC7sEpDJ0lz1dM9M9k
 x/P9t471sKn8JJCXDNieL0kcuP2koiu4/3g+4sWDBfh0Tw39HE
 GiztsfFvf91ZbutebIanWoXRxj22OQtqEGSESjjdmW8ycXgv7I
 CeTI45PupTpwuCUo+yiEi9JHkcwoQ0fdhx5R6XsS5q9Z7yLizp
 3xkAVMeh42E7MkwaI9kxLlEr/d3wTQS6/D8+3mqcN8riacTBKn
 EXy4kjm2Xi7+r/2/oydQI3wEO/ibmp/G5Ogd5I4CA+DSXYEhiY
 9mNTLTtSvtPhpQERBYzISw08xAZCHMXco6JjxUmai1pL6RZYHk
 m17LT/KuqjLV4NPJdMG+cutmEnoy8gY+aN0DppAgXz1gAK+gEc
 xST4dR5cDROVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204091>

Hi folks

There another API missing on HP NonStop and that is setitimer(), used in progress.c and build/log.c
I do have a homebrewed implementation, on top of alarm(), it goes like this:

#include "../git-compat-util.h"
#undef getitimer
#undef setitimer


int
git_getitimer(int which, struct itimerval *value)
{
        int ret = 0;

        switch (which) {
                case ITIMER_REAL:
                        value->it_value.tv_usec = 0;
                        value->it_value.tv_sec = alarm(0);
                        ret = 0; /* if alarm() fails we get a SIGLIMIT */
                        break;
                case ITIMER_VIRTUAL: /* FALLTHRU */
                case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
                default: errno = EINVAL; ret = -1;
        }
        return ret;
}

int
git_setitimer(int which, const struct itimerval *value,
                        struct itimerval *ovalue)
{
        int ret = 0;

        if (!value
                || value->it_value.tv_usec < 0
                || value->it_value.tv_usec > 1000000
                || value->it_value.tv_sec < 0) {
                errno = EINVAL;
                return -1;
        }

        else if (ovalue)
                if (!git_getitimer(which, ovalue))
                        return -1; /* errno set in git_getitimer() */

        else
        switch (which) {
                case ITIMER_REAL:
                        alarm(value->it_value.tv_sec +
                                (value->it_value.tv_usec > 0) ? 1 : 0);
                        ret = 0; /* if alarm() fails we get a SIGLIMIT */
                        break;
                case ITIMER_VIRTUAL: /* FALLTHRU */
                case ITIMER_PROF: errno = ENOTSUP; ret = -1; break;
                default: errno = EINVAL; ret = -1;
        }

        return ret;
}


Worth being added to compat/, e.g. as setitimer.c, or, as itimer.c (as a by-product, it has getitimer() too)?

Bye, Jojo
