Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2421FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933654AbcLGWnW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:43:22 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34191 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbcLGWnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:43:20 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so166597230pgx.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQ0nuCvl3knvYEUduGQ+I5eUgKS7TmvENal+O9dhUVM=;
        b=W80tY05jYuk9wCx2fFJ00PhpxQWNUMuoyBepZp3Ahd2SDwIRJew5Q/OMMBb0+9aTbq
         ifjzXwBCVKQUmFL1+ktueC0aMq48UCM1OSO3LIFIBBqvEnhvVyYfJN5ce1O8w+4tV2E4
         e+y9v5LMH5j76LwPHUg641Tba6P321TRiOjSktxjZ59HS2cfpsy0lSyuwhwnp4pbmNXo
         Oe9YOnH99R8OcFMxhfM1EcfPn0wAhexSM0Msx3fN38dtja5Mz6oIue7Mf+XSwMj43+n9
         BsUHjnwJ0m8oMNTtpoOG9VvN6GC9GUScQG2P5t7dld+2VpKUfEimAPdLim2VjLnmWniC
         EYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQ0nuCvl3knvYEUduGQ+I5eUgKS7TmvENal+O9dhUVM=;
        b=gJ7ylaHcf/0GHu9IfqNcdXvlul3/NFBKtQpx2PiCe02OMcOAp35rMJasgp0i8wsVdI
         KVJhvPMyWuUT+gR2qPJBVA7/tq0cHQQ2SfRpJ5O1PJysLY79F2Fs9Kg8cViuYLSTTj05
         oOdK6STdybet5mLPEDw0ZNofrZT18hjqrtc2cMApyFdn0a3jun068+u7VowoIWn3DALD
         eMSaMza/H980+hfRVEhepS0TTPnwRxtIejugYIYN6aww7VOBcSncbEdnGsQmTeUdMhu3
         9C9BbnNmVdJ8eExUeskGjjwCJPaFV7XgZbtoQEn15PGKy2tTp3lPwBU121PD1p4FfAPi
         3ppw==
X-Gm-Message-State: AKaTC00xPDNo996Qd2PyJMq4uAHMmztWCv8kAA0xwuq3EgP52Aq9zoJYfmXqlOJb+3Bz0A20
X-Received: by 10.84.218.15 with SMTP id q15mr152227611pli.143.1481150599673;
        Wed, 07 Dec 2016 14:43:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id o29sm45135117pgn.28.2016.12.07.14.43.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:43:18 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:43:17 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/17] ls-tree: convert show_recursive to use the
 pathspec struct interface
Message-ID: <20161207224317.GG116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-5-git-send-email-bmwill@google.com>
 <CACsJy8DELy5JsJmcyDtwT-O9qGa9+hR1UfcKWRY1cmCnTALixA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DELy5JsJmcyDtwT-O9qGa9+hR1UfcKWRY1cmCnTALixA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Duy Nguyen wrote:
> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> > Convert 'show_recursive()' to use the pathspec struct interface from
> > using the '_raw' entry in the pathspec struct.
> 
> Slightly off-topic (sorry, but you made me look at this code! :D),
> could you update the magic_mask argument of parse_pathspec() in this
> file to PATHSPEC_ALL_MAGIC & ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL)?
> It makes sure all future magic will be caught as unsupported (and I
> think Stefan is adding one, but understandably he did not find this
> code).
> 
> I think it's in the spirit of renaming _raw to match too. By limiting
> magic to fromtop and literal, we are sure match can only be path and
> nothing else, which is good because this show_recursive can't handle
> anything else either.

Can do.

-- 
Brandon Williams
