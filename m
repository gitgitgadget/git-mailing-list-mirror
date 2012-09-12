From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Thu, 13 Sep 2012 00:41:00 +0200
Message-ID: <50510F7C.4080700@op5.se>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com> <1347473304-21418-1-git-send-email-pjones@redhat.com> <7vtxv3atvu.fsf@alter.siamese.dyndns.org> <1347482918.21933.5.camel@eddie.install.bos.redhat.com> <7vpq5raqiq.fsf@alter.siamese.dyndns.org> <CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com> <7vhar2c29s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Dan Johnson <computerdruid@gmail.com>,
	Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:41:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvcv-00046v-RW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2ILWlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:41:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32781 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab2ILWlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:41:36 -0400
Received: by lbbgj3 with SMTP id gj3so1534806lbb.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 15:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Rx+rLXZdIYW1OKNLS5HwnBGB4uXRLthOTkkq0csT+wc=;
        b=FMW6zNX22sAHyFGhmOXDU9osFAwJcQOqlfH9ZPIvbdk5tfUJCPBaR02V4a1wjILmdK
         TRChvSZoYc2WeXXDM3sd63plalLevXAMvmhE+C2djR3RQHQtI5oY/7cHxhaSbVYOMzsL
         TJ92ZaiAVTkdXOQh+wLM8lDn8O34ke78ONkOYN2mJ4x7mmbe6ZQsmaNd6zVgoWVt+5fG
         kjfCNLWvUHap8FmrPDmIOKUpSq3RKztswsmWjIbwJsZfDwQYRVVMAVmyzzOXAYMuZlHP
         JhtC95/iClneNOjvNWwkwCqwwUUJG+/5XL9zgT8QL7gz7syeHXgShKRZhsyyxLuPoAQe
         /mcw==
Received: by 10.112.83.8 with SMTP id m8mr168151lby.115.1347489694721;
        Wed, 12 Sep 2012 15:41:34 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id bc2sm5570576lbb.3.2012.09.12.15.41.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 15:41:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <7vhar2c29s.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkFbtkNpSyvU1dnMNtJFFD/84X8C4bX50OTQQHdl086UUFjE1V5liGvuLCOye6uT2OhNyjl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205348>

On 09/13/2012 12:19 AM, Junio C Hamano wrote:
> Dan Johnson <computerdruid@gmail.com> writes:
> 
>>> Not really.  If we start encouraging people to use "git show" output
>>> as a kosher input to "am", we would have to support such use
>>> forever, and we end up painting ourselves in a corner we cannot get
>>> out of easily.
>>
>> If git am emitted a warning when accepting "git show" output, it seems
>> like it would support Peter's use-case without encouraging bad
>> behavior?
> 
> Are you seriously suggesting me to sell to our users a new feature
> saying "this does not work reliably, we would not recommend using
> it, no, really, don't trust it." from the day the feature is
> introduced, especially when we know it will not be "the feature does
> not work well yet, but it will, we promise" but is "and it may become
> worse in the future"?
> 
> I do not see much point in doing that.
> 
> Besides, what bad behaviour do we avoid from encouraging with such
> an approach?  As Peter said, the problem is not on the part of the
> user who ended up with an output from "git show", when he really
> wants output from "git format-patch".  Giving the warning to the
> user of "git am" is too late.
> 

It might be enough to either enable format-patch output or print a
warning to stderr when stdout is not a tty. I believe that would at
least mitigate the problem, and it might educate the user as well.
We already modify output format when stdout is not a tty (removing
colors), so we're not giving guarantees about its format when it's
piped somewhere. I believe that would provide almost every scenario
with the expected outcome (including 'git show | grep'), but there
will be a handful of very surprised people as well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
