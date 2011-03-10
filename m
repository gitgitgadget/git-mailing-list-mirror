From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] revision.c: get rid of struct rev_info.prune_data
Date: Wed, 09 Mar 2011 22:20:43 -0800
Message-ID: <7vhbbb7ays.fsf@alter.siamese.dyndns.org>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <1299726819-5576-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 07:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxZF3-0005FS-A4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 07:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab1CJGUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 01:20:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1CJGUv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 01:20:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 218FB2126;
	Thu, 10 Mar 2011 01:22:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2NfwLcPxGPg1
	POsCPAo41Q0SEqs=; b=DBJz7xglj6NpExPrzPGgV5ZtmxYfrsvRsGmxaf2hM4Oa
	Px4l0J19n5EM8XOCHPheEFGqiERdExquyx0P0uz5ibq/WtM7bseDgbo6jCD95/t3
	r0jHGLyjvWVKbeQfgeA5ftJ5MGuyXMP1wlzrf/3ZC3r8O49xN1h/NtI5iwB1JJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ixUKp+
	VzzTYUnL60H+VhE9ZdgdZ5jDbq5wJXXlmSpqnaJOn0BLo6Jt3cTfeurTF6NEcX4r
	VOe5K8iZRiJHSUcaxDbl8vP1FEohXy8AGTg+ftC1LlvRFRTAOQ+D6kHQzrK2pMQK
	aAk8WSPzSC1z0f7zgJPliK213bMo0Q89QJQ0s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F25912125;
	Thu, 10 Mar 2011 01:22:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F359B2122; Thu, 10 Mar 2011
 01:22:12 -0500 (EST)
In-Reply-To: <1299726819-5576-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 10 Mar
 2011 10:13:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE6C642E-4ADE-11E0-8EBA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168791>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There are three struct pathspec(s) in struct rev_info:
>
>  - prune_data
>  - pruning.pathspec
>  - diffopt.pathspec
>
> In some places, this pathspec is used, in other places another
> ... but i'm
> not sure why diffopt can't be used in place of pruning.

A command in the "log" family uses revision traversal and uses one
pathspec (pruning.pathspec) to cull side branches and skip irrelevant
commits, and another pathspec (diffopt.pathspec) to specify how the fou=
nd
commit is shown.  Off the top of my head, currently the only case the
pathspec of these diff options differ is when --full-diff is used, but
they are independent concepts.

I would suspect this would matter even more once somebody wants to redo
the --follow hack to actually follow different renamed-from path per
merged branches, but I haven't thought through the issues.
