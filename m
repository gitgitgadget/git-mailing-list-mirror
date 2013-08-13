From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3] status: always show tracking branch even no change
Date: Tue, 13 Aug 2013 12:49:31 +0800
Message-ID: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
References: <7vob964l6v.fsf@alter.siamese.dyndns.org>
	<8b2e7fa581846aca3209b430ac46950ff9d92924.1376146168.git.worldhello.net@gmail.com>
	<7vd2pj1lk6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 06:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V96Y7-0002rF-D5
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 06:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab3HMEte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 00:49:34 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60858 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab3HMEtd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 00:49:33 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so157286wiw.17
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 21:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SC6+lzwC0aovPnJEPXDlrcVfBty1YwgeK9Lm8JA3oZs=;
        b=ASxXene+V9YzWTFZHEsSZSvGdMj7Nu6X7flQ41fhSv8Ig744BYaiPtrI6bnrYcaGMn
         Cp7aAuxzMrAxaMdA/nZg+nA+GMwNIA9CguzHQDOViobzbCZ6m/1vppdB4DtdIIYhixRv
         ymZRVju151j+5AUk8EesGwaeNXwJ4Qgv7YtJ4k0n4HMsHXh4buU45OqV7svvc8tUhkXT
         xKpx950DpICQz6vr744uM+2dXsPBguJhf0QdgPPLhk8TKXZY9O5TkY/tdtkp1zZFQR26
         C+ENzjfjUU8Z2WB8G4NLSw4l7qickUQUAh454x85w0EKtjd2frLQgkO6Xm+HvcDiIzc7
         3Ipg==
X-Received: by 10.180.36.74 with SMTP id o10mr695724wij.23.1376369371870; Mon,
 12 Aug 2013 21:49:31 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Mon, 12 Aug 2013 21:49:31 -0700 (PDT)
In-Reply-To: <7vd2pj1lk6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232208>

2013/8/12 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> 2013/8/10 Junio C Hamano <gitster@pobox.com>:
>>> Jiang Xin <worldhello.net@gmail.com> writes:
>>>
>>>> So always show the remote tracking branch in the output of "git status"
>>>> and other commands will help users to see where the current branch
>>>> will push to and pull from. E.g.
>>>> ...
>>>
>>> Hmmph.
>>>
>>> I do not know if this will help any case you described above, even
>>> though this might help some other cases.  The added output is to
>>> always show the current branch and its upstream, but the thing is,
>>> the original issue in $gmane/198703 was *not* that the current
>>> branch was pushed and up to date.  It was that there was no current
>>> branch to be pushed.  The same thing would happen if you are on a
>>> local branch that is not set to be pushed to the other side
>>> (e.g. the configuration is set to "matching" and there is no such
>>> branch on the other end).
>>>
>>
>> How about write the commit log like this:
>> ...
>> Then if there is no tracking info reported, the user may need to do
>> something. Maybe the current branch is a new branch that needs to be
>> pushed out, or maybe it's a branch which should add remote tracking
>> settings.
>
> Would that help anybody, though?

I will split the patch into two. The 1st patch resolves a real problem:

    branch: not report invalid tracking branch

    Command "git branch -vv" will report tracking branches, but invalid
    tracking branches are also reported. This is because the function
    stat_tracking_info() can not distinguish whether the upstream branch
    does not exist, or nothing is changed between one branch and its
    upstream.

    This patch changes the return value of function stat_tracking_info().
    Only returns false when there is no tracking branch or the tracking
    branch is invalid, otherwise true. If the caller does not like to
    report tracking info when nothing changed between the branch and its
    upstream, simply checks if num_theirs and num_ours are both 0.

And in the 2nd patch, I will not mention "git push" (current not be
pushed out ...) any more, and only focus on "git status". It's just
a suggestion, may only fit small group of users' taste.


-- 
Jiang Xin
