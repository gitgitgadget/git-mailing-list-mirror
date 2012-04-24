From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what is a 'sequencer'
Date: Mon, 23 Apr 2012 18:59:40 -0700
Message-ID: <xmqqzka1hotv.fsf@junio.mtv.corp.google.com>
References: <jn4vrk$98c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:59:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMV2i-0007Z9-J9
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 03:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab2DXB7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 21:59:43 -0400
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:54332 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755080Ab2DXB7m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 21:59:42 -0400
Received: by laai8 with SMTP id i8so4919laa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 18:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=TMmAVkewDmWFkMlUPG1fPeXaXMDlDtItWOeDDndgYew=;
        b=bk2NRdIbTHyuicxJgRkNVO7RGJARKnrCBX725fqEZAR1Cj3Sq4EhaanMpGj6kIUfuE
         Ed8nI4YIGrd79pOsaBz7cYNekZVGrWNJgorKgLr7wr0G31dtU3KphBnXC0+kPxmAvM3i
         b0yKhc3ckdvYUrDUQmYd0w1c+T17Q95LZ12oPor8qHIYKfCujSG74vcBwPh6y0TtDAjN
         8uZdeko9JoF0Vihgj6rYJOf7KFdkQ4TwbSylz4Ndy4KCMbT7ak5tH+V4NLTlZQKmAVWe
         dzmCQa2KAL7G/3joOwLtne6uWW9u2TpLtrtbPHNrFKdi/N+snNAUZqG5r2aqWudH+YNG
         /GMA==
Received: by 10.14.95.199 with SMTP id p47mr4196900eef.3.1335232781260;
        Mon, 23 Apr 2012 18:59:41 -0700 (PDT)
Received: by 10.14.95.199 with SMTP id p47mr4196891eef.3.1335232781158;
        Mon, 23 Apr 2012 18:59:41 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si16336365een.0.2012.04.23.18.59.41
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 18:59:41 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id F07AA5C0050;
	Mon, 23 Apr 2012 18:59:40 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4C07AE120A; Mon, 23 Apr 2012 18:59:40 -0700 (PDT)
In-Reply-To: <jn4vrk$98c$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Mon, 23 Apr 2012 20:32:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkZPFuBvt2qisk/e8c4OLf/ts7Xi4YwZ+dQDcanGvLXn3MXfdbUWzsmJxDzMbKbAJLViIa46fHlhV424sOftV16gpVWvNKOIssZLl4wL1l52iGizIUYVP5deF2vz3FRPH/W7IWJUo1z7l8A27LztmfFsfWf1OcApjLBtcanrAJrdIulxtQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196176>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> All the talk about git 'sequencer' sounds interesting, but I don't
> know what it is.  (web search didn't help.)  Is there an explanation
> somewhere on what its supposed to do?

The sequencer is what sequences a sequence of operations ;-).

As an end user, stare at the instruction sheet "rebase -i" lets you
edit, and imagine different possibilities other than those offered by
"rebase -i" (e.g. "build on top of the history by cherry picking this
commit", "cherry pick this commit without committing, and amend the top
of of the history").

For example, wouldn't it be nice if you could say "here is a mbox---run
am to slurp the patches into commit and build history", or "merge the
history leading to this commit"?  "mark this point as :1, checkout this
other commit and continue operation"?  "now merge the commit we marked
earlier as :1 to the history"?  What other vocabularies can you imagine
to enrich your git life?

Recent additions to let "cherry-pick" and "revert" replay and revert
multiple commits are indeed built on the nascent version of this
infrastructure.
