From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Fri, 15 Jan 2016 09:24:49 -0800
Message-ID: <xmqqa8o6kb6m.fsf@gitster.mtv.corp.google.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<20160115103402.GC21205@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:24:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK87M-0003hR-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbcAORYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:24:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751978AbcAORYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:24:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94BBA392F1;
	Fri, 15 Jan 2016 12:24:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svebXj1kv9DnLBZJjLVEBUII21U=; b=DJDJ6z
	dkcMh6TN+68LWi0vSxar7Exh9KrK9HCQ6sl9++ebHuL4WL+mBB9o1Ixq06TXlURa
	Q5SEAXTFoNXRy4qoh2BlDATgfQoIIlcpD/YmJ8H3gBovK9cQf3BDQRftm+LClXG0
	Ve96/mxQN9Zfb4hADJ3EG4qQtU8hFFvSePUXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0cCuN5GTMloDACGnydyxEGBOkeeWMos
	2EbDMpm0aWjPPDbihY359rrcNtLYiqIztczicOPQttLU9k7iT/HhIBKlljeeAY5E
	J2sKgOFuHqYnv/x47qcYpX8+AYINBGoCf30wYfMjFmGYMcYsgezVqqSSkfx4skS4
	M9crjVZJOq8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B82A392F0;
	Fri, 15 Jan 2016 12:24:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C8FA392EF;
	Fri, 15 Jan 2016 12:24:50 -0500 (EST)
In-Reply-To: <20160115103402.GC21205@distanz.ch> (Tobias Klauser's message of
	"Fri, 15 Jan 2016 11:34:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E254BFC8-BBAC-11E5-ADF5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284187>

Tobias Klauser <tklauser@distanz.ch> writes:

>> > +test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original file on error" '
>> > +	cat basic_message >message &&
>> > +	chmod -r message &&
>> > +	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
>> > +	chmod +r message &&
>> > +	test_cmp message basic_message
>> > +'
>> 
>> If for some reason interpret-trailers fails to fail, this would
>> leave an unreadable 'message' in the trash directory.  Maybe no
>> other tests that come after this one want to be able to read the
>> contents of the file right now, but this is an accident waiting to
>> happen:
>> 
>> 	cat basic_message >message &&
>> +       test_when_finished "chmod +r message" &&
>>         chmod -r message &&
>>         test_must_fail ... &&
>> 	chmod +r message &&
>>         test_cmp ...
>
> Indeed, I forgot about this. I saw you already folded in the missing
> 'chmod +r message' in your tree. Thanks for that!

I did no such thing, though.
