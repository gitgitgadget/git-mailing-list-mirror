From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-p4: Test changelists touching two branches
Date: Thu, 24 May 2012 17:02:16 -0700
Message-ID: <7vmx4xunzr.fsf@alter.siamese.dyndns.org>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
 <1337729891-27648-2-git-send-email-vitor.hda@gmail.com>
 <20120524010805.GA26443@padd.com>
 <CAOpHH-U+cG2DvTtWD25JNgLYKrNcwXgqysA0G-wr5DFhLG-DAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 02:02:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhz7-00053G-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564Ab2EYACU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:02:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757841Ab2EYACT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:02:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE790846E;
	Thu, 24 May 2012 20:02:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mdHnXjq6F61y2DR0bpu+N5BRcHI=; b=ggtVgC
	Mej4k6biki06D54qOdjOVX347IotI8cMot6f8ojJcOPY5kALRNWtfABJiHQLvUms
	UFYjuwJ4DLJwXvN5OoIxl+JV3NXGsfR8HSWOPoYlFEIMicml5/mw8yhZ+abbLMA4
	f37P1pka1A44OUlxpY1OZwGZIM4loDPfL7vb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FcPAl1YWVLy8gucit5lsGB0Ynqgcbi4R
	MZWhpP4rWwYUJpAqsVrwlJGrzCW+x356Nu4vnZhzCI22D8/Y/QZpkgsCsPlTBs6L
	DCzYBa+8yX83tWW/73dReElhH6BqePgj2oTXnYSe0i2RNtiCIYsI+WaTCvOnYoSF
	iEg4VFhmE7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5340846B;
	Thu, 24 May 2012 20:02:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84510846A; Thu, 24 May 2012
 20:02:17 -0400 (EDT)
In-Reply-To: <CAOpHH-U+cG2DvTtWD25JNgLYKrNcwXgqysA0G-wr5DFhLG-DAg@mail.gmail.com> (Vitor
 Antunes's message of "Thu, 24 May 2012 23:42:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E420D14E-A5FC-11E1-B09F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198451>

Vitor Antunes <vitor.hda@gmail.com> writes:

> What about the parentheses in the next line, is it necessary? Or can I
> simply remove that pair of parentheses and unindent the code in
> between?
>
>> ...
>>> +     (
>>> +             cd "$cli" &&
>>> +             p4 integrate //depot/branch3/file3 //depot/branch4/file3 &&
>>> +             p4 delete //depot/branch3/file3 &&
>>> +             p4 submit -d "Move branch3/file3 to branch4/file3"
>>> +     )
>>> +'

If you mean this part, the parentheses to throw you into a subprocess are
required.  Otherwise, a failure in any of these three p4 commands will
leave you in $cli directory, causing the next test to start in a directory
that it does not expect.
