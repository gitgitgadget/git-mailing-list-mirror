From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 12:50:08 -0700
Message-ID: <xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAtv-0006Sy-K1
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbbG1TuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:50:15 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35995 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbG1TuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:50:12 -0400
Received: by pachj5 with SMTP id hj5so74569960pac.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5g3NG+0cuAC6QSUN1SyTpSF3KRARhrrr2RYaRQ+QNlU=;
        b=In1PHMpsUnzuApa7ryx3vGE4e6S/VeducIVnHp9QPU7MP89cCBhNxo3o5BJeF117lU
         UlaJyI+o+YoP24bw00qzy6B/BtV/kPb2r8CGyxX+JQHI4h0fbJCClmD/b4pY3omwiu5b
         WUgvGmK33TTPIJOPg5Tfw4T20p+eCkWBqTgR4mN3PJscki7y8jl8FS5tX5MBthDEFiu7
         ZWScB8kIymk01RV52qgBmlYUN/EYX2bBczsIgcyDMR576i1QBLos3KAImAvspZw3hRnP
         f0+vHg13+mI/YlL7SETXYOeshAwPTudLyVj15XpghzbkdFBqh9PvfiJSYJrWZv7N/lQ8
         KPcg==
X-Received: by 10.66.119.105 with SMTP id kt9mr85674552pab.86.1438113011451;
        Tue, 28 Jul 2015 12:50:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id v4sm4457220pdg.79.2015.07.28.12.50.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 12:50:10 -0700 (PDT)
In-Reply-To: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 28 Jul 2015 15:30:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274821>

David Turner <dturner@twopensource.com> writes:

> When we unpack trees into an existing index, we discard the old index
> and replace it with the new, merged index.  Ensure that this index has
> its cache-tree populated.  This will make subsequent git status and
> commit commands faster.

Wouldn't it make repeated calls to "git merge" and friends to build
a long history slower, when the user does not run "git status" in
between?  E.g. "git cherry-pick -4 $other_topic", where you would
not even have a chance to run "git status" in the middle.  What do
the pros-and-cons look like?
