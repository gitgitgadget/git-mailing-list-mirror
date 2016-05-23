From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Mon, 23 May 2016 13:30:21 -0700
Message-ID: <xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
References: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4wUf-0005sp-Ly
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbcEWUaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 16:30:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932093AbcEWUaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 16:30:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7091F1DC22;
	Mon, 23 May 2016 16:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiOQOn7znEzzap8/wmLHegxOd7w=; b=UWV+uL
	sbxrEN+TbFgk1KdmcDM3plK6emyrXsz8HoVCFAtvwFjdkcY1W+hHhw3FOIPztt87
	XQlQCtS5E03tcueW7FfoZrP9YGS1CFg4XQGTUie0e3Wi1vCJXCHb96AxASn3hu4B
	NuAgH9apt0gJGrC1FG/Xh9W/HJH6aDMpEc0uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QIG/z+gMsIijGB9kqOfOeabpVUPSH/vQ
	bGfDcWjAbjHe9bLaXNmOYTBCGXSBLmQcQvA/iQbPGxutl2x9HPCNvhnRyjiQZ3iR
	HY9I8meaJsjj3z8ykal+s5b1J0E0WbrN9JDZY6je0gc7qwZj3EJstA9AuinT0EpT
	lFEm76PCwTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67BE41DC21;
	Mon, 23 May 2016 16:30:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D76481DC20;
	Mon, 23 May 2016 16:30:22 -0400 (EDT)
In-Reply-To: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
	(Nathan Collins's message of "Mon, 23 May 2016 12:06:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CB50B30-2125-11E6-8724-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295389>

Nathan Collins <nathan.collins@gmail.com> writes:

> Example session:
>
>     $ git init test.git
>     Initialized empty Git repository in /tmp/test.git/.git/
>     $ cd test.git
>     $ mkdir "dir name"
>     $ touch dir\ name/file.txt
>     $ echo "dir\\ name/file.txt -text -whitespace" >> .git/info/attributes
>     $ git add dir\ name/file.txt
>     name/file.txt is not a valid attribute name: .git/info/attributes:1

That's because spaces are not allowed in paths there.

	echo "dir?name/file.txt -text" >.git/info/attributes

may be an easy workaround for now.
