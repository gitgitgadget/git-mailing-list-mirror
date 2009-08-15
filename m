From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Fri, 14 Aug 2009 19:01:41 -0700
Message-ID: <7veird4yyi.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <m3skfwnihn.fsf@localhost.localdomain>
 <fcaeb9bf0908130538x396b1208s43d312107e3e198c@mail.gmail.com>
 <200908142223.07994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 04:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc8c4-0003vk-RW
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 04:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbZHOCBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 22:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756324AbZHOCBu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 22:01:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbZHOCBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 22:01:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0CCB29A6F;
	Fri, 14 Aug 2009 22:01:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 117B429A6B; Fri, 14 Aug 2009
 22:01:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97977648-893F-11DE-9BDD-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125977>

Jakub Narebski <jnareb@gmail.com> writes:

>>> Hmmm... this looks like either argument for introducing --full option
>>>  to git-checkout (ignore CE_VALID bit, checkout everything, and clean
>>>  CE_VALID (?))...
>>>
>>>  ...or for going with _separate_ bit for partial checkout, like in the
>>>  very first version of this series, which otherwise functions like
>>>  CE_VALID, or is just used to mark that CE_VALID was set using sparse.

How would a separate bit help?  Just like you need to clear CE_VALID bit
to revert the index into a normal (or "non sparse") state somehow, you
would need to have a way to clear that separate bit anyway.

A separate bit would help only if you want to handle assume-unchanged and
sparse checkout independently. But my impression was that the recent lstat
reduction effort addressed the issue assume-unchanged were invented to
work around in the first place.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/123218/focus=123252

There is no reason to use assume-unchanged to tell git not to lstat to see
if a path is up-to-date by promising that you are not going to touch it
after you checked it out.

So I do not understand why you would want a separate bit, nor why you
think a separate bit would help when changing the index state from sparse
to non-sparse (or vice versa).
