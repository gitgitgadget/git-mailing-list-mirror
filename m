From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 10/15] update-index: enable/disable watchman support
Date: Wed, 20 Apr 2016 06:45:24 +0700
Message-ID: <CACsJy8D34SKcA0dsG0ZrsOZiOFLwgEuG-TJ914t4qFV1xZGnew@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-11-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asfLD-0001wv-VK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbcDSXp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:45:56 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33861 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbcDSXpz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:45:55 -0400
Received: by mail-lf0-f44.google.com with SMTP id j11so31066246lfb.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xKLXKwdBsZXWJsMo9th0/N2sUTY3hzGJnBmvi9KxJcE=;
        b=C7QHk3qxPBPPmMJ7wGoQleEP6FDhu6f2fPHDXGbafCVosf9dAGqCJW9lnktRQn4uNy
         e7lNjzqN/4KglfjAhL+cM2c2cme66J0pIYQ4dz9t6bNDMFEnnnf66UEkitT/2P8KURPf
         mCauZbmcs8HaAXrEsDpHwmnwH6BsDwXtBF+5jtG5Jbq9Z1xO1r6k0liOMLuTCN+YW7Ko
         Mpo2fVmVie8fKAntZxPZy+edLclM7hsdhXZgzs5+WyWVMcNSeEUYJU8ynkqhPkFxRIqc
         IuJq19O4qJoQRHXm8BCWbWdl0Nje7u+2Hqyxgces828C2TZywAZw/okZTmw2HHT9QCJL
         JGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xKLXKwdBsZXWJsMo9th0/N2sUTY3hzGJnBmvi9KxJcE=;
        b=nKoNBz673XaRbVqsfofgo1qBc1w0YWva/3uZWmJwH/SAnWdOb3rzCTN7XAMBtCZnuP
         Of1QOZvXURFk54GkpD0Y+9H6o8di583NvU9A9QYc4vKbgPUNT2QsYtSB45gazr/5cQDr
         VTsW48g3reZcIL5o2onC5qtAXufSxym5WlmVZlrkNz5BQxLahs5/wQoQmcqKHV9VYvhC
         R/JEL1qIsX+axsY2fzewMAhCMeH+7yBD/AEpdxeEfhjoz1I3KSzEzF3eMZpTiceqRslU
         qT1eOXnn+gRb2SEJJlQcvIKCEzVi528mFQl/BX5VhWJpbfJ5yb7J2uXVCgImuhbYzjco
         DiMQ==
X-Gm-Message-State: AOPr4FUuBZ2B71xVDxFYlY2tK8pTa7beWYp035HSOfKpQOdnoLfj2zmzroIfe1EUEDByho2Au5dNDjJfWBa8fQ==
X-Received: by 10.25.211.75 with SMTP id k72mr2202626lfg.45.1461109554083;
 Tue, 19 Apr 2016 16:45:54 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 19 Apr 2016 16:45:24 -0700 (PDT)
In-Reply-To: <1461108489-29376-11-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291969>

On Wed, Apr 20, 2016 at 6:28 AM, David Turner <dturner@twopensource.com> wrote:
> +       if (use_watchman > 0) {
> +               the_index.last_update    = xstrdup("");
> +               the_index.cache_changed |= WATCHMAN_CHANGED;
> +       } else if (!use_watchman) {
> +               the_index.last_update    = NULL;
> +               the_index.cache_changed |= WATCHMAN_CHANGED;
> +       }
> +

We probably should warn people if index-helper is not built with
watchman support, which makes this knob completely useless. If
watchman fails to start, that's a separate problem..
-- 
Duy
