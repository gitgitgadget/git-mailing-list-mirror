From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v2 0/5] push: update remote tags only with force
Date: Fri, 9 Nov 2012 19:15:49 -0600
Message-ID: <CAEUsAPbmimoEVoJjvXkOFacs-X6hu5b0NO1sHZ9eSSRM07yPFA@mail.gmail.com>
References: <1352084908-32333-1-git-send-email-chris@rorvick.com>
	<20121109183834.GB22164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 02:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWzkS-0002zb-QR
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 02:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab2KJBPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 20:15:52 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:51331 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab2KJBPv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 20:15:51 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3391542lag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=JpKpqgpMXNBlse2j22XWBUjLZARBsMmZRpOdqK6ZIzY=;
        b=R39VtQIIwCcfoPsOL0EDxnqh/2jP02YLWtGj5rXZyjvldoLJROGLBNrvG4RghFHJmk
         q4cI677h1LqV9yqylQvHe77Nxb6CmDWXstknBY0FRhB/ynqL8tcNQO57uGGnC09wrXKX
         e3Tit24EdiY+GRD7qCxANeaZ8ea2RcfRNPHpXuyV7o5yVN4pJ6wLVnDYgzesrKPBtKbA
         bJRSDilqPpBY3gwIz9JlY7lcsB2WrsK4lo2LY4ea1fMNwZWpal71VQdI1oI1p6iJy6ww
         C6BCIr0tkpXlrGzpx3oZqXn4vVeaCToezOn6+oRZ9oeWAgkZMhWuzToe3wOCmGunw//Y
         ioRA==
Received: by 10.152.105.103 with SMTP id gl7mr11991590lab.10.1352510149751;
 Fri, 09 Nov 2012 17:15:49 -0800 (PST)
Received: by 10.114.2.45 with HTTP; Fri, 9 Nov 2012 17:15:49 -0800 (PST)
In-Reply-To: <20121109183834.GB22164@sigill.intra.peff.net>
X-Google-Sender-Auth: RiwoO0f1p-_NQNzrFcCPIfbWSTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209256>

On Fri, Nov 9, 2012 at 12:38 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 04, 2012 at 09:08:23PM -0600, Chris Rorvick wrote:
>
>> Patch series to prevent push from updating remote tags w/o forcing them.
>> Split out original patch to ease review.
>>
>> Chris Rorvick (5):
>>   push: return reject reasons via a mask
>>   push: add advice for rejected tag reference
>>   push: flag updates
>>   push: flag updates that require force
>>   push: update remote tags only with force
>>
>>  Documentation/git-push.txt |   10 +++++-----
>>  builtin/push.c             |   24 +++++++++++++++---------
>>  builtin/send-pack.c        |    6 ++++++
>>  cache.h                    |    7 ++++++-
>>  remote.c                   |   39 +++++++++++++++++++++++++++++++--------
>>  t/t5516-fetch-push.sh      |   30 +++++++++++++++++++++++++++++-
>>  transport-helper.c         |    6 ++++++
>>  transport.c                |   25 +++++++++++++++----------
>>  transport.h                |   10 ++++++----
>>  9 files changed, 119 insertions(+), 38 deletions(-)
>
> I have not looked carefully at this topic yet, but I did try merging it
> to "pu" and found that it had some textual conflicts with the
> nd/builtin-to-libgit topic, which moves some builtin/send-pack.c code to
> send-pack.c. Since I am graduating that topic to master, I went ahead
> and just rebased your topic on top.
>
> If you do a re-roll, please use an updated master, and feel free to
> grab (and double-check!) the rebase I am about to send out in 'pu'. I
> also included the minor signed/unsigned pointer warning fixup in the
> rebase, too.
>
> -Peff

Thanks, I've rebased and checked against the changes in pu.  Looks
good to me.  I have a couple of other minor fixes (see below for
details.)  I'll include these in an update if there is sufficient
interest in this.

Chris

-- 8< --
diff --git a/remote.c b/remote.c
index fde2a79..b025a38 100644
--- a/remote.c
+++ b/remote.c
@@ -1351,9 +1351,8 @@ void set_ref_status_for_push(struct ref
*remote_refs, int send

                if (ref->update) {
                        ref->nonfastforward =
-                               ref->update &&
-                               (!has_sha1_file(ref->old_sha1)
-                                 || !ref_newer(ref->new_sha1, ref->old_sha1));
+                               !has_sha1_file(ref->old_sha1)
+                                 || !ref_newer(ref->new_sha1, ref->old_sha1);

                        if (!ref->forwardable) {
                                ref->requires_force = 1;
diff --git a/transport.c b/transport.c
index c183971..a380ad7 100644
--- a/transport.c
+++ b/transport.c
@@ -749,7 +749,7 @@ void transport_print_push_status(const char *dest,
struct ref *r
                        else
                                *reject_mask |= REJECT_NON_FF_OTHER;
                } else if (ref->status == REF_STATUS_REJECT_ALREADY_EXISTS) {
-                               *reject_mask |= REJECT_ALREADY_EXISTS;
+                       *reject_mask |= REJECT_ALREADY_EXISTS;
                }
        }
 }
