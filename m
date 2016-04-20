From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 09/15] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Wed, 20 Apr 2016 16:36:22 +0700
Message-ID: <CACsJy8CijNvJJzjxh5c-2bxJtEHzUNmR_iTPNLTqHGFQjOP9Eg@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
 <1461108489-29376-10-git-send-email-dturner@twopensource.com>
 <CACsJy8CM409OH12w3EdVP3UjXoURbWNuqb_coQ=AagdCs+ctaQ@mail.gmail.com> <1461114098.5540.158.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 11:37:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asoZA-0007dj-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 11:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbcDTJgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 05:36:55 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35301 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbcDTJgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 05:36:54 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so37297438lfb.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=13MqSbF6JGuKvJcWBem50X232mi1VFVH0U/gVpcDIkc=;
        b=DONOBzhp2vaGAp55pFGkwMPf6KBiYFMQbpUppKAMh2rPHU49Mc7V3t7i8ooGogrvlZ
         RE839S/+UCr05a01rC3MjjDdNXXjY3AWwfe5dz3GrjAIKg8fmL8Z3xKOs6vwNwrEOUpc
         pzENsKbtaGyAhXP8iKV5I9lrE94kAsiLwQbOeEvlXk/ONu9XBTepZT4MLe0J2udDqLbG
         zN+bByklmxbTZwyXpNxTorxpM0j0/+DUM2CFzcunFcHtWQlpg/7bP5wn/HJ6YpASsXxW
         x6GC+pv3Px73d60B9mUTqjmzsZZ5qiR76NCqzRsCxorHXmvHEuqkxbuzBciz/BYTZ+nN
         Faxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=13MqSbF6JGuKvJcWBem50X232mi1VFVH0U/gVpcDIkc=;
        b=gLDtnGwnliCFShqwDE+JHLuQqdH7MxiLVOfU+4qTYacbo4zkVV3YCxff0MHG7aJ1Aw
         8pR9WqOOMEhjFJ6DSI3LiyP+bzFXKEZXoq+/4txwTnJ6nV2Vz1wyZK4lWssgset7Ke7l
         IRChjoMSFLRkoGldFovbqqcZAPfRY+MrtG0s5c+eRNP1cWZ0SnYKYLrfPpuclN0xU2Js
         YEl6XVPNsv0MgG/8NmhVEKPt5Wr0HQTeZAgs2TUaXVcV2ZAnMjLwJPTQyReyX4tI/PM1
         0npKxj6aFy1jXoD/OAsmdyZe5v1BS7HWsVkkPuCyCT4/dsgl4CjQsJtD2yVWdIzun2dV
         zJdw==
X-Gm-Message-State: AOPr4FX+IttqOJlzy9Hx2JGPDjqMMo+c4r/pdaertAzXD9mM7mm7qwnbOclxs2Q3WZBA7/hkOLbloF6Sb/kyfw==
X-Received: by 10.25.42.1 with SMTP id q1mr3183621lfq.94.1461145012336; Wed,
 20 Apr 2016 02:36:52 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 02:36:22 -0700 (PDT)
In-Reply-To: <1461114098.5540.158.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292000>

On Wed, Apr 20, 2016 at 8:01 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-04-20 at 07:15 +0700, Duy Nguyen wrote:
>> Continuing my comment from the --use-watchman patch about watchman
>> not
>> being supported...
>>
>> On Wed, Apr 20, 2016 at 6:28 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > +static int poke_and_wait_for_reply(int fd)
>> > +{
>> > +       struct strbuf buf = STRBUF_INIT;
>> > +       struct strbuf reply = STRBUF_INIT;
>> > +       int ret = -1;
>> > +       fd_set fds;
>> > +       struct timeval timeout;
>> > +
>> > +       timeout.tv_usec = 0;
>> > +       timeout.tv_sec = 1;
>> > +
>> > +       if (fd < 0)
>> > +               return -1;
>> > +
>> > +       strbuf_addf(&buf, "poke %d", getpid());
>> > +       if (write_in_full(fd, buf.buf, buf.len + 1) != buf.len + 1)
>> > +               goto done_poke;
>> > +
>> > +       /* Now wait for a reply */
>> > +       FD_ZERO(&fds);
>> > +       FD_SET(fd, &fds);
>> > +       if (select(fd + 1, &fds, NULL, NULL, &timeout) == 0)
>> > +               /* No reply, giving up */
>> > +               goto done_poke;
>> > +
>> > +       if (strbuf_getwholeline_fd(&reply, fd, 0))
>> > +               goto done_poke;
>> > +
>> > +       if (!starts_with(reply.buf, "OK"))
>> > +               goto done_poke;
>>
>> ... while we could simply check USE_WATCHMAN macro and reject in
>> update-index, a better solution is sending "poke %d watchman" and
>> returning "OK watchman" (vs "OK") when watchman is supported and
>> active. If the user already requests watchman and index-helper
>> returns
>> just "OK" then we can warn the user the reason of possible
>> performance
>> degradation. It's related to the error reporting, but I don't think
>> you can send straight errors over unix socket. It's possible but it's
>> a bit more complicated.
>
> Do you mean that we should do this here?  Or in update-index -
> -watchman?  If the former, I agree.  If the latter, I'm not sure; maybe
> you'll be setting up your index before you've started the index helper?

Here is better than update-index because we can't know what
index-helper is capable of (the USE_WATCHMAN macro is more like a
suggestion)

>> > +static void refresh_by_watchman(struct index_state *istate)
>> > +{
>> > +       void *shm = NULL;
>> > +       int length;
>> > +       int i;
>> > +       struct stat st;
>> > +       int fd = -1;
>> > +       const char *path = git_path("shm-watchman-%s-%"PRIuMAX,
>> > +                                   sha1_to_hex(istate->sha1),
>> > +                                   (uintmax_t)getpid());
>> > +
>> > +       fd = open(path, O_RDONLY);
>> > +       if (fd < 0)
>> > +               return;
>> > +
>> > +       /*
>> > +        * This watchman data is just for us -- no need to keep it
>> > +        * around once we've got it open.
>> > +        */
>> > +       unlink(path);
>>
>> This will not play well when multiple processes read and refresh the
>> index at the same time.
>
> Multiple processes will have different pids, right?  And the pid is
> included in the filename.  Am I missing something?

Ahhh! I thought that pid was index-helper's. Silly me.

>> Now that I think of it, with watchman backing us, we probably should
>> just do nothing in update_index_if_able() (or write_locked_index()
>> when we know only stat info is changed) when watchman is active. The
>> purpose of update_index_if_able() is to avoid costly refresh, but we
>> can already avoid that with watchman. And updating big index files is
>> always costly (even though it should cost less with split-index).
>
> That sounds like a change we could make in a separate series.  It's not
> a bad idea, but if our goal is to get the basic version out, we should
> start there.

Agreed. More optimizations can always wait till later. We just need a
good foundation first.
-- 
Duy
