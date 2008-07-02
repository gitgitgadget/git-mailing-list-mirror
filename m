From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 04/12] Avoid calling signal(SIGPIPE, ..) for
 MinGW builds.
Date: Wed, 2 Jul 2008 16:29:09 +0200
Message-ID: <43A38130-39B6-41C8-B57E-A4405476CA34@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <7vod5gbpza.fsf@gitster.siamese.dyndns.org> <486B5263.1060805@storm-olsen.com>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, Marius Storm-Olsen <mstormo_git@storm-olsen.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>, Junio C Hamano <junio@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 16:30:09 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.244])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3LE-0005NM-SX
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 16:29:53 +0200
Received: by wa-out-0708.google.com with SMTP id n36so213410wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=T3FHF9y2PQVfo7Oq3X6ED1/tYkxAKeYvIduWhVBDdBs=;
        b=NEq2isLfi+NaCUqr3gNCnAp3Os7J3A+dgM5cKgSeTC/liVA1Sb2YRRHb6tcf1UfGCt
         0/ApACAxCyPD/g9Hiqa9XM7rqN9ZeE4llSOgNTMaIkGdrc1LvKgZ+Iiesn1SDHKIrKbc
         9nT1TG+iSGq9Q762unaaH2UoR1qq3Tf6r0IEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=hEx4311dIX19HwVpb0uZDphPJlwhs5ntI6tPeK8Yj2mgL9unlLe2L2EiWb9k1/u9AO
         SduJBYLalhXGDhpPKt4KzV6wXojxayjC9QP3VGuwc9w8MznUiZVKb6YVZzmbNVJiukOy
         hg299OPXX4meN9ypsV7F6AMoW5rhJv1d+ZKC4=
Received: by 10.114.160.1 with SMTP id i1mr566835wae.0.1215008934245;
        Wed, 02 Jul 2008 07:28:54 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2568pri.0;
	Wed, 02 Jul 2008 07:28:54 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.43.13 with SMTP id q13mr4937273anq.20.1215008933671; Wed, 02 Jul 2008 07:28:53 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si8200074yxr.2.2008.07.02.07.28.52; Wed, 02 Jul 2008 07:28:53 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62ESkiL002995; Wed, 2 Jul 2008 16:28:51 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62ESiZB025944 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 2 Jul 2008 16:28:45 +0200 (MEST)
In-Reply-To: <486B5263.1060805@storm-olsen.com>
X-Mailer: Apple Mail (2.924)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87143>



On Jul 2, 2008, at 12:03 PM, Marius Storm-Olsen wrote:

> Junio C Hamano said the following on 02.07.2008 11:22:
>> Steffen Prohaska <prohaska@zib.de> writes:
>>> From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
>>>
>>> SIGPIPE isn't supported in MinGW.
>> Shouldn't #ifdef be on SIGPIPE not on __MINGW32__?
>
> That's certainly a good suggestion. :-)

I reverted this in 4msysgit and will remove the patch from the
series.

	Steffen
