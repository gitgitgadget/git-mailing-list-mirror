From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sun, 04 Jan 2009 13:25:50 -0800
Message-ID: <7v8wpqu5k1.fsf@gitster.siamese.dyndns.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
 <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
 <7vvdsv3af6.fsf@gitster.siamese.dyndns.org>
 <9b18b3110901040341n5ff5fa09s878228131d11d2a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matt Kraai" <kraai@ftbfs.org>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 22:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJaVX-0001jW-8F
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 22:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbZADVZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbZADVZ6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 16:25:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZADVZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 16:25:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDCD78DDA3;
	Sun,  4 Jan 2009 16:25:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9BE08DDA2; Sun,
  4 Jan 2009 16:25:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45924CD0-DAA6-11DD-B40A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104540>

demerphq <demerphq@gmail.com> writes:

> Is it really deep perl magic to do:
>
>   return $val eq 'true';
>
> instead of
>
>   return $val eq 'true' ? 1 : 0;

No, neither are magicky.  But your argument to favor the former over the
latter that goes down to XS level was all about deep magic, and you wrote
yourself:

> ... It is not a good idea to use 0 as a replacement for perls false, as
> the two have different behaviour.

My point is that any caller that cares about the differences of "Perl's
true false" and 0 when talking about a function that returns a yes/no
value is already soaked too deep in Perl's deep magic.  I would want the
code to be maintainable by people who does not care the deep voodoo, and
for that reason, I do not want the callers to care.

Having said that, I think it is perfectly fine to favor returning "$val eq
'true'" over returning "$val eq 'true ? 1 : 0".  But that is not because
it is truer way to say false from Perl experts' point of view, but because
it is shorter and more to the point.
