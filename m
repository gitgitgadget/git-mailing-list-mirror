From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, v2] tag: implement --[no-]strip option
Date: Mon, 14 Nov 2011 15:04:10 -0800
Message-ID: <7vehxai9w5.fsf@alter.siamese.dyndns.org>
References: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
 <7vipmmibx4.fsf@alter.siamese.dyndns.org>
 <20111114223903.GA5751@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Tue Nov 15 00:04:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5Zb-0000Ay-2k
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 00:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab1KNXEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 18:04:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab1KNXEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 18:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D11960A4;
	Mon, 14 Nov 2011 18:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/rNK0Ayv50xXjIOpVCL7/MM7OE=; b=Iv+cHa
	jHy1M2tJ5BGt02o6UPzwBhvxG7YU9caWx3zr5teBQBItyUz2+IZ54Sw8D8L+ezLd
	S0saM9jlJtjTijTXsPEtmSVJcBpFE+Ab/RXGUqc4RwryN3dmRF8ZqWertkd06Iwy
	LNgmiPiYykRVFEnl5n+OC+iuVGIMJrkA+lQVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYixoPX+OUvNd71D10b/6EpXVExG7cFp
	zXMuGYaI4CgiWzf2K16dU0omrx+JZhpaV9lUXOPsYrq3hR9nl1ud/asI8tdqMs/a
	s4wnzZKNHV3GPQoTUqPMqMbumrkh6Tu91dx3vE1Ul0lDrDAPlPHC3apWhcy26GLi
	c0IF12fIQik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3419F60A3;
	Mon, 14 Nov 2011 18:04:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEA4C60A0; Mon, 14 Nov 2011
 18:04:11 -0500 (EST)
In-Reply-To: <20111114223903.GA5751@shutemov.name> (Kirill A. Shutemov's
 message of "Tue, 15 Nov 2011 00:39:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F719E58A-0F14-11E1-A61B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185416>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

>> > @@ -356,7 +362,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>> >  
>> >  		if (!is_null_sha1(prev))
>> >  			write_tag_body(fd, prev);
>> > -		else
>> > +		else if (opt->strip)
>> >  			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
>> 
>> Why are you not writing template when no strip is done? (Not an objection
>> disguised as a rhetorical question, but a question).
>> 
>> The user who typed "tag -a v1.2.3 HEAD" that spawns an editor would still
>> find it useful to have commented instructions, once we start filling the
>> template with more useful information that is customized for the
>> situation (e.g. "git show -s --oneline" output), no?
>
> Yes. But in this case commented instructions will not be stripped and they
> will go to the message. I think user will be confused.
>
> We can show show some instructions before spawning the editor. What do
> you think?

My knee-jerk reaction is that it would be worse than what your patch
does. I'd say we'd start from your patch and see how users of 'next'
reacts while the topic is cooking.
