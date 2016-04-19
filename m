From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/7] fix checking out a being-rebased branch
Date: Tue, 19 Apr 2016 08:04:46 +0700
Message-ID: <CACsJy8BCg3GO1g0Z+S+bDYT3Bdh8d8q0WHz=JoeALvYwfNrM0A@mail.gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com> <xmqqpotm6cfq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, rethab.ch@gmail.com,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asKAO-00033C-6F
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 03:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbcDSBFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 21:05:19 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33735 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbcDSBFS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 21:05:18 -0400
Received: by mail-lf0-f48.google.com with SMTP id e190so1539398lfe.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 18:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p3j5u3wosiha25tkk3NapPrTedVGxf/i5jM+5fMpy0Q=;
        b=UpOyvIX8Rd8fH8JLR/mgoYTT8zcmfdYl6SkvYtX+mZzvYQd33Zb2spGoOLcJ94OJgo
         xEkrGYNNw5HRIZBsfughwM1eUFyTCxFXOcLBhipKTpHV3DXn/yOZxa7hBR13t15hA7cS
         dMYYxoFt6rsMfuFfHaYISk7NUSq+agAGoblizBdxSM55lkU53YN3v14XgXedWcvQVIo0
         e3+1GHhK8odKXhX54JSmEu8HqNLIOO1bPpf9A3MtEInE90FAT4lTQthtI/GRY44j7Lt5
         uDZg7K/pPyUzWk/LYeWArybgCJCxP+NMUkyh6irVt7/PA65wyfcyqWTP8cTLpsMntFS7
         vPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p3j5u3wosiha25tkk3NapPrTedVGxf/i5jM+5fMpy0Q=;
        b=NLKQ6y30jvOkiKvyzXvOBv2vEVjmLMyqqOKDl9VIxABL8Csn2RHrcqU6f80gHcwlCl
         fR2BlZZVh3IjdC+PyMk1PexRxAjzsjNiD4QrBzZDXfplcgmlAuMXJYpdEGbF8ou8jHIg
         tK5eOpB6zGZ4Ubra5rqLqZFXt/ULZ1hFNvWfcPozS1fJIUULTSK8uYWGbCWjCB1jOyce
         wZMC4HRWvFLYinK+JMm55oJMeLrY8LTdhGCzulE5QrFxXs/Or4UaPV0Gw/79Ptmo4feV
         cWr9edO6fVIp19F6EdiIPsGeS4AuYRr8zuDPoiQhnlTX3R6XlGgtheqHvZGzObajQzAl
         b+FA==
X-Gm-Message-State: AOPr4FXd9iC2Fhm9FN6KIpSIbNX3swn8mKHn8SELS6NCK0mHFlPCjuPgLtSBUaePh+ZGrNbCx3J0b+PkfZni6w==
X-Received: by 10.112.130.41 with SMTP id ob9mr59188lbb.81.1461027916459; Mon,
 18 Apr 2016 18:05:16 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 18 Apr 2016 18:04:46 -0700 (PDT)
In-Reply-To: <xmqqpotm6cfq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291840>

On Tue, Apr 19, 2016 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Another option is leave wt_status_get_state() alone, factor out the
>> rebase-detection code and use that for worktree/checkout. We save a
>> few syscalls this way too.
>>
>> Comments?
>>
>>   [01/07] path.c: add git_common_path() and strbuf_git_common_path()
>>   [02/07] worktree.c: store "id" instead of "git_dir"
>>   [03/07] path.c: refactor and add worktree_git_path()
>>   [04/07] worktree.c: add worktree_git_path_..._head()
>
> I actually wondered how ky/branch-[dm]-worktree topics to avoid
> "branch -d" and "branch -m" from removing or renaming a branch that
> is checked out in other worktrees from screwing them up.  There may
> be a missed opportunity to clean them up with using these?

branch-m-worktree uses info populated at get_worktrees() phase.
branch-d-worktree uses find_shared_symref() which is modified in this
series in order to detect rebase branch. So both topics have the same
problem when a branch is being rebased and if I do it right, I'll fix
them both without extra code. Actually I may need to check
branch-m-worktree again, renaming a branch under rebase might cause
problems, I need to have a closer look at git-rebase*.sh.
-- 
Duy
