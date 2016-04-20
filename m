From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 09/15] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Tue, 19 Apr 2016 21:01:38 -0400
Organization: Twitter
Message-ID: <1461114098.5540.158.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-10-git-send-email-dturner@twopensource.com>
	 <CACsJy8CM409OH12w3EdVP3UjXoURbWNuqb_coQ=AagdCs+ctaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 03:01:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asgWY-0005RV-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 03:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcDTBBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 21:01:41 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34231 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbcDTBBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 21:01:41 -0400
Received: by mail-qk0-f182.google.com with SMTP id r184so10169898qkc.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FLQYUeXtoYMrQXzahtQ2N3xtjmBcqZo5DZnZxgEftQY=;
        b=A2orjjY7xpdUU54/LK79miaMrx126k+PcS/+oZ3XBlpuSa6U4BlQKVH+v953CgA3Ad
         2MzG14dsjAz2HeqWYrqWUFcvEIE56sbtYjCTJMiiFcXFDmxSqvgE0FL6N4x1Doom9tSz
         EMzQMShstkB3KKvBkokgo7/zg7QEi7HkAXu90wzaxh7MayT4JT3+TgMXqhWaErgp1hrn
         6EYtqpfDoJ1sCWps38yc7CdKcMzwCCuAfEEOPWZ70/45sDa+GXVU2h5GLpPRC0/lpr/5
         ragYQAKWaEoIctjfnPiO9qeT+FEhi7+VeFIvKqCtF6Uc80l/7AjwCtzLGKOvKITV98Y5
         q7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FLQYUeXtoYMrQXzahtQ2N3xtjmBcqZo5DZnZxgEftQY=;
        b=W07BVkET8SjugQvtSshfdNifF4MPDQiMfMJExG5Fow36TU3g0h3jtukhw7buY5uhh3
         /cbuiJZkyS1zujNt2uiYtJlMY7p520D6uPwu0/j4W5XoG/D83U96bHRM0rKFsKVY8yh4
         MBGSDIIuypDgZI98UANrJ6mMuf4scMBzOJX9+L3fms9TVail76srd4hedtBpxWV1boyp
         pSAcNfbcOIZZAOBcti/0EASQPlfoapq1rr7mmR+nuZzo9B6R1jw6Q/bjC5WdVtikS41c
         5G8LIVb9XeikvElsdkzQoofmA7SXl0j/uDRBfAVyevHmP2Y+22P9lbTIWkoUw9VGDE1y
         PuQw==
X-Gm-Message-State: AOPr4FV+k7G+lPMjxiSZfDp4rpagaucfEXsI8Suy2bqKm2/UKaZyCsb6aQ8IJFMqwNu/jg==
X-Received: by 10.55.77.202 with SMTP id a193mr7738417qkb.48.1461114099976;
        Tue, 19 Apr 2016 18:01:39 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a6sm18754899qhd.33.2016.04.19.18.01.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 18:01:39 -0700 (PDT)
In-Reply-To: <CACsJy8CM409OH12w3EdVP3UjXoURbWNuqb_coQ=AagdCs+ctaQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291975>

On Wed, 2016-04-20 at 07:15 +0700, Duy Nguyen wrote:
> Continuing my comment from the --use-watchman patch about watchman
> not
> being supported...
> 
> On Wed, Apr 20, 2016 at 6:28 AM, David Turner <
> dturner@twopensource.com> wrote:
> > +static int poke_and_wait_for_reply(int fd)
> > +{
> > +       struct strbuf buf = STRBUF_INIT;
> > +       struct strbuf reply = STRBUF_INIT;
> > +       int ret = -1;
> > +       fd_set fds;
> > +       struct timeval timeout;
> > +
> > +       timeout.tv_usec = 0;
> > +       timeout.tv_sec = 1;
> > +
> > +       if (fd < 0)
> > +               return -1;
> > +
> > +       strbuf_addf(&buf, "poke %d", getpid());
> > +       if (write_in_full(fd, buf.buf, buf.len + 1) != buf.len + 1)
> > +               goto done_poke;
> > +
> > +       /* Now wait for a reply */
> > +       FD_ZERO(&fds);
> > +       FD_SET(fd, &fds);
> > +       if (select(fd + 1, &fds, NULL, NULL, &timeout) == 0)
> > +               /* No reply, giving up */
> > +               goto done_poke;
> > +
> > +       if (strbuf_getwholeline_fd(&reply, fd, 0))
> > +               goto done_poke;
> > +
> > +       if (!starts_with(reply.buf, "OK"))
> > +               goto done_poke;
> 
> ... while we could simply check USE_WATCHMAN macro and reject in
> update-index, a better solution is sending "poke %d watchman" and
> returning "OK watchman" (vs "OK") when watchman is supported and
> active. If the user already requests watchman and index-helper
> returns
> just "OK" then we can warn the user the reason of possible
> performance
> degradation. It's related to the error reporting, but I don't think
> you can send straight errors over unix socket. It's possible but it's
> a bit more complicated.

Do you mean that we should do this here?  Or in update-index -
-watchman?  If the former, I agree.  If the latter, I'm not sure; maybe
you'll be setting up your index before you've started the index helper?

> > +static void refresh_by_watchman(struct index_state *istate)
> > +{
> > +       void *shm = NULL;
> > +       int length;
> > +       int i;
> > +       struct stat st;
> > +       int fd = -1;
> > +       const char *path = git_path("shm-watchman-%s-%"PRIuMAX,
> > +                                   sha1_to_hex(istate->sha1),
> > +                                   (uintmax_t)getpid());
> > +
> > +       fd = open(path, O_RDONLY);
> > +       if (fd < 0)
> > +               return;
> > +
> > +       /*
> > +        * This watchman data is just for us -- no need to keep it
> > +        * around once we've got it open.
> > +        */
> > +       unlink(path);
> 
> This will not play well when multiple processes read and refresh the
> index at the same time. 

Multiple processes will have different pids, right?  And the pid is
included in the filename.  Am I missing something?

> This is really extra. But if we know in advance that git does not 
> need refresh(), then we should be able to tell index-helper not to 
> waste cycles contacting watchman and preparing shm-watchman-%s-%d 
> (the poke line gets more parameters). Either that, or we decouple 
> watchman requests from read_cache() requests. Only when 
> refresh_index() is called that we send something to request shm-
> watchman-%s-%d. The same for read_directory() (i.e. untracked cache 
> stuff). Hmm?

It's true that we could decouple watchman requests.  I'll look and see
if that's reasonable.

> Now that I think of it, with watchman backing us, we probably should
> just do nothing in update_index_if_able() (or write_locked_index()
> when we know only stat info is changed) when watchman is active. The
> purpose of update_index_if_able() is to avoid costly refresh, but we
> can already avoid that with watchman. And updating big index files is
> always costly (even though it should cost less with split-index). 

That sounds like a change we could make in a separate series.  It's not
a bad idea, but if our goal is to get the basic version out, we should
start there.

> Of
> course this can only be done if watchman (inotify to be precise) can
> cover whole worktree. I'm not sure how watchman behaves when there's
> not enough inotify resource to cover full worktree.

It will detect this case and will either manually recrawl (in the event
of a max_queued_events overflow) or return an error (in the event of
too many watched directories).
