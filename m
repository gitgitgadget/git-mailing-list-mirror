From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make $prevent_xss protection for 'blob_plain'
 more usable
Date: Mon, 13 Jun 2011 16:12:09 -0700
Message-ID: <7vy615mily.fsf@alter.siamese.dyndns.org>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
 <201106101401.19108.jnareb@gmail.com>
 <7v8vt5ptj4.fsf@alter.siamese.dyndns.org>
 <201106132350.00161.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matt McCutchen <matt@mattmccutchen.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 01:12:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWGJ5-0005gW-6J
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 01:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab1FMXMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 19:12:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab1FMXMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 19:12:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B1325C1C;
	Mon, 13 Jun 2011 19:14:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1YXz6AwnGVfc9fjzIFXhmH+PrYo=; b=fYSFZh
	j47VMycVRkoOQpD88H293uZn7K/gjI9A4dQVXJ0FzOhZptOxK3DnRv7rFcFq2vy+
	cKDyXg+AouvXS6sRPMi9XXjO/7Zg1vx4a+0CRLXh29cUM7EKx2CwymsVaZNwTJGq
	KV4g7GM3b3RzvtJox/a7QjRpvSJfmX0bi0oho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DFMFhBKDH1nVrRf4rf6ENygG/6lQOnit
	o19ARvNbO25qNGvcSpRvoNfV7puiNC+6o4rXS6N3/mRYt3VmKpApAgNDXHzruapH
	wdtz+URtDrlm0dpqBbOdACQ1yhGtQieMXATq4oTnY3u0l9bBB+Jej06SABDszKHh
	WGhZuWPnmHY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A3785C1B;
	Mon, 13 Jun 2011 19:14:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B980F5C1A; Mon, 13 Jun 2011
 19:14:20 -0400 (EDT)
In-Reply-To: <201106132350.00161.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 13 Jun 2011 23:49:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1A1D800-9612-11E0-8968-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175737>

Jakub Narebski <jnareb@gmail.com> writes:

>> Hmph, wouldn't it be more straightforward if you dropped the statement
>> modifier?  I.e.
>> 
>> 	my ($subtype, $rest) = ($1, $2);
>> 	$rest = '' unless defined $rest;
>> 	$type = "text/plain$rest";
>
> Yes, of course.
>
> I don't know why I decided that avoiding rewriting 'text/plain; 
> charset=utf-8' case was important.

Just to make sure I understand what you are saying...

    my $type = 'text/plain; charset=utf-8';
    if ($type =~ m|^text/([a-z]+)\b(.*)$|) {
 	my ($subtype, $rest) = ($1, $2);
 	$rest = '' unless defined $rest;
 	$type = "text/plain$rest";
        print "Type is now <$type>\n";
    }


does yield "text/plain; charset=utf-8". It does rewrite but rewrite to
exactly the same thing, so...
