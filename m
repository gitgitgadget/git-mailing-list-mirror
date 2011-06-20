From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/20] transport-helper: use the new done feature
 where possible
Date: Mon, 20 Jun 2011 12:51:47 -0700
Message-ID: <7vzklcb7sc.fsf@alter.siamese.dyndns.org>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-16-git-send-email-srabbelier@gmail.com>
 <20110620114556.GA29818@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar@elie.pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 21:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYkVo-0006WY-3c
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 21:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab1FTTvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 15:51:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab1FTTvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 15:51:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02593552B;
	Mon, 20 Jun 2011 15:54:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYHWLnIi3BxKyRkT4JVeHHVdU8o=; b=qxYmZg
	2TBt9zxk5tcmjnhGKhOeVL4GRXajxu9Kb2q9D68IlWzxBw39lyEXMlYCXj2XW643
	IdNs4ehK7LNnZk2onzVxRjnnhJry1J97HJnck5k0WvzgoZrLcHkn3MSgY+LmCeDH
	V3yl4yh1ZPOWHt2rILrIjL75UJA2qrSj4tkRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BbZHf4dFE2n0WkZF0OgZ5N3JSukzab+H
	rciZKRyEKwo3Tp38ZMZN7fywnhGse94gTMziiv2QB0wimYExi7IRXleyUcSsKhxe
	k1H5QgG7eGVcGUBNUdxQzsc4aC2885/Sha0kL5BKI8vT04Gy/HsvO1/V2lNqc9FY
	eULPj0oBrfo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED4B1552A;
	Mon, 20 Jun 2011 15:53:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 427F15529; Mon, 20 Jun 2011
 15:53:59 -0400 (EDT)
In-Reply-To: <20110620114556.GA29818@elie> (Jonathan Nieder's message of
 "Mon, 20 Jun 2011 06:45:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A0D4CDE-9B77-11E0-8620-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176089>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -412,11 +413,8 @@ static int fetch_with_import(struct transport *transport,
>>  		sendline(data, &buf);
>>  		strbuf_reset(&buf);
>>  	}
>> -	if (disconnect_helper(transport))
>> -		die("Error while disconnecting helper");
>>  	if (finish_command(&fastimport))
>>  		die("Error while running fast-import");
>> -
>
> What is this change about?  Is the plan to allow other commands after
> a fetch_with_import?  Sounds reasonable; I think it should be
> advertised in the log message, though.
>
> When does the disconnect_helper call happen (to avoid leaks)?  Ah, in
> release_helper; phew.
>
> The disconnect_helper call writes the blank line that terminates the
> list of "import %s" commands to start the import, so there would need
> to be a
>
> 	strbuf_reset(&buf);
> 	strbuf_addf(&buf, "\n");
> 	sendline(data, &buf);
>
> in its place.

All sensible suggestions for a potential reroll.
