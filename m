From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 08 Nov 2011 09:44:40 -0800
Message-ID: <7vzkg6y0dz.fsf@alter.siamese.dyndns.org>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 18:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNpj7-0005E2-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 18:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368Ab1KHRoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 12:44:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195Ab1KHRon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 12:44:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93676DBD;
	Tue,  8 Nov 2011 12:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aifKNBfAy9Yu5NpWTrhC2AeeEOI=; b=GhKFqq
	hh3HT8RLpds6S8hOen4QEDW+4ez5j2Lvz+0yO3i+dN1yG0/5VxV0BgWQi38zeo1+
	MHFaQu6KsGSIodbCSMZDSurSkgLNfJAqj3Z1KTmPGWJeOryGBTJKTqXJIs5mlnsx
	IZKoafnxVHwj4tGVcubbjcr5O0Ijcyz0A3+I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoAn9OrtKsHmfmpce9K8IDC+BTR74mWD
	3r62daaA8J5OkxilVDjpZ/s3tMMegZ+z83fQRNKbLTltgqLe4VcqKia118rdPJJp
	x2II8QIjcNj3nJYUrFdFvMZkuTq6iw+a0VzmlBSimto8bQ6L6wCBzxrs69om0WQE
	b79EoC6Wo2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B09416DBC;
	Tue,  8 Nov 2011 12:44:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4533E6DBB; Tue,  8 Nov 2011
 12:44:42 -0500 (EST)
In-Reply-To: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com> (Dario
 Rodriguez's message of "Tue, 8 Nov 2011 10:58:05 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56C03EDC-0A31-11E1-9C1B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185099>

Dario Rodriguez <soft.d4rio@gmail.com> writes:

> So, how can I checkout the first version of each file? (I know that
> GIT tracks contents and not files, but the fact is that I need to keep
> track on files, it's the real thing I work with)

In general "the first version of a file" is an undefined concept if your
history has merges of parallel development, but in a narrow special case
of linear history, you should be able to do something like this:

    $ git log --format='# %h %s' --diff-filter=A --raw --abbrev=40

which would give you something like

    # 8d19b44 Git 1.7.7.2

    :000000 100644 0000000... e6bbef2... A  Documentation/RelNotes/1.7.7.2.txt
    # 0f77dea mingw: move poll out of sys-folder

    :000000 100644 0000000... 708a6c9... A  compat/win32/poll.c
    :000000 100644 0000000... b7aa59d... A  compat/win32/poll.h
    # 8f41c07 read-cache.c: fix index memory allocation

    :000000 100755 0000000... bca359d... A  t/t7511-status-index.sh
    ...

so that you know what blobs to check out to which path. E.g.

    $ mkdir -p compat/win32; git cat-file blob 708a6c9... >compat/win32/poll.c
