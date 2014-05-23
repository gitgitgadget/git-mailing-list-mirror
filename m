From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 23 May 2014 15:40:59 -0700
Message-ID: <CAKpPgvdR5vwSMk0w_uMH8oDKAgH+v1v5JnQOSbaiZt4aNxO0qA@mail.gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com> <xmqqha4gi5vg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wny9V-00040B-KO
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaEWWlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:41:21 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:43243 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaEWWlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:41:20 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so6106858obc.10
        for <git@vger.kernel.org>; Fri, 23 May 2014 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EK9qK+a+LDvUNWVfAuCy5H0iS6sapUjyEFvMkpTdR3I=;
        b=GTe7oDKhQvl2rCoYFrfNZYBjoB/IiXsxvGuFrTYpRcquJ0LNl+yumyDd+9O6I0lnIr
         jyOl/WhLbMlq8sHkPjqEp1tlLMhLV3bqAn2iLUbiAGq/gpemIPXM4dHHXAvNX4S0NOrg
         GhOWkS+ptLqWDENXZsA0VT7ygSWWxFpk6faX621lGf2wNWk3PKMDTl9JmIrpEahf/nQs
         kYnDOlFwv9WVBYk0xCIyJh+B6MJSOyZwkFfRmKmAxrQei+9zAqb3aK/eC8On/kDt6pI3
         L4gCZSBSc6bg83S453KGbui+wR4bE6PrKbuP0+Hn8/MGdB0YUF7figy+hlFt/hj/hBrB
         svww==
X-Received: by 10.182.104.101 with SMTP id gd5mr8283687obb.54.1400884879663;
 Fri, 23 May 2014 15:41:19 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Fri, 23 May 2014 15:40:59 -0700 (PDT)
In-Reply-To: <xmqqha4gi5vg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250043>

       Hi,

>
>>     /* "--git-dir" has been given */
>
> ... or it could have come from GIT_DIR environment, no?
    Yes, it does not matter where it came from, but I'll correct the comment

>
> Does this "additional exclude" need to kick in if GIT_DIR is set to
> "/home/pasha/w/.git"?  That is, when gitdir is ".git" or ends with
> "/.git"?
    I don't think it needs to kick in in either of these cases, as
".git" is already handled by "treat_path()". Now, here ".git" is
excluded by "if (strcmp()) {", while the first case needs to be
addressed too. Agree.

>> +#
>> +# Create a tree:
>> +#
>> +#    a  b  c  d  subdir/
>> +#
>> +# subdir:
>> +#    e  f  g  h  meta/  ssubdir/
>> +#
>> +# subdir/meta:
>> +#    aa
>> +#
>> +# subdir/ssubdir:
>> +#    meta/
>> +#
>> +# subdir/ssubdir/meta:
>> +#    aaa
>> +#
> It is not quite clear with this large blob of comment what are
> noises and what exactly are being tested.  I think you have two
> directories called "meta", but which one is the repository?  Or do
> you have yet another one next to {a,b,c,d,subdir} called "meta" that
> is not listed above?
>
> Given that the reason why people use --git-dir is so that they can
> put it completely outside the working tree (in which case, the usual
> "start from cwd and go upwards while trying to see if there is .git/
> that governs the working tree" logic would not work), readers would
> not expect to find the directory to be used as GIT_DIR in the
> hierarchy you are creating in the first place.  Because of that, it
> is even more important to clearify which "meta" you mean to use as
> your GIT_DIR if you want to be understood by readers.

I guess I was too simplistic, need to clarify a bit. And indeed,
perhaps two distinct subtrees are needed to test the repository that
is outside the work-tree, that would just do a slightly cleaner job

Pasha
