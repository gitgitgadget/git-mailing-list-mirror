Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CE02070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbcGHR6z (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:58:55 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35866 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbcGHR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:58:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id t190so14698361pfb.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 10:58:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FQNPFFvxGa/5iIXsqaE13PpRgR0Tqy7z4dnCFKqf8Yw=;
        b=h637ZiImTjBB/cIGl8aFW6FMCmOoAm9e6T5e55zZFEXs11tKuCWQ9Gb+kZgB+U0SCL
         dsIRBjgbZnI4zMUbReT51VNfHCWBQx2gzpedjC/RmEyJJEllid7+bjGQaGvD6jggbmND
         8Ok6fG6uFiP+bGUsfs2ufVVIQKv9c2FufpNpqMyA51f/ka7X+lyk6saeYwqYA0VAqwS+
         usZv/s781pZq1rL7kAc4TY5Bbq5MFVHZy/VHWZuz/swbIyof/bzRbY+kT0wCx3uKqgdv
         QCDnY4qYCP/XOoAEw6fcjbCAtSZvkNHRcAqDnYu2Wa1AUhMgRQOcWeX8GRDQJZCQCanD
         payw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQNPFFvxGa/5iIXsqaE13PpRgR0Tqy7z4dnCFKqf8Yw=;
        b=FVGy/im0xq1ZtWsEoUC2glvoPwOLcZENhDIW6k9BZeQLkihWVZdRJ/H6oxJ6wUTDq4
         2fmVel3MaqtOJ7ThucPykAk9YWTqLuBhvQr/k1W1BeBztv5oLVn3x02+s2qXpjdYcGyj
         YcLeHMDBGa0WXesb2KVm8iOSsXo3nrX3wAPS+hdSPPkseokkrLsejrTZObWkODHAjph9
         4666DuObC7Z4GKAhPsHRCN1m5+vK7AzVhJ2kiWb+PzHQ9bVRqUz5VpFGeS/gfcVPGzQt
         41hPDRV6ybGwK1UiUmajGQF+6i3DW56gT6FFWsIesDPQs5xD3SYSLpNq/fNmQOLO+wUW
         Y4Qw==
X-Gm-Message-State: ALyK8tKCjZx4pa3/nS8LQqEyMPoylFCrSyO7wF1goLB18/O5wcTvBQbGyP/OJfNNsGdRGQ==
X-Received: by 10.98.22.198 with SMTP id 189mr12076969pfw.74.1468000732401;
        Fri, 08 Jul 2016 10:58:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e1a9:2fc1:e3b6:b0de])
        by smtp.gmail.com with ESMTPSA id d65sm6023130pfa.45.2016.07.08.10.58.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 10:58:51 -0700 (PDT)
Date:	Fri, 8 Jul 2016 10:58:21 -0700
From:	Jonathan Nieder <jrnieder@gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160708175821.GA29326@google.com>
References: <20160707011218.3690-1-sbeller@google.com>
 <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:

>>> More importantly, if we plan to make this configurable and not make
>>> the limit a hardwired constant of the wire protocol, it may be
>>> better to advertise push-options capability with the limit, e.g.
>>> "push-options=32" (or even "push-options=1024/32"), so that the
>>> client side can count and abort early?

Sorry to butt into the conversation late, but: I am not yet convinced.

Is the idea that if the push options were very large, this would save
the client from the cost of sending them?  But this comes with a
downside: the server doesn't get to send an error message about where
the maximum number of push options can come from (e.g., with a link to
a page where the limit can be adjusted, or with an explanation of when
clients tend to run into this problem and what they should do
instead).

So I'd like to propose an alternative. What if the client tells the
server the number of push options early on (and possibly also a cap on
the length of those push options)?  That way, the client doesn't have
to waste bit sending the push options but the server gets an
opportunity to send a helpful error message on sideband 3.

	server> HEAD\0push-options ...
	client> ... commands ...
	client> push-options 2
	client> my-first-option
	client> my-second-option

Thanks,
Jonathan
