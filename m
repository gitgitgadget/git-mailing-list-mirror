From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Implementing git-am -3 with git-apply -3?
Date: Mon, 25 May 2015 20:29:21 -0700
Message-ID: <xmqqsiak819q.fsf@gitster.dls.corp.google.com>
References: <CACRoPnQWAYPsVVP_ycjBgPVSM_Orx7QmJc96zL5ixRuqi=V_eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 05:29:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx5Yd-0007WY-2J
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 05:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbbEZD3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 23:29:25 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36808 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbEZD3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 23:29:24 -0400
Received: by igbpi8 with SMTP id pi8so48126644igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=viAPm06E0xjr+Ks3bJ+BHQNHJQK5o/JKBoNYQ3otE70=;
        b=vr9Stwl2cjh4KMfARk6IjnSNlTMbs+o9fP6pBkX5sA7JEv1KPeIn3vez9dzMmY3HZ0
         S7b7uNuFa4oWn4QPIUd3NnH3NsabNyWKPlPVk982boJhlUyTBR+VnuIu057p/jVm5jVk
         yzNCwd9MoB8VLdrs+6A8/kZ2TdFZAtJPBiWiaeMg/1lQ+ZnvBaZFNKK3MytNUkHgJ5Ob
         CPrNHd2kfZeEZ9ysunXX9VnvvTI6IPFqpXofomFvzBsbrwQ51IDpDpRqHmE51FRtFm2B
         4RMiQnzaJX86jZnc5VDIyIrAyYMnYSq12hRDOUMtzosuVhKn5u+0syvVO1o+0nhHfWE7
         4cAw==
X-Received: by 10.43.12.136 with SMTP id pi8mr27573384icb.6.1432610964120;
        Mon, 25 May 2015 20:29:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id l6sm7485299igx.10.2015.05.25.20.29.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 20:29:22 -0700 (PDT)
In-Reply-To: <CACRoPnQWAYPsVVP_ycjBgPVSM_Orx7QmJc96zL5ixRuqi=V_eg@mail.gmail.com>
	(Paul Tan's message of "Tue, 26 May 2015 10:49:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269926>

Paul Tan <pyokagan@gmail.com> writes:

> I wonder if it is possible to implement the 3-way merge in git-am
> using git-apply. Are there any issues/deficiencies that I need to be
> aware of?

Anything is possible ;-)

Even though I suspect it might be of significant complexity, it
certainly would be nice if "apply -3" could be taught to do
everything "am -3" would do.

> * git-apply does not handle renames in the index.

True.  The patch application does not really have a global picture,
and that is one of the reasons why I foresee significant complexity
as I said above.  The three-way merge with synthesized virtual base
tree done in "am -3" makes use of established and independent
component that is merge-recursive, and that makes things easier and
keeps things cleaner.

> * It could probably try harder at merging submodules (perhaps by using
> merge_submodule()?)

I am not sure what you mean.  I thought it punts what "am -3" would
punt on, and handles what "am -3" would handle.
