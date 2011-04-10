From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 1/2] strbuf: make sure buffer is zero-terminated
Date: Sun, 10 Apr 2011 23:04:26 +0200
Message-ID: <BANLkTinKzatY-1kxLJ73TeDyMW175pr77A@mail.gmail.com>
References: <1302468858-7376-1-git-send-email-kusmabite@gmail.com> <20110410205711.GA2069@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jwa@urbancode.com, drew.northup@maine.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 10 23:04:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q91oT-0007lw-7X
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 23:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab1DJVEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 17:04:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42926 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab1DJVEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 17:04:47 -0400
Received: by bwz15 with SMTP id 15so4022511bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=5tnnGzMEm/MYUIq3wa4jKpuf7vjpkaQYIYgSS4QUJos=;
        b=jGSnqJeALAoD6sRbhrxUQ8Ex50tBI7teqR/a7IgERE2AuruvzTPrwLyCCqyOtU+ju7
         UbgclUWfMcey7/QX3hDA4XeDXOA3C+LQAYEMbPGCc2s0pDbWm3FdlVehnBQGj8rjmcts
         xqrTfg3uN5PpHA/AV86CR81j25JmYC8Kr+Qtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=k8Q5d104We8epvhgc7/QoZazoYEi6+RnDmqhy/OO49V3RebBV07sU1zi9vnTGjD9vU
         CB6ech/d7n4xyOqFMTZTzLYKxZpMlzs0PviI5q/cSZy0/uAqMdcd+GH4b3+ggMfLJipV
         BI8jv2UiBSZZcuKWUV0od8nEtv1T+/We8vY94=
Received: by 10.204.84.137 with SMTP id j9mr4052013bkl.120.1302469486089; Sun,
 10 Apr 2011 14:04:46 -0700 (PDT)
Received: by 10.204.172.130 with HTTP; Sun, 10 Apr 2011 14:04:26 -0700 (PDT)
In-Reply-To: <20110410205711.GA2069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171290>

On Sun, Apr 10, 2011 at 10:57 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 10, 2011 at 10:54:17PM +0200, Erik Faye-Lund wrote:
>
>> strbuf_init does not zero-terminate the initial buffer when hint is
>> non-zero. Fix this so strbuf_attach does not return garbage.
>
> s/attach/detach/ I think.

Indeed, thanks for catching it.

> It is more than just detach, though; the
> NUL-termination is supposed to be an invariant of strbuf, so any code
> just looking at "sb.buf" would be broken. So your code looks fine, but
> you may want to mention that in the commit message.
>

You're right. How about something like this instead?

strbuf_init does not zero-terminate the initial buffer when hint is
non-zero. Fix this so we can rely on the string to be zero-terminated
even if we haven't filled it with anything yet.
