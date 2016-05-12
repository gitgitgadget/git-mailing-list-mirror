From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Thu, 12 May 2016 09:53:38 -0700
Message-ID: <xmqqzirvfca5.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
	<xmqqoa8bgten.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZHbAiP13rC+VLnFUtoxPZEcyx_wkrxfKb+cGBxQaojZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0tru-00016q-8P
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbcELQxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 12:53:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbcELQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 12:53:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB8BC1AA40;
	Thu, 12 May 2016 12:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yj4QEZpfX0EnlRK8fbrbyGOZL+s=; b=xGnLBY
	nNP3BXooLlmhQrIObWEyV4xX57EN9184ZFAMgtErWhXcu6xDp7CDHiB+MjaqqBup
	yuTj599dwUPNdZk5SfSkKFTDCC3IMc7yITiEhjQmD6nMbGJGS7KhvgjfyGYA1C4P
	csKoqg3Dr4V4EA6TG98cp0mDtDRc755F6iV9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LijrHmgNm+oNoXym0oQXVrpazVqhIFkg
	DAHUPtCz/IjCbdFxwk9W+ZvZMhhRa929FQLLk2NzdrKN57Onzg5zd223hXooGzir
	luP/jsXT+e7svlDjoHYt4mf0/BAOHeRLL+Y0VzacTjIs3f6yftMscn5Qi90ySn7C
	nKSe/owbfZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E43D41AA3E;
	Thu, 12 May 2016 12:53:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C2F81AA3D;
	Thu, 12 May 2016 12:53:40 -0400 (EDT)
In-Reply-To: <CAGZ79kZHbAiP13rC+VLnFUtoxPZEcyx_wkrxfKb+cGBxQaojZQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 12 May 2016 09:35:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 141B2BDE-1862-11E6-9E68-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294419>

Stefan Beller <sbeller@google.com> writes:

> We can still keep the submodule.defaultGroup. (In the WIP I renamed
> it to updateGroup as its only feature is to have it set during clone
> and remebered for `git submodule update`)

Yes, my idle speculation between "[submodule"x"] label=A" stored
in .gitmodules and "path/to/submodule  group=A" in .gitattributes
is completely orthogonal to the need for submodule.defaultGroup.

The only difference it brings in is how we evaluate what
submodule.defaultGroup names (i.e. via "submodule label" vs
"path label").

> When we allow labels to be generic path labels instead of submodule
> labels, the user might be tempted to ask, why the submodules can
> be specified but not the individual paths, i.e.
>
>     git clone --init-submodule="(:group=docs)" ...
>
> may strongly hint at:
>
>     git clone --narrow="(:group=docs)" ...
>
> would only get parts of the repository.

If we are to have a (proper) narrow clone, I do not think there is
any reason why the latter should not work as expected.

> For the submodule case, this may add confusion as the user would
> need to configure some properties in the .gitmodules file and some
> in the .gitattributes file.

I do not quite understand this comment.

A new reader who knows nothing about "grouping submodules" would not
have any trouble, I suspect, if all and the only grouping she learns
is "grouping paths" from the beginning.

Thanks.
