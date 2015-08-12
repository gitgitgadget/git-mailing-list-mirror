From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 03/13] ref-filter: introduce ref_formatting_state
Date: Wed, 12 Aug 2015 18:56:40 +0530
Message-ID: <CAOLa=ZTKvNq0meFfHA8CjWsXOznmW4QUudQnizypzThhBQvFZg@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-4-git-send-email-Karthik.188@gmail.com> <xmqqd1ytsnfx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPW3o-0000D9-0S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbHLN1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 09:27:12 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34096 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbHLN1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:27:11 -0400
Received: by obbfr1 with SMTP id fr1so12386762obb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7RRDAidctBf4PkNxFQpqEmtZa+6vRNr7nK8NXUuAOz8=;
        b=iMHrPVAqu3fWl5JYB7FNe9Rc9bUB74nxuXznio/b+bobYLLyvdnd4kyNub3OxKtATd
         2Mh5RYPffZbf3uCKoxq/VPDWSJJnAYKweHaa1ABnmh7QdDISE6MVWp/6XS8HgmcitAEG
         VNsOwpfhHtfWrVNXaZeliaZF9LEt5Em1l1+rZMucdVXSSnAHW9SlBSzb4ZOUMwbz7Cwb
         8lRelAGYc28bzEUgm5u1kpt+cjm/4yrSjwGrG5cAWRexgbJQ43PROs0ei6pqQWgmt0Bv
         Wh2L5I7JrmANgpRzT2yjaHXKoGCuDX/+AmK6Q5z5NtyKbWasFhFOlYSLtQ7xNTbdxiX3
         8nLw==
X-Received: by 10.60.42.230 with SMTP id r6mr32042291oel.9.1439386030178; Wed,
 12 Aug 2015 06:27:10 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 06:26:40 -0700 (PDT)
In-Reply-To: <xmqqd1ytsnfx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275765>

On Tue, Aug 11, 2015 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>               get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
>> -             format_quote_value(atomv, quote_style, &output);
>> +             set_formatting_state(atomv, &state);
>> +             format_quote_value(atomv, &state);
>> +             perform_state_formatting(&state, &final_buf);
>>       }
>>       if (*cp) {
>>               sp = cp + strlen(cp);
>> -             append_non_atom(cp, sp, &output);
>> +             append_non_atom(cp, sp, &state);
>> +             perform_state_formatting(&state, &final_buf);
>>       }
>
> With the two helpers being very sketchy at this stage, it is very
> hard to judge if they make sense.  At the conceptual level, I can
> see that set-formatting-state is to allow an atom to affect the
> state before the value of the atom is emitted into the buffer.
> I cannot tell what perform-state-formatting is meant to do from
> these call sites.


True, set formatting state is to ensure that the state is manipulated for
a given atom.

perform_state_formatting() is meant to act on the state set by the atom,
It performs formatting based on the state values, here is just copies the
strbuf set within the state to the final_buf.

-- 
Regards,
Karthik Nayak
