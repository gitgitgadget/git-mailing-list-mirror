From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/3] gitweb: Add support to Link: tag
Date: Wed, 4 Jul 2012 10:54:36 +0900
Message-ID: <CAM9d7chjjRUyM=AunVV3=XT+v86diHGboi4KO_XWCK3_i_yqLw@mail.gmail.com>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-4-git-send-email-namhyung@kernel.org> <7vy5n0txdi.fsf@alter.siamese.dyndns.org>
 <CAM9d7ciU8j6Kt+9akyPpPiUdCJSFyL1xBbG2_c2epa79FgMmiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmEoB-0001WL-T1
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 03:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab2GDBzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 21:55:05 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36363 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2GDBy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 21:54:57 -0400
Received: by qcro28 with SMTP id o28so4049140qcr.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 18:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=FtTGcNOOGflcieMXn2a9xkILYZjsRBsNob/VUbOCUSU=;
        b=eitU1jN+fIU4W4ahCf4/3bxJur7zVRIvI/YTdQZSAGZbV1FKVxtFdjUNXFZrxuvNZI
         7aagX6ydJqHGC43ce3gNNIiyDjT0fAdBV8BCB4HFyHGM/fitK51bHh4tdgSyu6od68t9
         HXk57HwZfo1/FC95tgHo0jGlvNZRq8dGsXHY+AV48i6VMeA1zE4tIMMc332qGYnVD9HF
         FUr9+/fJUuDpeXnR/Y3Uvu4FnZ/USOETGWAbBDou5c6W3cpnYj9ZuOszDs55jU+d3ZHq
         4zOBL8wS6T/eLPd/GYpPZqgjgzR0upsrFYKnSQ0j0ssPZdJ8zuuyIrXTDfI8U9aARjrr
         3joQ==
Received: by 10.224.59.212 with SMTP id m20mr24901355qah.35.1341366897077;
 Tue, 03 Jul 2012 18:54:57 -0700 (PDT)
Received: by 10.229.176.217 with HTTP; Tue, 3 Jul 2012 18:54:36 -0700 (PDT)
In-Reply-To: <CAM9d7ciU8j6Kt+9akyPpPiUdCJSFyL1xBbG2_c2epa79FgMmiw@mail.gmail.com>
X-Google-Sender-Auth: BZ1R2rQxlcvXFho9LiiYLc_iQik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200979>

On Wed, Jul 4, 2012 at 10:24 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> Hi,
>
> On Wed, Jul 4, 2012 at 5:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Namhyung Kim <namhyung@kernel.org> writes:
>>
>>> The tip tree is the one of major subsystem tree in the
>>> Linux kernel project. On the tip tree, the Link: tag is
>>> used for tracking the original discussion or context.
>>> Since it's ususally in the s-o-b area, it'd be better
>>> using same style with others.
>>>
>>> Also as it tends to contain a message-id sent from git
>>> send-email, a part of the line which has more than 8
>>> (hex-)digit characters would set a wrong hyperlink
>>> like [1]. Fix it by not using format_log_line_html().
>>>
>>> [1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  gitweb/gitweb.perl |    7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index e0701af..d07bcb7 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -4493,6 +4493,13 @@ sub git_print_log {
>>>                               print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
>>>                       }
>>>                       next;
>>> +             } elsif ($line =~ m,^ *link[ :](http://[\w/~.@%&=?+-]*),i) {
>>
>> Hrm, I am somewhat confused.  This catches "link:http://..." and
>> "link http://...", but not "link: http://...", which looks a lot
>> more natural looking at least to me.
>>
>
> Oops, right. Actually I found it after some local testing,
> but forgot to update the patch. Sorry :)
>
>
>> Looking at a random sample:
>>
>> http://git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=fe85227347738eb9b871bc163e7fb0db8b6cd2a0
>>
>> I see a "Buglink: " which I think deserves to be handled by this patch
>> but would not.  Probably the pattern needs to be loosened
>> sufficiently, e.g.
>>
>>         m,^\s*[a-z]*link: (https?://\S+),i
>>
>> to catch it as well.  Note that I am rejecting space before ":" and
>> requiring a space after ":" in the above.
>>
>
> I think 'l' in 'link' should be '[Ll]'. Otherwise looks good to me.
>

Oops (again), I missed 'i' at the end.

Thanks,
Namhyung
