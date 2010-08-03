From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 02:32:06 -0700
Message-ID: <FF986C58-37A5-41ED-B2AF-1EA4C045B9F7@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <m3hbjcptyr.fsf@localhost.localdomain> <4C57D997.5010003@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 11:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgDr5-0001mQ-Tp
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 11:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab0HCJcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 05:32:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60503 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab0HCJcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 05:32:09 -0400
Received: by pzk26 with SMTP id 26so1581319pzk.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=dJURMgDeUjNVM9FmKVSECeF+QkpHKHBLRNvFJdu7Dcg=;
        b=X0YupYfk6e7RoeYYHpY3PR1KjDT0CHk/W5ATKGwgdnEPOR7tJER773jWGuuCI50b91
         c8O9e/4iy3vfCcAStLFClamrLyxBEJztkxpam+MgFj0m5kZatAYkfheE/GhQdpRayuB6
         zfQtfuWmrKFubJ33nFij+frs2GltHpdmQFJq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=M/ziHSUyTKvp28Go6TadX5sIc0p5gLMl1AtPJBDSJN5FV44QJ0xPMK2s5DA3cfmeKq
         z03PxiP0isNo4xx/JUElgGZxChZ3mxfKmW5z5TB2yNPqz0j+xIhTiZIH/rbhDJvZpv05
         lslzt05y6VzMk2Oc0QQaTuNi11JKZe43f83Oo=
Received: by 10.142.180.1 with SMTP id c1mr6354076wff.265.1280827928994;
        Tue, 03 Aug 2010 02:32:08 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 23sm8901335wfa.22.2010.08.03.02.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 02:32:07 -0700 (PDT)
In-Reply-To: <4C57D997.5010003@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152496>

On Aug 3, 2010, at 1:55 AM, Michael J Gruber wrote:

> Jakub Narebski venit, vidit, dixit 02.08.2010 23:48:
>
>> The headers inside commit (and tag) objects are stored in text form,
>> so they are not limited to 32-bit value.  You would have to use  
>> system
>> that has 64-bit time_t, or patch git.
>>
>> 64-bit time_t would be enough for everyone (sic!).
>

> time_t is signed on most systems. Using unsigned long buys us a few
> years as long as we don't go through any system routine nor conversion
> to time_t. So maybe we should:
>
> - check to make sure we use time_t and system routines only when  
> getting
> the current time
> - use signed long long as our git_time_t (I think long is less system
> dependent then long but I could be wrong)

Obviously you mean "I think long long is less system dependent than  
long".

Does any system exist where long long is not 64 bits?  In any case,  
you can future-proof it by spelling it "int64_t".  That symbol is not  
guaranteed to exist (nor is <stdint.h>), but neither is the long long  
type in the first place.

> - make our own algorithms work for the extended format

This would enable systems with 32-bit time_t to deal with pre-1901  
commit timestamps in Git.[1]  Hopefully such systems will become  
increasingly rare.

Josh

[1] Or post-2038 timestamps, but any use case for such is dubious.
