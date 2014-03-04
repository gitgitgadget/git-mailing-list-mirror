From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] make --set-upstream work for local branches not in refs/heads
Date: Tue, 04 Mar 2014 11:44:47 -0800
Message-ID: <xmqqlhwpkats.fsf@gitster.dls.corp.google.com>
References: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:44:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKvGq-0004Un-Me
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbaCDTow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:44:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbaCDTov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:44:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29A206F30E;
	Tue,  4 Mar 2014 14:44:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDv76wQgEzHLf19hO26ccoovGi4=; b=vIFkNy
	xsFjsCRp+PckNzrw2noLv6dV7EoIfec29InvTvgSdRCCvygiuxl25xdB9p55l4pK
	hmAeLgl7a6qeOtYq3XEMLz7zR6gonbTXOVM6yQb9IO+gTmQYCdkkWCQXMvSThbxc
	4zFIc+Xq24T4IB7ShAIBdtROEwYYUrGYLoveo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnR1EhiYXm04ThunKnqBXydhpBfcBI4J
	q8ItfrLe+lSHc2vk5we/CLt20lhU2aAwS9tZf+fSeypYjPwhQ3D29KfSWbpK4rtj
	1fZr7CUhQlipQbSOqkJXKGFZPZo8goYBzTc6vpGFZa5O59XTKkrGtt2CDk+pFQwP
	uf7FlR8IL1E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189C76F30D;
	Tue,  4 Mar 2014 14:44:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE03C6F30B;
	Tue,  4 Mar 2014 14:44:49 -0500 (EST)
In-Reply-To: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Tue, 4 Mar 2014 15:07:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72A2990C-A3D5-11E3-AA50-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243374>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> It might be possible (in "Gerrited" setups) to have local branches
> outside refs/heads/, like for example in following fetch config:
>
> [remote "origin"]
> 	url = ssh://user@example.com/my-project
> 	fetch = +refs/heads/*:refs/remotes/origin/*
> 	fetch = +refs/wip/*:refs/remotes/origin-wip/*
>
> Let's say that 'test' branch already exist in origin/refs/wip/. If I
> call:
>
> git checkout test
>
> then it will create a new branch and add an entry to .git/config:
>
> [branch "test"]
> 	remote = origin
> 	merge = refs/wip/test
>
> But if I create a branch 'test2' and call:
>
> git push --set-upstream origin test2:refs/wip/test2
>
> then branch is pushed, but no entry in .git config is created.

By definition anything otuside refs/heads/ is not a branch, so do
not call things in refs/wip "branches".  Retitle it to "work for
local refs outside refs/heads" or something.

Having said that, I do not see a major problem if we allowed

	[branch "test2"]
		remote = origin
                merge = refs/wip/test2

to be created when "push --setupstream" is requested, making
test2@{upstream} to point at refs/remotes/origin-wip/test2.

I do not know what the correct implementation of such a feature
should be, though.
