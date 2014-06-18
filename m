From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Wed, 18 Jun 2014 10:51:04 -0700
Message-ID: <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 19:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxK1F-0004lE-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbaFRRvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:51:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52034 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbaFRRvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:51:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 651291E9A3;
	Wed, 18 Jun 2014 13:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3I7qCXkwVw4jNCGQ7xcRAH+jwY8=; b=JstprD
	cNPdStyPYIMYNLRZ3yHMKfE3O7LChL4rIzplDPcDeqnyr0cLiWaa8sZfiufWjotH
	ggMHNyqPVxoNQ/NwFVQ1xPdm/Msor3+hCRtmunviBHUfe9nyY6H+KohvsLVlOidE
	CmbW8n7kAf79gsFa3QyMpCdHCb3LDb6xT5lP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yKP5swS9mEZ55WZF5tfz1oFwjKe9+pc/
	Sg5iN1fIVpYxETYBsRQqMHDYCora56R15KQ5thgi4awr0spQn4qkPLE3YtfEHb3e
	7H3+AkGftHJ9brpO0EQgFYzejac/8wozv8ZUnqoS38bV2uGc0inFQ2Q3iVfU4Bhh
	srnkdv3GiMI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF2E71E9A1;
	Wed, 18 Jun 2014 13:51:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A36B21E99E;
	Wed, 18 Jun 2014 13:51:03 -0400 (EDT)
In-Reply-To: <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	(Junio C. Hamano's message of "Tue, 17 Jun 2014 23:49:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1DBF1CE6-F711-11E3-AC34-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252017>

Junio C Hamano <gitster@pobox.com> writes:

> On Tue, Jun 17, 2014 at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> OK, after looking into this for a while, I realize
>> this is a special property of the Signed-off-by footer.
>> For now I think it's reasonable to just avoid de-duplicating
>> other footers if any. Agree?
>
> Not really. I'd rather see "git am" hardcode as little such policy as possible.
> We do need to support S-o-b footer and the policy we defined for it long time
> ago, if only for backward compatiblity, but for any other footers,
> policy decision
> such as "dedup by default" isn't something "am" should know about.

By the way, "append without looking for dups" is a policy decision
that is as bad to have as "append with dedup".

I'd rather not to see "am.signoff", or any name that implies what
the "-s" option to the command is about for that matter, to be used
in futzing with the trailers other than S-o-b in any way.  As I
understand it, our longer term goal is to defer that task, including
the user-programmable policy decisions, to something like the
'trailer' Christian started.

I suspect that it may add unnecessary work later if we overloaded
"signoff" with a similar feature with the change under discussion.
I would feel safer to see it outlined how we envision to transition
to a more generic 'trailer' solution later if we were to enhance
"am" with "am.signoff" now.

Thanks.
