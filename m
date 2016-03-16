From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for the "Leftover Bits": rebase -x to imply -i
Date: Wed, 16 Mar 2016 15:33:31 -0700
Message-ID: <xmqqpouu2guc.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:33:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agK0Z-0007Xj-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 23:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbcCPWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 18:33:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932546AbcCPWde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 18:33:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 210024E861;
	Wed, 16 Mar 2016 18:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5x4wbUHlYreRKMSBUjgT6gYDv/0=; b=rYQ/ZK
	/Biaei+ySLVMwtfil76Rn1/D8rawrqqIiQ/mgL3Z6EWH4AOhu79wSAhchaQEEmg+
	h6HpumcfZUBDia3TMVPGKdXlSqZe+akM08Vtl9oBxy7yDUL47sqnTDpdLPG0iL+F
	IKjOn2V1SKeJjM1/iJEzg1akGsVa+PtGsSVfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iwoKGH42/dpfn3aQ4bSe20bvypZtDdgy
	HJ6BhL9a0mvKPyDIX/YNVIOmK6NN8+RhheX3thIq+1F7FXyvcDF+1hAQBI8O1XQF
	tK48MNBnB0zrsJVixojlzMKPD0cThtoIHWbcnE1N6/kNXeNCoj/bkRVEQdtx6X95
	CIB/yW6OMMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17E804E860;
	Wed, 16 Mar 2016 18:33:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 918B94E85F;
	Wed, 16 Mar 2016 18:33:32 -0400 (EDT)
In-Reply-To: <CAGZ79kZg3QkfjB1hwZKRS9Hqg-1H=kQwuwByX_rAMzveXtnp7Q@mail.gmail.com>
	(Stefan Beller's message of "Wed, 16 Mar 2016 14:12:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D3B5CF6-EBC7-11E5-A197-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289055>

Stefan Beller <sbeller@google.com> writes:

> * "rebase -exec" requiries to be an explicit interactive rebase (i.e.
>   --interactive was given)
>   Could --exec just imply --interactive with a no-op editor?

Perhaps like this?  You have to defend the change with a good
description, have to protect the new behaviour with a new test from
future breakages, and may have to adjust existing tests if they are
expecting the current behaviour (I didn't test).

 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index cf60c43..c68baa0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -248,6 +248,7 @@ do
 		;;
 	--exec=*)
 		cmd="${cmd}exec ${1#--exec=}${LF}"
+		interactive_rebase=explicit
 		;;
 	--interactive)
 		interactive_rebase=explicit
