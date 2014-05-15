From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 05/42] update-ref.c: log transaction error from the update_ref
Date: Thu, 15 May 2014 08:47:59 -0700
Message-ID: <CAL=YDWmsD6ajY0f+yfqW+8Tp7NOE6HvYFGgrUGRFswwXBvP6-w@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-6-git-send-email-sahlberg@google.com>
	<20140514220831.GB9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 17:48:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkxt9-0005vV-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 17:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbaEOPsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 11:48:01 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:43864 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbaEOPsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 11:48:00 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so4574152vcb.21
        for <git@vger.kernel.org>; Thu, 15 May 2014 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uBaenc0dGPXJFJe6xXZRO+GeqDqs+ZvvK6YDtnTcVEg=;
        b=VT5BdMkUGKyGiIqkRLskZL8/NZoIzT07mfnLR1PUshokZ27XSKS/7zsvR0Abq8hj76
         j7gp+po5h2ZCpyGCTvrLrYoDFQaJv/WpUf8ifbDwYQkjn9wDGn21lC4IcQSBSY7SxHcK
         pLGkl/RBb5r/C+FLSv+g8GLNd3sawBWyCIZVq6YStpKXFEIMAMn6LWK9P6mKOuknm8s7
         L4oV+jrAjwbQpp8CeuaC7r3SZdCw5+uQ+hJ7J01aTQtdFtgRixBTjMLxiaV2F2+xDAqp
         vGivhdbBgHvW8uY6AMqQdz+Ro9/ZxGLz5hl6JnneldIbX6D0ImUeUcG8CdHCbFFK3Qkj
         sIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uBaenc0dGPXJFJe6xXZRO+GeqDqs+ZvvK6YDtnTcVEg=;
        b=l4gnPQ8xpplF5VZV/kTrKb2Rp7QWPDmDBPfIt6upRS1kQ3s0SxPUbQMMumdiftGesU
         ysw7Bg7CQVWQ4bo5KVKmsUSXnsB0eaqtxFNluRgsNVPzakum1FDiKp+OD1vtyN5z2yF4
         rRuYoI5viFxM+lmftuMhwPQl1OV4d1qO+98JlmmdS0WgiOyM72CvujivFBFPsVk8akP/
         gJqoXkv80CTblQPvOg6uLrFHpycCFLOciSbfH3i3Wkbl5dYF92sd7QQE1+k1Bo+q2Zia
         mnbzeSmKDcI8BGQHDf8xZuqj0C6v9GuucnBZSFSggGC2dYZx1EE3lX85cuCJbrUj4flA
         QIYA==
X-Gm-Message-State: ALoCoQnq0/FJUfz5O2gZA2Y+qHUx1o5++hKU2YNht90ZV/hG7ZbUf/ecq7I5RiCZe5MhX0Fc5OJu
X-Received: by 10.58.66.195 with SMTP id h3mr874090vet.57.1400168879664; Thu,
 15 May 2014 08:47:59 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 08:47:59 -0700 (PDT)
In-Reply-To: <20140514220831.GB9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249102>

On Wed, May 14, 2014 at 3:08 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
> [...]
>> @@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
> [...]
>>               if (delete || no_deref || argc > 0)
>>                       usage_with_options(git_update_ref_usage, options);
>>               if (end_null)
>>                       line_termination = '\0';
>>               update_refs_stdin();
>> -             ret = ref_transaction_commit(transaction, msg, NULL,
>> -                                          UPDATE_REFS_DIE_ON_ERR);
>> -             return ret;
>> +             if (ref_transaction_commit(transaction, msg, &err,
>> +                                        UPDATE_REFS_QUIET_ON_ERR))
>> +                     die("%s", err.buf);
>
> Nice.  I like this much more than passing a flag to each function to
> tell it how to handle errors. :)
>
> ref_transaction_commit didn't have any stray codepaths that return
> some other exit code instead of die()-ing with UPDATE_REFS_DIE_ON_ERR,
> so this should be safe as far as the exit code is concerned.
>
> The only danger would be that some codepath leaves 'err' alone and
> forgets to write a messages, so we die with
>
>         "fatal: "
>
> Alas, it looks like this patch can do that.
>
>  i. The call to update_ref_write can error out without updating the
>     error string.

Fixed.
I reordered the patches so the change to update_ref_write to take an
err argument will come before the change to update-ref.c as you
suggested.

>
>  ii. delete_ref_loose can print a message and then fail without updating
>      the error string so the output looks like
>
>         warning: unable to unlink .git/refs/heads/master.lock: Permission denied
>         fatal:
>         $
>

Fixed.
I have added a new patch before the change to update-ref.c to add err
to delete_ref_loose.

>  iii. repack_without_refs can similarly return an error
>
>         error: Unable to create '/home/jrn/test/.git/packed-refs.lock: Permission denied
>         error: cannot delete 'refs/heads/master' from packed refs
>         fatal:
>         $
>
>  iv. commit_lock_file in commit_packed_refs is silent on error.
>      repack_without_refs probably intends to write a message in that
>      case but doesn't :(

Fixed.
I added a patch to take an err argument to repack_without_refs and
update it for both
conditions iii and iv.



>
> I wish there were some way to automatically detect missed spots or
> make them stand out (like with the current "return error()" idiom a
> bare "return -1" stands out).
>
> (i) is fixed by a later patch.  It would be better to put that before
> this one for bisectability.
>
> I don't see fixes to (ii), (iii), and (iv) in the series yet from a
> quick glance.

Fixed in the next version of the patch series I will send out.
Thanks.
