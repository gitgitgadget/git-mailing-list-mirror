From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree
 content
Date: Tue, 16 Aug 2011 13:01:41 -0700
Message-ID: <7vippxgm6y.fsf@alter.siamese.dyndns.org>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 22:06:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtPto-0003Jw-RT
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 22:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab1HPUBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 16:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236Ab1HPUBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 16:01:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C00004FC4;
	Tue, 16 Aug 2011 16:01:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wjnBiYTarCrM
	LCSbJQXCDtcIbxE=; b=KOfcYSzJ/vqYbfuP6Uy4VFv/GP+3pX5eU2nWzioVter6
	S2yUhUocLNOidWCncsXDu1Jfk2nmRSAMbEoShfIkDJzTxv5EmtGMWrXIoIfNSvHf
	NcBSqxrouj6l1wj3WUxgch37OBlNNZj2fdebjqH8LWQa6ZDas+Y3cjcNGJkQmq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KXCHLi
	5P85w6NePYZqSwHZPCx0SYJ0IoN3ZHZY34q/LS1PT1md9HPJ6O2tEsP9rpErPnjI
	arVntdcCGPhdr5CBOIFgukyec04vngMyzFmXxXbTVY47nawIMt/RHD0BAzUteeoD
	4K5eDMYRBXUN/JIndsRVVbdU1aY3ArpM3ikOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A304FC3;
	Tue, 16 Aug 2011 16:01:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A36B4FC2; Tue, 16 Aug 2011
 16:01:43 -0400 (EDT)
In-Reply-To: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 12 Aug
 2011 21:07:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90295B58-C842-11E0-8E37-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179475>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> What I want is a quick way to modify index content without changing
> worktree, then I can continue adding more hunks to the index.

Why would you even want to do that?

Suppose you want to update hello.c in the index but not in the working
tree for whatever reason I do not understand.  Presumably you would wit=
h
this patch do this:

	edit hello.c
        git update-index --swap hello.c

assuming that the state of hello.c _before_ the edit was pristine.  But
then after that what would you do?  Probably you would commit that
untested change, and rebase-i to clean them up later, which is fine.

BUT

After swapping, the file in the working tree lacks the change you made =
to
the index, so if you keep working on it after the above "swap" in your
editor, the next "git add" will revert whatever you did with the first
"edit".

I think that makes it too error prone and difficult to understand for b=
oth
new and experienced people.

Whatever the expected use case is, it needs to be explained a lot bette=
r.
