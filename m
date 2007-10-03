From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 08:37:23 +0100
Message-ID: <200710030837.25689.andyparkins@gmail.com>
References: <20071002155800.GA6828@coredump.intra.peff.net> <7vsl4tjo28.fsf@gitster.siamese.dyndns.org> <20071002204848.GA8284@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 09:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icyng-0001ny-9q
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 09:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbXJCHhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 03:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbXJCHhc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 03:37:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61134 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbXJCHhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 03:37:31 -0400
Received: by ug-out-1314.google.com with SMTP id z38so71463ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=q7FNE/xsymUtXkq1wd/k5e0qTBHBqm0KFK65a4JhRH0=;
        b=FyG6+KgA4uH/o3neDWfW+9mKI9qVxtraWguCk6ZWsZrm3Wx04jfH8RP/asF4u8nLWMbErOGWY+UdMM36hmtppn3e80RRdEwp3ugOTqzP96hU4msAvvBEcxCQ7ymhp5HtlkVyPnxII14H1HpQA0WtZVL8w0cZQuMrNBopkzgTJG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TbCKqgrOpMPL0oyOJfZAqpfSOJXmGjMhBhXK09D1rF92b1cNSzgexcaBvpIpl1Zp1u3i1RxxVUiIqXhEHW9SMk/uXXbmbSO66gK4/VGOWViwDHGoVjzXYkUDiRix+CqIKb8zx7vhXQoGd+k41UIoedqiLfZq2or5pp2FlBcVgoY=
Received: by 10.66.217.2 with SMTP id p2mr138644ugg.1191397049997;
        Wed, 03 Oct 2007 00:37:29 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b36sm102985ika.2007.10.03.00.37.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2007 00:37:28 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071002204848.GA8284@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59801>

On Tuesday 2007 October 02, Jeff King wrote:

> Perhaps a better quest would be to eliminate all of those counts
> entirely with code that is obviously correct. I think it is much more
> readable to replace:

I've got a patch replacing every appropriate memcmp() with prefixcmp(), but it 
goes on top of this one, so wanted to get this through review to save 
constantly spamming the list with the same patch slightly modified because of 
changes in a different patch.

>   url = xmalloc(strlen(repo->base) + 64);
>   sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
>
> with something like:
>
>   strbuf_init(&url);
>   strbuf_addf(&url, "%s/objects/pack/pack-%s.idx", repo->base, hex);

I've not been following the strbuf() changes, so have missed the appearance of 
these handy new functions.  They would appear to be an improvement for cases 
just like this.

> > constants in CAPITAL_LETTERS_WITH_UNDERSCORE shout too loudly to
>
> Part of the problem is also that they're long. Perhaps REFS_HEADS, while
> being less unique in the C namespace, would look better?

I completely agree with the length and loudness concerns, but my worry was 
polluting the namespace while maintaining some sort of rationality between 
PATH_REFS_HEADS and STRLEN_PATH_REFS_HEADS.  My reasoning was that

 "refs/heads" -> PATH_REFS_HEADS

is only three extra characters, and

 strlen("refs/heads/") -> STRLEN_PATH_REFS_HEADS

is only one extra character.

However I have no strong feelings about changing them.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
