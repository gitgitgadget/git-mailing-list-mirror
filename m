From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 15:10:50 -0700
Message-ID: <xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	<6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	<CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	<1432070690.14498.4.camel@kaarsemaker.net>
	<xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
	<1432072167.14498.12.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed May 20 00:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupj0-0001IW-QH
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbESWKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:10:54 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35009 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbbESWKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:10:53 -0400
Received: by iesa3 with SMTP id a3so25413012ies.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+Yc8vMdDQs+8YSJJ1/QmpRIbKxwRLomt7UGpniDqevQ=;
        b=QzyRuBPyuTvx8jfACQ+my3b/91WznQgP8tAnPF+8L4zx/qp7R0Vx54ReYrKTyEY5o6
         xrXOINdyO+tViQ6hGRFGytX4b7u6/rSKVsuYfWFeKyc+ZPPeguHRen+tNt7t2gqXJDzh
         cKVB9zkDmhJL5CnHVdWkXp8RLxjLyTmmHV/AFf52J9CPxaT+yUw1yNFuZldkuKITuGrH
         rvjM8O7KrK8ePI9DQJuDbC6e8BhxBz1wUuTc2WBjbJHQPYo84FuqfeYluratCXFxwfRf
         ZPZ5NVYI9OM1wz+dEIhtMUpcpF/UZISzOrtwZLOlviZgihyZzbW0PlZMhawiUbkj1KqN
         TNrg==
X-Received: by 10.42.52.4 with SMTP id h4mr27815169icg.32.1432073452889;
        Tue, 19 May 2015 15:10:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id o15sm186732igw.11.2015.05.19.15.10.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 15:10:51 -0700 (PDT)
In-Reply-To: <1432072167.14498.12.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Tue, 19 May 2015 23:49:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269416>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I've actually done it differently while implementing:
>
> 1) Make test_commit recognize --tags and stop creating tags unless
>    specified
> 2) while ! prove --state=save,failed {
>        Find and fix tests that now need --tags
>    }

That was what I feared.  The result of that process is the hardest
to reason about and review.

> For the actual patch series I'll add -p the changes slightly
> differently:
>
> 1/N: Make test_commit recognize a --tags parameter but not change
> behaviour.

Make test will pass after this one.

> 2/N - N-1/N: Add --tags where necesary (or other fixes as appropriate)
> N/N: Only write tags when --tags is passed to test_commit.

And untouched ones will continue passing.

Only when you remove --tags from ones that need (i.e. the caller
needs to create the necessary tags), we will see a patch and unless
there is mistake in the conversion, the result should pass.
