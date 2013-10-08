From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 8 Oct 2013 13:02:35 -0700
Message-ID: <20131008200235.GG9464@google.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>
 <20131008194147.GF9464@google.com>
 <87li23v8p5.fsf@flea.lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 22:02:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdUV-0003Eo-SE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab3JHUCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:02:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44670 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab3JHUCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 16:02:39 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so9302400pab.39
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h1sl8BjNHztQZMs70UXjkid59lV8kpvCT9Ck3lUMp20=;
        b=iCHBe80Cqpe4/W2ST7v7WiP8nlQZBIRs/J1YXjutFyG6eQl6YJ+5X6MKtZk8z0rEFP
         9LOs+4CXKaX9SIeKGa2krKVnQVMXmS+uYT1gKIqYrXvKPwT+S9MhLI61EOaO/dqZHtK6
         awqqFwHCXLlEmlm8sOU3JGUkbC55Iw6Cgwde6ycx8cjucmtFIus9hwSPyx/cI5nwLXQK
         PXdsGNSIbPQ0VYKo6hmpongt/6EWnSQvg+jMBPgWRDTN2/6+mjTPyyZhp4NL64OB0rbO
         w4pj5FeIukSgW0/C1gL6AWN0DnGPyHxQ+N266bIjOrzaABY9DLEpRNS1BsFs4r5jnJpx
         1irg==
X-Received: by 10.68.197.73 with SMTP id is9mr3799213pbc.75.1381262559375;
        Tue, 08 Oct 2013 13:02:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id im8sm41895160pbc.24.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 13:02:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87li23v8p5.fsf@flea.lifelogs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235789>

Ted Zlatanov wrote:
> On Tue, 8 Oct 2013 12:41:47 -0700 Jonathan Nieder <jrnieder@gmail.com> wrote: 
> JN> Ted Zlatanov wrote:

>>> Simple patch to avoid unitialized warning and log what we'll do.
> JN> Sign-off?
>
> I didn't realize it was a requirement, must I?

See Documentation/SubmittingPatches, section '(5) Sign your work'
for what this means.

If you just forgot to sign off, that's fine and I can forge it or go
without.  If you are unable to sign off because you don't have the
right to submit the change under an open source license, I'd be a bit
worried going forward.

[...]
> JN> Or more simply, would it make sense to wrap both 'defined' checks into
> JN> a single "if", like so?
>
> JN> 		if (defined $entry->{$check} && defined $query->{$check}) {
> JN> 			...
> JN> 		} else {
> JN> 			log_debug(...);
> JN> 		}
>
> I prefer the explicit version because we can issue a more precise
> log_debug message.

That's fine with me.

After this patch, the code looks like

	if (!defined $entry->{$check}) {
		log_debug(...);
	} elsif (defined $query->{$check}) {
		...
	} else {
		log_debug(...);
	}

As a small nit, wouldn't it be more readable with the two !defined()
cases together?

	if (!defined $entry->{$check}) {
		...
	} elsif (!defined $query->{$check}) {
		...
	} else {
		...
	}

Thanks again.
Jonathan
