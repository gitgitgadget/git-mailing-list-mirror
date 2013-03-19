From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Improve git-status --ignored
Date: Tue, 19 Mar 2013 07:48:57 -0700
Message-ID: <7vehfbla1y.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com>
 <7vsj3skp5b.fsf@alter.siamese.dyndns.org>
 <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxr0-0008Hh-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab3CSOtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:49:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320Ab3CSOtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:49:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C0DAD8D;
	Tue, 19 Mar 2013 10:48:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uV9ebd7UZdQaQSWsiAU5IpLeXkQ=; b=LOdPj0
	R+oIGnqXTa3thPhczyM66QDN6MfobZqXcsaIebY1NlT9LoY2tQZuhi427UCKDeEa
	Pr+uzuS6b/1vpPjIB/gEQC85oxhJR76d1ZGRWrE7wEZUa7I+eo+xeBPOeCb++Cyd
	uKhaII/hIpizofOFFoPkP8Cg45JL2vBBD1Nyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OBfaXHv32feIBgQ80zhJE48NaBcIZW70
	w3/GK5j7mpFNeIBIPxKcT5PIEm+IePeAFl4X2zu0Psk4xYyZri9XbO4OOd13ZpLk
	20C/haqcW4qFKE0MP0sGU2psPIvYSQEyVnHxBkPuXDzApmw+9IYxa+OKeDZONhoR
	cBjw2qryXqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B600CAD8C;
	Tue, 19 Mar 2013 10:48:59 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37398AD8B; Tue, 19 Mar 2013
 10:48:59 -0400 (EDT)
In-Reply-To: <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 19 Mar 2013 12:20:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21E70790-90A4-11E2-A1F3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218518>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 19, 2013 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> This patch series addresses several bugs and performance issues in
>>> .gitignore processing that came up in the inotify discussion.
>>
>> Thanks.
>>
>> How does this interact with the nd/read-directory-recursive-optim
>> topic that has been cooking for a while?
>
> I think 8/8 is another version of nd/read-directory-recursive-optim

Yeah, it seems so; even though the series is much larger, overall it
looks to me a cleaner solution without a specific special case.

Would we we better off kicking nd/read-directory-recursive-optim
back to 'pu' (and eventually ejecting it) and replacing it with a
reroll of Karsten's series when it comes, perhaps?
