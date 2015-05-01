From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 15:41:22 -0400
Message-ID: <CAPig+cR7V+9JLsCiJ_kmUBJc8_1Wwn6=O7uxQSEbogOGFKj8FQ@mail.gmail.com>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
	<CAPig+cQr5wQ6nfy90+SWyFFv0Neq4oJiEtur4cBJNGHNKXhZrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 21:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoGoX-0001ut-H9
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 21:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbEATlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 15:41:25 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38460 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbbEATlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 15:41:23 -0400
Received: by igbhj9 with SMTP id hj9so45943221igb.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W6SVcHZNWuhqS8ZzKe9Rdcu8HRT7TjxxXfAbOE9DNyQ=;
        b=UJrc0UbN6aR2sMKTxwv1STNrvDrfDggxq9U7UuzJWqCUQQIGQ1UFTkThWqVIinPb/h
         oxUivaI2Bx+5wNjey1WtAO5jnBavdAGOH5GqNpz9qUqroba1HW6uCJlOcg0pPww4fj3I
         qjD/iKc2WcTPNdPy0DwpmB5+dZ9PWap9XPLsLLDyFTMde/ztX3c7Tgql0OT0OZ8tjfgd
         JFzxWrbKjkBWJ1w0CPEP+v0so3wbFtS5EFD3rlT/oh+AzG+fiFoi/froc0Dup/xBUQAS
         wwoWnBVRfZ/b002J0xQr2Dc8NyP/Os5xFwL77B4k8H9FgRQu11puUIGO2sGj3yXouBwf
         dryw==
X-Received: by 10.50.27.67 with SMTP id r3mr12209186igg.15.1430509282485; Fri,
 01 May 2015 12:41:22 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 1 May 2015 12:41:22 -0700 (PDT)
In-Reply-To: <CAPig+cQr5wQ6nfy90+SWyFFv0Neq4oJiEtur4cBJNGHNKXhZrQ@mail.gmail.com>
X-Google-Sender-Auth: dvwO5Ou013mo1m909quBNEeE-k0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268177>

On Fri, May 1, 2015 at 3:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, May 1, 2015 at 3:28 PM, Stefan Beller <sbeller@google.com> wrote:
>> It's safe to free the char pointer `p` unconditionally.
>>
>> The pointer is assigned just 2 lines earlier as a return from
>> prefix_path, which allocates new memory for its return value.
>>
>> Then it is used in checkout_file, which passes the pointer on to
>> cache_name_pos and write_tempfile_record, both of which do not store
>> the pointer in any permanent record.
>>
>> So the condition on when to free the pointer is just "always".
>
> Why doesn't the 'p' in the 'while' loop just below deserve the same treatment?

Ditto update-index.c:do_unresolved().
