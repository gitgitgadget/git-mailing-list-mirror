From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (for maint)] gitweb: Fix fixed string (non-regexp) project search
Date: Tue, 6 Mar 2012 12:59:15 +0100
Message-ID: <201203061259.16714.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <7vd38r2d8y.fsf@alter.siamese.dyndns.org> <7vhay2y6fd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4t3C-0008Cr-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164Ab2CFL7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 06:59:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44566 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759094Ab2CFL7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 06:59:25 -0500
Received: by eaaq12 with SMTP id q12so1784600eaa.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 03:59:23 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.13.195 as permitted sender) client-ip=10.213.13.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.13.195 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.13.195])
        by 10.213.13.195 with SMTP id d3mr2024701eba.55.1331035163909 (num_hops = 1);
        Tue, 06 Mar 2012 03:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Eb6zb/9z8BNO7eXB/IQwu8ySnllZuVizAXVzE13+2Pw=;
        b=iq1QzUtVXY/lUin3eZpALBZ1EYSuPkCBV2ENMN+SrwCRxxkJIhnT2BxrvW1LtgGUOw
         D8c/VaeyQnjNaI8kBhJcN54irq5Cesce66LHBfzVQ2tOs0fulUZqkBM4SGpJmUsBK2Yr
         JbYk4ttNMXGHk4OgVY7k6x0TZ4igmhLY8hBW5alE1JyRtTJ0C6yOonRlFVRzit7nsu6a
         edCOTTBBPvsGxsJZSxOS888i3e4Ocr9S8Tqa6NdKHzQOwNLvaSuWHLDcvqdcOTYGoF1Y
         vZNF6AKmgxDQEQUGRjzVvwvcf3YWHLL4ZWG8p+YKrO185AlGqUxQUUJFgcLqCQk4Lcs0
         TGDg==
Received: by 10.213.13.195 with SMTP id d3mr1518676eba.55.1331035163810;
        Tue, 06 Mar 2012 03:59:23 -0800 (PST)
Received: from [192.168.1.13] (abwf76.neoplus.adsl.tpnet.pl. [83.8.229.76])
        by mx.google.com with ESMTPS id n55sm33659908eef.6.2012.03.06.03.59.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 03:59:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vhay2y6fd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192338>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>> Hmph, didn't you already call fill_project_list_info(\@projects) before
>>>> search_projects_list() already?
>>>
>>> True.  Sorry about that. 
>>>
>>> Can you fix that, or should I resend?
>>
>> Could you check the following two diffs?
>>
>> $ git show debd1c2
>>
>> This is jn/maint-do-not-match-with-unsanitized-searchtext that
>> should be merged to maintenance track that lack the lazy filling.
>>
>> And then
>>
>> $ git show --first-parent d4b52c2
>>
>> This is how the above was merged to 'pu' and the conflict resolution
>> should be the same when we merge it to 'master'. As our @projects may
>> still be only sparsely filled when search_projects_list() returns,
>> we do call fill_project_list_info(\@projects) ourselves with the
>> lazy filling codebase.
> 
> The latter is now
> 
> $ git show --first-parent 657c6d0
> 
> on today's 'pu'.
> 
> Thanks.

Both look all right (the only difference in diff is use of $searchtext
vs $search_regexp global variable to check if search is on, but for that
purpose those variables are equivalent).

Thanks.

-- 
Jakub Narebski
Poland
