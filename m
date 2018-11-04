Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44B31F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeKEImt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 03:42:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37503 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeKEImt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 03:42:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so6302198wmc.2
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 15:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kWETomqLjzXDlt1Y+fc8UMwPM1UBTK716+3f9MJ/RJ8=;
        b=Kdylf7R063zo5FnO4riz4k8ynOg5N9NeggThxgKsl9Azw1k7P5qvuhIEeIH+Tdy7hV
         sUtTjH585rJ19ttcv8wEYzEhcIohHKw4ua5UxU7410O0F9cObVO/EOQhw56jBjEVIfX9
         Mu6erAYpvQrh0sjnAC0u+vrhq1TC6MJGzfsFk8luzN1nm4pVk/Wyamw+ZlaeGiLOVis6
         wyJcZEMd77HcJJukKWc1ndJLWX7pCM2ipHr5RAlqqOJFerPifKvXWS8e8zbcNzhBbj2V
         rPCKlf8NyVDpdqsrbHo28u5NVqnaGjq0v1i/NKkPO6y1RflKVa+HdQC8IH3ZyZ1Q5htl
         XkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kWETomqLjzXDlt1Y+fc8UMwPM1UBTK716+3f9MJ/RJ8=;
        b=R/KMRYlAlrBxfCHljSTiDubR+apF8sCyreu/rjUessMzxu8XtHtwpgVNrk7bSNQFe9
         zll+xBvnPBOXEa+kWAI7TN3SfsIggXcRdAeAPXnhW1xoynF32G/s1sOk2yWTKXBK0sqT
         XZb15Ho0v6NFvdR5hE1LuD/X4NOgChj+Z+PLGmUIRpDWaMfiqNtF494hii4Nx/e4OmVL
         03JkMJ68nK5ffCVZKjy35ZaLxqcs9jhYRXAFblgXNOi56RLOyjBqa2Xx3EDnTFo8phTE
         /we+Cqy6cCQgkNxAK3thgc4l6xtMOB/gNnPtU45+IEQo//sJWjFauRy9k5VETDKMhBJ0
         Kq3g==
X-Gm-Message-State: AGRZ1gJOg0FHyiFjjO7zUXwxOIHatWjSs4zXwBbbLgk7lfUzt5wba1PC
        7cqGW/fxqpnpP88lm10FwP0=
X-Google-Smtp-Source: AJdET5cFy+qUq1O8ehFEzx0HkusJ0g0ZuQoSUaPzeHmp6bVIM9AvgYtf/ZvRUhmIShG8EtTHfUhkeg==
X-Received: by 2002:a1c:a905:: with SMTP id s5-v6mr4282384wme.75.1541373966427;
        Sun, 04 Nov 2018 15:26:06 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v2-v6sm11669748wru.20.2018.11.04.15.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 15:26:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Carlo Arenas <carenas@gmail.com>, shoelzer@gmail.com,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around issues
References: <pull.64.git.gitgitgadget@gmail.com>
        <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
        <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
        <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
        <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
        <CAPUEspgF0GjJPtMqmZjUmsEeaJpQQBBwOV9YOg8A6YBdwbdaFA@mail.gmail.com>
        <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org>
Date:   Mon, 05 Nov 2018 08:26:02 +0900
In-Reply-To: <46aa1893-095b-9f0c-4989-e63ebaa88705@kdbg.org> (Johannes Sixt's
        message of "Sat, 3 Nov 2018 15:05:54 +0100")
Message-ID: <xmqqefc0mnlh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.11.18 um 09:14 schrieb Carlo Arenas:
>> On Fri, Nov 2, 2018 at 9:44 AM Johannes Sixt <j6t@kdbg.org> wrote:
>>>
>>> +      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);
>>
>> nitpick: cast to DWORD instead of int
>
> No; timeout is of type int; after an explicit type cast we don't want
> to have another implicit conversion.
>
> -- Hannes

OK, thanks.  It seems that the relative silence after this message
is a sign that the resulting patch after squashing is what everybody
is happey with?

-- >8 --
From: Steve Hoelzer <shoelzer@gmail.com>
Date: Wed, 31 Oct 2018 14:11:36 -0700
Subject: [PATCH] poll: use GetTickCount64() to avoid wrap-around issues

The value of timeout starts as an int value, and for this reason it
cannot overflow unsigned long long aka ULONGLONG. The unsigned version
of this initial value is available in orig_timeout. The difference
(orig_timeout - elapsed) cannot wrap around because it is protected by
a conditional (as can be seen in the patch text). Hence, the ULONGLONG
difference can only have values that are smaller than the initial
timeout value and truncation to int cannot overflow.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Acked-by: Steve Hoelzer <shoelzer@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/poll/poll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index ad5dcde439..4459408c7d 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -18,6 +18,9 @@
    You should have received a copy of the GNU General Public License along
    with this program; if not, see <http://www.gnu.org/licenses/>.  */
 
+/* To bump the minimum Windows version to Windows Vista */
+#include "git-compat-util.h"
+
 /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
 #if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
 # pragma GCC diagnostic ignored "-Wtype-limits"
@@ -449,7 +452,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   static HANDLE hEvent;
   WSANETWORKEVENTS ev;
   HANDLE h, handle_array[FD_SETSIZE + 2];
-  DWORD ret, wait_timeout, nhandles, start = 0, elapsed, orig_timeout = 0;
+  DWORD ret, wait_timeout, nhandles, orig_timeout = 0;
+  ULONGLONG start = 0;
   fd_set rfds, wfds, xfds;
   BOOL poll_again;
   MSG msg;
@@ -465,7 +469,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   if (timeout != INFTIM)
     {
       orig_timeout = timeout;
-      start = GetTickCount();
+      start = GetTickCount64();
     }
 
   if (!hEvent)
@@ -614,8 +618,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 
   if (!rc && orig_timeout && timeout != INFTIM)
     {
-      elapsed = GetTickCount() - start;
-      timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
+      ULONGLONG elapsed = GetTickCount64() - start;
+      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);
     }
 
   if (!rc && timeout)
-- 
2.19.1-816-gcd69ec8cde

