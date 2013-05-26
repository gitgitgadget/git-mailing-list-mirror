From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Sun, 26 May 2013 22:14:05 +0200
Message-ID: <51A26D0D.2030702@googlemail.com>
References: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com> <51A26BB7.3060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 22:14:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UghKK-0005ia-Qz
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab3EZUN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:13:56 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:65384 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab3EZUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:13:55 -0400
Received: by mail-ea0-f178.google.com with SMTP id q16so3663133ead.9
        for <git@vger.kernel.org>; Sun, 26 May 2013 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=E4At11EuSKimEMTrA7L+oy+cteoMSASu+WgykrXDeOc=;
        b=m+clkPz67JPr5gp9Jvpepi4DIyynIhhg1W2VyEYqjvpyTOq66RU48BjgF+e3eNI8hZ
         K/eK2fIT4k8PtXE3z1zE99BeknTlPqvQIQVzhDYwOcJUllbymmKmU1c5f2nlZnukMPQs
         UzGeDC+glc3jK94pYurKyA+0pCFdIE7YOnsuECbfadk0elxFljehd2ldm10FzUIRV9pH
         6Ab3wBJHYkp0LOFxirgcoSThEl20HDq2jgev3jo3tI7JEV42ZJPkld6zuewO6h0YZ8XW
         OfHz71/Tbx9tfRTkuokMqldz5TbPbX8zYK2YKPrv4hpGJSZ7N9L6yKQq1HxVqyE6dSTN
         uRwA==
X-Received: by 10.14.177.5 with SMTP id c5mr7298064eem.62.1369599234299;
        Sun, 26 May 2013 13:13:54 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-90-70-123.unitymediagroup.de. [109.90.70.123])
        by mx.google.com with ESMTPSA id bp51sm37339904eeb.5.2013.05.26.13.13.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 26 May 2013 13:13:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51A26BB7.3060702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225568>

It's not done very often.
For example at the very same place of the patch there is
const char *p; not assigned.

Well you could argue, that it can be detected by gcc as that variable p
is assigned next line.
So another counterexample, having the same pattern would be
fast-import.c line 2992 in parse_treeish_dataref(const char **p)
there we have a pointer to a struct, which is only assigned inside
the following if/else branches.
Then that place would need to be fixed up to
struct object_entry *e = e;

Regards,
Stefan

On 05/26/2013 10:08 PM, Stefano Lattarini wrote:
> On 05/26/2013 10:05 PM, Stefan Beller wrote:
>> Reported by cppcheck.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>  fast-import.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fast-import.c b/fast-import.c
>> index 5f539d7..0142e3a 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -2914,7 +2914,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
>>  static void parse_cat_blob(void)
>>  {
>>  	const char *p;
>> -	struct object_entry *oe = oe;
>>
> This was done on purpose, to avoid spurious warnings with (at least)
> some versions of GCC.
> 
>> +	struct object_entry *oe;
>>  	unsigned char sha1[20];
>>  
>>  	/* cat-blob SP <object> LF */
> 
> Regards,
>   Stefano
> 
