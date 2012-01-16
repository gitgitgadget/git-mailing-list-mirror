From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Mon, 16 Jan 2012 14:47:39 -0800
Message-ID: <7vsjjfuuwk.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjjhwvdy.fsf@alter.siamese.dyndns.org> <vpqhazv3m17.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvL9-0004Ct-KK
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050Ab2APWrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:47:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab2APWrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 17:47:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 985807B99;
	Mon, 16 Jan 2012 17:47:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=exNzhdNKaiKytWybCrBYZljM8Jg=; b=MfUVoV
	vddfBwUw69S+fHbMKR84V/1uuLF72Mh5tF1joYJ20IGP4xgrMjcHkPWyC4M3Yfld
	MycxRIfhKjDJfjOuHxM/9bnLLi1LRzoGRimFafx2iWjsgPKKmZGXd92fzMBuO9+F
	sgxujJyLLXesN6NC2A4dh6rABcT5f4TmXEoX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=amM5nubNKXVMZtgkzi0IcCmTeXnIqvwN
	UwWAhA19hnxMBV98zHW5tal830r7bdP33adpWiSNjL6OE6ePnL8obb8JH/mRLWTG
	ejbz2DLi5BfmUn+UUCJzlGdI7/Whx6GrrSwje/f9HlOZE5skxksk2tCZvexWv814
	RC1bk3JcXWo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1007B97;
	Mon, 16 Jan 2012 17:47:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFFD67B96; Mon, 16 Jan 2012
 17:47:40 -0500 (EST)
In-Reply-To: <vpqhazv3m17.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 16 Jan 2012 12:49:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 188695E6-4094-11E1-BB9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188662>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> but is that the right thing to do if suffix came from "$4"?
>>
>> As far as I can see, "$4" is used to append "." in very limited cases, and
>> nobody explicitly passes SP as "$4" when calling this, so it may be easier
>> to read if you moved this before that "if we have 3 or more args, use the
>> fourth one as the suffix" block, i.e. something like this?
>
> Why not, but in case someone explicitely passes " " as $4 in the future,
> it's likely to be better to strip it for the same reason we strip it here.

I doubt that would be sufficent or appropriate. If some caller _WANTS_ to
add a SP, shouldn't we be devising a way to tell zsh to add it without
quoting, instead of silently stripping?

> I don't care much either way in this case.
>
>> +	# Because we use '-o nospace' under bash, we need to compensate
>> +	# for it by appending SP after completed word ourselves.
>> +	local suffix="${BASH_VERSION+ }"
>
> Not sure why you reworded the comment, but I don't think it's a good
> idea to remove the "ZSH would quote the trailing space added with -S"
> that I had added, because this is really the reason we do a special case
> here. Your version is misleading, because we use -o nospace for ZSH too.

Ok, use of "-o nospace" in Zsh is what I missed. I thought the issue was
about the nospace emulation.

So does that mean we would be forcing zsh users to add SP themselves?  I
wonder if we can do better than that.
