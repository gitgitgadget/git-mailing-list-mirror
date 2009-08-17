From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 22:17:30 -0700
Message-ID: <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
 <7vy6pj449g.fsf@alter.siamese.dyndns.org>
 <86iqgn8brv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Mon Aug 17 07:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McubK-0006PM-RR
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 07:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbZHQFRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 01:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbZHQFRi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 01:17:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQFRi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 01:17:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3420F2BDAF;
	Mon, 17 Aug 2009 01:17:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E197E2BDAD; Mon, 17 Aug 2009
 01:17:31 -0400 (EDT)
In-Reply-To: <86iqgn8brv.fsf@blue.stonehenge.com> (Randal L. Schwartz's
 message of "Sun\, 16 Aug 2009 18\:33\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 470D6976-8AED-11DE-9E58-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126117>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> % rm -rf /opt/git/share/man
> % make prefix=/opt/git quick-install-man
> make -C Documentation quick-install-man
>     SUBDIR ../
> make[2]: `GIT-VERSION-FILE' is up to date.
> '/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
> % make prefix=/opt/git quick-install-man
> make -C Documentation quick-install-man
>     SUBDIR ../
> make[2]: `GIT-VERSION-FILE' is up to date.
> '/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-add.1 (File exists)
> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-am.1 (File exists)
> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-annotate.1 (File exists)
> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-apply.1 (File exists)
> [...]
>
> So it fails the second time.  This is new behavior.

Interesting, and this does not reproduce for me.  

I've tried "run twice back to back" like you did above, "run once, then
'find -type f -print | xargs touch' the target, and then run again", and also
"run once, then 'find -type f -print | xargs chmod -w' the target, and then run again".

None of these fail.

One way I can think of to break it deliberately would be:

	make prefix=/var/tmp/gomikuzu quick-install-man
        find /var/tmp/gomikuzu -type d | xargs chmod -w
	make prefix=/var/tmp/gomikuzu quick-install-man

But then the failure is different from what you showed above:

    error: unable to unlink old '/var/tmp/gomikuzu/share/...' (Permission denied)

Puzzled.
