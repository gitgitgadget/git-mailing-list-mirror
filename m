From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to update
 CE_NO_CHECKOUT bit
Date: Thu, 20 Nov 2008 14:16:58 -0800
Message-ID: <7vod0aqbz9.fsf@gitster.siamese.dyndns.org>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
 <1222833849-22129-5-git-send-email-pclouds@gmail.com>
 <1222833849-22129-6-git-send-email-pclouds@gmail.com>
 <20081118113316.GA18610@segfault.peff.net>
 <7vk5b0vp19.fsf@gitster.siamese.dyndns.org>
 <7v4p24tq59.fsf@gitster.siamese.dyndns.org>
 <20081119130223.GA27893@segfault.peff.net>
 <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3HsS-0002EN-0V
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 23:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbYKTWSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbYKTWSl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 17:18:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587AbYKTWSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 17:18:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4015A171D6;
	Thu, 20 Nov 2008 17:18:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CDD517087; Thu,
 20 Nov 2008 17:16:59 -0500 (EST)
In-Reply-To: <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu, 20 Nov 2008 22:26:48 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D604766-B751-11DD-8D50-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101474>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

>> Yes, I also dislike the subtlety, but my "obvious" idea was something
>>  like:
>>
>>   for i in 1 2 sub/1 sub/2; do
>>     touch $i
>>   done
>>
>>  which just seemed clunky. But:
>>
>>
>>  > -     touch 1 2 sub/1 sub/2 &&
>>  > +     touch ./1 ./2 sub/1 sub/2 &&
>>
>>
>> this is less clunky, and I have confirmed that it solves the problem. I
>>  just wasn't clever enough to think of it in the first place. ;)
>
> Thanks for catching. The last half also has the same problem. Another
> way is maybe just stay away for those numbers, naming the files by
> ... Just wonder if we could have some ways to automatically
> catch this kind of bug in the future.

A tool to do so essentially amounts to coming up with a set of POSIX
command line tools that know and flag all the known bugs broken platform
tools have, at the same time producing a reasonable end result so that it
can continue running and detecting more portability issues in the scripts.

Using dash as the shell helps to catch use of constructs outside POSIX,
running various GNU tools with POSIXLY_CORRECT=YesPlease may have similar
effects, but quirks specific to particular platforms like the above is
fundamentally hard to check.  Running autobuilder farms like Jeff does is
probably the best thing we can do.
