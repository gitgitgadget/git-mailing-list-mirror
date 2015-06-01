From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 11:37:08 -0700
Message-ID: <xmqqpp5f5l7v.fsf@gitster.dls.corp.google.com>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
	<xmqqiob773iy.fsf@gitster.dls.corp.google.com>
	<vpqa8wj48c1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUaK-0005Dn-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbbFAShM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:37:12 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34451 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbFAShK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:37:10 -0400
Received: by ieczm2 with SMTP id zm2so115873727iec.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tE2FhzGZfo1GKUvM9RoFngmWb3XatQCf0Z0RPYCkLPU=;
        b=mfW3WceuL5qMqK73kRVB7sIWof/u4I9JbifgGDcFh6v7xt7FqZ+XKm6ZMSEaaycSfH
         YGQ7vkKdFmDav5f59e0mMUGGYfiKmBlOTvC/kFY4J+Lr+1L32k3hUOEmRYrdwYqIciK1
         QSeqDw7r5qvPNvkf9Cb2xqzJJA28umGlZ2WJici3nBn2djvi35wXoj+Em5emldVVYRrE
         meoY+xzAWJlCAe5To89ql+PduKKL7edrjc13Dy4AApOA/fAGGyLuTxcDtdlHjOFqy9kr
         8anX0PIjwm6QOnj6vxcNNYw7XnULyii+n0dK2EofwAQPwJxOtbQpDxxPLBmtWNhQbuOH
         dvjQ==
X-Received: by 10.107.161.6 with SMTP id k6mr29684216ioe.41.1433183829951;
        Mon, 01 Jun 2015 11:37:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id w4sm8345035igl.22.2015.06.01.11.37.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:37:09 -0700 (PDT)
In-Reply-To: <vpqa8wj48c1.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	01 Jun 2015 20:00:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270455>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> @@ -1,1 +1,2 @@
>> +5
>>  10
>> @@ -1,3 +2,3 @@
>>  10
>> +15
>> -20
>>  30
>
> With this one, I get:
>
> $ git apply < p2.diff   
> error: patch failed: pre.txt:1
> error: pre.txt: patch does not apply
> $ patch < p2.diff 
> patching file pre.txt
>
> => no fuzzy matching for patch, git apply should actually work.

I am not sure what you are trying to do with that patch that tries
to touch the same line twice.  Is this the same old laziness coming
back to bite us, the one that we attempted to work around with
933e44d3 ("add -p": work-around an old laziness that does not
coalesce hunks, 2011-04-06)?

In other words, isn't the right fix to coalesce that input, so that
the second hunk does *not* require fuzzy application in the first
place?
