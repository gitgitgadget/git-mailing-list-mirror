From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Fri, 28 Mar 2014 10:06:31 -0700
Message-ID: <xmqq4n2ickx4.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
	<20140325092215.GB3777@mini.zxlink>
	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
	<20140326195201.GB16002@mini.zxlink>
	<xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
	<20140327142438.GE17333@mini.zxlink>
	<xmqq1txneavo.fsf@gitster.dls.corp.google.com>
	<53351C1B.6040609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, kirr@mns.spb.ru,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaEp-0005p0-EU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaC1RGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbaC1RGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21763774DE;
	Fri, 28 Mar 2014 13:06:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ONezfsA8PeW8OpPzDX/xu/TQVY=; b=wWFtZM
	MJAXC1jImko1tRBMAUVgCMsQHR2Y1s9XdZpwqe2djF3s1al5J9zlhsVslYbonomP
	9DXESU24iHZBdT623NNFneUmn+h4uR156Zx6sRyJg7Q8gh3WhaxGjKEdCSa7Rm2F
	bQMRvV6P0bNMPZMAPf2UzaTTqVQzEg2TxCjE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kU5APNfNJUDCfc2HI3HCPUMYdCg3ltjR
	TEPmkfhH824IVZFOY29hp2mixw1IcPLmvy6ve81TQjKMz/cjRJLoSQqSo4wUcXDr
	XTJuNJ2wsV/wNEHX15pJq3LM8fybUbB2Q6tcw5nbkykWuef6gbOtKzaRv7S737Eh
	Dw1mQBv4Xz8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09DEC774DD;
	Fri, 28 Mar 2014 13:06:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A319774DA;
	Fri, 28 Mar 2014 13:06:33 -0400 (EDT)
In-Reply-To: <53351C1B.6040609@viscovery.net> (Johannes Sixt's message of
	"Fri, 28 Mar 2014 07:52:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5022092A-B69B-11E3-A78F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245398>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 3/27/2014 19:48, schrieb Junio C Hamano:
>>> From: Kirill Smelkov <kirr@mns.spb.ru>
>>> Date: Mon, 24 Feb 2014 20:21:46 +0400
>>> ...
>> 
>> By the way, in general I do not appreciate people lying on the Date:
>> with an in-body header in their patches, either in the original or
>> in rerolls.
>
> format-patch is not very cooperative in this aspect. When I prepare a
> patch series with format-patch, I find myself editing out the Date: line
> from all patches it produces again and again. :-(

I am not sure what you mean.  If you are pasting the format-patch
output into an editor your MUA is using to receive the body of the
message from you, you would remove all the non-body lines, not just
Date: but Subject: and From:, no?
