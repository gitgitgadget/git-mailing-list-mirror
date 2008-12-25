From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 10:50:37 -0800
Message-ID: <7vvdt884xu.fsf@gitster.siamese.dyndns.org>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
 <20081225100033.GA8451@b2j> <7v3agca7fp.fsf@gitster.siamese.dyndns.org>
 <20081225102527.GB8451@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 19:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFvJT-0004K2-PI
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 19:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYLYSuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 13:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbYLYSuo
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 13:50:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYLYSun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 13:50:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B4B821B11C;
	Thu, 25 Dec 2008 13:50:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9A93E1B11A; Thu,
 25 Dec 2008 13:50:39 -0500 (EST)
In-Reply-To: <20081225102527.GB8451@b2j> (bill lam's message of "Thu, 25 Dec
 2008 18:25:27 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE707DE4-D2B4-11DD-80B5-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103907>

bill lam <cbill.lam@gmail.com> writes:

>> Why are you building with NO_UINTMAX_T to begin with?  Isn't ubuntu 8.10 a
>> recent enough platform that ships with modern enough header files that
>> define ANSI uintmax_t type?
>
> No, I did not do anything on that, 
>
> make clean
> ./configure --prefix=/usr
> make 

I do not use configure myself (use of configure is entirely optional, and
it is not tested often and core developers do not touch that part very
much --- in a sense, use of autoconf is a second-class citizen in our
build process); it is plausible that it has broken checks for detecting
the need of NO_UINTMAX_T.

Relevant part of configure.ac reads like this:

    # Define NO_UINTMAX_T if your platform does not have uintmax_t
    AC_CHECK_TYPE(uintmax_t,
    [NO_UINTMAX_T=],
    [NO_UINTMAX_T=YesPlease],[
    #include <inttypes.h>
    ])
    AC_SUBST(NO_UINTMAX_T)

and I do not see anything suspicious there...

Running "./configure --verbose" might leave some clues in config.log; for
me on my primary development box (Debian on x86_64), the relevant part
passes the test (iow, inclusion of inttypes.h does give a working
uintmax_t type) like this:

    configure:5709: checking for uintmax_t
    configure:5742: cc -c -g -O2  conftest.c >&5
    configure:5748: $? = 0
    configure:5763: result: yes
