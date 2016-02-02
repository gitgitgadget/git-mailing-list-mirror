From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 00/12] ref-filter: use parsing functions
Date: Mon, 1 Feb 2016 19:37:59 -0500
Message-ID: <CAPig+cTT2Ti5r73=ndF5uR6ovGi16PcYEBb89ik0rcYTVZiRDw@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:38:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQOyq-00064W-MB
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 01:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbcBBAiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 19:38:00 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36571 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbcBBAh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 19:37:59 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so5436765vkg.3
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qavHUtcTeV4PiENucSsLneIgRZjA+xQ0V/wJDhY6+J4=;
        b=GAKEDfmTbAmEI4R2OX9AgIug815Z2GvqbDJthSqMr/PdCBIz9WOCQ06wpUw9HiWKTD
         OnGVJg5+2Dwe9PpsAp73Db8wKjTTspeuHCX/yLdb0rH8YPUQCW887bdBhxzCDX4fBk3a
         PmdfYAcHDVN2O2sdAxfXCU69U6G/pLVW3TG57jPUABDNdRDxKXpiZdeSKZc8jI2cei58
         HfuNx4Nlv3vGXWbN44XuvM4vTe/V9c5K/WpHyMG7BReRM9E9RGkwgVEbJkorKaUmaTlQ
         9JKJoiIbUAPaNB9lTqsr38iNVN01HsBNErlvjDGzj1WPlae0MlxctPxaHEMQ0KvtV9jX
         /7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qavHUtcTeV4PiENucSsLneIgRZjA+xQ0V/wJDhY6+J4=;
        b=ivSGz+46yWV8QeWwSceW4zheUI39vvghs+Pg53zePzHftWysTY9V4r72/2MsbME2bm
         G0WTCeFt9asb5+9aGXP62zsBZkpRO2KzfSE0P+j8BHBNN+UzEuCSbHAVlKx0XQVh3Dab
         +FOV9sUkaoJpx2xs/IkolpreM9Y1tWpt91Rh5VTkXHIaJHMAif/nj++58v+LwTUUlhZU
         FP+gAy889hgkwVq8rx03YC3xCGQubDcuX68cbu2umoh6ev4QboL7MlnAdyHOizAeOYY1
         KsimtHRJ5q7eOEjIViHxGblgnt7F9jVYEUsqmpkLsgaxpM1n3u+9ciQ5Fvdfiv+NYYbS
         wJuA==
X-Gm-Message-State: AG10YOS7ECa87GZO8vmZwOM5JJJYZ52y2JeEyezxGhHtK0oJuzAeymbQaNZnAoqNTkq+t+WoeopXJm58TOXRZg==
X-Received: by 10.31.47.135 with SMTP id v129mr18202975vkv.115.1454373479165;
 Mon, 01 Feb 2016 16:37:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 1 Feb 2016 16:37:59 -0800 (PST)
In-Reply-To: <xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: a2YmRy_-3ufAIgEG-qNY9dNcmq4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285228>

On Mon, Feb 1, 2016 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This series cleans up populate_value() in ref-filter, by moving out
>> the parsing part of atoms to separate parsing functions. This ensures
>> that parsing is only done once and also improves the modularity of the
>> code.
>>
>> v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
>> v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
>> v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
>>
>> Changes:
>> * The parsing functions now take the arguments of the atom as
>> function parameteres, instead of parsing it inside the fucntion.
>> * Rebased on top of pu:jk/list-tag-2.7-regression
>> * In strbuf use a copylen variable rather than using multiplication
>> to perform a logical operation.
>> * Code movement for easier review and general improvement.
>> * Use COLOR_MAXLEN as the maximum size for the color variable.
>> * Small code changes.
>> * Documentation changes.
>> * Fixed incorrect style of test (t6302).
>>
>> Karthik Nayak (12):
>>   strbuf: introduce strbuf_split_str_omit_term()
>>   ref-filter: use strbuf_split_str_omit_term()
>>   ref-filter: bump 'used_atom' and related code to the top
>>   ref-filter: introduce struct used_atom
>>   ref-filter: introduce parsing functions for each valid atom
>>   ref-filter: introduce color_atom_parser()
>>   ref-filter: introduce parse_align_position()
>>   ref-filter: introduce align_atom_parser()
>>   ref-filter: align: introduce long-form syntax
>>   ref-filter: introduce remote_ref_atom_parser()
>>   ref-filter: introduce contents_atom_parser()
>>   ref-filter: introduce objectname_atom_parser()
>
> Hmm, 10/12 didn't make it to the list?

Not surprising. Somehow, Karthik did git-add on the compiled
test-fake-ssh before committing, so the patch sent to the list
contains an rather huge binary resource. I did receive it since I was
a direct addressee of the email; I'll reply to the message on-list
without modifying anything (other than stripping out the binary
resource) so that other reviewers get a chance to see it.
