From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] reset: trivial refactoring
Date: Thu, 13 Jun 2013 16:20:22 -0500
Message-ID: <CAMP44s17nRzh157hyLMjKWi3ZOLqUui=uMVMwyffcGFFrucd_w@mail.gmail.com>
References: <1371147305-20771-1-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6i5xL-V+W46zWXGzLc+dSO6a+V0BLPt7hFgGZGXpp03BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 23:20:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnEwW-0002kd-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 23:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab3FMVUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 17:20:24 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52614 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756931Ab3FMVUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 17:20:23 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so7687188lbi.25
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pNLLNhecqlkjmDdB5t9CRFV7KlE23zQidkqMOVPDu0U=;
        b=IybNqiMnqXCFq1vlrvkd0BV0UOg13//RxxGBdAYQ4NxBTCc5hZN+u3InIUlBUM54Oy
         ETwfin/Yis5a7m77+fBoPEOKjJ+0SnX9Vkx6pwEB/vMddu+U0IFuI5XCfI2GBLjxwmz/
         Qp2sHNJNoWaQAM7BXnjdzVeyjQQdZBrHFWUOa5vA0/jpi/m5KW5S8wFMDRYZmaHxzRPN
         R/cRz+/ctk8vuaRgoLnWYlArKiSqrPZ7SQ84yNKVCJwJkU81cf5P2LNHbkug7w9JessQ
         zfhNSYt9IRfI182Y8HVTRs0qY9dWAcKzG5bVZDtzeTMuup9KrmQHRzEtLvyKOp080ay4
         NbSw==
X-Received: by 10.112.52.97 with SMTP id s1mr2220441lbo.8.1371158422255; Thu,
 13 Jun 2013 14:20:22 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 13 Jun 2013 14:20:22 -0700 (PDT)
In-Reply-To: <CANiSa6i5xL-V+W46zWXGzLc+dSO6a+V0BLPt7hFgGZGXpp03BQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227779>

On Thu, Jun 13, 2013 at 4:13 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Thu, Jun 13, 2013 at 11:15 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> @@ -82,7 +82,7 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
>>         if (unpack_trees(nr, desc, &opts))
>>                 return -1;
>>
>> -       if (reset_type == MIXED || reset_type == HARD) {
>> +       if (reset_type == HARD) {
>
> Are you sure that this can not be reached given that...
>
>> @@ -323,8 +323,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>                 struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
>>                 int newfd = hold_locked_index(lock, 1);
>>                 if (reset_type == MIXED) {
>> +                       int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
>>                         if (read_from_tree(pathspec, sha1))
>>                                 return 1;
>> +                       refresh_index(&the_index, flags, NULL, NULL,
>> +                                     _("Unstaged changes after reset:"));
>>                 } else {
>>                         int err = reset_index(sha1, reset_type, quiet);
>>                         if (reset_type == KEEP && !err)
>
> ...the line after this one reads
>
>    err = reset_index(sha1, MIXED, quiet);

That's true. Only the rest of the patch makes sense then. It seems
there should be a way to have a single call reset_index(KEEP), so we
don't have to call again with MIXED, but perhaps that's for later.

-- 
Felipe Contreras
