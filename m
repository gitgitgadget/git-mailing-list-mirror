From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Fri, 21 Sep 2012 10:46:55 -0700
Message-ID: <7vipb75kvk.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh> <7v392cd4vi.fsf@alter.siamese.dyndns.org>
 <CACsJy8AAjxMN7MX09Eq4Dy6NJHMkyxGJZm9uZquXWTi0goAYLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF7Jq-0001vF-8B
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431Ab2IURrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:47:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab2IURq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:46:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6119EC2;
	Fri, 21 Sep 2012 13:46:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IMw8utt8P84+eyKuEq9LIrpJ0PA=; b=qYPRykTN9V0VSrfIph9A
	FRhVQCJNQB6jGS0ODPf+DqF+xufKTDHLTMDDjZyFNmycBXGtoiowXQp8LwavO2+U
	ZfU0/cfWkXzxn3vTkEQ5L+HZI7Wv2lLPb0v4XJBuhP/U6jwwhBtcdkrTNRsMTEoT
	cVvxdUcL9i3Utyr5D9fFpbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qjwl9UJQyW4Og2L9gtZPSmLcdvliId8hujDKkGjfm8JL61
	BRPxaM/21q9yOTE3atP7yV6KlyZD+gl0Hggn6zv2RwNFV9jBEK1sEMx3FfyKzP2q
	0mix02viNujO+C5vN8pXxsKi76B1thIoFQQhX6D43rxGnLL1NjYY3FVtYe85Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD149EC1;
	Fri, 21 Sep 2012 13:46:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EC879EC0; Fri, 21 Sep 2012
 13:46:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56ADAFDC-0414-11E2-A72B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206144>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>  - How does this interact with the wrapped output?  Should it?
>
> We have to deal with it anyway when the left aligned text takes all
> the space. On one hand, I don't want to break the terminal width,
> leading to ugly output, so it'll interact. On the other hand, I don't
> really wish to turn pretty format machinery into a full feature text
> layout engine (by ripping of links/lynx?). So we have a few options:
>
> 1. ellipses, line cutting means i18n issues ahead
> 2. just put the right-aligned text on another line. We do something
> similar in parse-options. When the option syntax is too long, we put
> help description on the next line.
> 3. bring in html/css box model for arranging text so that both
> left/right aligned texts can share the same line.
> 4. tell users upfront it's not supported. don't do that
>
> I'd vote 2, or 4.

I am fine with 4 personally.

>>  - I am wondering if somebody ever want to do this with a follow-up
>>    patch:
>>
>>         Left %h%|Center %cd%|Right %ad
>>
>>    Is %| a sensible choice for "flush right"?  I am wondering if it
>>    makes more sense to make %|, %< and %> as "multi-column
>>    introducer" (the example defines output with three columns) that
>>    also tells how text inside each column is flushed inside the
>>    column, e.g.
>>
>>         %>col 1 right flushed%|col 2 centered%< col 3 left flushed
>>
>>    or something like that (we may want explicit "column width"
>>    specifiers if we were to do this kind of thing).
>
> Yeah that crossed my mind. But I'll need to convince myself it's
> actually useful. Once you're on that road, you may want >=4 column
> tables. We can extend column.c to do that. That hard part is
> converting pretty format to use column functions.

Reading the above again, I realize that I may have sounded as if
saying "With 'flush to right', we are inviting wishes for 'left' and
'center', and a patch that only does 'right' is unacceptable.", but
that was not what I meant.  I am perfectly fine with 'flush to right'
without anything else as the first step.

The only concern I had was that somebody who later tries to add
'left', 'center', etc. to accompany the 'right' that you are adding
with your patch will find it unfortunate that the natural choice for
'center', i.e. %|, has been taken to mean a wrong thing and that
mistake cannot be corrected without breaking backward compatibility.
