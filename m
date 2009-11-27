From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] status -s: obey color.status
Date: Thu, 26 Nov 2009 21:15:03 -0800
Message-ID: <7vws1cwnu0.fsf@alter.siamese.dyndns.org>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
 <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 06:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDtBB-00054f-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 06:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbZK0FPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 00:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbZK0FPI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 00:15:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZK0FPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 00:15:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2F6CA18B0;
	Fri, 27 Nov 2009 00:15:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SNsqK1I6MJVcCBQRrcNjZ7jHa6s=; b=vQUi/r
	0wSudoDWv2tnnsJ8arGQQPBGzKf9z+asZRwRWbQWgc+cN6/IaIAJVVpfIKev/cnn
	ePUBeHVqEkp+UU2xTA+S4ByWmxFBGOYwEo0j7FFDa634r1HnRb3DoE41QwCU2GDN
	5M9lfiN3cF5K+u0fBWeMu6a/WxTDakxRS5dCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhbRqOosBDEn1M/p/GeitJo5cdFOjeuj
	hURsdiipbl3Gspi/hC31z4JyTWf+PHSl836TLnP0KKlNHFvlMPi3Y8C1QbAx+rRH
	DCvil7KTrOS3b5H53jfdzETaU8wS3hl+e82veKNsYaZU3NdsP7YW6LxT/D59xwxa
	Os5HuB1sN9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92295A18AF;
	Fri, 27 Nov 2009 00:15:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A60EA18A6; Fri, 27 Nov 2009
 00:15:05 -0500 (EST)
In-Reply-To: <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 26 Nov 2009 16\:24\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D534A3F6-DB13-11DE-A90B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133857>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> * Should I rename wt-status.c's color() into something more unique when
>   I export it?

Is it an option to instead move short_unmerged(), short_status() and
friends to wt-status.c from builtin-commit.c?  It's been quite a while
since I worked on the code, so I don't recall why it needs such cross
references at low level between two files.

> * Is there any policy regarding use of putchar/puts vs. printf?

J6t addressed it.  You have mixture of putchar(' ') and printf(" ") which
looks somewhat funny ;-)

> * The way it is done now I "color" a space, otherwise one would need to
>   break down the print statements even more. Since we always color the
>   foreground only it is no problem, is it?

Some people do configure to use "reverse".  For example, I have:

    [diff.color]
            old = red reverse
            whitespace = blue reverse

    [status.color]
            updated = green
            changed = red
            untracked = blue reverse

The output should be consistent between long and short format (I do not
offhand recall what we do for the long format, though).
