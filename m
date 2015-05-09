From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 08 May 2015 20:45:00 -0700
Message-ID: <xmqq7fsiifcz.fsf@gitster.dls.corp.google.com>
References: <1431124726-22562-1-git-send-email-dturner@twopensource.com>
	<1431124726-22562-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat May 09 05:45:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqvhg-0000iO-Pu
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 05:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbbEIDpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 23:45:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbbEIDpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 23:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1401F50854;
	Fri,  8 May 2015 23:45:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TdrlLLtkWv9N5kvEJ5oQnIwdCiw=; b=mkcXsQ
	+mYml6dsHnWHA7nt6X4ogw083hZjm/yqLSbmI6bcERKnQMbUAVIAzNuH9BcAoc5b
	3W1Qx+RV5v8Jo7xFTK7lvdQ4y1F4zltKuZd31F5Zk10yTiQdcIz2pHuU5zYdOIrj
	momlBtakuvna813OSXZRmVl3hyjJTKn6YlZgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IxooUCiJ9Bu87g0sAXR32YYfSUoeGszN
	Bz1kLFe/SkCbavlFDiRKRKSliobA0H+OyjpxvnhPSSvs1uiMg58PO2lGO/19A2p4
	+ut0YB3WfbDoJnvaxuTFepbpdVQo8N9yPfvXbxRxMBeAOAsAOAaWpTS/9hsgrV55
	Hqle66Lg4q4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CDFB50853;
	Fri,  8 May 2015 23:45:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56C9550852;
	Fri,  8 May 2015 23:45:02 -0400 (EDT)
In-Reply-To: <1431124726-22562-2-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Fri, 8 May 2015 18:38:45
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5F7D182-F5FD-11E4-AF0A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268696>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
> when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
> is incompatible with G_S_ONLY_TO_DIE because the diagnosis that
> ONLY_TO_DIE triggers does not consider symlinks.

Is "does not consider" something fundamental, or it just happens to
be that way right now?
