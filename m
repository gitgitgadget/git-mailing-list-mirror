From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Wed, 25 Aug 2010 20:49:32 -0600
Message-ID: <AANLkTimRLUwB7ycnaUGjpztLYtN7SoLyA8rXvYDqfi4P@mail.gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
	<1282704795-29661-3-git-send-email-newren@gmail.com>
	<AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
	<AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 04:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoSXP-0001S2-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 04:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0HZCtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 22:49:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0HZCtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 22:49:33 -0400
Received: by fxm13 with SMTP id 13so919271fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aPoQ9LmZ9awdOsnshgyZZR5LkC5+LYV+OEOCC7Zj21E=;
        b=PTqG4Ft/9ObXTBS2dD9iECM9gL2dkrzIFp2zT78sPkl/UCuJBwmXtwx45PElgwiM8V
         8A+N6eKCqxtGYObSStQQh9e3CmZbHesTuCN7YxkjKh4OLpP4NCWXjcTsm32bK2fNa1WR
         s6CmCRHXprSPAYqHVWcYw8RfYqWSdhDGACN/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Q5gTHZTmCPJGSH/qQdTtly5eYJ2JBDS5vUkI6Vgg8jTMjJjuKqYzWx6mZibVicN2zL
         HX5CzEITdCrH7YzwW4qUvHWQAYuALNO6fvak4f3qv4m6mVEQJxP035Fpzbfcv5LodoYn
         YC6GHAFA91wBHoWtAU1sY1AnZKTN46NJ0jJms=
Received: by 10.223.108.71 with SMTP id e7mr8839066fap.13.1282790972117; Wed,
 25 Aug 2010 19:49:32 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 19:49:32 -0700 (PDT)
In-Reply-To: <AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154502>

On Wed, Aug 25, 2010 at 5:50 PM, Elijah Newren <newren@gmail.com> wrote:
> On Wed, Aug 25, 2010 at 4:11 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>> I wonder if we can avoid xmalloc/free so many times here. If full_path
>> is unchanged, how about moving it outside the loop?
>
> Good point.
>

<snip>

> Thanks, but I just found a bug with it; I'm investigating.

tree_entry_interesting assumes base[baselen-1] == '/' || baselen == 0;
it will fail to notice matches if this precondition is not met, and I
failed to meet it except for files at the toplevel tree.

I'll send out an updated series with a fix for this and the
improvement you suggested.
