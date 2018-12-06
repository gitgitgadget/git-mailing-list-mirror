Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5194A211B4
	for <e@80x24.org>; Thu,  6 Dec 2018 23:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLFXZo (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:25:44 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49692 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLFXZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:25:44 -0500
Received: by mail-qt1-f201.google.com with SMTP id n95so2001203qte.16
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=77oa5aO+hJ0jXdI3dpGL1UoM9mdITeQ40yPqb7TSUH0=;
        b=rHyjgmOsN2XpOveM3OQxJbevPBcxgfWIcF4kjU26wQFwx27GPpRjXW4QLzINg+nJe4
         ie/jTKajhimX3PbNNNcBs3cupbinTlcHZnnbYdsnut6KwEhbn8EkZffKlir2lJJpy5sB
         +mYnqcnhuLu5d9Gzkd/FW3CZc62AhLAgi6+6aUTtgOHDP4ucWFw/8ACiGdqggPQjImgb
         +YAI+BYpgo0q6uhgLEB6JL3cu0Y/IiRmm/b9vqLHg4Lr6unbHFO64e1VoSqMz6RPxv1y
         47cNGABZ5FVrVzlRMnRmMVHCDt8fSKXckIZG0pXxUoCMswhRg+1BiO2L0WA3jZK5bFwg
         sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=77oa5aO+hJ0jXdI3dpGL1UoM9mdITeQ40yPqb7TSUH0=;
        b=e8oDeUWSStrkRoKOZ6I5IMvDMUYHgxCgwRAWmhJRH6ZLRFXaeEf03y2+Ekyrp/Hz44
         RYz+BIauk8wtg+Mr/q/uefBPONn1V2CGkdaW2okYyjJ7Jid9zB8+0JH6JlDGwqvnYeBp
         v9ZWsEvfN24XUMJUHl27cGeDV5ZdOBPEoYNucXE+2ezcwbTHaKn6MAKiyOJQ0rmSCI5Z
         ZAxw11KuBbgz+E7YNOsuOQwG5snqF8cJ50Cu0yitytvvnTYBzyIorZ4ntFPaBJxg1DPW
         4BW6+8yf446ZBJWt4tnlDcQPOVbTygRq9XASvvMxyZJ86twSrHApMY/ES6fZcyzcqnLC
         ySRQ==
X-Gm-Message-State: AA+aEWaB3sNkR5eB4zL7BxpQxoME32dh4iuzhDSjdlyy4Iyd7JVNnPN7
        jvMr2FVB835F/gZzSFHUcjpkAzFhnZlzpWn2j2SE
X-Google-Smtp-Source: AFSGD/XWFd6B3BP4joyU2OqMwyi6F2lnxSqbeEVk1MzlvUB7BOrsYgEVokogi3N2Pwe7JCm1k1pULTliuBvB3C8fcS+J
X-Received: by 2002:a0c:ba2e:: with SMTP id w46mr22597137qvf.58.1544138743273;
 Thu, 06 Dec 2018 15:25:43 -0800 (PST)
Date:   Thu,  6 Dec 2018 15:25:38 -0800
In-Reply-To: <xmqqzhtj88nw.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181206232538.141378-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzhtj88nw.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 4/5] upload-pack: refactor writing of "packfile" line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > @@ -126,6 +129,12 @@ static int read_pack_objects_stdout(int outfd, struct output_state *os)
> >  	}
> >  	os->used += readsz;
> >  
> > +	if (!os->packfile_started) {
> > +		os->packfile_started = 1;
> > +		if (use_protocol_v2)
> > +			packet_write_fmt(1, "packfile\n");
> 
> If we fix this function so that the only byte in the buffer is held
> back without emitted when os->used == 1 as I alluded to, this may
> have to be done a bit later, as with such a change, it is no longer
> guaranteed that send_client_data() will be called after this point.

I'm not sure what you mean about there being no guarantee that
send_client_data() is not called - in create_pack_file(), there is an
"if (output_state.used > 0)" line (previously "if (0 <= buffered)") that
outputs anything remaining.

> Isn't progress output that goes to the channel #2 pretty much
> independent from the payload stream that carries the pkt-line 
> command like "packfile" plus the raw pack stream?  It somehow
> feels like an oxymoron to _buffer_ progress indicator, as it
> defeats the whole point of progress report to buffer it.

Yes, it is - I don't fully like this part of the design. I alluded to a
similar issue (keepalive) in the toplevel email [1] and that it might be
better if the server can send sideband throughout the whole response -
perhaps that should be investigated first. If we had sideband throughout
the whole response, we wouldn't need to buffer the progress indicator.

[1] https://public-inbox.org/git/cover.1543879256.git.jonathantanmy@google.com/
