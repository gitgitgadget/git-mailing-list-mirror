From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 15:39:53 -0600
Message-ID: <CAHd499Bt6_SOkj9Pp+GcLGnwDUR-pgr_YKt4yqZBAHjX+vkM8Q@mail.gmail.com>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
	<54A310AB.7050701@alum.mit.edu>
	<xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y64WF-0003Kq-NX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 22:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaL3Vjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 16:39:55 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65503 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaL3Vjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 16:39:54 -0500
Received: by mail-lb0-f174.google.com with SMTP id 10so12994186lbg.33
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 13:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UARHbBsRMY2Qs2fWXuqdGDICwUMY/QFUdswAyHw/CKk=;
        b=C8efX6gOTY9MmmvV93I6f5bWV/lJRi/ra+bHxJBAsF6N6loCNw0u6ObFg/V7sBJPFN
         0D9Ox5qXI2wBdO/r/wmlEkLJSzklImTC5DLc5AZwXMbp1th9xVisIog51gQ5agyD+jAS
         DJ5OBChhrZCQgJRxmzZ1NS7qyEysVsMMEk3UihnC6Y13DbXn5WBknosrRRxSTTzg1QrL
         oRCAYUTRaj4ItFUXE4LXw6ER8qytvQRm6PwdFvAsaIY+bO5g4d/sY3sQpmAxLFS6jDMi
         fniEvTfekwlj2dpdQ3LUl4g9xqjRFnVQDLxIR2cWx5CDDZg9fbhSxlXI8j6E8pVSFaeh
         NO7g==
X-Received: by 10.152.29.193 with SMTP id m1mr63710065lah.84.1419975593125;
 Tue, 30 Dec 2014 13:39:53 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.185.67 with HTTP; Tue, 30 Dec 2014 13:39:53 -0800 (PST)
In-Reply-To: <xmqqppb0rh63.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: qNiAMeDTeNY9_qbNnGg_Z42DJXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261948>

On Tue, Dec 30, 2014 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> There is yet a third similar question: "What is the last commit that is
>> currently on the master branch that was *authored* at least one year
>> ago? Please note that this question is even subtler, because author
>> timestamps are often out-of-order even on a single branch (whereas
>> commit timestamps are usually in order). I don't know of a simple git
>> command to answer this question.
>
> --author-date-order?

Thanks to everyone for explaining this, it makes sense now. I've been
using git a long time and I found this rather unintuitive because my
mindset was not on "reflog" but instead "git log", so there was a huge
misunderstanding.

Is it valid to use durations (as Michael has done) in the --since and
--until options to `git log`? It also feels like there should be a
shorthand for the `git log` usage in conjunction with `git show`... I
could probably make an alias for it. But basically what I'm looking
for is this (please correct me if I'm wrong):

$ git log --since='1 year ago' -1
(somehow grab the SHA1 from the commit printed above)
$ git show <grabbed SHA1>:Path/To/File.h
(path to file is parameterized above)

So basically these two commands together could be stuffed into an alias:

$ git log-show '1 year ago' Path/To/File.h

This is the best I can come up with for now. Note also that "accuracy"
isn't important here, just "closest matching". I appreciate and
understand that things can be out of order (as far as commit
timestamps go, since you can rebase and reorder things). Accuracy for
these things aren't too important because usually I will use them for
bisect or an approximation of where in time I want to see a file for
code reference (i.e. how a function "used to look back then").
