From: Bryan Turner <bturner@atlassian.com>
Subject: Re: credentials are being erased from credential manager via git
 credential-wincred erase command
Date: Wed, 13 Apr 2016 13:12:06 -0600
Message-ID: <CAGyf7-FJcJyP_CdRZLO7Eh6DoWp8XRU2CNczCdaYJO_MS6rnmw@mail.gmail.com>
References: <58eced84663c4ef38a63811d3367acf2@USNAEXCP1.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "O'Connell, Ken" <Ken.O'Connell@cognex.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:12:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqQD9-0000rr-Op
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 21:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbcDMTMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 15:12:10 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36551 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbcDMTMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 15:12:08 -0400
Received: by mail-qg0-f49.google.com with SMTP id f52so50438039qga.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XhX9k1FE+5R9TsyDHgmTd8yp0w2z8nn3+pyJiIfks6g=;
        b=OUVviGk61xMrIqMT4ZWg44TbPenQ5E6IFjrPTshPL8UdPoo3leW9l6+fmZmRgnxoZ+
         qPz6gfgTA5MoU9Ej8L4KSD9FTZ0vijRaas9Xp/8q99vGvmVda9JhCmuuUMCgICyO406y
         aTQsKJ6gFODU3l3QYDqgMiZiAWDGecpDgSI2/l2dgNATLseLmj/sRpgfElU13AD3bz9Y
         hjFnh6LFRPfxVBDmzdWRIwaVp3stb6+Mv5C1BaW+sGoVCPwUiQToUp2/DXVZANEpwv+r
         pZeUXfoweliOXVE1kHMQV96e5nSZw19a90HXFdkTiu394qSi3yQOC7wQIWnnQeaHHtWv
         b98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XhX9k1FE+5R9TsyDHgmTd8yp0w2z8nn3+pyJiIfks6g=;
        b=Ut/Z2kguc6aCUzjZwrdiF4/AxrkcKdZWGIHhBAvBpAw82q6hzVFAYGahPaPqMUycgJ
         DvFU3VizrulRtSvkEqPJ5M4xUE3nf8YaJjsWV05cNAh6PNrudXkx1WE3xR4ocdmTKbEK
         Ju9iMpe9nuQiqSxdZ98r7Qkdn5OZS2eWouihbVdbHVCma6KSCxQH3pZvsuQlXQDpix3u
         Z+9ROZeHR/NLxB3u9kLc3QKJuCkSqICFCbYhylkJ1UiQL9SdGcG7BUk+KaK6iZ08hHch
         3rHH/ORkT5xb+5EmgUF0wwQZVhbJx+0dqyazJqNwI53hwk8w2fgTiyZ9vzKvEctGgjix
         h0bA==
X-Gm-Message-State: AOPr4FXJ+kzH7ZmsiEJBB73rP65dpWRHaqpmYcsCJb6NKasGUER/w+DfFXjwLlmT/GZEfCpdRfOumEdhwjAjLqS0
X-Received: by 10.140.88.202 with SMTP id t68mr13367371qgd.86.1460574726942;
 Wed, 13 Apr 2016 12:12:06 -0700 (PDT)
Received: by 10.55.3.16 with HTTP; Wed, 13 Apr 2016 12:12:06 -0700 (PDT)
In-Reply-To: <58eced84663c4ef38a63811d3367acf2@USNAEXCP1.pc.cognex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291479>

Ken,

I'm one of the developers for Atlassian Bitbucket Server (formerly
Stash), which I believe you're running.

>From the credentials code in Git (which I could be mis-reading; I'm
sure others on the list will correct me if I'm wrong), it appears the
erase is done after a cached credential is rejected by the server.
That implies that, periodically, authentication with your Stash server
is failing and that that failed authentication results in Git clearing
the "bad" credential. That's likely why you see this happen on
seemingly random builds.

To follow up on the possibility that authentication with Stash is
periodically failing, I'd recommend opening a support request at
support.atlassian.com. My belief is that the remote Git client is
doing what it's intended to do in response to an authentication
failure. That suggests we need to look at your Stash instance to
determine why authentication is failing. If you do open a support
request, please mention me in your description so that our support
engineers can attach me to the issue!

Best regards,
Bryan Turner

On Wed, Apr 13, 2016 at 12:49 PM, O'Connell, Ken
<Ken.O'Connell@cognex.com> wrote:
> Good afternoon,
>
> My company setup wincred for management of our git/stash user credentials for our automated build scripts. It works great for days, sometimes a couple weeks.
> Then one day build haven't run and we discover the scripts are randomly found at a user prompt awaiting stash user credentials.
>
> We look at Windows Credential Manager store in Windows and find the Stash user credentials are erased from Credential Manager!
>
> We discovered via GIT_TRACE, that the command used to retrieve the credentials, is being followed up by a git command to erase the credentials. -not all the time, but seemingly in a random way.
> Looking at the trace logs on one server, we see the following commands:
> 'git-remote-https' 'origin' https://stash-server/bla/bla/bla.git
> 'git-credential-wincred' 'get'
> 'git credential-wincred erase'
>
> Do you have ideas on how to track down the root cause of why this command is running?
>
> Info:
> Windows 7 machines
> Git version 1.9.5-msysgit, and Git 2.7.4 windows (on one machine to see if upgrading helped) -it did not.
> Stash version 3.11.2
>
> Please let me know if I can get any more information to help diagnose.
> Thanks,
> -Ken
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
