From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per repo
Date: Wed, 3 Feb 2016 12:19:20 +0700
Message-ID: <CACsJy8BHem_8OcnT9KYhKZVhNcQbK91VDOJPLm9awfWJtpsi=g@mail.gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com> <20160203035648.GA20732@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Aloni <alonid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 06:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQprA-0005Bu-3J
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 06:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbcBCFTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 00:19:52 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33620 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbcBCFTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 00:19:51 -0500
Received: by mail-lf0-f49.google.com with SMTP id m1so6432188lfg.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 21:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aB3xGeiydGFmI4XMT9Wru5eDeparzUHtZuHyk5WX5Us=;
        b=ScjPNvxQ3s98UW1y+rrdlwT9Cw6HXggeCWvfmex2aEwfFa8fshsW3O4RBAvBBDmrpA
         SzM4NIiyX3N330zYbAsKLIOBcIVUvsma36f1SBHfDxxRNn0/0+Zq5yNnORwMzC+xltnY
         0nbF7nli5rnhj2uNmefGex28yRM/d4hRylCxqXLF3Kkq8iUtDdki9auTLoG/RCgbinKK
         p3sLizjuIx5qGPj5b7NzIWBCJnFCB+5efkUkPvTHmOGE4dA+kcbylo1+GMr4j1hygQum
         LVjD0zT0PQvbDZvrrFK2JFQB4CZQ00l5ZWdT0aA282CwEhFfjtW2LYRNCBDPX/1m3j1G
         xe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aB3xGeiydGFmI4XMT9Wru5eDeparzUHtZuHyk5WX5Us=;
        b=PiY0wB8Nrf5/ZnVgv/33MIZSn7mfcrP13NegwIAXqC/M/ewpynFFo6BzjPvE12eJtj
         gAhfau+AvYjUpHRVipSBOkSeq3g5sNXW2d/6SPAP+/81MsRmM4syyTdp6nQSUKmAFLgL
         8jgAKSE5cC71V8IGp5uwjYV5pOaWfSDNtlzqJVC3vG9fJKyhUyjMez8KpVACnAHCZqca
         GTeuvUThifBc8mdsiLgALQH8Al8wQlRknn5CjCYYOuFaL+N6o6sPiXqnborDHZH6sUKO
         bHfFrfQSk9dG3UhNogsMfgJ+8m0zov+shr9suywouv9u/UKVd/xyRlpa8zStyK0vA/1r
         isbA==
X-Gm-Message-State: AG10YOQTuR/sxU5WC+tv056k7PH9388qe37ZZB/9NcppSwFI3CN+U5u1Azk5xBMrGsLqysd2L99R09ADOOloYA==
X-Received: by 10.25.208.213 with SMTP id h204mr13667215lfg.112.1454476790254;
 Tue, 02 Feb 2016 21:19:50 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 2 Feb 2016 21:19:20 -0800 (PST)
In-Reply-To: <20160203035648.GA20732@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285330>

On Wed, Feb 3, 2016 at 10:56 AM, Jeff King <peff@peff.net> wrote:
> I find it disappointing that we go back to looking for magic sequences
> in the string. Could we perhaps do this more cleanly with a new config
> option? Like a "user.guessIdent" which defaults to true, but people can
> set to false. And without that, we do not do any automagic at all; we
> get the values from the GIT_COMMITTER_* environment or the
> user.{name,email} config variables, or we die().
>
> I think that should allow your use case (and extend the same feature to
> user.name). It wouldn't work on older versions of git, but nor would
> your fix here (the only way to do that is to re-instate "(none)" as
> magical).

Should we generalize this use case, i.e. define a list of
configuration variables that must be (re-)defined per-repo? Maybe not
worth it, I don't know. I can't think of any other variable that
should behave this way off the top of my head.
-- 
Duy
