From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/8] branch: refactor width computation
Date: Sun, 13 Sep 2015 17:53:48 +0530
Message-ID: <CAOLa=ZQoEsJ_pHZpsOWJaCVhku0Ai0Xkc=ON+LR+qGspDnszqQ@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-2-git-send-email-Karthik.188@gmail.com> <vpqio7ev8o6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb6KV-0000bh-0T
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 14:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbbIMMYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 08:24:19 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34274 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbbIMMYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 08:24:18 -0400
Received: by vkhf67 with SMTP id f67so45856875vkh.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZUdz9KftnYYpccs2xgvjae4Pwz1wLl+ATcU5c4rolg8=;
        b=lFg93DfKitigqluoIBgfD2tn0GZQehdFcyngopvVI0+pYwtEHcFMJ1uMA0Opq8KNea
         yBERfNXQRLX/yQ0TT+yuXyVOJsfjlSfrF3JJwNYU8orNhNqXivAyBG6TuuwEVRGekoGm
         8JkTyPgr/KnWWtIq57xqfo3REETc5RJ3Xyl2kxFcNM5BQYSq4oBMcjQFHEOxLSvMc6Ae
         fkm9C11ZqRJhFZ8UxTrcBrdpBHuApgCLrMUvfxFJf+HsNsBbXO7rmgNXEij6qTrnBrrF
         DvgPBK2tQt4zn0wQlJFjZkMAVMDTdp1QjHf4yrLSPeMNk9F/8s2HwyLN4S+IH0hSF0Z+
         sssg==
X-Received: by 10.31.149.143 with SMTP id x137mr8197591vkd.17.1442147057911;
 Sun, 13 Sep 2015 05:24:17 -0700 (PDT)
Received: by 10.103.23.66 with HTTP; Sun, 13 Sep 2015 05:23:48 -0700 (PDT)
In-Reply-To: <vpqio7ev8o6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277777>

On Sun, Sep 13, 2015 at 5:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -667,26 +675,22 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>                       clear_commit_marks(item->commit, ALL_REV_FLAGS);
>>               }
>>               clear_commit_marks(filter, ALL_REV_FLAGS);
>> -
>> -             if (verbose)
>> -                     ref_list.maxwidth = calc_maxwidth(&ref_list);
>>       }
>> +     if (verbose)
>> +             maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>
> I don't understand this hunk. To give a bit more context, the closing
> brace corresponds to:
>
>         if (merge_filter != NO_FILTER) {
>
> Hence this patch gets the two lines out of this "if". Actually, I don't
> understand how it could work previously. Wasn't this "calc_maxwidth"
> needed regardless of merge_filter from the beginning?

Previously, we used to compute and store each item's width in append_ref()
and change the ref_list.maxwidth only if we find a new maxwidth (all
within append_ref()).
Although the maxwidth variable is only needed when we use the verbose
option this is computed otherwise also (without the usage of calc_maxwidth()).
When using the merge option with verbose the maxwidth would need to be
recalculated. Hence we compute the maxwidth again using
calc_maxwidth() within the
if block.

Currently we only compute and store maxwidth if required, after
obtaining required refs.

>
> In any case, that remark is not an objection on your patch, but I'd like
> to understand.
>

Happy to explain.

-- 
Regards,
Karthik Nayak
