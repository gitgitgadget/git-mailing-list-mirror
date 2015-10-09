From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pull --rebase: reinstate helpful message on abort
Date: Fri, 09 Oct 2015 11:36:06 -0700
Message-ID: <xmqqbnc7q489.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<47e66f159e8929879f22504a180330e3fa020ee9.1444336120.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:36:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkcWc-0004fA-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 20:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbbJISgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 14:36:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34570 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbJISgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 14:36:08 -0400
Received: by padhy16 with SMTP id hy16so93305869pad.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i+4PIWcmuhHfqZVM2ifoH1Bj5SG+al2RwN/n+57vIDM=;
        b=qrf1XqCsx5GvQe11418DrYMSuvS7YXKmc6WlKPhzbGYm9AyMlzLEcF9J9zhatKSgiP
         aWt91hvGb5wOOJvBfCuCElH6McbYZGEnY85me51KSD9FVh1SXvSLlTFrQ5kOw7RRRyTB
         /rsFy8ymfY0XUcNeLz834fPGGVnFl2IqWQKyU3ODV/WUlHx+idyaGZB1iT3VW3bmawsR
         2+d1R1byjt1IBcnpPtHM/C4nJrTPNhijebdSV7ngdQu25pHX+iUuqpSzgzKQOMjt3loD
         pEOQtQSL6uev00q3ZlmF5wLbjj0qSMSki9AKqit4DQNc030TJvIZ1YmNb4zcFqM9mrTn
         EKMQ==
X-Received: by 10.68.242.41 with SMTP id wn9mr10390767pbc.79.1444415768391;
        Fri, 09 Oct 2015 11:36:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id vv9sm3720619pbc.95.2015.10.09.11.36.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 11:36:07 -0700 (PDT)
In-Reply-To: <47e66f159e8929879f22504a180330e3fa020ee9.1444336120.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 08 Oct 2015 22:35:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279313>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When calling `git pull --rebase`, things can go wrong. In such a case,
> we want to tell the user about the most common ways out of this fix:
> ...
>  builtin/am.c | 1 +
>  1 file changed, 1 insertion(+)

It is strange to see a patch to am that does not talk anything about
it, though.  And looking at the codepath, the issue does not have
much to do with "pull --rebase".  It doesn't even have much to do
with "rebase".  This is purely about "am -3" fallback codepath.

Because fall-back-threeway wants to react to an error (i.e. calls
merge_recursive_generic() and wants to use its return value), but
merge_recursive_generic() can die, it fails to do so.  It would not
even run rerere(), for example.
