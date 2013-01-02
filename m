From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Better Error Handling for add
Date: Tue, 01 Jan 2013 18:21:57 -0800
Message-ID: <7vobh85np6.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-4-git-send-email-greened@obbligato.org>
 <7v1ue4a8i0.fsf@alter.siamese.dyndns.org>
 <87obh8fs8e.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jan 02 03:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqDyG-0000he-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 03:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab3ABCWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 21:22:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab3ABCWA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 21:22:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0F3CABCA;
	Tue,  1 Jan 2013 21:21:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xhd/ZodFSOCExRiShjtC1i8SlLY=; b=EoS//h
	guHnn/iYTR80CZACasl9If0+1QIXRadH5ivdnW7usXYIkedeYGF+Yz5qvgKMHxal
	ZDvC6Mwu5piC+k6eWzdxce3vJcB7ruvzWkMe6zVWvZxmyUgtTiIi48fIiWGB111d
	uqvWlQ23cuPJZ1Zdstv2pmgd+rtwUgdmtcHlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SRgtxGgMLrLecTceDww0Dd6wV8WfOxZW
	vV2LDgAMeqkNA4ScBhjJyPXBN0W0fshtRdZWwz+37hJEn3nKoK/rzQb1AXGWbJGK
	ojjX/oZO/TTkJZJbeTp8JiFm1BKSEVor/WkP/vxp0QDOf59HBSAW9jfqSQT+TT/d
	kWVt6OTFlnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C238DABC9;
	Tue,  1 Jan 2013 21:21:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DC7CABC8; Tue,  1 Jan 2013
 21:21:59 -0500 (EST)
In-Reply-To: <87obh8fs8e.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 01 Jan 2013 16:33:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FB87D84-5483-11E2-B749-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212487>

greened@obbligato.org writes:

>> If you want to make sure you give a comit to add_commit, you can
>> probably say something like this:
>>
>> 	git rev-parse -q --verify "$1^{commit}" >/dev/null ||
>>         die "'$1' does not refer to a commit"
>
> What does $1^{commit} mean?

"$thing^{type}" tells Git to interpret the $thing as that type (and
error out if it can't).

So v1.0.0^{commit} is a less cryptic way to say v1.0.0^0 (there is
no need to say "zeroth parent of a commit is the commit itself?
Yeah, it makes sort of sense" when you learn it).

"git cat-file -t junio-gpg-pub^{blob}" will say "blob", but you will
get a failure from "git rev-parse v1.0.0^{blob}" as you can only
dereference a tag that refers to a commit down to the comit and then
to its top-level tree, but not to a single blob.

And you can ask for the tree object with v1.0.0^{tree}, for example.

        
