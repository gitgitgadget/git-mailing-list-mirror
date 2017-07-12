Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE33202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdGLRNN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:13:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34888 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753923AbdGLRNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:13:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so3720976pgc.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0V7x/rzT6CRUhACQNrpD0QQ8A9Szd281YbbO08vJbUQ=;
        b=X0ehfnLUE7/zY1GUz/khfx5P5P2B9/FslXz7EwrEINWu89rfzYyMs5zYaSbigXkLqp
         eqz/1dyRu2erc3cXoObffnK0J2cvGlcOmjnGXix96FRybkGHtGp6y2Sikure5BPLuHgW
         rCyfzwYlMjC/fpy6qMhrUDxI03EyF9slT/2BqHmTzBiegWwzARtcWakqPivi2CFqo3+8
         osuYmlQcBcNzgVYyoykFIxisufztcKH2ysRdxLbqiMQHINQ1qJZOZAXxxiLzww87zYvd
         pyq+GiPMsYWSgUVOOmvOE/7mSFG2YbdeXwSkHgTXVeA38mT+2/qBoM0cGvAq5B6iBrYI
         rQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0V7x/rzT6CRUhACQNrpD0QQ8A9Szd281YbbO08vJbUQ=;
        b=P62RMnLS/t/jiFczQqt8ExFzslDejKmWosT2s3med2JPquiuVl8Hvut3Pcvna7gRj5
         uRvSXZjslWSHidTZe7u/AB+W1gfzvPKLHxplLyHhyJDx6VPxEJZnDcjRNcXRIE8viMKq
         coDL4AKHIDKm1Ijtu7oq9Wrr099oozFNJ565L5lupy8TwJPVYerPnpoNhFGADQNDqEI+
         vvLDcLIB/TCEsDCVIOSpxhyAQ7ciqMssXaMS6+xX9+PnCE4W9Ii/arQ8HZEq5FhV83lN
         k1kKY9ANnfY9M9/7jQcAvJIx0R9761mJtymKQBwQBduUlcPx6JW6Hn8ZhgZ9mqDGnVDA
         v8YQ==
X-Gm-Message-State: AIVw110v1ojiiDvcH4JSHSvcsSbBJtiysbZuqPyyFFhCKYC5pwQBZJbN
        VUtAixi9aG9Fsg==
X-Received: by 10.84.128.76 with SMTP id 70mr5322103pla.229.1499879591796;
        Wed, 12 Jul 2017 10:13:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id j27sm5841623pgn.63.2017.07.12.10.13.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 10:13:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
References: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
        <20170711225316.10608-1-miguel.torroja@gmail.com>
        <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
        <CAKYtbVb8T=edPG5539=uwDjHnCerLO2Oejy8bWK+giSS8nNGig@mail.gmail.com>
Date:   Wed, 12 Jul 2017 10:13:09 -0700
In-Reply-To: <CAKYtbVb8T=edPG5539=uwDjHnCerLO2Oejy8bWK+giSS8nNGig@mail.gmail.com>
        (Miguel Torroja's message of "Wed, 12 Jul 2017 12:16:44 +0200")
Message-ID: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miguel Torroja <miguel.torroja@gmail.com> writes:

> The motivation for setting skip_info default to True is because any
> extra message  output by a p4 trigger to stdout, seems to be reported
> as {'code':'info'} when the p4 command output is marshalled.
>
> I though it was the less intrusive way to filter out the verbose
> server trigger scripts, as some commands are waiting for a specific
> order and size of the list returned e.g:
>
>  def p4_last_change():
>      results = p4CmdList(["changes", "-m", "1"])
>      return int(results[0]['change'])
>  .
>  def p4_describe(change):
>     ds = p4CmdList(["describe", "-s", str(change)])
>     if len(ds) != 1:
>         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
>
> Previous examples would be broken if we allow extra "info" marshalled
> messages to be exposed.
>
> In the case of the command that was broken with the new default
> behaviour , when calling modfyChangelistUser, it is waiting for any
> message with 'data' that is not an error to consider command was
> succesful

I somehow feel that this logic is totally backwards.  The current
callers of p4CmdList() before your patch did not special case an
entry that was marked as 'info' in its 'code' field.  Your new
caller, which switched from using p4_read_pipe_lines() to p4CmdList()
is one caller that you *know* wants to special case such an entry
and wanted to skip.

Your original patch that was queued to 'pu' for a while and then
ejected from it after Travis saw an issue *assumed* that all other
callers to p4CmdList() also want to special case such an entry, and
that is why it made skip_info parameter default to True.

The difference between knowing and assuming is the cause of the bug
your original patch introduced into modifyChangelistUser().  

The way I read Luke's suggestion was that you can avoid making the
same mistake by not changing the behaviour for existing callers you
didn't look at.

Instead of assuming everybody else do not want an entry with 'code'
set to 'info', assume all the callers before your patch is doing
fine, and when you *know* some of them are better off ignoring such
an entry, explicitly tell them to do so, by:

 * The first patch adds skip_info parameter that defaults to False
   to p4CmdList() and do the special casing when it is set to True.

 * The second patch updates p4ChangesForPaths() to use the updated
   p4CmdList() and pass skip_info=True.  It is OK to squash this
   step into the first patch.

 * The third and later patches, if you need them, each examines an
   existing caller of p4CmdList(), and add a new test to demonstrate
   the existing breakage that comes from not ignoring an entry whose
   'code' is 'info'.  That test would serve as a good documentation
   to explain why it is better for the caller to pass skip_info=True,
   so the same patch would also update the code to do so.

While I was thinking the above through, here are a few cosmetic
things that I noticed.  There is another comma that is not followed
by a space in existing code that might want to be corrected in a
clean-up patch but that is totally outside of the scope of this
series.

Thanks.

 git-p4.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1facf32db7..0d75753bce 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1501,7 +1501,7 @@ class P4Submit(Command, P4UserMap):
         c['User'] = newUser
         input = marshal.dumps(c)
 
-        result = p4CmdList("change -f -i", stdin=input,skip_info=False)
+        result = p4CmdList("change -f -i", stdin=input, skip_info=False)
         for r in result:
             if r.has_key('code'):
                 if r['code'] == 'error':
@@ -1575,7 +1575,7 @@ class P4Submit(Command, P4UserMap):
                 files_list.append(value)
                 continue
         # Output in the order expected by prepareLogMessage
-        for key in ['Change','Client','User','Status','Description','Jobs']:
+        for key in ['Change', 'Client', 'User', 'Status', 'Description', 'Jobs']:
             if not change_entry.has_key(key):
                 continue
             template += '\n'
