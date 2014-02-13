From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Thu, 13 Feb 2014 11:51:19 -0800
Message-ID: <xmqqbnyalrk8.fsf@gitster.dls.corp.google.com>
References: <cover.1392299516.git.kirr@mns.spb.ru>
	<1dd9ca564e00ef235875aae4944675f53dcd25a3.1392299516.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Feb 13 20:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE2Jo-0007Gn-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbaBMTv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 14:51:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbaBMTvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 14:51:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D31AD6C655;
	Thu, 13 Feb 2014 14:51:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOPUAUsHI4CnhkcGSJx9c61MNzw=; b=kIgFFp
	kTFwqn7PNX0anF9mbq35xGNxccs+DkERCYirCzb01vr8jmeaj/O0SDWaS8Kp9U62
	44n8pFF1OnY8ilOEx5uGJQrX0ZXZ1/nfxyc+MV+/ppXiVqy47FfXRI5UDCx5Ox/9
	tia+SvyddxRNk1ssRBpXA8nsnwS1adDbC3jhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AE6aAcIadpNwveSK6Zcu9mpLdSTB1Dwq
	VyYOuf/vRobcCApKCD0d5dcn13Fmbsb3EVDwWYt6LnbSKQmiRPIMqhIQplBPyb5Z
	Ek10ViWn+9DFE7u2/Q8vdFpZIIRA+nQ+B+zb+NeWyo0eFuAXQuuexxNZzh1CZ73Z
	i6c/YO4dU5g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D2A96C654;
	Thu, 13 Feb 2014 14:51:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F5A96C650;
	Thu, 13 Feb 2014 14:51:21 -0500 (EST)
In-Reply-To: <1dd9ca564e00ef235875aae4944675f53dcd25a3.1392299516.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Thu, 13 Feb 2014 18:02:54 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 363EAE52-94E8-11E3-8DA0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242075>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> +		/* until we go to it next round, .next holds how many bytes we
> +		 * allocated (for faster realloc - we don't need copying old data).
> +		 */
> +		p->next = (struct combine_diff_path *)alloclen;

I am getting this here:

tree-diff.c: In function '__path_appendnew':
tree-diff.c:140:13: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
