From: Marc Finet <m.dreadlock@gmail.com>
Subject: Re: PATCH/RFC: format-patch: Add format.subjectprefixsep to change
 separators
Date: Thu, 8 Jan 2015 22:47:22 +0100
Message-ID: <20150108214722.GA10014@mlap.lactee>
References: <1420377686-25608-1-git-send-email-m.dreadlock@gmail.com>
 <xmqqlhliqq1f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 22:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9L1G-00082z-N9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 22:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbbAHVx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 16:53:26 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37927 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbbAHVxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 16:53:25 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so6144017wiw.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D6kZXcv/sFXzRmP8oEdEP1jzmfxD63nok9AK5mUGbig=;
        b=d4Ib8mkhz36XfWcEqluGqtHqsC341fKj/+tU1n0Ah4wz0E405UhuSBR6d2dsUYD+tU
         zoEhh3/jxVopXP9MNTGLjH9lFvsRwmO3UCH8tq6ssFW278vKbr0l9vFD+rAD4yzrQEXE
         hfhYOLTRqL1+kmuUIGiwjUoY/OY8O4Jh3KrmnVyWEgziNDzZVzpEzCfEJoOce0bpJTa2
         devy/czxzYLKPRGz0nIw4BEWTlSaRUkGqDE/fOBDVxQmNhXauY/33Uc5BHBPImvqfGzb
         GXBTPXJL0CLu1lcWTDvMxMhTVA7zqMTnjcaCSx88W8gNccERmmOrzEqhbZURW6e2tIhd
         a5sg==
X-Received: by 10.194.188.39 with SMTP id fx7mr23268106wjc.113.1420753645594;
        Thu, 08 Jan 2015 13:47:25 -0800 (PST)
Received: from mlap.lactee (amg01-2-78-227-45-71.fbx.proxad.net. [78.227.45.71])
        by mx.google.com with ESMTPSA id dv9sm8110627wib.14.2015.01.08.13.47.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2015 13:47:25 -0800 (PST)
Received: by mlap.lactee (Postfix, from userid 1000)
	id 04F0417EA68; Thu,  8 Jan 2015 22:47:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqlhliqq1f.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262224>

On Sun, Jan 04, 2015 at 11:55:24AM -0800, Junio C Hamano wrote:
> Marc Finet <m.dreadlock@gmail.com> writes:
> 
> > Some mailing list use "PATCH:" rather than "[PATCH]" to prefix
> > patches, so introduce a new option to configure:
> >  - 2 chars that would enclose PATCH (and counters)
> >  - 1 char that would come just after the PATCH (and counters)
> > ---
> > This mail has been sent with:
> >  git -c format.subjectprefixsep=: send-email --annotate --subject-prefix=PATCH/RFC
> 
> A few comments:
> 
>  - "Some mailing lists" may want to say "[PATCH v3 #4 of 10]" or
>    somesuch; as a customization mechanism, the approach this patch
>    takes falls way short to be useful.  "--subject=<format>" option
>    where <format> is similar the "log --format" options, e.g.
> 
>    --subject="[PATCH% v #%N of %T] %s"
> 
>    with format-patch specific set of substitutions (in the above
>    example, %v stands for patch version, %N patch number and %T
>    total number of patches in the series) may be a better way to go.
In fact the log-tree.c::log_write_email_headers() has two cases
depending on the number of patches to send. So we need either two (or
three) options or we need to implement (because AFAIK it does not exists
yet) conditionals. Both seemed to me a little bit overkill here.
 
>  - Do not add configuration variable before you add command line
>    option.  Add option first and then when option proves useful you
>    can have the corresponding variable, not the other way around.
>    Make sure that the comamnd line option overrides configuration
>    variable while adding the variable in the second step of such a
>    patch series.
Ok.

> Having said all that.
> 
> What are these mailing lists and why are they using non-standard
> convention?  Back when Git was young, we would have added more knobs
> to adjust the behaviour to existing prevailing convention, but now
> Git is older than X% of projects that use Git where the number X is
> a pretty large number.  Perhaps just like they (whichever mailing
> lists they are) switched out of Subversion or CVS and started using
> Git to come to the modern world, maybe it is time they switch their
> convention as well?
Well, the only mailing-list I saw this behavior is zsh. I did not dig
into its history to see when this behavior has been adopted. I did not
see remarks regarding patches sent with [PATCH], but I just wanted to
adopt the existing style rather than using a new one and thought that
git was already providing a way to do so, and eventually developed this
patch.

So, I do not know what to do now:
 - stick to [PATCH]
 - try one of the two first alternatives above (multiple options or
   implement conditionals)
 - re-work this patch by implementing the command line option, creating
   an other patch to use a configuration option, and hope it would be
   accepted because it makes sense to some people. The only advantage of
   using PATCH: rather than [PATCH] is that 1 char is saved :|. Making
   the subject less 'aggressive' is a feature but not necessarily an
   advantage.

Failing to see some interest for solutions 2 or 3, I would fall back to
solution 1 :).

Thanks,

Marc.
