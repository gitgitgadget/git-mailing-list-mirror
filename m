From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: update all per-worktree HEADs when renaming a branch
Date: Tue, 22 Mar 2016 07:49:00 +0700
Message-ID: <CACsJy8BKBiYTsp5wv9ynr++p2TE-dzS9J+DkOPEKumCL-reLVw@mail.gmail.com>
References: <1458553816-29091-1-git-send-email-k@rhe.jp> <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kazuki Yamaguchi <k@rhe.jp>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 01:49:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiAVs-000425-IF
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 01:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbcCVAtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 20:49:32 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34270 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcCVAtb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 20:49:31 -0400
Received: by mail-lb0-f169.google.com with SMTP id k12so140866464lbb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 17:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qDdKl2T2s4xI7d0esRaX1CIr5MWJ5Ynbi7YKkeCQov0=;
        b=KSAnqUK9DKxsJgw+QnTEw1gfvJOEN+JLJANu2KFNPPcFQUH8wsQKEyJsx5bobVPwBV
         7lxJK353Hx0mR70NvGWgmISmR+/bTONjQXmL5PwsKxbjcviVZ61zrBf5jezFVc53WRGY
         gV5hiCvDg69atxVc3sCCPUT0lPmX2s8t0A4UEcsYVVa9a/as6KAUTaU5IGkkrux8GrxA
         I7xN3oYuVbFFiNxy6VEW6wHglNivPt4u9uRdApGPVoU/Eqd8eqE2WLlPHIkT674aNuPp
         7kzO/JlRDV3FO5B57T2mVvBhNlF8b/MZQCSgwjpy3w/kP1i36RgkCcNumo7JzljbBz+d
         ArgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qDdKl2T2s4xI7d0esRaX1CIr5MWJ5Ynbi7YKkeCQov0=;
        b=ZbJUDzAyPCZ4XcllF8vJ5DiPPdLspLFMI/sQq5CsSCwGBBVAdwzU6dduYYbU9xT1OH
         bjcQKkdfBB7vg8A5if6s6Z85EDdCGmtnRAmj0IAfwjmBmjNZpOyfArkOX43LJo5npw2S
         YZ7Kdg7cE4Zo8HCvcUVJbPylGdsLI8x3wSAdvNLBtK39FhtOXMlEWCQuEjkRJT3Dvi+f
         zznbm/4/LIG4S5zIHf66CiYLzEkP9JcYRxO5txP0cS9S9NBnxM2pMoC7vYu43TQ43mbL
         E9g0racLdMe5hcZw5AQS6B2k+rWahxwEeWm0PMDRLRfRN8rAH3p8dxi4GkjXA9j/08zD
         JS1Q==
X-Gm-Message-State: AD7BkJLlT7ZsWiPsAYWSc7scbwVxtZbYLME6o8dK3l7lblMQDmO68ky93HS9ckC3nfbHAN8tUc8zA2LCPdNqVQ==
X-Received: by 10.112.157.105 with SMTP id wl9mr12093019lbb.137.1458607769863;
 Mon, 21 Mar 2016 17:49:29 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 21 Mar 2016 17:49:00 -0700 (PDT)
In-Reply-To: <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289478>

On Tue, Mar 22, 2016 at 12:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> diff --git a/worktree.c b/worktree.c
>> @@ -217,3 +217,41 @@ char *find_shared_symref(const char *symref, const char *target)
>> +int update_worktrees_head_symref(const char *oldref, const char *newref)
>> +{
>> +       int error = 0;
>> +       struct strbuf path = STRBUF_INIT;
>> +       struct strbuf origref = STRBUF_INIT;
>> +       int i;
>> +       struct worktree **worktrees = get_worktrees();
>> +
>> +       for (i = 0; worktrees[i]; i++) {
>> +               if (worktrees[i]->is_detached)
>> +                       continue;
>> +
>> +               strbuf_reset(&path);
>> +               strbuf_reset(&origref);
>> +               strbuf_addf(&path, "%s/HEAD", worktrees[i]->git_dir);
>> +
>> +               if (parse_ref(path.buf, &origref, NULL))
>> +                       continue;
>> +
>> +               if (!strcmp(origref.buf, oldref)) {
>> +                       int prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
>> +                       const char *symref = path.buf + prefix_len;
>> +
>> +                       /* no need to pass logmsg here as HEAD didn't really move */
>> +                       if (create_symref(symref, newref, NULL)) {
>> +                               error = -1;
>> +                               break;
>
> Is aborting upon the first error desired behavior? (Genuine question.)
> Would it make more sense to continue attempting the rename for the
> remaining worktrees (and remember that an error was encountered)?

Since all these HEADs stay at the same (or close) location, if one
fails, I think the rest will fail too. Which leads to a series of
warnings if we continue anyway. A more interesting approach is update
HEADs in a transaction, so we successfully update all or we update
none. But I do not know if ref transactions can be used for HEAD,
especially worktree HEADs. I'm ok with either abort here or continue
anyway, though.
-- 
Duy
