From: Stefan Beller <sbeller@google.com>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 12:16:13 -0800
Message-ID: <CAGZ79kZteMXLaQowxNdrXd-ULbmZQ=AuyCyz0w6dLJC68ThxnA@mail.gmail.com>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63DG-0003xn-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbaL3UQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:16:14 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53715 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbaL3UQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:16:14 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so13042725igb.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ccBBn9AQHgpGJM1i6FS0GVNeBCp0sWuOI210I6lRXmE=;
        b=QokL3rqvrfKs+FlJQYU4jQD8BElm+VAD2ibXr3DLxcVHuMT81IpjIbSTtcDKIWXBLX
         Vq2AnM8zhPe6iXZ8+DtH1S307eOmL3Dqt7kbJlCtfzDW26BAAbWbO3/70MR+C1urkJxE
         HizH7C/MUcvuZDvNpqe4vtQG7EnIFRs+bTMuCVx7pcFPsxXmnK+hai/p33wVy8K/LumZ
         oFm7l1uRNycVhgNOpxAFRGkvXqv8D3IF5zE273TFTsuTM0wS7+Nh4EfRdLq+xjJe+0J6
         EnBOpbN7f5eb+EPeiFSujObrAYjm0JGM099dbdmLxQN0zoXRgtjywoWwI6KPr/kXm8qT
         UOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ccBBn9AQHgpGJM1i6FS0GVNeBCp0sWuOI210I6lRXmE=;
        b=OGIxemNOksFRmmNDXdLkqxgkwyXrshrU2eX97aqFHkKKymfWJFKson2oeqcQffPZtt
         MapZ3A6ec6244Ui4F5wMarp5kOfOlJSJ1tcnQOqNgYwjCiR+d8kyA8fB9PE051yBBkl7
         DOE1e+Ezvw6Sy9OWK33xd2l9kls3Qs1AVB5jt8KCMi7c3N/yeaBwd3cyLrIc+errkWz2
         ZWeORR4BagRMyiIJfcZGOITeFc9N5qxEctGAEuVZvvSqAwLz4DWfUdY9e6YLJee9COj4
         go69+aPNsMuF4zAFMnyJkKOZF+9CaV10thZvt2vkMpIU8ySyGL2ZRNdtsPdfe0O6IE/a
         dJBQ==
X-Gm-Message-State: ALoCoQmBnKJvOgaAIihBRWc6XdjvRzBq3FZBLjZ8Hz/ahaP9AsPWE1/gdKC7hCAkC5Oid8udXqyo
X-Received: by 10.50.80.36 with SMTP id o4mr51662709igx.37.1419970573106; Tue,
 30 Dec 2014 12:16:13 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 12:16:13 -0800 (PST)
In-Reply-To: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261939>

On Tue, Dec 30, 2014 at 12:12 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> I was surprised to find today that the following didn't work as expected:
>
> $ git show master@{"1 year ago"}:Path/To/File.h
>
> It gave me the following warning which did not make the problem obvious at all:
> warning: Log for 'master' only goes back to Mon, 8 Sep 2014 12:08:44 -0500.
>
> What it is trying to tell me (and I only found this out after a lot of
> poking and prodding around Google) is that I can't refer to a commit
> by date if it extends beyond the range of the reflog.
>
> I don't understand why this requirement is in place. Each commit has a
> time stamp, so in theory it should be possible to calculate an
> absolute date from the duration specified in the refspec and grab the
> commit from `git log` from that.

Because the commit may have existed at a certain date, but not in the branch.
It may have been merged at a later time. I am not sure if this is the
actual reason though.


>
> I can only assume I'm oversimplifying things and that there is a good
> reason for this. If I can't get this to work, how can I view the
> contents of a file at a specified relative time frame as I have done
> above?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
