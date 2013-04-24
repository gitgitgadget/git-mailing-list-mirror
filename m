From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 00:18:49 +0530
Message-ID: <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4l9-0003Pd-L2
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab3DXStf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:49:35 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:60905 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab3DXSte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:49:34 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so1953619iad.10
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8qryvU70Bk50emSd7Vp8bBNmbNYzpd5sbaaMWdCoYdA=;
        b=rQr2LTxIdjKvpV/4hNIjty1ekv6kgIpwDSUp+Pemoxwg+BC1LUWJIxBY3j22pWFfFx
         YdDQMtPzfebgl6hXckkHgHtuYW9LCMW9VOap8SwXCl8kCu9vRYogbmqCN4zzhlhYIHOl
         fzxfz1PK+jUyx94mpJqhUprpXot42Uuxizcav/fyxdVuPf3kxnNBU2DTD5Tclt2HHfpl
         VXZDeDuEhJKYIJ5jqAhgnZGEF6jmlcEF9UM1BMPThiHqZXpZyu5XVQP6wmAiyXYY5s62
         httGeSdRfX1PkZVeA6+pN1O2ugzD9RAz0azPR4GGF18qpMyPvLcABuHHFeaV7GqdWrAJ
         yOaQ==
X-Received: by 10.50.66.197 with SMTP id h5mr5972589igt.63.1366829374254; Wed,
 24 Apr 2013 11:49:34 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:48:49 -0700 (PDT)
In-Reply-To: <7v38ufer2x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222292>

On Wed, Apr 24, 2013 at 11:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> What are your thoughts on inventing a new syntax A~B = $(git
>> merge-base A B) B which can be used by both range commands like log
>> and non-range commands like diff ?  (In other words, why shouldn't log
>> be able to do this?).
>
> The idea for a new syntax to denote a merge base may be an
> interesting one.

Sorry I wasn't clear.  A~B = $(git merge-base A B) B to diff and $(git
merge-base A B)..B to log.  I don't mind a hybrid command as long as
we document it properly.  rev-parse will parse it into B ^${git
merge-base A B) just fine.  Implementation: diff should swap the
arguments if the second argument is UNINTERESTING: it already does
this :)

Basically, I want to be able to do git log master~rebase.autostash
(without having to rebase).  I'm also considering making the first
argument optional (just git log ~rebase.autostash), and defaulting to
mean [nearest fork point].

What do you think?
