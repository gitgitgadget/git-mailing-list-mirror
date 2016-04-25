From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Mon, 25 Apr 2016 08:53:01 -0700
Message-ID: <CAJo=hJucHFFxDeChwWNy7KQ2mbn21WBsJ5eG_S3W4R5z5CGqfg@mail.gmail.com>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 17:53:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auipC-00061E-5S
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbcDYPxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:53:22 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36261 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbcDYPxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:53:21 -0400
Received: by mail-yw0-f179.google.com with SMTP id o66so220242140ywc.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h3fdqzEOnP7FWHXYJgQc0O3zXp+oJJn3TlsEgmLB2+o=;
        b=NnzN8pNnsZmC2kSh3JUnA0dQWjlCleRuYgpgJPTOrIO8m41nSixqKsO6gtuLD/pAZ1
         I7+PgywVcslidJHuip8GqJW2MjMDGazyWcQ5/ZQzDzcbupGsyO7XcFOh1xcIWYbyA/Ud
         tbHAjh3/EDZW4ocT/rFNnxIdvsNgOzsMhG2/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h3fdqzEOnP7FWHXYJgQc0O3zXp+oJJn3TlsEgmLB2+o=;
        b=ORXRUiYRxw7Mk7coTCWS3vjl7pXupFc/R66Fh+ib7c/KCQIZnRAKxMcj/v/kQ5NsS9
         BezSx5ZuP6agdDu7PULja6XmZhM/rlDkcGRu8v/BOZ7Z6TAMVPpbLGtKdUcK4mJJPwnT
         ZUHTfkq9jYxE6lVPneJ4lX9KKhpTaL0XnwgJ6ctiSICsx50b6P/TqSJ3/4TnVAcpv5Zd
         O0PkKSntN6S3pOJvvOsHJJKv6rS0ELinmFD4Rn2XvWC3W97R9Y21l0COIQAdrlkwnZkI
         kDustqLw+4Oia9uXZc450n9aJoAPhqdEzIGPemDKcxDYNz4HMcaWRf7HNEYihqLgHU9f
         T/Vw==
X-Gm-Message-State: AOPr4FVkHJiz5ktdrRPAoK5YxGBV+5NUbYBxuXBvMGu7KiR3HYQh2LDxBLfN6kxKu4okAMy6D5DnoeN8QSoVnw==
X-Received: by 10.176.0.179 with SMTP id 48mr18780512uaj.6.1461599600758; Mon,
 25 Apr 2016 08:53:20 -0700 (PDT)
Received: by 10.103.123.72 with HTTP; Mon, 25 Apr 2016 08:53:01 -0700 (PDT)
In-Reply-To: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292507>

On Mon, Apr 25, 2016 at 6:13 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To make communication for `git fetch`, `git ls-remote` and friends extra
> secure, we introduce a way to send custom HTTP headers with all
> requests.

Hmm. Its not Apr 1 2016. So I guess you are serious. :)

> This allows us, for example, to send an extra token that the server
> tests for. The server could use this token e.g. to ensure that only
> certain operations or refs are allowed, or allow the token to be used
> only once.
>
> This feature can be used like this:
>
>         git -c http.extraheader='Secret: sssh!' fetch $URL $REF

Its not very secure to be adding secure data to the command line, e.g.
on Linux you can see that data in /proc.
