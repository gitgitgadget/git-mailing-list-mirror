From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/maint-merge-rename-create
Date: Mon, 20 Jun 2011 09:08:57 -0700
Message-ID: <7voc1scwo6.fsf@alter.siamese.dyndns.org>
References: <BANLkTimkm4SU8nML_6Q7Q34faBziJ=gheA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 18:09:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYh2B-0005SC-Sh
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 18:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab1FTQJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 12:09:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1FTQJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 12:09:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F83B58E7;
	Mon, 20 Jun 2011 12:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9cX+VL0aH944Hwm3SkTwFmVDcks=; b=RAUzBj
	gcQLIRc+UuT9K/klLRuVIHkqzn8wexq5KhuzkKzBiTz2HiO+M4Lc0idYNP7ZX64k
	wNn36BdKz4tvLu4QBsbQS8u74ZFE662e/rQLbXNN8MOHnZxw16I+pdYmr7AgMt7f
	f+nn+8MUUUCZrshT8dJe0Bw/sNlLB2YAHNsF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=THgJyPFv4Xo/ByX0HH87T4xt6ILcdc77
	w4M7CSdmsHsVLMWcmSuF1WWvS10FJQEdzQoJyYZjeaQznq/rDyFSt30JUbNucfLX
	boYZiayJGrnVB5jw+XEvWOwNw1xgY+te5BrBM3nDYkKGbIh2z+0Efjn92PUm7Pg5
	LjOD2GfOtCw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CDDD58E6;
	Mon, 20 Jun 2011 12:11:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68AC558E3; Mon, 20 Jun 2011
 12:11:10 -0400 (EDT)
In-Reply-To: <BANLkTimkm4SU8nML_6Q7Q34faBziJ=gheA@mail.gmail.com> (Elijah
 Newren's message of "Sat, 18 Jun 2011 15:49:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9941EC0-9B57-11E0-B8E4-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176078>

Elijah Newren <newren@gmail.com> writes:

> --- Why doesn't break detection work as I expect? ---
> $ git init -q
> $ printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >a
> $ printf "a\nb\nc\nd\ne\nf\ng\nh\ni\nj\n" >b

Use something non-trivial.  Taking a real-life file COPYING from our
source set, I can do this:

	$ git init
	$ cp $git_src/COPYING a
        $ tr 'A-Za-z' 'N-ZA-Mn-za-m' <a >b
	$ git add a b
        $ git commit -m ab
        $ git mv a c; git mv b a; git mv c a
        $ git diff --stat -M -B HEAD
         b => a | 0
         a => c | 0
         2 files changed, 0 insertions(+), 0 deletions(-)
