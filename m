From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/3] cache: modify for "cat-file --literally -t"
Date: Mon, 09 Mar 2015 18:26:56 +0530
Message-ID: <54FD9898.8040801@gmail.com>
References: <54F89D90.6090505@gmail.com>	<1425579499-18780-1-git-send-email-karthik.188@gmail.com> <CAPig+cT-AG2pnHJnkUcnHXzWu9jp2Q7ZBE7Re5jimFU7mOWLhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 13:57:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUxF4-0000Ln-2o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 13:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbbCIM5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 08:57:01 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:44195 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbCIM47 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 08:56:59 -0400
Received: by pdjz10 with SMTP id z10so43817164pdj.11
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9ZqT6+PtZG6TFB8dXs0X0OynM07dP+3UF7ZVgxe7NFw=;
        b=u6jwI00GlfUeWqA4K3fQAnC8QkfPgvJfCKi9IwYLDmXs63TJuS6tUTHpCeqYiGKAze
         2ReB4pZn+IlUdz05nLsXcJGiTmCmOHDKCrJLZpnoMRqmyIm9fdf0AdVDyOX18t2aGOh4
         6E5t3DxrxNG3objlWJ8wNUaWWKB63Vzkzurw0JHypOhGZQS6qbdN5SxeR1f0NN23BCyf
         DJ5DUCH1G+HE7QGP+8yUOtSmuOKR1Mcf6cK49M/FJDsoXyQPBH3BfFjSuk64wVN7DtPr
         dSZmH02olBE9AxpfRA+K2nBsiWJzkCD2owEN5AlK0Hi0IsaAjn05nMFly4LmflJooLqv
         7lYw==
X-Received: by 10.66.65.234 with SMTP id a10mr54998470pat.120.1425905819506;
        Mon, 09 Mar 2015 05:56:59 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id bt2sm19313700pad.12.2015.03.09.05.56.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 05:56:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cT-AG2pnHJnkUcnHXzWu9jp2Q7ZBE7Re5jimFU7mOWLhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265163>



On 03/09/2015 03:55 AM, Eric Sunshine wrote:
> On Thu, Mar 5, 2015 at 1:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> cache: modify for "cat-file --literally -t"
>
> It is desirable for the first line of the commit message to explain,
> as well as possible, the intent of the patch. The bulk of the commit
> message then elaborates. Unfortunately, this line says almost nothing.
> All patches modify, so writing "modify" here is not helpful and merely
> wastes precious horizontal real estate. A more informative summary
> might say something like:
>
>      cache: add object_info::typename in support of 'cat-file --literally'
>
>> Add a "struct strbuf *typename" to object_info to hold the
>> typename when the literally option is used. Add a flag to
>> notify functions when literally is used.
>
> It's good to split up changes such that each patch comprises one
> logical step, however, this patch does not really do anything on its
> own, so having it stand-alone doesn't make much sense. It would make
> more sense to fold it into the patch which actually requires these
> changes.
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/cache.h b/cache.h
>> index 4d02efc..949ef4c 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -830,6 +830,7 @@ extern int is_ntfs_dotgit(const char *name);
>>
>>   /* object replacement */
>>   #define LOOKUP_REPLACE_OBJECT 1
>> +#define LOOKUP_LITERALLY 2
>>   extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
>>   static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
>>   {
>> @@ -1296,6 +1297,7 @@ struct object_info {
>>          unsigned long *sizep;
>>          unsigned long *disk_sizep;
>>          unsigned char *delta_base_sha1;
>> +       struct strbuf *typename;
>>
>>          /* Response */
>>          enum {
>> --
>> 2.3.1.167.g7f4ba4b.dirty

Hey Eric!
Thanks for the feedback, I guess I need to stick to different patches 
only for logical changes, not considering different files.
Have been reading old commit messages to get a hang of it. Also found 
some blog posts explaining why we should use imperative sentences while 
writing Git commit messages. All makes sense now.

Regards
-Karthik
