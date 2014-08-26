From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v2 18/23] refs.c: add a backend method structure with
 transaction functions
Date: Tue, 26 Aug 2014 15:11:45 -0700
Message-ID: <CAL=YDWmKvV8oLF=4eqdo8SjLVaFd7PmunN=1VBV3KojFJy+oEA@mail.gmail.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
	<1407960907-18189-19-git-send-email-sahlberg@google.com>
	<xmqqha0zgcym.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:11:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMOxy-0001QW-7e
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 00:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbaHZWLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 18:11:46 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:61060 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbaHZWLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 18:11:46 -0400
Received: by mail-yh0-f41.google.com with SMTP id b6so12690164yha.14
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oVRqR1oAdZP34p8dr6dOJAtOLkqyU+Qji5DyUt6aWOw=;
        b=If0fBjC8sR1hP2zqLi2KTKPG/bauV3j0TWfA+OrzJAfPRw6zImArAPNailiVXHhRIx
         jCkaNZjqncXtIyR6uyFex0UeXYxJqkkR4ybGw4lenJjHKS/CZ/Xhsb29zH57jPX9J0Kf
         a/Yvdym3noNLfiZpfAF0oDjibznkkikCvftBRL1SXFfCEbh9r6iauh5mfftXO7C9S9dw
         BzflPWwDd8Z2PewFjMbGKrvN6QwwXPPwTnty6MbGDBhUyLBNXeuXkyJDFgwd1nLwkIr6
         KsJzV92xQmmf5jEdC78QsqdaFAyg6viuQnQk3UE2kXGV6wtp0DnOjmkSJvPj4cxQhm3s
         0Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oVRqR1oAdZP34p8dr6dOJAtOLkqyU+Qji5DyUt6aWOw=;
        b=gxvmP+NmPpiFCOiihvUrKVnJSaDiNhOXTB2e8RoJyQlnZa9KDhhUCV2k5Ppw9Uyvra
         noEAutsME/lrWCF6qReMkbMSYYYU2IyayT8AV8KIvayv4cM23lg3dqo8Awam5SpkHazr
         CxNpWDe1Y3R5BFPmaM88TC9iKg0Eo02C1h0UPr9tDjXA0gNbKU1Ivv0QI+h5eKP8/ISk
         +cZBKqAB0tg/yb7InmN6pavlcLUo9Qv+1QZP/nxNwDoQ+EApKvJ5gQLnwDiHYw6Nzak4
         MB38wvKu1VcpOpApogy1Bs0w+UF2Q1mrbnQkYhimqo7bGYpRm4Z/4NIAyAV9WRcFgmrz
         QXdQ==
X-Gm-Message-State: ALoCoQkqDXo9T79FOkKkzruOa89iZbkAs6daNgGFnXcPFQLNWwpbooJ2/jIyK9Ll9+3l3ldLd+Ze
X-Received: by 10.221.21.201 with SMTP id qt9mr13139231vcb.39.1409091105531;
 Tue, 26 Aug 2014 15:11:45 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Tue, 26 Aug 2014 15:11:45 -0700 (PDT)
In-Reply-To: <xmqqha0zgcym.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255951>

On Tue, Aug 26, 2014 at 2:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> +struct ref_be {
>> +     transaction_begin_fn transaction_begin;
>> +     transaction_update_sha1_fn transaction_update_sha1;
>> +     transaction_create_sha1_fn transaction_create_sha1;
>> +     transaction_delete_sha1_fn transaction_delete_sha1;
>> +     transaction_update_reflog_fn transaction_update_reflog;
>> +     transaction_commit_fn transaction_commit;
>> +     transaction_free_fn transaction_free;
>> +};
>> +
>> +extern struct ref_be *refs;
>
> The overall organization is nice, but please don't use such a short
> name for the systemwide default singleton instance, which should not
> be accessed by normal code other than via helpers that implicitly
> use that singleton (e.g. resolve_ref_unsafe() which invokes the
> method of the same name on the singleton, passing the parameters it
> received[*1*]).  The name will be used for other things (e.g. a
> local variable for a collection of refs) by code that do not care
> about the underlying implementation of the helpers and will cause
> confusion later.
>
> Perhaps the_refs_backend or something?
>
> Also does the singleton have to be extern, not a static inside refs.c,
> perhaps with a setter function to switch it or something?
>
>

Thanks!

I did these changes :
1, rename to the_refs_backend
2, add a function set_refs_backend()

To this series and update it at
https://github.com/rsahlberg/git/tree/backend-struct-db



> [Reference]
>
> *1* A typical helper that uses the singleton looks like this:
>
> +const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1,
> +                              int reading, int *flag)
> +{
> +       return refs->resolve_ref_unsafe(ref, sha1, reading, flag);
> +}
