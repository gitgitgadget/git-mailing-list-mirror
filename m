From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Mon, 24 Aug 2015 15:15:55 -0700
Message-ID: <xmqqfv382uzo.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
	<xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU03q-00021Q-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbbHXWP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:15:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36779 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbbHXWP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:15:57 -0400
Received: by padfo6 with SMTP id fo6so2939811pad.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PCgqrjeYEw1VbkpPxer+qNIr2ZJn6xnX1AIaUNtGBII=;
        b=KaUugCc4yatw5B6s9Qf8HQtzSi7sfwIkBz270tlQlFUJiE9/w5YB5JlYVrlqekA8/c
         1ujXQfaovSFComZKLgfllnqbVCR9ff7vnjc/b2LpO6uHlpzasshG4++fDqTmNqM0M0H/
         Iq3rFvnHUHm2HsbbAPu+JNHBuQlnyEi9CX52E83gCCLo7SKiQPMPx4sVpMpywty+tGP5
         5rhG+gsHC6Duak6qMafOIV0LbQq4i4H7Pq5fREGI3z/GkmI3V2U0MNY0dle7uAe9IV2n
         sm/hMkaC4+bDCSxAOe082y9sHaPJJz/LbYUptlJb3MgH/1oWcXMpgMHW+AUsDBmgl5Ej
         C9PQ==
X-Received: by 10.66.250.226 with SMTP id zf2mr49629161pac.20.1440454556986;
        Mon, 24 Aug 2015 15:15:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id n9sm15944540pdi.88.2015.08.24.15.15.56
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:15:56 -0700 (PDT)
In-Reply-To: <xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Aug 2015 15:13:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276492>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void end_atom_handler(struct atom_value *atomv, struct
>> ref_formatting_state *state)
>> +{
>> +	struct ref_formatting_stack *current = state->stack;
>> +	struct strbuf s = STRBUF_INIT;
>> +
>> +	if (!current->at_end)
>> +		die(_("format: `end` atom used without a supporting atom"));
>> +	current->at_end(current);
>> +	/*
>> +	 * Whenever we have more than one stack element that means we
>> +	 * are using a certain modifier atom. In that case we need to
>> +	 * perform quote formatting.
>> +	 */
>> +	if (!state->stack->prev->prev) {
>
> The comment and the condition seem to be saying opposite things.
> The code says "If the stack only has one prev that is the very
> initial one, then we do the quoting, i.e. the result of expanding
> the enclosed string in %(start-something)...%(end) is quoted only
> when that appears at the top level", which feels more correct...

As this already allows us to use nested construct, I think we would
want to have test that uses

    %(align:30,left)%(align:20,right)%(refname:short)%(end)%(end)

or something like that ;-)

Very nice.
