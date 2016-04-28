From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Thu, 28 Apr 2016 10:26:06 -0700
Message-ID: <CAGZ79kYe-WsAJj3xkr9YkHZbHqQ9rhKV80+K0Bx3SZsB85+tHA@mail.gmail.com>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
	<20160428115748.37177-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:26:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avphd-000525-PD
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbcD1R0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2016 13:26:08 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35975 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcD1R0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2016 13:26:07 -0400
Received: by mail-io0-f170.google.com with SMTP id u185so96814605iod.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=uSCyEvgP+HRLzIFHT0FadBCVEoTPi0wQA7q7rMyo8cE=;
        b=aThc45vqRrUWDZ164CYOv+Hk9thebzJxfcJXnPmeMjNuc3uuhvFZmkMKfZKWXyeevn
         a2JPmTS0bj2+elJNYqMVu40HPjzlUtuE861pK3s3A9viyOvLNYZWOlz5BuElBA3F9BJR
         DDtUTf4arIcZQbNOjNHS0LwOQd8hwTe8Vdv9BXsV5QUnqzr4V6bpgK6oBY27Eis3hklK
         ImSYtFj5YzN6mBxkSh9gG5KRMq+rZqSD56fhzvbSsR/uXU+1gzDTxbokt6hntr+nrm2/
         rZiNyhYvqihMkG/BQ7GgMcV1u3BlixP0p6r+/1zQlvPBud2i3dWgdBsZOwneVXm3V1Wh
         4Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=uSCyEvgP+HRLzIFHT0FadBCVEoTPi0wQA7q7rMyo8cE=;
        b=H6nLiCanDutkZnn4dVMwfptX7PRM3xLhn7X5dqnjZmJZsA1PeluYuQgY/BCjLRezDS
         RpWdWjYub/F+eTWpOiTbKS5dt4YvUntaMl/soKFuxSpe2k/QENzkETdbZwiPDx/j0+b8
         QAXBRYof7aS9fAmqzOMR3jxSYrEmM20ktwKyaKmwiH+UnVF+Sqt1EoerJQgCbfHTefZm
         JQBGH0CXBG58SWFgd5gsY0/T+FDXRxc19xX72VMi0oeGqKI5m5/YtFrHkmD62TOdwkla
         ioQaTrZUP09kjtD3hIg4/d1vYB35ibOtVeKKmPzpGD/tmfzHDKtjj1loXBoxEwJYKinA
         iVKA==
X-Gm-Message-State: AOPr4FUNz8+s50EB5k/NniAKEyO9S4mDv+qwIJE1xtngWtrJ3MkGWZfpHHX1fEIGD589j1Ct9u/9iV0Y8EYGck18
X-Received: by 10.107.161.68 with SMTP id k65mr21327689ioe.110.1461864366712;
 Thu, 28 Apr 2016 10:26:06 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 10:26:06 -0700 (PDT)
In-Reply-To: <20160428115748.37177-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292925>

On Thu, Apr 28, 2016 at 4:57 AM, Elia Pinto <gitter.spiros@gmail.com> w=
rote:
> Implement the GIT_TRACE_CURL environment variable to allow a
> greater degree of detail of GIT_CURL_VERBOSE, in particular
> the complete transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis. Document the new GIT_TRACE_CURL
> environment variable.
>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Documentation/git.txt |   8 ++++
>  http.c                | 109 ++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  http.h                |   4 ++
>  3 files changed, 120 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 8afe349..958db0f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1075,6 +1075,14 @@ of clones and fetches.
>         cloning of shallow repositories.
>         See 'GIT_TRACE' for available trace output options.
>
> +'GIT_TRACE_CURL'::
> +       Enables a curl full trace dump of all incoming and outgoing d=
ata,
> +       including descriptive information, of the git transport proto=
col.
> +       This is similar to doing curl --trace-ascii on the command li=
ne.
> +       This option overrides setting the GIT_CURL_VERBOSE environmen=
t
> +       variable.

How does it overwrite the GIT_CURL_VERBOSE variable?
After a quick `grep -r GIT_CURL_VERBOSE`, I notice 2 things:

* apparently GIT_CURL_VERBOSE is used as a boolean,
  so I presume we assume True for GIT_CURL_VERBOSE, but
  extend it?
* GIT_CURL_VERBOSE is not documented at all. (It is mentioned in
  the release notes for 2.3.0, not sure if that counts as documentation=
)
  As you know the area, care to send a documentation patch for
  GIT_CURL_VERBOSE?

I am trying to understand how much more information I get by using
GIT_TRACE_CURL instead of GIT_CURL_VERBOSE.

GIT_TRACE_CURL follows the standard of GIT_TRACE_$subsystem, so I
guess that will be the encouraged way of debugging and GIT_CURL_VERBOSE
will not be encouraged to the user?
