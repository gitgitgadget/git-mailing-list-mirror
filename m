From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/6] path.c: allocate enough memory for string
Date: Wed, 30 Mar 2016 09:41:38 -0700
Message-ID: <CAGZ79kb6dsaSxQ+HaYODBurnFz3MbsisSNkdrckFZLvSCvS-JQ@mail.gmail.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-2-git-send-email-sbeller@google.com>
	<CAPig+cSqC1muy+vcmpkp9uM9T3CC4pa5jWGUot_FtrVshEAUEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 18:41:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJBk-00011f-QW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 18:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbcC3Qlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 12:41:44 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35393 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbcC3Qlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 12:41:44 -0400
Received: by mail-io0-f173.google.com with SMTP id g185so81034063ioa.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=l9r7qQ7o8lEpz4xZmpf9N6t4UNnMZq3pFP5/7FRMv/8=;
        b=b6myTMX6583DC39HZXRjZjwPp7KytYhU3O6XR5pa3TZQshqNqPxfoy/sjhcgWPtsoF
         hc5awE1JMuSUzsS4PtkYlVocyMOCSI39n7JkWVRQ4ItVgx5RIsrmV11y34VdkwKYWwdj
         PTGEvmln1fnoSSZNfqEzp4WGAhoSVHl8UjvBOXVTiBFpmqgHUZC6Gk5VKeIhJRwD3Ymd
         ei+haykqlyXYoZu8Ywbr7RdRwP85/fuWykM4EACd2P0quP5utbFuu9kdfcxJrFNlx4yj
         JUc9sr23qUuDCzKMN7qWiKggZrgo0V50ruYyazVUEsegbAxy+0lcvFbLjqq3SQSaHhRD
         9Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=l9r7qQ7o8lEpz4xZmpf9N6t4UNnMZq3pFP5/7FRMv/8=;
        b=mOVCxBZNsyNfc7pCe+vpi+P9NPLxPiZ0snMxyqnJQLRtE6igaXTXsOoxstN3ayvNgM
         XAhFB/yAAmuA8TylNuhDPcqopj9gtigBG6FU95gjhVBYyVUHC5cA6BQkNyV9eIxnpE05
         QE9EBWdvyuUY98upCC1rLgiZEszbb9+LbOWMZGDORWY5H43l9iWZC8Ancbcs/Q9LTWsH
         LvC2I4RBNZ4yz5cxnMEdJBSeSdE/EILsKxrknLnZBskFIwF8NIUF3FD/Clntlzx+Hyj8
         v9jkqBcSsh81YOiWsI1dGxiWuJINq5Yeq2nlpAAs2RyNcJGEprPJl3FsDos3FgKmhbNl
         c8Bg==
X-Gm-Message-State: AD7BkJLJqFHKLf8Xvt+oZIjILMICshnHOYqhJzCwiLZDFfwI7sGvbmR3m/SzZZAflVtbNLOrD7PUMowCdWkPMIFc
X-Received: by 10.107.161.68 with SMTP id k65mr12387624ioe.110.1459356098765;
 Wed, 30 Mar 2016 09:41:38 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 09:41:38 -0700 (PDT)
In-Reply-To: <CAPig+cSqC1muy+vcmpkp9uM9T3CC4pa5jWGUot_FtrVshEAUEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290311>

On Tue, Mar 29, 2016 at 5:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 29, 2016 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> `strlen` returns the length of a string without the terminating null byte.
>> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
>> to the allocation function.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/path.c b/path.c
>> @@ -155,7 +155,7 @@ static struct trie *make_trie_node(const char *key, void *value)
>>         struct trie *new_node = xcalloc(1, sizeof(*new_node));
>>         new_node->len = strlen(key);
>>         if (new_node->len) {
>> -               new_node->contents = xmalloc(new_node->len);
>> +               new_node->contents = xmalloc(new_node->len + 1);
>>                 memcpy(new_node->contents, key, new_node->len);
>
> Huh? This is a trie. It never accesses 'contents' as a NUL-terminated
> string. Plus, no NUL is ever even copied, thus this is just
> overallocating. How is this an improvement?

By using strlen, I assumed it was a standard C string.
I missed that, though.

>
>>         }
>>         new_node->value = value;
>> --
