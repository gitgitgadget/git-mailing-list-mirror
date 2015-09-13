From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Sun, 13 Sep 2015 02:27:43 -0400
Message-ID: <CAPig+cQr1WgvPY2QveN-5PeWWZhXXJjEDA27EzDmia2VKbyevw@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 08:28:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb0lm-000223-SQ
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 08:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbbIMG1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 02:27:45 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34553 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbIMG1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 02:27:44 -0400
Received: by ykdg206 with SMTP id g206so127078470ykd.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+CVpnfq/e8WMzQzC6bPnkdwEuHKD+lyR7cbv9fjxibo=;
        b=YmOSPanZlTcioXoaQ+tSAsz9HKx7CGi5JYa0oonwhbPtp2EAFJivSaMm04Xzqx5q0Z
         Z6Ms0kvoDDEFIaN/Ohso+VVDFwU/NjVKmUs3GLgGLxpGKPrWUkSzQmJKO4fp3tcWOMes
         2vq8wRlRB6hCArjADLK73BG+bKK/P0VcojCrnTvMU0y70FHo5uo2gEkARl29jjrAoQL8
         5qBB6jbFlKWEQrvZ6sqwtekLoOCBQ1v/dGYVx3x1rcaWtouyCahRDTGrzcPoogMYnMkE
         JlRMEQOIFjlVp+ua3YyUsldgQamdCJx/c3g6v0YlDAEUf9ZG8DEA0ngbHmqUgfZvW57x
         VbXw==
X-Received: by 10.170.74.85 with SMTP id q82mr7463410ykq.94.1442125663575;
 Sat, 12 Sep 2015 23:27:43 -0700 (PDT)
Received: by 10.37.217.200 with HTTP; Sat, 12 Sep 2015 23:27:43 -0700 (PDT)
In-Reply-To: <CAPig+cQRx-uKZnnx2O0pG34HkcEdg1GbGNFd9PHdw+m0O3aJEA@mail.gmail.com>
X-Google-Sender-Auth: xvBnNdTYiJn3Wp__DYs2EkgcYpU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277759>

On Sat, Sep 12, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Sep 4, 2015 at 5:39 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> +               }
>> +       } else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
>> +               if (starts_with(ref->buf, "ref:")) {
>> +                       strbuf_remove(ref, 0, strlen("ref:"));
>> +                       strbuf_trim(ref);
>> +               } else if (is_detached) {
>> +                       *is_detached = 1;
>
> I find the placement of the detached detection logic here a bit
> strange. The only case for which it might trigger is the so-called
> "main worktree", yet having it in this general purpose parse function
> seems to imply misleadingly that any worktree could be detached. Also,
> given the current world order[1], wouldn't missing "ref:" indicate an
> error for any worktree other than the main one? Consequently, this
> detection probably ought to be done only for the main worktree
> (outside of this function, probably).

Eh, ignore this bit. My brain was conflating 'bare' and 'detached'.
