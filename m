From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 15/15] ref-filter: introduce objectname_atom_parser()
Date: Wed, 6 Jan 2016 23:57:56 +0530
Message-ID: <CAOLa=ZQxFTSAfdVf6moRkJYKGDKG35FBUZ+Tg2+d4Ue0biYsuw@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-16-git-send-email-Karthik.188@gmail.com> <xmqqegdviugx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGsox-0000vX-3h
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbcAFS22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 13:28:28 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32997 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbcAFS21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 13:28:27 -0500
Received: by mail-vk0-f68.google.com with SMTP id n1so520404vkb.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7J4wa3MycjgCWMZiW8wdQC0DlYDQZPh8hZqYPN79MIg=;
        b=jFodDzobLB3x9Up1RMHTLftpDVPbepSn6pKSFuvPvij0ga75LqZwxE6HfBQp0XF3fq
         pUzHwR9kMX/T5Em7GtdB1SCFJ8KXeZcaHe5xtDgL+CgVZBv7buSw4xrMCCA4gaSiR0FA
         YAl15xVeZOn7L/OALjviakFyBggB5rk5RM32eMfxCCuSc+nHnrX3nrqX5InYJcxvWttT
         9y13Sl74vyOCKw3LEIhkh78YADoj52ny9mUrLIAs5Jv9PH7ZI3MMWu698MS8PHWC/Q20
         OK/wy600d59fR47BNXOjb/s8AnHbFruUBCDRt58A1yjaM70nBDKT/RVEeSITQepd7mxD
         EWqQ==
X-Received: by 10.31.8.204 with SMTP id 195mr70473272vki.30.1452104906054;
 Wed, 06 Jan 2016 10:28:26 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Wed, 6 Jan 2016 10:27:56 -0800 (PST)
In-Reply-To: <xmqqegdviugx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283450>

On Wed, Jan 6, 2016 at 3:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -467,15 +482,17 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>>  }
>>
>>  static int grab_objectname(const char *name, const unsigned char *sha1,
>> -                         struct atom_value *v)
>> +                        struct atom_value *v, struct used_atom *atom)
>>  {
>> -     if (!strcmp(name, "objectname")) {
>> -             v->s = xstrdup(sha1_to_hex(sha1));
>> -             return 1;
>> -     }
>> -     if (!strcmp(name, "objectname:short")) {
>> -             v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
>> -             return 1;
>> +     if (starts_with(name, "objectname")) {
>
> The original used to reject "objectnamefoo", but the updated one is
> more sloppy.  Shouldn't it be doing the same match_atom_name() here?
>
> This comment applies to many remaining strcmp() and starts_with()
> that is reachable from populate_value().

Should we worry about such extensions of atoms? I see that
parse_ref_filter_atom()
takes care of something like that in the beginning itself

-- 
Regards,
Karthik Nayak
