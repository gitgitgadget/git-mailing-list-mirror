From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 2/2] git-p4: import/export of labels to/from p4
Date: Thu, 05 Apr 2012 07:54:43 +0100
Message-ID: <4F7D41B3.7010202@diamand.org>
References: <1333438715-14902-1-git-send-email-luke@diamand.org> <1333438715-14902-3-git-send-email-luke@diamand.org> <20120403235247.02c85147@fenix.utopia.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:54:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFgap-0004sx-T3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 08:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab2DEGyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 02:54:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55850 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab2DEGyq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 02:54:46 -0400
Received: by eaaq12 with SMTP id q12so322393eaa.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 23:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=DrnikPsF/wlxRYren0rEa7Qbw+eWSLUmN9f6djN6qzQ=;
        b=Q/UH3v8FsXc87XyE1cAKpF7wCLKrCTeBWEvePqEKHKg1ZUJ0nstmPuKQv/CWwkClx/
         Ql8UXjSCNJOCARSOeU17HM/v23zkgMxxmmyr4MCLFy2YjFvxEDj6ox9Njn1ZmDTNKmIp
         EF/hDQyse3US8TwF9aQ2h9Jji88t2kDEvudgGxu9XQ0WcGzmUz1ic1M/gE6a6gIlg3to
         fDp7rrIz7LAWSNR3WUk5FrjJKpkEiX0zyNB4jktScEopzUEDs5vOoCK+XnelXDRcr3g1
         BLMtM6RQUxf0VTygkatbmycXE4Bap8884H2RkY63SsgNCNS5AN2JTtHovH0QVWkvHTN+
         cjFw==
Received: by 10.213.15.144 with SMTP id k16mr293552eba.10.1333608885199;
        Wed, 04 Apr 2012 23:54:45 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id n55sm9870516eef.6.2012.04.04.23.54.44
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 23:54:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20120403235247.02c85147@fenix.utopia.dhis.org>
X-Gm-Message-State: ALoCoQlPFfPv0gulPS1jJMjBHVBiobqV/y6xjclqdzEJfV3wSg3G/ERk5KmhPVgiOIzFdaTWGsV5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194763>

On 03/04/12 23:52, Vitor Antunes wrote:
> On Tue,  3 Apr 2012 08:38:35 +0100
> Luke Diamand<luke@diamand.org>  wrote:
>
>> The existing label import code looks at each commit being
>> imported, and then checks for labels at that commit. This
>> doesn't work in the real world though because it will drop
>> labels applied on changelists that have already been imported,
>> a common pattern.
>>
>> This change adds a new --import-labels option. With this option,
>> at the end of the sync, git-p4 gets sets of labels in p4 and git,
>> and then creates a git tag for each missing p4 label.
>>

<snip>

>>
>
> Would it be possible to only export git tags during commit?
>
> I don't think it is intuitive to make changes in P4 during sync operation.
> And because it is possible to configure git-p4 to always export tags it will
> be easy to forget that while sync'ing we are also updating P4.

Commit isn't a great time to do it because you don't know the p4 
changelist number for your git commits.

e.g.

git commit -m 'Some change'
git tag -a MYTAG -m 'whatever'
git-p4 submit [--export-tags]

======= the tag must be ignored here ========
======= as you don't know the p4 cl  ========

git-p4 sync --export-tags
======= *Now* you know the p4 cl     ========

So it either has to be part of sync/rebase, or we add a new command, 
e.g. git-p4 export-tags (and presumably git-p4 import-tags). But that 
seems awkward as well.


>
> I still did not test the patch in my branch environment, so I may have more
> updates later. But for now, everything else seems ok by me.
>

Thanks,
Luke
