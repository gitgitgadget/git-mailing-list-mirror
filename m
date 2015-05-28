From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for
 better organisation
Date: Fri, 29 May 2015 02:07:19 +0530
Message-ID: <55677C7F.6080400@gmail.com>
References: <5567527A.6090607@gmail.com>	<1432835025-13291-2-git-send-email-karthik.188@gmail.com> <vpqegm0o3dx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 22:37:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4Yd-0001nO-9r
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbbE1Uh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 16:37:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36597 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbbE1UhY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:37:24 -0400
Received: by pdfh10 with SMTP id h10so49568425pdf.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=O/ZS82NxbyfWt1kTNLFQ08lSTsD1WdY2bEfuyphobk0=;
        b=qWr4Cf0t41f1TRtmrX+xRwF3Sm3pENvS8SRAGEMNMJwGWex4Sl/vGe+lqHnjcxtjTA
         MQBG/pcYi4xsrVS7IZpWH9f8umxbL/d8+ip5JRV4dbTwuAidz5TZLYDeCl4EZAqeqxwN
         qQpB21nL4oPmPXPuVORzus0txTysibp4GbC78V73Dm+dG3erAJZEdH1IwzH+NQUyqM18
         Li4teXXRYtPx6tHk/Z6QJKcxy0SDH7t9vgpA8aGkdq4OPJ2dzodu2+Kc9S78D4bR/LlM
         ksj4edP1BBsA32+zxDzoYUC2+dqz4ABcnLOiznqEU6oTYp5N+9elwdg0ucQkBjC1+k8j
         Q9BQ==
X-Received: by 10.68.242.41 with SMTP id wn9mr8668780pbc.117.1432845443700;
        Thu, 28 May 2015 13:37:23 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id u8sm3284995pdj.46.2015.05.28.13.37.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 13:37:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqegm0o3dx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270193>

On 05/29/2015 01:56 AM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Rename 'refinfo' to 'ref_array_item' and intoduce 'ref_filter_cbdata'
>
> The fact that you need to use "and" to describe your changes is a hint
> that you can split better.
>

But the patch alone wouldn't make much sense here, as the whole idea is 
the introduction of the new structures and renaming 'refinfo' to 
'ref_array_item' was more of a byproduct to go along with the new 
structures introduced.

 >
> The patch looks much better, but I think you still need to split more to
> make it easier to review.
>
>> - * of properties that we need to extract out of objects.  refinfo
>> + * of properties that we need to extract out of objects. ref_array_item
>
> Not very important, but two spaces after a period is what one is
> supposed to do in English. Not everybody follow the rule, but it seems
> backward to change the code to break it.
>

I'm just so used to single spacing, Will change it.

>>   	if (flag & REF_BAD_NAME) {
>> -		  warning("ignoring ref with broken name %s", refname);
>> -		  return 0;
>> +		warning("ignoring ref with broken name %s", refname);
>> +		return 0;
>
> Whitespace fix mixed with actual code.
>

Noted.


>> -static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
>> +/* Free all memory allocated for ref_filter_cbdata */
>> +void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ref_cbdata->array.nr; i++)
>> +		free(ref_cbdata->array.items[i]);
>> +	free(ref_cbdata->array.items);
>> +	ref_cbdata->array.items = NULL;
>> +	ref_cbdata->array.nr = ref_cbdata->array.alloc = 0;
>> +}
>
> And this one is a real behavior change, which would be much better
> documented in its own patch with a proper commit message (we had a
> memory leak before, we didn't care because it happened right before
> exiting, but we can't accept that in a clean library).
>

Ok will put that into a separate commit.


> Reviewing is not just about having a look and seeing if there's
> something stupid. Reviewers are actually taking a lot of time to see if
> the patch does not introduce new bugs, or looking for better ways to do
> the same thing. Be nice with them!
>

Thanks for the effort from your side, will try to split things as much 
as possible and make it easier for Reviewers.

-- 
Regards,
Karthik
