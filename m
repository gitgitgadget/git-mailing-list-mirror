From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Tue, 14 Jun 2016 00:18:08 +0200
Message-ID: <070d6313-8328-3086-b04f-0bf70e236264@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
 <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
 <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
 <20160609002150.GA28547@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:18:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaBU-0001vU-0l
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbcFMWSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:18:12 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:56034 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161289AbcFMWSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:18:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 94F0720AE;
	Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6LgofjHsdsk; Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7C44220AD;
	Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 758D42066;
	Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gunFJY8DyKT; Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 11D202064;
	Tue, 14 Jun 2016 00:18:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160609002150.GA28547@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297251>

On 06/09/2016 02:21 AM, Eric Wong wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
>> Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1].
>> Should we handle \n\r at end of line as well?
>
> "\n\r" can never happen with local $/ = "\n"

If the email file contains "\n\r", setting $/ = "\n" will leave "\r" at
the beginning of each line.

We could trim them with:

   s/^\r//;
   s/\r?\n$//;

But is it worth adding `s/^\r//;` to handle that extremely rare case?
