From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [TOY PATCH]: rebase: Add --show-files option
Date: Fri, 03 Oct 2014 12:11:18 -0700
Message-ID: <xmqqiok1klyh.fsf@gitster.dls.corp.google.com>
References: <CAEY4ZpN4HEo-Csf1UjpGX4YLKWRrywinUemeZFZdVg=ZtTsaqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 21:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa8GH-0003H6-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 21:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaJCTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 15:11:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57567 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbaJCTLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 15:11:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51CD83F263;
	Fri,  3 Oct 2014 15:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1zpGtzGosA3elYZT5IAu7Njh1JE=; b=ApKFKA
	8ICVn/jj9K+VV+Ht5bGDsbwZzw5D3tjINmdwaKYAVas4Sm9or+NAykCRM0YFc9Pv
	UKWVJ66BuNUyz/YzeSVlC8eoeoB6Zj3byahZvqqXzGSc+bRu8cvZ3Ags48Wo22ML
	+aMo1cltjPR3rGla5kV0mEkCZKhW8LKoHkIdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjmZmsy7F/BZZNqsspt4xtGd8JIuOZHB
	Y1EmlLEZ8DyvwueOYUT4gsz91IbD+mPes8Za4tG/UeYwN4MNDEPgDY/aDK0VpKmq
	RsdWTnEMT8ABJ0XJmJf25g4Nw19oNR32uco6H6vAvKGjJ0Wm5XioATFmr2NGSYyI
	eKANRKxtUWw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 493943F262;
	Fri,  3 Oct 2014 15:11:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8AA13F261;
	Fri,  3 Oct 2014 15:11:19 -0400 (EDT)
In-Reply-To: <CAEY4ZpN4HEo-Csf1UjpGX4YLKWRrywinUemeZFZdVg=ZtTsaqA@mail.gmail.com>
	(Nazri Ramliy's message of "Fri, 3 Oct 2014 12:42:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E98DCC4-4B31-11E4-A281-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257847>

Nazri Ramliy <ayiehere@gmail.com> writes:

> When rebasing these upwards of 40+ commits, it is helpful if the
> rebase instruction sheet shows me the actual files that the commits
> affect so I made this patch (sorry I couldn't attach it inline since
> gmail eats all the tabs) that adds the "--show-files" option to
> git-rebase to achieve something to this effect:
>
> pick 996fa59 Remove autoconf submodule
>      # :100644 100644 cfc8a25... 28ddb02... M   .gitmodules
>      # :160000 000000 0263a9f... 0000000... D   autoconf
> ... more pick lines
> pick 4c5070f Remove automake submodule
>      # :100644 100644 28ddb02... f907328... M   .gitmodules
>      # :160000 000000 9042530... 0000000... D   automake
>
> Having the list of files shown below each commit, indented to reduce
> cluttering the "pick" instruction, really does help in deciding the
> reorder and squash candidates.

Sounds like a good idea to give helpful information in a comment
form to the insn sheet.

Other than two minor points:

 - If I were doing this, I would have used "diff-tree --stat
   --summary" instead of "show --raw".  You can tell
   deletion/addition by paying attention to 0's and also mode
   changes, but the information density of --raw for human
   consumption is rather low.

 - Regardless of the above, I am not sure if dumping listing of 100+
   paths modified would really help, and it might make sense to cap
   the number of paths displayed for each change.

I didn't look at your implementation at all, though.
