From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Cache stat_tracking_info() for faster status and branch -v
Date: Sat, 20 Oct 2012 16:02:30 +0700
Message-ID: <CACsJy8A2ub2y64qAbP2OTPNsVi-KmxAMFdwBBLXYReF5ASZLKg@mail.gmail.com>
References: <1350408967-13919-1-git-send-email-pclouds@gmail.com> <7v7gqmjl6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 11:03:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPUxk-0007uk-CA
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 11:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab2JTJDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 05:03:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49185 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab2JTJDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 05:03:01 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1132987obb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A5tWtNVFxFNm4l7HQO/ekpJV/o/q6q7TYIMcV+O6R0I=;
        b=v5JDfJqFZ+qudnKFa2YDBK9yhkLGg19sU4fxJUp8y3eoZ5nVq6/diRRIV/ye9y3kmm
         zVeTAnjn/RO595zJx1svdACmW0rnKR87ygMsAZ7oapHVvmE/7q8w4CbuRA0hwSEQAmkv
         j46AoGoiMA5/uQH9tOhFTe4qnKjMQmocMYgWRUD4ehvFbToj1JlZlyUBE0YMeukMPs1C
         s20ifr2SYHcOQQ6Ag+NQfCFqqAWdEo1325mzwPVSkQ+5+iGtc/yRdsN4nvDbGjfJvt6L
         gb1blE8oPG0FC1Zf9ZZPOnfRnnHW88guCUpvEhDNVuvv+Z3tdDRTKOXmd5t16G6/zu+0
         ReRQ==
Received: by 10.60.26.230 with SMTP id o6mr3432739oeg.109.1350723780626; Sat,
 20 Oct 2012 02:03:00 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Sat, 20 Oct 2012 02:02:30 -0700 (PDT)
In-Reply-To: <7v7gqmjl6n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208082>

On Sat, Oct 20, 2012 at 2:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Not particularly interested in the cause, but not so strongly
> against it to veto it.

I wonder how many people keep old branches like I do, which are
usually far from remotes.

> Doesn't it make more sense to use a notes-cache that is keyed off of
> the commit object name X of the remote?  You will have a single note
> that stores a blob for the commit object remotes/origin/master, and
> the blob tells you how far the commit at the tip of 'frotz' is from
> it, and the same for 'xyzzy'.
>
> You would obviouly need to run "gc" on such a notes-cache tree from
> time to time, removing notes for commits that are not tip of any
> branch that could be a fork point, and from the remaining notes
> blobs, entries that describe commits that are not tip of any branch,
> if you go that route.

The notes-cache route looks much nicer. Thanks. We can also use Jeff's
persistent hash table from his rename-cache series.
-- 
Duy
