From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Wed, 5 Mar 2014 02:48:04 -0500
Message-ID: <CAPig+cSQtQ_uvjdA2s3+K8YQLDuMXqqc-jG2AuSM7K52q3_pPQ@mail.gmail.com>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cR=9oonOdyOm3y2NpdLxh-sq5qQtSxmmN2dH7+UzRy-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL6Yl-00085E-RG
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 08:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbaCEHsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 02:48:06 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:54464 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaCEHsF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 02:48:05 -0500
Received: by mail-yk0-f174.google.com with SMTP id 20so1808371yks.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=r2I+hjEZJchiLRHqvhpYOxU+vqXnjCOVDw8lzi3KZho=;
        b=dTriy1WnOI0UHoxeS4xOl/IJyJOIJPwNI8bIJcnfeztZMK2stZRn0YJpyn69ypuG3N
         K31f/Mhnka9PjAlCDBf7gctCsQWUzhwPKAXcQh0+KXroRhivIvqPSej6X1jCIRUQEcfS
         yTG1s6QjJmvcWfGe6hQmkAwnV19ZpkIivVnVd5Tmg6LtdUultm+1OQW6LxVpq74yDX4e
         0mPqLd6aa16pnv0BhoO1gjfM6P2giydTXi9Sikdb85aWRNPHvkmKU6qk9UAq+KlwXL8v
         b31qIElr9evBnG5H+blhDKgy/dsxhoIhK472bzhYjBzKHfulhF8dzHIS+uIehBWa4t4n
         qpTA==
X-Received: by 10.236.66.143 with SMTP id h15mr5026697yhd.36.1394005684161;
 Tue, 04 Mar 2014 23:48:04 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 23:48:04 -0800 (PST)
In-Reply-To: <CAPig+cR=9oonOdyOm3y2NpdLxh-sq5qQtSxmmN2dH7+UzRy-gA@mail.gmail.com>
X-Google-Sender-Auth: mb979b6MRy_GKfdc04fijHdskCI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243423>

On Tue, Mar 4, 2014 at 5:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 4, 2014 at 10:54 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> diff --git a/commit.c b/commit.c
>> index 6bf4fe0..71a03e3 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
>>                 char *next = memchr(line, '\n', tail - line);
>>
>>                 next = next ? next + 1 : tail;
>> +               indent_line = skip_prefix(line, gpg_sig_header);
>
> Even stranger variable name for a GPG signature (which has nothing at
> all to do with indentation).
>
>>                 if (in_signature && line[0] == ' ')
>>                         sig = line + 1;
>> -               else if (starts_with(line, gpg_sig_header) &&
>> -                        line[gpg_sig_header_len] == ' ')
>> -                       sig = line + gpg_sig_header_len + 1;
>> +               else if (indent_line && indent_line[1] == ' ')

Also, shouldn't this be checking *indent_line (or indent_line[0])
rather than indent_line[1]?

>> +                       sig = indent_line + 2;
>
> Why is this adding 2 rather than 1?
>
>>                 if (sig) {
>>                         strbuf_add(signature, sig, next - sig);
>>                         saw_signature = 1;
