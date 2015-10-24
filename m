From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git --literal-pathspecs add -u says "fatal: pathspec ':/' did not
 match any files"
Date: Sat, 24 Oct 2015 12:55:47 -0400
Message-ID: <CAM-tV-8Qpy2fLMU=x7Yc4x2BhwpwN+0zZtJspYMZpamCij=z5A@mail.gmail.com>
References: <CAM-tV--Q=DjTwLk8sZVm7-xMQsGwKmyjy4XiT08QpQ5-dffL0w@mail.gmail.com>
	<562B2FB2.4080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 18:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq26m-0000iX-Tf
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 18:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbbJXQzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 12:55:51 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35790 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbJXQzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 12:55:48 -0400
Received: by wicll6 with SMTP id ll6so65783482wic.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TmK0E0N+wK4mWPc9lYjD/kUeerVJKstSK/ZhNnMfdac=;
        b=hvAwWEtw61kg60hdzvDa5xSPtKOrwTkxE9BGnJv9rdRioOtegF8qxeemCyHJ218Q7S
         ExGNbbEkHg8WYLPCu2tz1cJf2CO2KcCOGrryfcEAXkkY0cKvBExcgjSy5aBmX0qsTeao
         42U0GISCfFCbjlA5B9+wvU2JPf5J4/W8rOEt0VizGcN+nGUg79mx3iCVMf/oL6f8Ch5X
         BAm9trqmFiUuFXfzvXg3K+57WGVB3igKmk0vDkJRXm80/+ihu+KcU+JHkUMqaSruJW9j
         Nq4q7YUjvXohbHdbwEvQhjkXkGDI/2nLTGP3fp0wT7iN9neHQj9qu7GU3cdQCASNlikM
         ffHQ==
X-Received: by 10.180.37.135 with SMTP id y7mr10287440wij.89.1445705747667;
 Sat, 24 Oct 2015 09:55:47 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Sat, 24 Oct 2015 09:55:47 -0700 (PDT)
In-Reply-To: <562B2FB2.4080604@gmail.com>
X-Google-Sender-Auth: L3OQBKpj_T5FxUUrwurGZl6CKZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280129>

On Sat, Oct 24, 2015 at 3:13 AM, Victor Leschuk <vleschuk@gmail.com> wrote:
> The problem is that in the absence of explicit argument we set the list of
> files to special path ":/" which means repo root:

> And after that we treat it as regular file

Aha.

> Maybe it'll make sense to modify file_exists() to treat ":/" specially.

I'm not sure how this would translate into code, but it would make
more sense to me if we undo the effect of --literal-pathspecs when
setting arguments to ":/". After all, it's obviously not meant to be a
literal file so it shouldn't treated as one (also this way still
allows a user to pass --literal-pathspecs with ":/" to add an actual
directory named ":" (not that anyone should ever want that)).
