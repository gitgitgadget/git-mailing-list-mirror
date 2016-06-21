Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D912B1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcFUQsu (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:48:50 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36018 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcFUQst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:48:49 -0400
Received: by mail-io0-f179.google.com with SMTP id s63so17334203ioi.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 09:48:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rmG/zuXkFOhRALVrg0ihF+tLHxnSqawAFt1L9HRKpZk=;
        b=lGFu1MbI/OX61UUOJGCBrrnGxaCX9XqgNzNAjW71mn61FRQgXHu+2yWmwlMUYAZwUD
         wgw4hoxN26ymhTW39AfkvnaZaVObsisuliGjJVOeEdbAb49mDxJsxYTrp2pqLDCTdY8v
         /J3HLVUrGXpzBfpr/UddK4AQVSjE6WqvJudNYnmRhd21wWlrVlKlwIKxf/xAXFO3ooUU
         hwFQc1ipOr4fVvRBLZDS64aqiOcyAWw6aXnvhh20g6hZQjy6t+JGGlw+bfjgkamnMq/m
         j9w20FM7yxRc6MBIhzZ8pRI1guvfePA++3VmLUbNSUFIEDJzoQmUWJQ/qnQ5WGRu8t9P
         kjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rmG/zuXkFOhRALVrg0ihF+tLHxnSqawAFt1L9HRKpZk=;
        b=fnn8vlf0rMgRL7izmhGucbVSs04QcUyPke2r8TC/QjZCCVdUDZUND8GILlhOKt54Qm
         RyuE4Z19VBHdX7vNEFS/qng3VZmA8GSIgMc5FDZ50yCcwVV+TcPGYGOtzNHtw7Pied1V
         gK567YTf2+dgp62PoylKnh0XBNFb25E2RIGkJxxV4vphLF8uO5xrJLdSYE5aY+N8Nq+n
         yVoGmO5mhTjVtKVwnI2pNNPuLg9ZETgjEF46Nu2W3Pa7X4f9OJLEKhgoFu9JmUaM7RIV
         0qjSE6zEfCyxhZor5eh0NVp9JGlE3MeEBlEUXLAfQDQXL9i4pz4mpKwJqHz0sxXCmNuz
         7HjA==
X-Gm-Message-State: ALyK8tIdooyz52EOGAhMeGKlkVtDEGHILJDoUPOUip6bfeUEaRR8Pf2ySLJ5FiO2g9Lu6WndxnyzcHYgoqqbEg==
X-Received: by 10.107.8.220 with SMTP id h89mr33478021ioi.95.1466527728811;
 Tue, 21 Jun 2016 09:48:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 21 Jun 2016 09:48:19 -0700 (PDT)
In-Reply-To: <20160619100051.GA14584@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 21 Jun 2016 18:48:19 +0200
Message-ID: <CACsJy8DZ8jR=jZoC9F6k+WKr4mvZHMHtvLpT5+Mt9shX5-Wj8g@mail.gmail.com>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
To:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Cc:	Vadim Eisenberg <VADIME@il.ibm.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 12:00 PM, Jeff King <peff@peff.net> wrote:
> Stefan, I think it might be worth revisiting the default set by d22eb04
> to propagate shallowness from the super-project clone. In an ideal
> world, we would be asking each submodule for the actual commit we are
> interested in, and shallowness would not matter. But until
> uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
> going to be a problem.

Maybe we can pass an option to subsequent clones that say "if
allow-...-sha1-in-want is advertised, do a shallow clone, otherwise
fall back to full clone"?
-- 
Duy
