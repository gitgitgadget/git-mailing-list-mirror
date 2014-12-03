From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Wed, 03 Dec 2014 06:30:55 -0500
Message-ID: <547EF46F.3000007@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>	<1417335899-27307-25-git-send-email-pclouds@gmail.com>	<547B5170.6050206@gmail.com> <20141201103818.GA20429@lanh>	<xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>	<547D487B.4040502@gmail.com>	<CACsJy8DjbgNpbf9Z-OVCpv+YNmvsuHfcPW_Jfm3_gbq2VgYgkQ@mail.gmail.com> <xmqq4mtem029.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw89A-0001MU-As
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 12:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbaLCLbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 06:31:01 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:64822 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbaLCLa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 06:30:59 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so10875675qgd.15
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FWTDHX5/bATigtugvK6QNRtBiYPfUHlg9YksWYHr5bI=;
        b=jV2tQvngRLrgs6GWoP2DLvCY74UruVQTyOG0nRrxIkDvZjaky5/7aT8IZ4BHZ+j2Su
         mV3CIEVWp8bg/C2qk6nWzyRxz6KzWA11fmtLA8s7mGu2HeZeFO7jIuKHeuY8wEotwDdB
         q077EmSbJNJPQu8u3Vb8ON5aKIkfjR3hfB0EhkPvuaJjhXQAs1+Pvc6j5m6dXAW2P5yj
         Y/mgFo2+GJgC+Ws6VF79ISmyqiFw6G6cJJbGK22iQymscgOdgYS4ne8H16YHxJDH7e1W
         oCBY83+3UrL1SDiPzPqCA8EWuA18VatP+rGyOOLE7fz/R0ncycKZHBIVbKRe1Vn68XFN
         S+Lw==
X-Received: by 10.224.28.135 with SMTP id m7mr7192358qac.7.1417606258449;
        Wed, 03 Dec 2014 03:30:58 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-126-100.washdc.fios.verizon.net. [173.79.126.100])
        by mx.google.com with ESMTPSA id t5sm17512591qad.5.2014.12.03.03.30.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2014 03:30:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq4mtem029.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260645>

On 12/02/2014 12:30 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> FWIW git-branch usually can show the original branch of detached head
>> (must not always). I don't think we have a plumbing equivalent for it
>> though. People can "tail -1 $GIT_DIR/logs/HEAD| sed .." but that seems
>> hacky.
> @{-1}, i.e. "the last branch I checked out"?
>
>> I do like "read-only" ref concept where we can keep ref name
>> (especially tags) in HEAD until the next commit. But it didn't go
>> anywhere
> Remind me.  That sounds somewhat interesting.
>
>
I think these ideas support solutions more complicated than the 
"problem" trying to be solved. Consider a use case: multiple algorithms, 
each a different branch in one repository, any of which can be used to 
analyze the same kinds of data. We also have multiple data sets, each a 
separate branch in a other repository. For development / test / analysis 
it is necessary to have multiple checked out pairs (algorithm + data) on 
the same machine to allow comparison / debugging in place of different 
combinations. Assume one algorithm, multiple data sets are checked out 
and being worked on.

With new-workdir, or Duy's approach with --ignore-other-checkouts, all 
are checked out normally in git, git-branch, git-status, git log all 
work normally. If a change needs to be made that affects the branch in 
more than one checked out repository, once done the other copies are out 
of date. It does not matter which instance is modified, once committed 
the change is already visible in all others, and "git reset --hard" in 
all the others completes the process. This is not difficult to 
understand, requires no new code, no special methods.

Consider the alternatives:
a) Use separate complete repositories + work trees: now the new branch 
needs to be broadcast to all using fetch or pull, and as the change 
might have been an amend, fetch + reset --hard may be required. This is 
not "simpler" to implement in practice, nor do I find it easier to 
explain. Note also that if using push, it is possible to force push into 
the current branch of the other copies, with receive.denyCurrentBranch = 
false, resulting in exactly the same situation as above using 
new-workdir (checked out code not matching the ref).

b) Use Duy's approach without --ignore-other-checkouts. First, you have 
to find the copy that is not on a detached HEAD, detach the HEAD their, 
then go back to the copy where the problem is found, attach the HEAD in 
that one, and make the change. Then go back and do git reset --hard 
$branch in the others.

I just don't see how these alternatives are in the end any simpler to 
use or explain.


Mark
