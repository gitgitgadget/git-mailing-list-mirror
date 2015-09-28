From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 28 Sep 2015 22:05:59 +0200
Organization: gmx
Message-ID: <737df8378d1c83c97a53e5591a2a6ffb@dscho.org>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
 <fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
 <20150928190332.GA17258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 22:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgegi-0002Mu-T6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 22:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbbI1UGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 16:06:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:49740 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbbI1UGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 16:06:06 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MhhwJ-1a2yvi1lyN-00MugR; Mon, 28 Sep 2015 22:06:01
 +0200
In-Reply-To: <20150928190332.GA17258@sigill.intra.peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:oYFCRyk8vuqQPvDJm40YVEDVCzLiNhVha0Vj6n89HZIXwStUoUW
 arKaZruylkwUzezLjVH5bzH6+YJRY6kjzQkM5LgOxAJmXtq9ljJvfqh94frKQgx1hO1i4QI
 JGQc+duHLVlO3xxzKOlhbcFdg53wJUdpUTxYSbN+ou++VrwlPxmEb239YxbrMAi1ZIocugW
 Ly5m7U4OdnE2z5HF6upbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rSQUEGCKy3k=:bCBBGXzs0sE6CPnJBdET9/
 vkOaiTST2lRLQwQuEsDJKvvAXmm0oUNKNhshSnt3K3Kj69Itse+MeZYIeoTHTYg4QYPT8EwqT
 u3kQxGM/V5nhjFmqvkpMQeO2dT6GViIlN6vgP0NmRBjR2DBkFbXiFEXbe/ZnRvO9YokGLG0Dl
 WezhUfJ2ThuF0pPHnywRW/aIQMAF/fh+ikOX42t+8ka2khvmsQksOmNPly39m6wexYdeBfDAs
 08b6w4agBKmX3RyRFRhDIQlTUj8lEjJm+4bdRzpmLnsTiDFtOyePVPwMHztxFr9xyc3Q0g05U
 UzbmIvbToYvzls34uqpI2Jto1FY2nGrzNH9diutl0tWN3NfRpCVynRmOuypOlThiXctS6zUTW
 35JacrajjGJz1bOg+X+WpBA3aZR5JwoaJFADu6oFDptOPcvcL5lERq5egC0dAI2As8vasO2pK
 sWtS1j//D4YFio4di/cM57IuuSYaa0MIQZeAQuEAHJv57q26Em6ZLXCae+RHBqSRgECO+pOJA
 aZHdNytY/9D8W0Nt1oUl0wob6OD22mE2OZjaUWpkWUvsk4Div6Xu6pT98yzFyTUf2NHRqgEoz
 kwA05cqD+MbGf5giR0ASuY1mwhKofkz/Vi68bFRFz/1z9O1IrIRJWKV+jF4xUZjX4SwT9Cl4D
 v54FZuQ7rsBgdlFUu5f5yshZWT8bPsPvQezlsV9Bj3bWwRgQI6pXLUjOnRrJN+xfusUMJRANK
 awW2wmbyWgobkuklZ2GQGVfpj42IAwMBo0awLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278749>

Hi Peff,

On 2015-09-28 21:03, Jeff King wrote:
> On Mon, Sep 28, 2015 at 04:02:08PM +0200, Johannes Schindelin wrote:
> 
>> @@ -136,7 +139,14 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>>  	if (show_progress)
>>  		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
>>
>> -	mark_reachable_objects(&revs, 1, expire, progress, NULL);
>> +	revs.ignore_missing = 1;
>> +	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);
> 
> You should not need this ignore_missing anymore, right?
> 
> It is the dangerous thing I mentioned earlier, but I am puzzled why it
> does not cause t5312 to fail.

Gaaaaaah! I edited this out at least twice, yet it creeps back in. Bah!

Junio, would you mind fixing this up locally? If you want me to submit v3, just let me know, I will take care of it tomorrow.

Ciao,
Dscho
