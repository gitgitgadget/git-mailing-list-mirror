From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Fri, 11 Apr 2014 09:57:18 +0700
Message-ID: <CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com> <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 04:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYRf8-00018f-1X
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 04:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbaDKC5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 22:57:50 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:41986 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbaDKC5s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 22:57:48 -0400
Received: by mail-qc0-f181.google.com with SMTP id x3so5249939qcv.26
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+w1nLVxIYHGiaE6+aqfdbjyVIcBlYBZXOqInAdvKAkE=;
        b=hUK/mm3RnsQz7HeZ0lgq5sQAHweVOkcawWvgf8WcxXe2lbsA8/41C9yOLyOZzRPhol
         e/Z8uG/LSV22CPeN7kljVE2N4ydayNry0/hOfpHcryWNq2aznsx6bANRv6GhLQuNCygj
         +/vmLd0RJHVUSy1DuXDhCbY6cCXrrk5sJ18HE4M4xAKj+2vObmqXnyijcshPj8XTYBj6
         QKzK9qZkn5wV5YC/CKSjc7uKx3xMzBXKfJHy2ArMxKEPdS4qLux/7wpW+7xzKeI1l5aq
         FMyHXXVYSXCAZOwF/Q+dkd7Zk1iBNrRjy/9vLL7h55foulj0ogwpHRstoCaeUgHfAGcn
         b6Tg==
X-Received: by 10.140.85.116 with SMTP id m107mr23579921qgd.78.1397185068278;
 Thu, 10 Apr 2014 19:57:48 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Thu, 10 Apr 2014 19:57:18 -0700 (PDT)
In-Reply-To: <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246065>

On Fri, Apr 11, 2014 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Yiannis Marangos <yiannis.marangos@gmail.com> writes:
>
>> +     n = xpread(fd, sha1, 20, st.st_size - 20);
>> +     if (n != 20)
>> +             goto out;
>
> I think it is possible for pread(2) to give you a short-read.
>
> The existing callers of emulated mmap and index-pack are prepared to
> handle a short-read correctly, but I do not think this code does.
>
> I'll queue this instead in the meantime.

There are two things to sort out (sorry I can't spend much time on it
right now): should the same sha1 test be done in write_index(), in
addition to update_index_if_able(). And what do we do about
istate->sha1[] in discard_index(), keep it or clear it.
-- 
Duy
