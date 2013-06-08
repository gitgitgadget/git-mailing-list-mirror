From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 12:06:52 -0500
Message-ID: <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMbn-0004gm-H2
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab3FHRGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:06:54 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:45865 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3FHRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:06:54 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so3630007lbh.23
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cAOVvvOMtzy3QeWiVlkx7IjHrZoy+8LKaht3Xlaqxxw=;
        b=ofXK0W1cFRtVXq+8VpfqBlV068JsGs76NOGWiFUwNLJP/6kVHlbAxsHg0QLyeyRhTw
         0K/jGuD/yNi4kduIZsG1RvAst5dtPDMDsJuP6eo+Cv6LoUX583ZjaA3pYxh6vnRZoqDb
         kb+x0I+cXcaItZST/Kn5k5/ntc9ngPcheBa+bQLPPXcuhB2oNrqkmrZ6YjhVVgjb9vtC
         DgnjZOXu6xhYbu8BdquMW5tss7dHK8t9YeI4u1p3wF2gicI4fAzynI2jWR1e8ANRGOw2
         ulJ5UOfsXJ0N5D2xtzklDGhpF9Ug0mfEwF1MpIcyk/b6uNT9/lXDFg+DARwJIWQGxmzu
         qPNw==
X-Received: by 10.112.219.133 with SMTP id po5mr3279029lbc.80.1370711212162;
 Sat, 08 Jun 2013 10:06:52 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 10:06:52 -0700 (PDT)
In-Reply-To: <20130608164902.GA3109@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226841>

On Sat, Jun 8, 2013 at 11:49 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Duy Nguyen wrote:
>
>> libgit.a is just a way of grouping a bunch of objects together, not a
>> real library and not meant to be. If you aim something more organized,
>> please show at least a roadmap what to move where.
>
> Exactly.  There are some rough plans I would like to help with in the
> direction of a more organized source tree (so "ls" output can be less
> intimidating --- see Nico Pitre's mail on this a while ago for more
> hints), but randomly moving files one at a time to builtin/ destroys
> consistency and just makes things *worse*.  So if you'd like to work
> on this, you'll need to start with a description of the endpoint, to
> help people work with you to ensure it is something consistent and
> usable.

So lets stash everything together.

--- a/Makefile
+++ b/Makefile
@@ -990,6 +990,8 @@ BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/write-tree.o

+LIB_OBJS += $(BUILTIN_OBJS)
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =

@@ -1712,9 +1714,9 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
        '-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
        '-DGIT_INFO_PATH="$(infodir_relative_SQ)"'

-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(GITLIBS)
        $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-               $(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+               $(ALL_LDFLAGS) $(LIBS)

 help.sp help.s help.o: common-cmds.h

@@ -1892,7 +1894,7 @@ VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o

 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
-OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+OBJECTS := $(LIB_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
        $(XDIFF_OBJS) \
        $(VCSSVN_OBJS) \
        git.o

And stop any delusions that libgit.a has any meaning at all, and along
the way get rid of any hopes of ever having an official public library
similar to libgit2.

> Actually, Felipe, I doubt that would work well.  This project requires
> understanding how a variety of people use the git source code, which
> requires listening carefully to them and not alienating them so you
> can find out what they need.

My patch covers every need. Nobody has come forward with a reason not
to organize the object files. Everything works after my patch the same
way it has worked before.

> Someone good at moderating a discussion
> could do that on-list, but based on my experience of how threads with
> you go, a better strategy might be to cultivate a wiki page somewhere
> with a plan and give it some time (a month, maybe) to collect input.

This has nothing to do with better strategy, it has everything to do
with gut feelings and tradition. Not reasons.

> NAK to changing the meaning of builtin/ to "built-in commands, plus
> sequencer", which seriously hurts consistency.

Then apply the patch above and stop wasting our time with a "library".
Git is nothing but a bunch of disorganized object files, all squashed
together, there's no library, nor will ever be; libgit.a is a
misnomer.

-- 
Felipe Contreras
