From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Verifiable git archives?
Date: Thu, 09 Jan 2014 12:11:20 -0800
Message-ID: <xmqqsiswapav.fsf@gitster.dls.corp.google.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
X-From: git-owner@vger.kernel.org Thu Jan 09 21:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LxA-0006le-0m
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 21:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbaAIULl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 15:11:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbaAIULj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 15:11:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75B561B0C;
	Thu,  9 Jan 2014 15:11:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pa0rj/Ht99ihzXvgq+TT23rTh9s=; b=IAlbc+
	47ItKjUK4rhu24Hz6AQF9vPVBM+a1T8TNK7Yu80utZQoruX0TUBb1KcYQNaQA3Jp
	snljtEqTnl7San02RO/8CtyTm/FOmLY94l7UF+ADiEqVCIAlxkC/DWbKKJKgN862
	NCDG6qspBNj1aG4DpKNGZObLp2FUOZ9og3RxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mg/nQXtkPQCAowvi3OXR7OtxbUXQeLJj
	2kWUuH/PJVUfH83Bwa4Q/SUlWH+zzsfdC2qDMP433Aqwpe7K7tzpnuJt1LfKktgi
	785+7AEVCAFKuDn3VrH2rjOid9/PKKuoJFyQB/ZyHWdlp/b3jTOk1Ku161DxswX5
	ezg3YuqO4ro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D49561B0A;
	Thu,  9 Jan 2014 15:11:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F64061B02;
	Thu,  9 Jan 2014 15:11:23 -0500 (EST)
In-Reply-To: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
	(Andy Lutomirski's message of "Wed, 8 Jan 2014 19:10:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36143332-796A-11E3-B437-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240271>

Andy Lutomirski <luto@amacapital.net> writes:

> It's possible, in principle, to shove enough metadata into the output
> of 'git archive' to allow anyone to verify (without cloning the repo)
> to verify that the archive is a correct copy of a given commit.  Would
> this be considered a useful feature?
>
> Presumably there would be a 'git untar' command that would report
> failure if it fails to verify the archive contents.
>
> This could be as simple as including copies of the commit object and
> all relevant tree objects and checking all of the hashes when
> untarring.

You only need the object name of the top-level tree.  After "untar"
the archive into an empty directory, make it a new repository and
"git add . && git write-tree"---the result should match the
top-level tree the archive was supposed to contain.

Of course, you can write "git verify-archive" that does the same
computation all in-core, without actually extracting the archive
into an empty directory.
