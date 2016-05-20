From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/17] ref-filter: move get_head_description() from branch.c
Date: Fri, 20 May 2016 19:50:31 +0530
Message-ID: <CAOLa=ZQOHFFS+j-AR2Nv66-QKt1umQbh0Q7=8-rmJ67pAnN7dQ@mail.gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
 <1463309133-14503-6-git-send-email-Karthik.188@gmail.com> <xmqqtwhwv4kd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 16:21:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lIa-0001n2-Nk
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbcETOVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 10:21:04 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36834 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcETOVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 10:21:02 -0400
Received: by mail-qg0-f65.google.com with SMTP id z70so5282994qge.3
        for <git@vger.kernel.org>; Fri, 20 May 2016 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V/r5a5eKxq+yxSY2rcZzke3tz+p02ceKdxcGzNpNmmQ=;
        b=xj7AvdjxWtj/i1+Qf3YPn93nNndGRVkodv61ic0qBui84fJCg2QQlaNv+NPW3cJani
         fqvdpBG/pR8JgkFPZZiGeJYjWi0WMvA/gzdbV4yI28XtwkeL4TivRoCz18yLshHE92ft
         hKRB2tBIBJ9qDzD5LwzpfPFnd16zBZVz8JJ98u2INrrWof9yDcD0w36KGcdlN+wv7CfX
         tTfTkyi9QOe3pUxqezlt2dhzVwv6J6UX8tifZKiHKhfDQhYEfFoI/pMp/d2zkKh3wNcX
         +DWKcFAOnc+G3k3lzoO0z0onubxmjfW8abKBhATz4Wwa/6EcRhswSc0DnmdSdkK3JSRj
         tuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V/r5a5eKxq+yxSY2rcZzke3tz+p02ceKdxcGzNpNmmQ=;
        b=ESTUuaijJSyj02hJUERjGzmwpZUFPyBSZqKeOfzszy4YK3TpRtSfOIUJUmzEDEoRQi
         EmEumdzS584mfzYGjqL67viqnC/uIK4P7qxSiZ2nELllLF5dUGn6REvcVakWng4GSeop
         ox0173o/11nanXyksML2HUt+2vtH3H/hvfZrjOe6ou758oEy+27mhqGnvceTXn8KvXLi
         Lj6MZ4HXkwPqmQmStBh6+vKAhRapP0TYVFIIHYpJ96pNTuSfnv4EZ/4tlVt3O2hRi1S6
         ayClAlqphPnQS1Oukr4CyaSowNKwzxeYWBeJNvu7qcgVosYzcu1RiMUjjdDMRVbOlqfk
         GxuA==
X-Gm-Message-State: AOPr4FU9LQRUMDwmpdNZglZ2Kk/2VG2rTTTzzz2jCS1iinyzDkkdSCm7H+Sv25DOnya7vbMNXVXrnNLsUSihpQ==
X-Received: by 10.140.46.11 with SMTP id j11mr3536853qga.96.1463754060713;
 Fri, 20 May 2016 07:21:00 -0700 (PDT)
Received: by 10.140.92.178 with HTTP; Fri, 20 May 2016 07:20:31 -0700 (PDT)
In-Reply-To: <xmqqtwhwv4kd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295168>

>
> Note that this expects that va/i18n-misc-updates topic, which
> corrects the translator instruction around here, is already applied.
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7d3af1c..fcb3353 100644
>> ...
>> +char *get_head_description(void)
>> +{
>> +     struct strbuf desc = STRBUF_INIT;
>> +     struct wt_status_state state;
>> +     memset(&state, 0, sizeof(state));
>> +     wt_status_get_state(&state, 1);
>> +     if (state.rebase_in_progress ||
>> +         state.rebase_interactive_in_progress)
>> +             strbuf_addf(&desc, _("(no branch, rebasing %s)"),
>> +                         state.branch);
>> +     else if (state.bisect_in_progress)
>> +             strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
>> +                         state.branch);
>> +     else if (state.detached_from) {
>> +             /* TRANSLATORS: make sure these match _("HEAD detached at ")
>> +                and _("HEAD detached from ") in wt-status.c */
>> +             if (state.detached_at)
>> +                     strbuf_addf(&desc, _("(HEAD detached at %s)"),
>> +                             state.detached_from);
>> +             else
>> +                     strbuf_addf(&desc, _("(HEAD detached from %s)"),
>> +                             state.detached_from);
>> +     }
>
> ... but the change is apparently lost.
>
> It is a good lesson not to blindly rebase things on 'next', which
> would have unrelated changes.  If you needed es/test-gpg-tags topic
> for the test script change, check out 'master', merge that single
> topic, and then rebase the series on top of the result.
>

Lesson learned. Will do that from now on :)

-- 
Regards,
Karthik Nayak
