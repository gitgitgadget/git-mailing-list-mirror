From: Junio C Hamano <gitster@pobox.com>
Subject: Did we break receive-pack recently?
Date: Sat, 04 Aug 2012 18:55:23 -0700
Message-ID: <7vk3xe6r1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 03:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxq4V-0000i5-HG
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 03:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab2HEBz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 21:55:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009Ab2HEBz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 21:55:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D409864;
	Sat,  4 Aug 2012 21:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	3XipsTxcdX61y6OjBrqIfygFG4=; b=VMwzFM3YMSVkyWKRqMW+chGNRF7pLfxAM
	xoO3gmcgTSCep0f4vII0OR9Ricz6KYF5KSSMnomLZawXgKuWoaqtPL0Tc7F7nPaT
	7iT68axHJc4j7DZ0+M5PmmaU8xkYltOfDZd+CjDtMUHay1i8nm3T4j3fGXU+dzrX
	ysI6TU0W8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Gl3
	TGfsHgGkvrHJlLKMKnBHNKCAW5/h2TjSQbbpCiPk/jYM0YgcXkL8U4NfmE8VfNL9
	e3HLg2uDYJVlDrKUSB9b6q9ucewvLvMXRnLOeGa9Wd1+mKp++N9Yv3cHtbNwohhB
	FJ+4ccf1XJ1AgyyfPmFTLfJ0WD6/YDkpmovcjlUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E59919863;
	Sat,  4 Aug 2012 21:55:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6403D9862; Sat,  4 Aug 2012
 21:55:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FC0BE38-DEA0-11E1-B070-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202901>

I just saw this:

    $ git push ko
    ko: Counting objects: 332, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (110/110), done.
    Writing objects: 100% (130/130), 32.27 KiB, done.
    Total 130 (delta 106), reused 21 (delta 20)
    Auto packing the repository for optimum performance.
    fatal: protocol error: bad line length character: Remo
    error: error in sideband demultiplexer
    To ra.kernel.org:/pub/scm/git/git.git
    ...

What is unusual with this push is that it happened to trigger the
auto-gc on the receiving end and the message "Auto packing the
repository..." came back to the pusher just fine, but somebody
nearby seem to have tried to say "Remo"(te---probably) without
properly using the sideband.

Does this ring a bell to anybody?
