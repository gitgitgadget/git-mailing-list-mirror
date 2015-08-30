From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sun, 30 Aug 2015 20:27:34 +0530
Message-ID: <CAOLa=ZRZ6RcRm6ERR=NVzng17qJx+1N8iGThuo=xQhEszJQ90w@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 16:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW43f-0005lH-Tw
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 16:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbbH3O6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 10:58:06 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34806 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbbH3O6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 10:58:05 -0400
Received: by obbfr1 with SMTP id fr1so76622810obb.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bq52g3tBITfwTaTVD0GUJ9EvKKstrxWZYlWEKbpZhaU=;
        b=e/5SxL0eMBXXJGQXMg5NfTH85OOe9WVcAePyRkDlqvEQWhcg5n6DvZzlyLhX/YJ0Ih
         fYX6uGa5EisJXK4qR6/MXy/RPO6lEmN2Vw/IxPoGgiLQ9HbpeOoqL42FdgccWMJztGBX
         wFR5c/JcrpSpCMgD/LiCN1MT29IPHlBVDLWKsAI2MuzcmvRoetnvTt1QYsJX/bywjbW0
         Ud78sP8PmyXfl8kJtvh1RPy/GU4utfMW8u10rYUQCg6FI/TRUGHpgxB8oIlCsKr0wHUC
         v2m1Xkhjx6NEG8+53QIWxU97Oax3X7cikRHOkce2HnLm+oY3+mS1/nKjSWjXEKo21XoU
         4YoA==
X-Received: by 10.182.171.35 with SMTP id ar3mr10694162obc.57.1440946683937;
 Sun, 30 Aug 2015 07:58:03 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 30 Aug 2015 07:57:34 -0700 (PDT)
In-Reply-To: <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276821>

On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 432cea0..21c8b5f 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -53,6 +54,13 @@ static struct {
>>         { "flag" },
>>         { "HEAD" },
>>         { "color" },
>> +       { "align" },
>> +       { "end" },
>> +};
>> +
>> +struct align {
>> +       align_type position;
>> +       unsigned int width;
>>  };
>>
>>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
>> @@ -69,6 +79,8 @@ struct ref_formatting_state {
>>
>>  struct atom_value {
>>         const char *s;
>> +       struct align *align;
>
> Why does 'align' need to be heap-allocated rather than just being a
> direct member of 'atom_value'? Does 'align' need to exist beyond the
> lifetime of its 'atom_value'? If not, making it a direct member might
> simplify resource management (no need to free it).
>

But it does, since we carry over the contents of align from atom_value to
cb_data of ref_formatting_stack and that holds the value until we read
the %(end)
atom hence it seemed like a better choice to allocate it on the heap

-- 
Regards,
Karthik Nayak
