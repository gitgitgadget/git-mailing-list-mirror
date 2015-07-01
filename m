From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 02:37:25 -0400
Message-ID: <CAPig+cSM5VH9e8T_Bee1d_2GB2ZZpvygKh7_19BJHnifiNp5CA@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
	<CAPig+cT7X=LOtgYjXWx=EBJpMrytntQHgdSzdN=prqaysanaCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 08:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZABeF-00014h-MI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbbGAGh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:37:27 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36391 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbGAGh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:37:26 -0400
Received: by ykdr198 with SMTP id r198so30566217ykd.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5t8vie5Fd3QsCoMHecEP2cKQ9Bx4nXchXxWpskG99w4=;
        b=oavdg3hx9NBgH8klKW9bS7ggC+oPCVcOP3cQFyhoFt2uFR7XsrpAB0/j8Iwy/M2voO
         Xq/Mn9YV0ok60VIX4J66s9oqzRtShD6KtZYxu4pqAxVl9LOExxC651PTYIk0q4fZec49
         W8KT3PB2TjTfsrwouHOExOrprIdWuWZBFuHWrzXHW3HHtktHNrrmz3+dBUfTQ1GWzqwl
         d/eCkbfFddMaZUOmZ1yAT5xECtOupB8ueSSdRIeu1forhBVhwrioiEtgF45Es6DO51pC
         v0/+f6BbBjn24ENntQrGrMgCsWGrBYou0Rd/7sDQ3NNp2WXPjH0NtlaFXJWCVeRHj4HA
         Fv0Q==
X-Received: by 10.129.91.135 with SMTP id p129mr31188254ywb.95.1435732645340;
 Tue, 30 Jun 2015 23:37:25 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 23:37:25 -0700 (PDT)
In-Reply-To: <CAPig+cT7X=LOtgYjXWx=EBJpMrytntQHgdSzdN=prqaysanaCw@mail.gmail.com>
X-Google-Sender-Auth: nCxjRrS9KUxN_j_ClQCzuQdZTCc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273132>

On Tue, Jun 30, 2015 at 6:02 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 30, 2015 at 5:23 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Jun 30, 2015 at 11:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> The command "git checkout --to <path>" is something of an anachronism,
>>> encompassing functionality somewhere between "checkout" and "clone".
>>> The introduction of the git-worktree command, however, provides a proper
>>> and intuitive place to house such functionality. Consequently,
>>> re-implement "git checkout --to" as "git worktree new".
>>
>> "git worktree new" definitely makes sense (maybe stick with verbs like
>> "create", I'm not sure if we have some convention in existing
>> commands), but should we remove "git checkout --to"? I could do "git
>> co -b foo --to bar" for example.
>
> You can still do that with "git worktree new bar -b foo", which is
> effectively the same as "git checkout --to bar -b foo" (with
> s/checkout/worktree/ and s/--to/new/ applied), though perhaps you
> don't find it as obvious or natural.

I had never understood why you chose to plug the linked-worktree
functionality into git-checkout via --to, but this usage pattern
(creating a new branch and checking it out into a new worktree as one
operation) goes a long way toward explaining why you consider
git-checkout a proper home for linked-worktree creation. I don't think
that justification was ever mentioned when the series was being
presented (or, if it was, I must have missed it). Now it makes much
more sense, and I can better appreciate your desire to keep "git
checkout --to" as an alias for "git worktree add". Thanks for
explaining it.

(Having said that, replacing "git checkout --to" with "git worktree
add" still seems a preferable first step, while keeping open the door
to re-add "git checkout --to" later if we become convinced that it's
worthwhile.)
