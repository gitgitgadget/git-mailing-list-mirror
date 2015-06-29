From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Mon, 29 Jun 2015 11:28:22 -0700
Message-ID: <xmqqtwtq9xo9.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	<1435222633-32007-6-git-send-email-karthik.188@gmail.com>
	<xmqqegkubddy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dnC-0001lG-1b
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbF2S2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:28:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34220 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbF2S2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:28:24 -0400
Received: by iebmu5 with SMTP id mu5so120739370ieb.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YlRrpiUWosynuKvl8teQFFqAW/HD0Hhpcm2BBcE0R0c=;
        b=OuHsBWQeAvrA5OfpMmwFaZMb3mELXtYNnuCFDvtB9uhWXOQjpRvdWB5+snp8P6ECHZ
         TdWwkq9ENMNQDyRKaNJVEG7bQdYA9ZQFzTIG0jL+JrN1AWtEE48RInh1vX4aAz9eSbdL
         rOVESkPi8WZU8ii5lYc9PkZ9rQfVO7YXTcy7Zk8+klHjaXAowED1WHgprwCN2qMYLfPm
         o9/RDrlPXywt/VuxTJ+MWDABqHV5V03aj/FXtWIJ5GNtjrO55fazclNXCHYyDSRUAekC
         wmyVsDY1Bt/DewuBulGS0LXqlxDYhDzAFbIgOcx2M/++/CZy5bkUhWwjrksQAccaBpxy
         LIfA==
X-Received: by 10.50.138.70 with SMTP id qo6mr17170645igb.15.1435602503922;
        Mon, 29 Jun 2015 11:28:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id e69sm28248139ioe.11.2015.06.29.11.28.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 11:28:23 -0700 (PDT)
In-Reply-To: <xmqqegkubddy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 29 Jun 2015 11:03:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272991>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>> +{
>> ...
>> +	for (i = 0; i < array->nr; i++) {
>> +		struct ref_array_item *item = array->items[i];
>> +		add_pending_object(&revs, &item->commit->object, item->refname);
>> +		to_clear[i] = item->commit;
>> +	}
>> +
>> +	filter->merge_commit->object.flags |= UNINTERESTING;
>> +	add_pending_object(&revs, &filter->merge_commit->object, "");
>> +
>> +	revs.limited = 1;
>> +	if (prepare_revision_walk(&revs))
>> +		die(_("revision walk setup failed"));
>> + ...
>
> Did this come from somewhere else (e.g. tag -l or branch -l)?  If
> so, you'd need a note similar to what you added in [02/11] to the
> original.

Ah, now I see this came from a part of print_ref_list in
builtin/branch.c; you would want to leave a note there.
