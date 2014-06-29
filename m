From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: trace.c: struct timeval tv not portable
Date: Sun, 29 Jun 2014 08:53:44 +0200
Message-ID: <53AFB7F8.7070701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 08:53:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X18zp-0002eT-Hz
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 08:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbaF2Gxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2014 02:53:49 -0400
Received: from mout.web.de ([212.227.15.3]:52794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbaF2Gxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 02:53:48 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Lba5z-1WFxGU2SYF-00lDrp; Sun, 29 Jun 2014 08:53:45
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:GEwktZZU+/92e9hPgfcbYchOfu47q4tyuewJZtc4PfKG0dUXEzh
 rNAP1cOHm77+8ZJUUDWQnveWnf9rfePOkqW73c0cOneDRnF13xyGov7idamEpH9XDY1OcAR
 89otm3Zq+dOITDiV8P5m6nFpEdLpH+ZnaLMM435ofh0dC9GEbShVkxAtx0RUnyALSiLO/EU
 0HQVohJlkVA6dp/ARRRvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252633>


The following printout gives a warning:
(trace.c, arounf line 105)
	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
		    tm.tm_sec, tv.tv_usec);
trace.c:105: warning: format =91%06ld=92 expects type =91long int=92, b=
ut argument 6 has type =91__darwin_suseconds_t=92


A format string of  "%06ld" for is not always good for tv.tv_usec

http://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/time.h.html

A better solution would be:

	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
		    tm.tm_sec, (long int)tv.tv_usec);
