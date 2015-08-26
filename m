From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Wed, 26 Aug 2015 18:10:31 -0400
Organization: Twitter
Message-ID: <1440627031.26055.5.camel@twopensource.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	 <1440618365-20628-3-git-send-email-dturner@twopensource.com>
	 <xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 00:10:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUitz-0002hM-ET
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbbHZWKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 18:10:35 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33324 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbHZWKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 18:10:34 -0400
Received: by qkch123 with SMTP id h123so792338qkc.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 15:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=p3EvUUtWv4aQ9yiBwRNDWZWDc22x9HsmFBjTvKY/f28=;
        b=hMD0bOrTmgCksEt01M0RhWSB93aSQyjcPD4bYsOQoCa9d77XChCLavDBlYYmc178BU
         PEko5yvtdnvv/+ZBLvYa2kakLrAcIRjyIxnkkWkatpkHfYveEH/Pnj0QLTX0BhIYIc4+
         Q5cKpt3h2416eYI5MkL6l9V+JhFdxX7ziF0RF17//e5KA1dgvZBCSdVBnCrsTd1k6QYL
         C3gkkCsH0wRz6XN18gu+uwVL8jyhrBzGKbEdQNKwzoIGSO5PSRUHxWhaF1RxCyOmGavJ
         hPdZW6orQBcU5p/jujooP1MG8YD9mAnHXkApVXWCJBUkfXenDOPS3SDJQEko1Io/PiEr
         HuqA==
X-Gm-Message-State: ALoCoQmmQKU7TfRSyximelbd+OGX7nLMhcIOEUZ4w2gV+E6R2qBbKOzAD4JS0W6AQpIxRKY4T4vr
X-Received: by 10.55.195.17 with SMTP id a17mr1494251qkj.84.1440627033942;
        Wed, 26 Aug 2015 15:10:33 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id t49sm49862qge.21.2015.08.26.15.10.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2015 15:10:32 -0700 (PDT)
In-Reply-To: <xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276643>

On Wed, 2015-08-26 at 14:15 -0700, Junio C Hamano wrote:
> > + * For example, consider the following set of strings:
> > + * abc
> > + * def
> > + * definite
> > + * definition
> > + *
> > + * The trie would look look like:
> > + * root: len = 0, value = (something), children a and d non-NULL.
> 
> "value = NULL", as there is no empty string registered in the trie?

Indeed.

> > + *    a: len = 2, contents = bc
> 
> "value = NULL" here, too (just showing I am following along, not
> just skimming)?

Yep.

<snip>
> > +	/* Partial path normalization: skip consecutive slashes */
> > +	while (key[0] == '/' && key[1] == '/')
> > +		key ++;
> 
> These "skipping consecutive slashes" inside this function is cute.
> I would have expected me to react "Eek, Ugly" to it, but somehow I
> didn't find them ugly.

It's right on the cute/ugly edge for me too.

<snip>

> I somehow wonder if we'd want to precomute the trie at the build
> time, though ;-)

LOL.

<snip>
> Thanks for a pleasant read.

Thank you!  I'll re-roll with those last two fixes (re value=NULL)
tomorrow-ish.
