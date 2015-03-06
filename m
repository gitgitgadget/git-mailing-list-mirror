From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Fri, 06 Mar 2015 11:02:45 +0300
Message-ID: <54F95F25.9090300@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>	<xmqqzj7takks.fsf@gitster.dls.corp.google.com>	<54F6D3B0.60600@gmail.com> <xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:02:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTnCu-0008HD-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 09:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbbCFIBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 03:01:55 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37248 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbbCFIBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 03:01:54 -0500
Received: by lbdu10 with SMTP id u10so9106808lbd.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NMRjMHga6AUwbZ0UOn+6yFQccWOWjTI6hHtLtZdaa5A=;
        b=y5xcWDbRV+voOYZr0mSqwSEHelrc31WKrKReie13PLi5Fnm3NUci5bxOF/8eALGLF5
         HTjYYj6mus3RHt+aYm5MkTpXevCxW1tZqXHHp4+JhF16sL/hjeVSYrWQ01zRvrmgT4F+
         1SUXBwzOxYQW+fmAvm24QAKg6PdnolvmkZwqrlro3A0pRTi/9cFa8MHWU9MF/btheHoC
         QloT5mL8kSFUH6zXz+at10pARsUYSPUCpfsFY9SrMCa9Ez4/6lpsXt9I9BynHeH4EPYK
         I/wLIa+9dNFSqvxlhqjRWM34jImmAfWqJcgs9ep3cTet6X0+GrIZin9mN515YpNgkkLj
         y8ug==
X-Received: by 10.152.29.68 with SMTP id i4mr11492319lah.5.1425628912704;
        Fri, 06 Mar 2015 00:01:52 -0800 (PST)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id x5sm1590298laa.44.2015.03.06.00.01.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 00:01:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264894>

On 04/03/15 23:01, Junio C Hamano wrote:
> [] 

My apologies for pushing this topic, but what would you recommend?
Should we treat both sides line-wise or should we correct the documentation?

Current version for git help merge:

...
ignore-space-change, ignore-all-space, ignore-space-at-eol
    Treats lines with the indicated type of whitespace change as
unchanged for the sake of a three-way merge. Whitespace
    changes mixed with other changes to a line are not ignored. See also
git-diff(1)-b, -w, and --ignore-space-at-eol.

    o   If their version only introduces whitespace changes to a line,
our version is used;

    o   If our version introduces whitespace changes but their version
includes a substantial change, their version is used;

    o   Otherwise, the merge proceeds in the usual way.
...


The 1st bullet point could be changed into
    o   If their version only introduces whitespace changes to *all
changed lines*, our version is used;

And the 2nd one into:
    o   If our version only introduces whitespace changes to all changed
lines, but their version includes at least one substantially changed
line, all lines from their version are used;
