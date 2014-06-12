From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 00/19] add strbuf_set operations
Date: Thu, 12 Jun 2014 00:09:32 -0700
Message-ID: <20140612070932.GA25353@hudson.localdomain>
References: <cover.1402348696.git.jmmahler@gmail.com>
 <CAPig+cRJJ6byQi6+=+8r3Ohyt9FvMHwQViq+MNR1DcD2t8w+NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:09:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuz8n-0000TJ-2E
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 09:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbaFLHJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 03:09:37 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40823 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbaFLHJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 03:09:36 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so664233pdi.23
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+5y83DiLB6BNcuEwv3YPocTRGHDpd2tyY9Gshc6S0II=;
        b=Uy4Hw74tuauhZquZWjb4NXPyZgk8oahiR9T37W+z/q1h3GlkUUXYNhB5Dj0lf3sBeo
         IDJQo+Euv7KZv3+QOP0XGy91bYDcxoT183gJeS5oDYBXVoOn8QcH71W+EIdQw039737I
         cUfpmj52LGuqrqYGzab8+upfa0G9ukOf0o9PnqVoCtSj6k6cPqt8HummsRkBouEf7YQM
         kmkGfDGfExANYGPLNpAJcSovsTLE80emFVeANrqaKisBcmQhnv6r46oPxJCyIDV0gL5o
         qQSegIAqEhMHIu7fq3+U2VbMhLNfeTV+YuVjKOenbH6zbYpGzcVH5h5GDX7To1XiVoP4
         K9tQ==
X-Received: by 10.66.254.166 with SMTP id aj6mr19244654pad.11.1402556975591;
        Thu, 12 Jun 2014 00:09:35 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bz4sm78704560pbb.12.2014.06.12.00.09.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 00:09:34 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cRJJ6byQi6+=+8r3Ohyt9FvMHwQViq+MNR1DcD2t8w+NQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251395>

Eric,

On Wed, Jun 11, 2014 at 04:09:17AM -0400, Eric Sunshine wrote:
> On Mon, Jun 9, 2014 at 6:19 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > Version 2 of the patch set to add strbuf_set operations.
> >
> > Includes suggestions from Eric Sunshine [1]:
> >
> > [...snip...]
> >
...
> 
> Food for thought: This patch series has now likely entered the
> territory of unnecessary code churn. Quoting from
> Documentation/CodingGuidelines:
> 
>     Fixing style violations while working on a real change as a
>     preparatory clean-up step is good, but otherwise avoid useless
>     code churn for the sake of conforming to the style.
> 
>     "Once it _is_ in the tree, it's not really worth the patch noise
>     to go and fix it up."
>     Cf. http://article.gmane.org/gmane.linux.kernel/943020
> 
> Rewriting code merely for the sake of replacing strbuf_reset() +
> strbuf_add() with strbuf_set(), while not exactly a style cleanup,
> falls into the same camp. (The patch which introduces strbuf_set(),
> however, is not churn.) Each change you make can potentially conflict
> with other topics already in-flight (see [1], for example), thus
> making more work for Junio.
> 
> Also, these sorts of apparently innocuous "mechanical" changes can
> have hidden costs [2], so it's useful to weigh carefully how lengthy
> you want to make this patch series.
> 
> Having said that, patch 4/19, particularly the changes to
> builtin/remote.c:mv(), in which multiple strbufs are reused
> repeatedly, does seem to make the code a bit easier to read and likely
> reduces cognitive load.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/245133/focus=245147
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/245133/focus=245144
> 

I did not realize this "code churn" aspect at the time but it makes
sense now.  These "mechanical" changes can be more trouble than they are
worth.

I will try to re-focus my changes to only those that have a substantial
benefit.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
