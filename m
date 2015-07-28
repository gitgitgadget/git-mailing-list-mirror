From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 13:04:39 -0700
Message-ID: <xmqq1tfsdp60.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	<xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
	<1438113266.18134.26.camel@twopensource.com>
	<xmqq6154dpkt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB7I-0008QI-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbbG1UEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:04:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36607 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbG1UEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:04:42 -0400
Received: by pdjr16 with SMTP id r16so77285948pdj.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bFTztQRud1zLs7H8fbRKqAA8xlq0hqIApy6ctiD6zJc=;
        b=QkHW4Kl/djgJ50/R/eiGs+ctvF3I/2fBlCdFEt4lihRF19mkUrtlBTHms/nQpUo1+1
         KQQ8qL/plKwg+BnuHNeW3KLqdHlcuBwwfR/xT2JlfDkcFPH1uYoI/KUQ2HF2Z41LW+hG
         V0PKR/pybLbMLEf/MNs1ze7zr0E2aT/UmjhQD7ZVEEppD8rJpSlqRb8u7tp5zzOVLiC9
         Otch160uMGeOGSdFIn59pO6QhsfcjDQ0Ow1y4O85RVVWCJ8aht4uDNhd+RkDfXQyIwAY
         QhSbjD2Q8hMa+yIhg42kknHPNbp/5LPD45rsEJhvUcvACjqjUhdpz9bO9sDipwOgqAiN
         x7UA==
X-Received: by 10.70.30.193 with SMTP id u1mr83510453pdh.59.1438113881562;
        Tue, 28 Jul 2015 13:04:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id cj7sm36717416pdb.33.2015.07.28.13.04.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 13:04:40 -0700 (PDT)
In-Reply-To: <xmqq6154dpkt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jul 2015 12:55:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274827>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> The work done to produce the cache-tree is work that the commit would
>> otherwise have to do.  So we're spending extra time in one place to
>> eliminate that work in a different place.
>
> Good point.  Thanks.

Hmm, I forgot about another codepath.  What about operations that
are purely done to pouplate the index, without necessarily creating
a tree out of the index?

The most worrisome is "git checkout $branch" (two-tree merge).
