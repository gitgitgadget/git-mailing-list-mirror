From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 14:37:44 -0800
Message-ID: <7veixkrfif.fsf@gitster.siamese.dyndns.org>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
 <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcosu-0005qn-V1
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbZBZWhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbZBZWhx
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:37:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZBZWhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:37:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D38069DA42;
	Thu, 26 Feb 2009 17:37:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7501A9DA41; Thu,
 26 Feb 2009 17:37:46 -0500 (EST)
In-Reply-To: <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
 (Jay Soffian's message of "Thu, 26 Feb 2009 17:19:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1973FC5A-0456-11DE-8ED0-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111605>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Thu, Feb 26, 2009 at 4:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> So perhaps define a variable:
>>
>> good="\"\(PUT\|MOVE\) .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*" 20[0-9]\""
>>
>> and grep for it?
>
> Hmpfh. According to my re_format man page:
>
> Obsolete (``basic'') regular expressions differ in several respects.
> `|' is an ordinary character and there is no equivalent for its
> functionality.

Ahh, you are right; there is no '|'-alternation in BRE.

We of course could do something like:

    good=" .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*" 20[0-9]\""
    grep -e "\"PUT $good" -e "\"MOVE $good"

But that's too ugly.

I don't mind Perl as we already depend on it; the looseness of the regexp
stil bothers me somewhat, though...
