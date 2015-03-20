From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git=p4.py rebase now honor's client spec
Date: Fri, 20 Mar 2015 08:13:54 +0000
Message-ID: <550BD6C2.4070208@diamand.org>
References: <D1303946.5CED%Sam.Bishop@blackboard.com> <20150319215816.GI612775@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sam Bishop <Sam.Bishop@blackboard.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 09:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYs4Y-0006Xi-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 09:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbbCTIOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 04:14:21 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36102 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbbCTIOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 04:14:14 -0400
Received: by padcy3 with SMTP id cy3so101863340pad.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=8E0WF8f2DRMThNIPHyn0sRMkCH6w5DWGEEQeynfmktQ=;
        b=Odq20Ua7u6d6zd8FuOm89spPyGKVnQ7EEAL3Ner0GUbY0lATK6y+xs/+BETur6dg/X
         kv6Xi5VKho78dnCfCoIvkvsYnsKbJStmnEshrTmWOYo2W+pkDYES0L/80HfqBjARnfWF
         Ws8Jf++atXlnh5qF39Yrq6SF+jcKWJacxfO8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8E0WF8f2DRMThNIPHyn0sRMkCH6w5DWGEEQeynfmktQ=;
        b=acQn0H+ftFEHIfKW1QbDabJrNntIYNB8vKm30+gvO0sbn88vioFtuCDegxrtjqV+yU
         W9WvwGg5IH9HzgRSPYjJo9BkaXpLML5RLr7fKo1LkovzvJhNvP53yMaZLvC+xR2kydHF
         BDNv93jmYuhQNqYtMd8BZ427xy7PI652O5SYEIx4KYPUJBn6yR5k5v6fSUnpClPLfQ8W
         8HSG+vwsVQ4mu1WnQVyxkNu6m4muAS6QiL36UoZsHD9766QMqeUNtQz6vlkd0uX4nqzd
         m3HWJ9G1VG22+sZwpV4+GyHD3fYVKE1kuRPxdZZs0RtOc4XrV1nCnLzhswNACfIf8nnP
         pYEA==
X-Gm-Message-State: ALoCoQkmsliUK8x98zpK5/5JCZtRqZ1PiEs+BhR6gXoCXbaCDP3miIyF5JEWEdt/1JAwbI/ZbdWd
X-Received: by 10.70.90.133 with SMTP id bw5mr186564756pdb.93.1426839253321;
        Fri, 20 Mar 2015 01:14:13 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id pu9sm6716319pdb.49.2015.03.20.01.14.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 01:14:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <20150319215816.GI612775@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265868>

On 19/03/15 21:58, brian m. carlson wrote:
> On Thu, Mar 19, 2015 at 12:28:09PM +0000, Sam Bishop wrote:
>> When using the git-p4.py script, I found that if I used a client spec when
>> cloning out a perforce repository, and then using a git-p4.py rebase, that
>> the rebase command would be using the current perforce client spec,
>> instead of the one used when doing the initial clone. My proposed patch
>> causes the rebase command to switch to the perforce client spec used when
>> doing the initial git-p4.py clone.
>>

That's very useful, thanks. I've noticed that behaviour in the past and 
always thought it ought to be fixed. As Brian notes, it needs a 
"Signed-off" line in the patch.

A very small nit: could you prefix the subject with "git p4:" so that 
it's consistent with other recent git-p4 changes - it makes it easier to 
pick them out when reviewing changes.

Could you run the git-p4 unit tests on it please (t/t98*)? I could be 
wrong about this, but it looks to me like t9806-git-p4-options.sh 
doesn't pass now with this change (*)

Thanks!
Luke

(*) There's at least one test that doesn't pass anyway, but this seems 
to be new.
