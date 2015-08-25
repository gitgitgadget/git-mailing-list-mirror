From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Tue, 25 Aug 2015 10:52:01 -0700
Message-ID: <xmqqpp2bz266.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
	<xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
	<vpqk2sj7tlb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:52:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUIOH-0001sP-4k
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbbHYRwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:52:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33063 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbHYRwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:52:03 -0400
Received: by pacti10 with SMTP id ti10so57959298pac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=I17HvfrAEPD2mqiJSVahRKFjblMgXA/UBh/uBDOlmog=;
        b=CXVxd/QpFWMACIoirpjw26T08agwC7wJMJfg1CsBVf02kchMT/epNzt8sRB3Y9JjzB
         A+ESo+oDDYjYnlLTB6juoiWmvw4gxz7kPVIszvsMPtvYxIwXU/yXv5wiYmlwRa+INbmh
         uovb4+eiUX1Sy5rIdA1bqT7aXoPMmVLkPy4pGH5VHDq5524oqJf6JdALdLcWfPd8xVJl
         hERKppFz1vj6U1uxCGCw67MLApOkFyMC3iiP/u6IvYfJDiV4TK9uWGnCpC47pTB3z/gZ
         6ImQ1kjowVeq/0jljGzcUzo2PkQrvnt5R1Td58co4BN5zpS8NRCbxtDAgdE6lGE4DRoU
         ZjJw==
X-Received: by 10.68.233.5 with SMTP id ts5mr59070861pbc.58.1440525122529;
        Tue, 25 Aug 2015 10:52:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id fw15sm21806248pdb.26.2015.08.25.10.52.01
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:52:01 -0700 (PDT)
In-Reply-To: <vpqk2sj7tlb.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	25 Aug 2015 08:47:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276553>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> You can see that I expected that "if !state.stack->prev" check to be
>> inside append_atom(), and I would imagine future readers would have
>> the same expectation when reading this code.  I.e.
>>
>> 	append_atom(struct atom_value *v, struct ref_f_s *state)
>>         {
>> 		if (state->stack->prev)
>> 			strbuf_addstr(&state->stack->output, v->s);
>> 		else
>>                 	quote_format(&state->stack->output, v->s, state->quote_style);
>> 	}
>>
>> The end result may be the same,
>
> There's another call to append_atom() when inserting the "reset color at
> end of line if needed",  so moving this if inside append_atom means we
> would do the check also for the reset color. It would not change the
> behavior (by construction, we insert it only when the stack has only the
> initial element), so it's OK.

Thanks for checking---I did overlook that other callsite and did not
check if the suggested change was sensible there.
