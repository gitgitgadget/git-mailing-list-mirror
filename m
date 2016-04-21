From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Thu, 21 Apr 2016 10:45:41 -0700
Message-ID: <xmqqr3dysvne.fsf@gitster.mtv.corp.google.com>
References: <20160420152209.GH23764@onerussian.com>
	<CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
	<xmqqh9ewukhw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZMOv0r9fRFbP1WV8qFJBm+s=V8=ueFbYvnyFtgV8j9iQ@mail.gmail.com>
	<xmqqshygt1gs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbyDuu8hUQXOUNmDLyO88GOi3kqSzsc0UfgzwAL9peZHg@mail.gmail.com>
	<20160421031426.GY23764@onerussian.com>
	<CAGZ79kYmobvZgAeJv7MNXeFXd+Ahg5mtyagt5m+f7Gpp=Ps4iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yaroslav Halchenko <yoh@onerussian.com>,
	Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:45:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atIfl-00074p-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbcDURpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:45:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751878AbcDURpp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:45:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 804DB14477;
	Thu, 21 Apr 2016 13:45:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QVA6c42+RaGUa2PeVi2UXLC1ZI=; b=LBti+s
	ByfndHdQJ2+LWACX3vm4kCPXzR1AHM9Li34R4FA3QpSwGdl6pzb+fzEHX/8c2kbd
	8Q2871s839Jap3HJL+92PxisuB2reEkskaFDVeKlAU36AvVJPzw64dnQ4sZxYKP9
	riVThAGx1/2q8nFRJ4FGQ70ktTQDRG/E25lLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ya0svwbi2Psv0UH2n61mtg6lINlesv+W
	Tf4wqMFF9JqZOTzYctKQnQbS7KwKGI/RzS1b9ZydpKJLOCCEYLzz7ivAPkv9yIPj
	D3dsfHnibZ+7kEbX10F7ItNcynhs8uPO8LrsGmhcxTH7fVl38bNHDXa/GBcWFYwB
	U0jh7tOCQwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 765DF14476;
	Thu, 21 Apr 2016 13:45:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB35714475;
	Thu, 21 Apr 2016 13:45:42 -0400 (EDT)
In-Reply-To: <CAGZ79kYmobvZgAeJv7MNXeFXd+Ahg5mtyagt5m+f7Gpp=Ps4iQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Apr 2016 10:11:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE8F13A6-07E8-11E6-A4A7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292135>

Stefan Beller <sbeller@google.com> writes:

> In case of non bare:
>
>     Get the repo and all its submodules from the specified remote.
>     (As the submodule is right there, that's the best guess to get it from,
>     no need to get it from somewhere else. The submodule at the remote
>     is the closest match you can get for replicating the superproject with
>     its submodules.)
>
> This way is heavy underutilized as it wasn't exercised as often I would
> guess, 

My guess is somewhat different. It is not used because the right
semantics for such a use case hasn't been defined yet (in other
words, what you suggested is _wrong_ as is).  You need to remember
that a particular clone may not be interested in all submodules, and
it is far from "the closest match".
