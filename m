From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 0/4] cat-file: add support for "-allow-unknown-type"
Date: Mon, 04 May 2015 19:00:32 +0530
Message-ID: <55477478.9010406@gmail.com>
References: <55463094.9040204@gmail.com>	<xmqqzj5ltd6c.fsf@gitster.dls.corp.google.com> <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 04 15:30:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpGSJ-0002vV-1s
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 15:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbEDNai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 09:30:38 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33868 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbEDNag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 09:30:36 -0400
Received: by pacyx8 with SMTP id yx8so160812711pac.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=67Vr2bQtQeHflwv4lSXlaws5xs3yR/XB6xCe4XMoHdk=;
        b=riMYWBPdp4ZCs8qKaozxFDJs1yQYQchN5z/YrVJUQIyayAm7lXYeOZG6RwwcXPldEo
         OmaNySRFwahChEwNtqYzDQJ7jUNqoh0mDWWVqFMJyt9s6FHAtkjCwTcbeO6ClaVz7Blv
         c1OOo7FnQGF3KVm2PA7BVqwnr6JDxZQx0DX7vAdWvg3L/GvUIUfOAL+QwNQgEOx4q20k
         qyjnkR51JdJc5G98xaElhBb12Lb+/P/dR/EqeNchhHs2caRtlDImq5dITU1Zb5FdDSkW
         F8d0vIIpoj7u2X429HebvoRLgRHjFBHQQUf23t2KGAHe8PtYoqlnwjwROyb2ogpWyG+E
         cyOQ==
X-Received: by 10.70.87.231 with SMTP id bb7mr41967445pdb.70.1430746236311;
        Mon, 04 May 2015 06:30:36 -0700 (PDT)
Received: from [10.0.0.21] ([106.51.242.250])
        by mx.google.com with ESMTPSA id wa4sm12930311pab.17.2015.05.04.06.30.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 06:30:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqvbg9td0x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268325>



On 05/04/2015 05:44 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmmmm... you do not seem to pass your own test.
>>
>> expecting success:
>>          echo $bogus_type >expect &&
>>          git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>>          test_cmp expect actual
>>
>> --- expect      2015-05-04 00:09:24.327335512 +0000
>> +++ actual      2015-05-04 00:09:24.335335473 +0000
>> @@ -1 +1 @@
>> -abcdefghijklmnopqrstuvwxyz1234679
>> +abcdefghijklmnopqrstuvwxyz123467abcdefghijklmnopqrstuvwxyz1234679
>> not ok 86 - Type of broken object is correct when type is large
>
> Perhaps it would have a better chance of being correct with this
> squashed in.
>
> -- >8 --
> [PATCH] fixup! sha1_file: support reading from a loose object of unknown type
>
> ---
>   sha1_file.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index f65bf90..e010e7c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1568,7 +1568,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>   					unsigned long mapsize, void *buffer,
>   					unsigned long bufsiz, struct strbuf *header)
>   {
> -	unsigned char *cp;
>   	int status;
>
>   	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
> @@ -1579,7 +1578,6 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
>   	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
>   		return 0;
>
> -	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
Ok this works, weird, I test before sending patches, anyways getting to 
the point of discussion, shouldn't we have add the buf, since we did 
inflate once, before doing inflate again?
>   	do {
>   		status = git_inflate(stream, 0);
>   		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
>
