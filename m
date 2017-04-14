Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E7820970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdDNUWV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:22:21 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34596 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbdDNUWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:22:20 -0400
Received: by mail-pg0-f51.google.com with SMTP id 21so47357958pgg.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pF7qpDvkpWMKU75x1K55A4DQs822Zygs+NGjJ1BNn9I=;
        b=kRGiVrIQu9lZgexjDqLebwtCJUHF7YV5XIgDeJmzIhG2tE+BaQ2hDauS5gp/32N9ei
         pgy19rlttWU2MiQWrRHzSrQ1alC2sf+TWoz8GWV65WVaQxrmaEn5zDhCniXBCZjIQZJW
         yKN+nyi3gitTpy3WlwmB6kCjn8fAK0mJr2px/3Mv8tvWQhlG2lxKWPvXXc5aYPp0y6+D
         uSreccxOmU04uo91F4gzbuvd91+giU39N8rbNrS2MG2tSdcOz/vcMlYyGo9WanlETPmf
         QNKI/ItW4FKHc8+OiD2PDPttmkCxNyYMbgGGy8/qXvGFbPTY2BuffNyEsvP7TZrWDXkY
         fwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pF7qpDvkpWMKU75x1K55A4DQs822Zygs+NGjJ1BNn9I=;
        b=Kad/igkgRR54xjR1eCu778kqy+xkdvlSrG4gmeCN57cTJjTJoblOOxm4Ex37LlxGjn
         O0q0jDHtF0eop71TKKR3WyeJLFflEqEUY7LD6FiyaekVE8xcky2dYubNbJpm1h62Yc6b
         6m7t7ur0CDt+53Duy6BuBkCosuMRWkwSfXyrlKoMGXV3HBw4LyuQHHR8/0nIaWC7mA5O
         BS5C/Fk5ubPWOFgs+jNbPQxvLnOirDsWAaQDTA6rQbVQsn5RwWf7zSemwPS4G4I+E8jI
         KCOLqeqvGWDSl7YVzFz34YWh3H50hyvCZJkQcNFtmm8Z897iDyaiMPYPLKAxbhj4DtqX
         kAeQ==
X-Gm-Message-State: AN3rC/5lr7uAYVSo+b4fUzheg1HL54DhmZqihBu8d7BnJUqxbWfjG0S7
        zDS/4TmB2PyUus+g
X-Received: by 10.84.236.74 with SMTP id h10mr10783315pln.91.1492201339303;
        Fri, 14 Apr 2017 13:22:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:11e7:137a:7479:ecbc])
        by smtp.gmail.com with ESMTPSA id x6sm4753135pge.47.2017.04.14.13.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 13:22:18 -0700 (PDT)
Date:   Fri, 14 Apr 2017 13:22:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] run-command: eliminate calls to error handling
 functions in child
Message-ID: <20170414202217.GB54940@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-8-bmwill@google.com>
 <20170414185054.GA23865@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414185054.GA23865@whir>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/14, Eric Wong wrote:
> Brandon Williams <bmwill@google.com> wrote:
> > +++ b/run-command.c
> > @@ -211,14 +211,82 @@ static const char **prepare_shell_cmd(struct argv_array *out, const char **argv)
> >  #ifndef GIT_WINDOWS_NATIVE
> >  static int child_notifier = -1;
> >  
> > -static void notify_parent(void)
> > +enum child_errcode {
> > +	CHILD_ERR_CHDIR,
> > +	CHILD_ERR_ENOENT,
> > +	CHILD_ERR_SILENT,
> > +	CHILD_ERR_ERRNO,
> > +};
> 
> I realize I introduced this in my original, but trailing commas
> on the last enum value might not be portable.  Checking other
> enum usages in our tree suggests we omit the last comma.

While I realize its not portal, I think there are other places that do
this same thing.  I think it means we can move to a newer standard of C!

In all seriousness though I'll drop the trailing comma.

-- 
Brandon Williams
