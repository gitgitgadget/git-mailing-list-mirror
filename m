From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 10:51:09 +0530
Message-ID: <536F08C5.3010705@gmail.com>
References: <536E2C19.3000202@gmail.com> <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com> <536ECC93.1070102@gmail.com> <1399772049733.13154@student.bi.no> <536EDC1C.5040101@gmail.com> <1399777917522.41294@student.bi.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: "Storm-Olsen, Marius" <Marius.Storm-Olsen@student.bi.no>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 07:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjMCW-00018B-WB
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 07:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbaEKFVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 01:21:16 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38964 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaEKFVP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 01:21:15 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so5289267pdj.25
        for <git@vger.kernel.org>; Sat, 10 May 2014 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ReQXPUR5bT0bwDrWd6pAQkfMIeJCkzeTQFFm2+8Mwlw=;
        b=JG3fl4oiB2lp4Jtiz1vb1e0DtQcT85dPUcjhqhuyHglq/Z5A2P4d98vC5dPOc5NIx9
         OhjXMiW9bVifG30Q5VnWTXDM1PxoKHIAxbuMuiCULzh8Fw2+WUyyMkZ3pOyVIJoyw4zN
         CRel9XGlViO08fKHCaMzEm97KaYvD5EGfesOr864Gaa0REMA9aa/uocWnSCJb7/57IM8
         LfqvRRJYAr+xrsmJ86nacAlr4y7OrNcdJYcd5oBXuD1LPc9nq4tTWQe9HDFNu3u9ltQB
         NDJYr6Od2jyT6vuOBUNbN/y5PxC++MiZ0ASsofEQXeOmzIaKMFzmrIiBUljYO2ZZMs8d
         l3GA==
X-Received: by 10.66.158.10 with SMTP id wq10mr40595311pab.32.1399785674963;
        Sat, 10 May 2014 22:21:14 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.215.9])
        by mx.google.com with ESMTPSA id kt8sm30929385pab.7.2014.05.10.22.21.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 May 2014 22:21:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1399777917522.41294@student.bi.no>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248672>

On 05/11/2014 08:41 AM, Storm-Olsen, Marius wrote:
> On 5/10/2014 9:10 PM, Sitaram Chamarty wrote:

>      1. Clone remote repo
>      2. Hack hack hack
>      3. Fork repo on server
>      4. Push changes to your own remote repo
> is equally efficient.

Your suggestions are good for a manual setup where the target repo
doesn't already exist.

But what I was looking for was validation from git.git folks of the idea
of replicating what "git clone -l" does, for an *existing* repo.

For example, I'm assuming that bringing in only the objects -- without
any of the refs pointing to them, making them all dangling objects --
will still allow the optimisation to occur (i.e., git will still say "oh
yeah I have these objects, even if they're dangling so I won't ask for
them from the pusher" and not "oh these are dangling objects; so I don't
recognise them from this perspective -- you'll have to send me those
again").

[1]: for any gitolite-aware folks reading this: this involves mirroring,
bringing a new mirror into play, normal repos, wild repos, and on and
on...
