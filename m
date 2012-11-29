From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 11:04:30 -0800
Message-ID: <CANiSa6j2sriXaGr0yH9kMrxDEvKHsjNPX_Exbc2_6ecnPYdroQ@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<1354213975-17866-1-git-send-email-martinvonz@gmail.com>
	<1354213975-17866-2-git-send-email-martinvonz@gmail.com>
	<7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Pj-0007OC-9a
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab2K2TEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:04:31 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43032 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab2K2TEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:04:31 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so10929146qcr.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V4zH1XBY6vLdBM8N8AinWjMjKdZGyLA8wRZyG+05fdU=;
        b=VDsdYLTld++xf1i4ELbN0XdnEb5s9KZ/yyN3WFGOsL1eDKQnMjf5tnzoiVgaaBYdVl
         jX7hjxN4iDNp25Ts3nuPyvDhjrQrl9TRz1F/1Bc6v3a7WCEwRDZZJ0finOHJdI01fbzW
         EWoem62445E2jYtG3/drOBuHod8A6fdK1+J+c6025JY+BSHzEpuWclHDtz3tNr48F5Tw
         0e6PYc8tf+v3TDYUqrjDjKubL8VtYaFyNstYxVPUK2qnQmf/s3itjTnjdbLx9uVk4SaP
         q5tBX05dwKf9Vy+HgU50E5kNs7E4KKrgSK31E5P8CwO0rlB+n0Dnj3mBTrAr+DcnzSp9
         aLaw==
Received: by 10.49.127.199 with SMTP id ni7mr30671427qeb.17.1354215870525;
 Thu, 29 Nov 2012 11:04:30 -0800 (PST)
Received: by 10.49.2.195 with HTTP; Thu, 29 Nov 2012 11:04:30 -0800 (PST)
In-Reply-To: <7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210863>

On Thu, Nov 29, 2012 at 10:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> In cases where HEAD is not supposed to be updated, there is no reason
>> that "git reset" should require a commit, a tree should be enough. So
>> make "git reset $rev^{tree}" work just like "git reset $rev", except
>> that the former will not update HEAD (since there is no commit to
>> point it to).
>
> That is a horrible design I have to nack, unless you require
> pathspec.  You cannot tell what "git reset $sha1" would do without
> checking the type of the object $sha1 refers to.  If you do this
> only when pathspec is present, then the design is very reasonable.

Very good point. Thanks! I now see that "git checkout" also requires a
path when given a tree.

So then "git reset" on an unborn branch would imply "git reset
$empty_tree -- ." instead. And "git reset --hard $tree" would not be
allowed. And the intersection of these -- "git reset --hard" on and
unborn branch -- would also not work. Would the correct fix be to
first make "git reset --hard -- $path" work (*sigh*)? I have never
understood why that doesn't (shouldn't) work.
