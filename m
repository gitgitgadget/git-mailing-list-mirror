From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Tue, 4 Mar 2014 17:43:15 -0500
Message-ID: <CAPig+cRna0FX66535HX2Yz6t4eZ_zcJDa5HWBJ2nphKA+Aqi8g@mail.gmail.com>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cR=9oonOdyOm3y2NpdLxh-sq5qQtSxmmN2dH7+UzRy-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKy3V-0002P4-K0
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbaCDWnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:43:17 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:60594 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbaCDWnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:43:16 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so223107yha.28
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jaizXlEHanIkRQjU9TJUUVaAmWdflG7YIgCAN422fdU=;
        b=vGBeeQNuxYiEUmg7/fw8WmuixqA6QC+wX4ClynS542nahHDhzdGUkb1L+Eg0pSIwyB
         U2/FLlS82H4q0A5PDe66EdbM7EA2FGC3PRoPsNPx9cBad0rQtw4WL2xidzmPxKYcbAwe
         y6XHQx6W05wdbsB032HCuTXmQCFa0Ny/WVMwX6W261qpOEaTzvJCvMdSUk5UXFf8s38g
         70RWpagAeMZNNA2SiEmpIAbwqJmr+fEuEarAFgKAl8om/KzSCuKhomh5HaTZaw/2lIIg
         YcTsE6H8ITcM6xHtMxFki+YaSRq1gm1OdrmhZqWo3nwaguIZRweqkfNx7Uq9HbcrGEFe
         4AVA==
X-Received: by 10.236.46.18 with SMTP id q18mr2379624yhb.21.1393972995505;
 Tue, 04 Mar 2014 14:43:15 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 14:43:15 -0800 (PST)
In-Reply-To: <CAPig+cR=9oonOdyOm3y2NpdLxh-sq5qQtSxmmN2dH7+UzRy-gA@mail.gmail.com>
X-Google-Sender-Auth: 0DsXMDvVtlGyYFsYKGLSiwJRD4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243402>

On Tue, Mar 4, 2014 at 5:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 4, 2014 at 10:54 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> diff --git a/commit.c b/commit.c
>> index 6bf4fe0..71a03e3 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1193,10 +1196,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>>         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>>                 const char *found, *next;
>>
>> -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
>> -                       /* At the very beginning of the buffer */
>> -                       found = buf + strlen(sigcheck_gpg_status[i].check + 1);
>> -               } else {
>> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check +1);
>
> Add a space after the plus sign.
>
>> +               if(!found) {
>>                         found = strstr(buf, sigcheck_gpg_status[i].check);
>
> 'found' is being computed again here, even though you already computed
> it just above via skip_prefix(). This seems pretty wasteful.

Ignore this objection. I must have misread the code as I was composing
the email.
