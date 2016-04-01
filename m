From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 05/16] ref-filter: move get_head_description() from branch.c
Date: Sat, 2 Apr 2016 00:11:55 +0530
Message-ID: <CAOLa=ZSs3ZUysusArNK8oXSe7jqqquJyx4=ZtNyqmDsm_iAguQ@mail.gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459330800-12525-6-git-send-email-Karthik.188@gmail.com> <xmqqy48zr4r6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:42:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am41f-0000f7-4e
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 20:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcDASm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 14:42:26 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36657 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbcDASmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 14:42:25 -0400
Received: by mail-qg0-f48.google.com with SMTP id f52so7185186qga.3
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iSVn3oqS/c4tGAZ84+EO1yCFvc3hWjN3qnqJJJoB1FQ=;
        b=Gh8taE1NEhJ0LtMcxp/F5BXelDXpNDRghNqrQ5qPOQ+o5IA6Umk9ryxVcTGm3aqkrV
         HM/DcUT/vvztb2on5lSTkRO98FoRROf+neSfa0Vt17W9jjdwoO7Iz0WJTFDnYekk3/nT
         RhQeKXfWkYVM2QHSk6cT7NXtaj3ycLo+gsvSPCTYqq5ddNMuEj1WGl+nABkCP28Ogzp3
         hrBBmuNeQzi3+4wZyCaXH+eBBF6WGaQX3ABxliPPPMzLwwOqDQPfag+qt/5RUc3zi1f9
         HMFz4NrxQWCbn/VzaW5/gvKJc4KB6+gSaoWNpCvlOURq1eIq4F5u9CGdJn6KSe7OZVxW
         mmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iSVn3oqS/c4tGAZ84+EO1yCFvc3hWjN3qnqJJJoB1FQ=;
        b=U3IREQo1GiNM7NDguABQ8fw31UxUz37wAwRgJmEjA2Wc3DCQjzPJY9h/VmRezSGE+3
         a/4NWLAyhtPb4wK0ezezWjc8RjVkzChKh/YjYZ5PfIHqlawbWQxUuCWRQcghXb2MqVT7
         p8oXkZRhcF3mUMZCUBqqMhsTbwJ7xav5sYggVQKBgINb5vI3euWyiXIS52fBOCSdG1/k
         EOCwbBPhHo4WxX5WFYlxf+1hZiHlW0q4iGHKORgZBZS9gkVtJv8yQlvFArOEeedylhKO
         sSiM3UMc5RP7KggVKEn+YOEQA1zV7ed+I8dMq5iPadJ3F0GoMx/vNTTy/aijkoLyuVY7
         Ptcg==
X-Gm-Message-State: AD7BkJKSWY6ccsRmmRqRAGvlDmIZD+Pu+MTKLPRDdXLWd5S/LsMC0inweXYz0w2NQC56nNC0VjRyIDtAOvJf0A==
X-Received: by 10.141.28.209 with SMTP id f200mr27968551qhe.53.1459536144800;
 Fri, 01 Apr 2016 11:42:24 -0700 (PDT)
Received: by 10.140.18.85 with HTTP; Fri, 1 Apr 2016 11:41:55 -0700 (PDT)
In-Reply-To: <xmqqy48zr4r6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290572>

On Thu, Mar 31, 2016 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -static char *get_head_description(void)
>> -{
>> -     struct strbuf desc = STRBUF_INIT;
>> -     struct wt_status_state state;
>> -     memset(&state, 0, sizeof(state));
>> -     wt_status_get_state(&state, 1);
>> -     if (state.rebase_in_progress ||
>> -         state.rebase_interactive_in_progress)
>> -             strbuf_addf(&desc, _("(no branch, rebasing %s)"),
>> -                         state.branch);
>> -     else if (state.bisect_in_progress)
>> -             strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
>> -                         state.branch);
>> -     else if (state.detached_from) {
>> -             /* TRANSLATORS: make sure these match _("HEAD detached at ")
>> -                and _("HEAD detached from ") in wt-status.c */
>> -             if (state.detached_at)
>> -                     strbuf_addf(&desc, _("(HEAD detached at %s)"),
>> -                             state.detached_from);
>> -             else
>> -                     strbuf_addf(&desc, _("(HEAD detached from %s)"),
>> -                             state.detached_from);
>> -     }
>> -     else
>> -             strbuf_addstr(&desc, _("(no branch)"));
>> -     free(state.branch);
>> -     free(state.onto);
>> -     free(state.detached_from);
>> -     return strbuf_detach(&desc, NULL);
>> -}
>> -
>
> Hmph, the name used to be a good one within the context of
> implementation of "git branch" command, but I have to wonder if it
> is a specific enough name in the global context of the entire
> project.  I also wondered if this sits better in wt-status.c;
> doesn't "git status" do something similar?
>

Yes, `wt_status_print(struct wt_status *s)` pretty much does the same, maybe
we can eventually lose this in favor of using that.

> For now, this should do, as I do not think of anything better.
>
> Thanks.

Sure.

-- 
Regards,
Karthik Nayak
