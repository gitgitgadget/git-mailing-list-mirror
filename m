From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Tue, 4 Sep 2012 23:47:56 +0200
Message-ID: <002c01cd8ae6$f23d7ec0$d6b87c40$@schmitz-digital.de>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org> <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de> <7v1uijexor.fsf@alter.siamese.dyndns.org> <003601cd8a0f$6a792840$3f6b78c0$@schmitz-digital.de> <7vzk55bu8s.fsf@alter.siamese.dyndns.org> <002801cd8ac2$10937480$31ba5d80$@schmitz-digital.de> <7vwr09abim.fsf@alter.siamese.dyndns.org> <7vobllaami.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Johannes Sixt'" <j6t@kdbg.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:48:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T90yk-0003EF-MR
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 23:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651Ab2IDVsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 17:48:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:59163 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760Ab2IDVsF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 17:48:05 -0400
Received: from DualCore (dsdf-4d0a1636.pool.mediaWays.net [77.10.22.54])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LrGGm-1TaYKD0SpY-013QLs; Tue, 04 Sep 2012 23:48:01 +0200
In-Reply-To: <7vobllaami.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIhsC26HFNXVNf5LMacgAbi0X2P9gIuBdH5AgQ1j9EAzDU6SAHd2fuOAzRbc6QCZvCE2AIPCL7WANNwrfABx6z0HgKAOAv2AfSTz54DIBk6npYMuAkA
Content-Language: de
X-Provags-ID: V02:K0:sNzn3QizIoutA8x3Zzp0KrWMMhS6aLcou/z4SuT34Rw
 /Ue/Q7b/2MYymD/KGXcxmAVYCWl3+NZuzR+e5aqOeaVgsWgEXt
 j0vBMBq9d2zzEQEI80KddLw2RfvMuodXDEfEFWS2F9eHb9C/Xo
 XELx/HOjymO4gDDD9MfI7/WJTUtRXfcwS9ciwv3eR8PWRudb86
 t+yXZ9Oi0cYI+ZmelQecumTqGbPwkb33gnqomTYz7ah3uIa9zg
 d6eybh7+oNC4aFFRKsNQuGWRqd6K+20IxflaAoeamoMMa0mfKD
 eXvzJFjbIZ0uTGDbeSeKywsRWrwGJNg9zui1VJnWYxvmvxswun
 VBqphNwnZUv4J9FrbuAVrjxluxwMlxawWEs22/x8JzO+R5ygVP
 +vD/KdSABTejQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204787>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 04, 2012 8:47 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Johannes Sixt'
> Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> >>> Only with the observation of "clone", I cannot tell if your timer is
> >>> working.  You can try repacking the test repository you created by
> >>> your earlier "git clone" with "git repack -a -d -f" and see what
> >>> happens.
> >>
> >> It does update the counter too.
> >
> > Yeah, that was not a very good way to diagnose it.
> >
> > You see the progress from pack-objects (which is the underlying
> > machinery "git repack" uses) only because it knows how many objects
> > it is going to pack, and it updates the progress meter for every
> > per-cent progress it makes, without any help from the timer
> > interrupt.
> 
> I think the "Counting objects: $number" phase is purely driven by
> the timer, as there is no way to say "we are done X per-cent so
> far".
> 
> Doesn't your repack show "Counting objects: " with a number once,
> pause forever and then show "Counting objects: $number, done."?

Yes, only once, when it is done
$ ./git repack -a -d -f
warning: no threads support, ignoring --threads
Counting objects: 140302, done.
Compressing objects:   1% (1385/138407)
