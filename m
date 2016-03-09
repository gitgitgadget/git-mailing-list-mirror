From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred
Date: Wed, 09 Mar 2016 10:04:17 -0800
Message-ID: <xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
	<xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Wed Mar 09 19:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiTB-0008K3-Er
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578AbcCISEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:04:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933125AbcCISEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:04:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46FD74AB7F;
	Wed,  9 Mar 2016 13:04:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iyvt2Y+LEO2f3wZ0NVg9XB40rcs=; b=MYcLSZ
	at657jyN8g3oOb7bMp2Nkp98Cs7c+6arIC0KOF0cgQWYMb6R4kfKtwPVIXiDH/No
	fvdGoME4/eFNpIryHZG9qdbyY3Ph19aPFTaL4umb1+qHdzRve2iQq6zfxqvzn7cj
	l0zOy0PiTv3rZNayRNnJTT95RNndHFcY349Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0jeFMNE3yJuqxwq6c4lyVdC1AhB4UBm
	njrmSj5CvAoqkKdVdDvrs5htJIQ2Jv/yjHMmqmu8ff6RlIgF5Rsaq6cDtcUoeDG8
	26QdiIJG5gf7O6N13aTbyjon3h036+euvO7NzX0+F8nuL+1lUBheOQzWVWRLGBgS
	bxpia3oK460=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E0D34AB7C;
	Wed,  9 Mar 2016 13:04:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2DC44AB7B;
	Wed,  9 Mar 2016 13:04:18 -0500 (EST)
In-Reply-To: <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 08 Mar 2016 10:32:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57E2E168-E621-11E5-B637-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288541>

Junio C Hamano <gitster@pobox.com> writes:

> The duplicated code to read the same file bothers me somewhat.
>
> I wondered if it makes the result easier to follow (and easier to
> update) if this part of the code is restructured like this:
>
> 	if (file_exists(git_path_merge_msg()) ||
>             file_exists(git_path_squash_msg())) {
> 	    if (file_exists(git_path_squash_msg())) {
> 		read SQUASH_MSG;
> 	    }
>             if (file_exists(git_path_merge_msg()))
>             	read MERGE_MSG;
> 	    }
>             hook_arg1 = "merge";
> 	}
>
> but I am not sure if that structure is better.

... as this duplicates file_exists() call to the same thing, which
is no better than duplicated calls to read *_MSG files.
